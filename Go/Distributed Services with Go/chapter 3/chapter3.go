In this book we’re building a distributed service to learn how to create distributed services with Go (shocker). But how does building a log in this
chapter help us achieve that goal? I believe the log is the most important tool
in your toolkit when building distributed services. Logs—which are sometimes
also called write-ahead logs, transaction logs, or commit logs—are at the heart
of storage engines, message queues, version control, and replication and
consensus algorithms. As you build distributed services, you’ll face problems
that you can solve with logs. By building a log yourself, you’ll learn how to:
• Solve problems using logs and discover how they can make hard problems
easier.
• Change existing log-based systems to fit your needs and build your own
log-based systems.
• Write and read data efficiently when building storage engines.
• Protect against data loss caused by system failures.
• Encode data to persist it to a disk or to build your own wire protocols and
send the data between applications.

The Log Is a Powerful Tool
Folks who develop storage engines of filesystems and databases use logs to
improve the data integrity of their systems. The ext filesystems, for example,
log changes to a journal instead of directly changing the disk’s data file. Once
the filesystem has safely written the changes to the journal, it then applies
those changes to the data files. Logging to the journal is simple and fast

How Logs Work
A log is an append-only sequence of records. You append records to the end
of the log, and you typically read top to bottom, oldest to newest—similar to
running tail -f on a file

Build a Log
We will build our log from the bottom up, starting with the store and index
files, then the segment, and finally the log. That way we can write and run
tests as we build each piece.

We will build our log from the bottom up, starting with the store and index
files, then the segment, and finally the log. That way we can write and run
tests as we build each piece. Since the word log can refer to at least three
different things—a record, the file that stores records, and the abstract
data type that ties segments together—to make things less confusing,
throughout this chapter, I will consistently use the following terms to mean
these things:
• Record—the data stored in our log.
• Store—the file we store records in.
• Index—the file we store index entries in.
• Segment—the abstraction that ties a store and an index together.
• Log—the abstraction that ties all the segments together.

// checkout store.go
The store struct is a simple wrapper around a file with two APIs to append
and read bytes to and from the file. The newStore(*os.File) function creates a
store for the given file. The function calls os.Stat(name string) to get the file’s
current size, in case we’re re-creating the store from a file that has existing
data, which would happen if, for example, our service had restarted.
We refer to the enc variable and lenWidth constant repeatedly in the store, so
we place them up top where they’re easy to find. enc defines the encoding that
we persist record sizes and index entries in and lenWidth defines the number
of bytes used to store the record’s length.
Next, write the following Append() method below newStore():

// append  fxn store
Append([]byte) persists the given bytes to the store. We write the length of the
record so that, when we read the record, we know how many bytes to read.

// read fxn
Read(pos uint64) returns the record stored at the given position. First it flushes
the writer buffer, in case we’re about to try to read a record that the buffer
hasn’t flushed to disk yet. We find out how many bytes we have to read to
get the whole record, and then we fetch and return the record. The compiler
allocates byte slices that don’t escape the functions they’re declared in on the
stack. A value escapes when it lives beyond the lifetime of the function call—if
you return the value, for example.
Put this ReadAt() method under Read():
// readAt fxn
ReadAt(p []byte, off int64) reads len(p) bytes into p beginning at the off offset in the
store’s file. It implements io.ReaderAt on the store type.
Last, add this Close() method after ReadAt():
Close() persists any buffered data before closing the file.

Let’s test that our store works. Create a store_test.go file in the log directory with
the following code:
// store_test.go
In this test, we create a store with a temporary file and call two test helpers
to test appending and reading from the store. Then we create the store again
and test reading from it again to verify that our service will recover its state
after a restart.
After the TestStoreAppendRead() function, add these test helpers:
Below testReadAt(), add this snippet to test the Close() method:
// close test


Write the Index
Next let’s code the index. Create an index.go file inside internal/log that contains

Our index entries contain two fields: the record’s offset and its position in the
store file. We store offsets as uint32s and positions as uint64s, so they take
up 4 and 8 bytes of space, respectively. We use the entWidth to jump straight
to the position of an entry given its offset since the position in the file is offset
* entWidth.

index defines our index file, which comprises a persisted file and a memorymapped file. The size tells us the size of the index and where to write the next
entry appended to the index.
Now add the following newIndex() function below the index:
newIndex(*os.File) creates an index for the given file. We create the index and
save the current size of the file so we can track the amount of data in the
index file as we add index entries. We grow the file to the max index size before
memory-mapping the file and then return the created index to the caller.
Next, add the following Close() method below newIndex()

Now that we’ve seen the code for both opening and closing an index, we can
discuss what this growing and truncating the file business is all about

// readindex
Read(int64) takes in an offset and returns the associated record’s position in
the store

Now add the following Write() method below Read():

func (i *index) Write(off uint32, pos uint64) error {
	if uint64(len(i.mmap)) < i.size+entWidth {
	return io.EOF
	}
	enc.PutUint32(i.mmap[i.size:i.size+offWidth], off)
	enc.PutUint64(i.mmap[i.size+offWidth:i.size+entWidth], pos)
	i.size += uint64(entWidth)
	return nil
	}
	
	func (i *index) Name() string {
		return i.file.Name()
		}















































































































































































































