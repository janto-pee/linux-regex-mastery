#  how to list files,
#  modify their timestamps,
#  create temporary files,find files in a
# directory hierarchy,
# apply commands to a list of files,
# determine the amount of filesystem space used, 
# and compare files

echo /bin/*sh #Show shells in /bin
# /bin/ash /bin/bash /bin/bsh /bin/csh /bin/ksh /bin/sh /bin/tcsh /bin/zsh

 ls /bin/*sh | cat #Show shells in output pipe
# /bin/ash
# /bin/bash

 ls /bin/*sh #Show shells in 80-character terminal window
/bin/ash /bin/bash /bin/bsh /bin/csh /bin/ksh /bin/sh /bin/tcsh /bin/zsh

# ls replaces nonprintable characters in filenames with question marks in terminal output,but reports filenames to
# nonterminal output without changes. Consider a file with the peculiar name one\ntwo,
# where \n is a newline
 ls one*two #List peculiar filename
# one?two
$ ls one*two | od -a -b #Show the real filename
# 0000000 o n e nl t w o nl
#  157 156 145 012 164 167 157 012
# 0000010

# Unlike echo, ls requires that its file arguments exist and complains if they do not:
$ ls this-file-does-not-exist #Try to list a nonexistent file
# ls: this-file-does-not-exist: No such file or directory
$ echo $? #Show the ls exit code
1

$ echo * #Echo matching files
# one three two
$ ls * #List matching files
# one three two

Filenames that begin with a dot are hidden from normal shell pattern matching.
$ echo .* #Echo hidden files
# . .. .dos .tres .uno
$ ls .* #List hidden files
# .dos .tres .uno

$ ls -d .* #List hidden files, but without directory contents
# . .. .dos .tres .uno
$ ls -d ../* #List parent files, but without directory contents
# ../hidden ../one ../three ../two
 ls -a List all files, including hidden ones

10.1.1 Long File Listings
ls can report further details about them (files) —notably,some of the filesystem metadata. 
 ls -l /bin/*sh #List shells in /bin
# The first character on each line describes the filetype: - for ordinary files, d for directories, l for symbolic links, and so on.
# The next nine characters report the file permissions for each of user,group,and
# other: r for read, w for write, x for execute, and - if the permission is absent
The second column contains the link counts: here,only /bin/zsh has a hard link to
another file,but that other file is not shown in the output because its name does not
match the argument pattern.
The third and fourth columns report the file owner and group,and the fifth column
reports the file size in bytes.
The next three columns report the last-modification timestamp. In the historical
form shown here,a month,day,and year are used for files older than six months,
and otherwise, the year is replaced by a time of day:
$ ls -l /usr/local/bin/ksh List a recent file
-rwxrwxr-x 1 jones devel 879740 Feb 23 07:33 /usr/local/bin/ksh

However,in modern implementations of ls,the timestamp is locale-dependent,and
may take fewer columns. Here are tests with two different versions of ls on GNU/
Linux:
$ LC_TIME=de_CH /usr/local/bin/ls -l /bin/tcsh List timestamp in Swiss-German locale
-rwxr-xr-x 1 root root 365432 2002-08-08 02:34 /bin/tcsh
$ LC_TIME=fr_BE /bin/ls -l /bin/tcsh List timestamp in Belgian-French locale
-rwxr-xr-x 1 root root 365432 aoû 8 2002 /bin/tcsh

10.1.2 Listing File Metadata
10.2 Updating Modification Times with touch
We have used the touch command a few times to create empty files. For a previously
nonexistent file, here are equivalent ways of doing the same thing:
cat /dev/null > some-file Copy empty file to some-file
printf "" > some-file Print empty string to some-file
cat /dev/null >> some-file Append empty file to some-file
printf "" >> some-file Append empty string to some-file
touch some-file Update timestamp of some-file

However,if the file exists already,the first two truncate the file to a zero size,
whereas the last three effectively do nothing more than update its last-modification
time. Clearly,the safe way to do that job is with touch,because typing > when you
meant >> would inadvertently destroy the file contents.

By default,or with the –m option, touch changes a file’s last-modification time,but
you can use the –a option to change the last-access time instead. The time used
defaults to the current time,but you can override that with the –t option,which
takes a following argument of the form [[CC]YY]MMDDhhmm[.SS],

$ touch -t 197607040000.00 US-bicentennial Create a birthday file
$ ls -l US-bicentennial List the file
-rw-rw-r-- 1 jones devel 0 Jul 4 1976 US-bicentennial
touch also has the –r option to copy the timestamp of a reference file:
$ touch -r US-bicentennial birthday Copy timestamp to the new birthday file
$ ls -l birthday List the new file
-rw-rw-r-- 1 jones devel 0 Jul 4 1976 birthday

$ touch -t 178907140000.00 first-Bastille-day Create a file for the French Republic
touch: invalid date format `178907140000.00' A 32-bit counter is clearly inadequate
$ touch -t 178907140000.00 first-Bastille-day Try again on system with 64-bit counter
$ ls -l first-Bastille-day It worked! List the file
-rw-rw-r-- 1 jones devel 0 1789-07-14 00:00 first-Bastille-day

$ touch -t 999912312359.59 end-of-9999 This works
$ ls -l end-of-9999 List the file
-rw-rw-r-- 1 jones devel 0 9999-12-31 23:59 end-of-9999
$ touch -t 1000001010000.00 start-of-10000 This fails
touch: invalid date format `1000001010000.00'

Fortunately, GNU touch provides another option that avoids the POSIX restriction:
$ touch -d '10000000-01-01 00:00:00' start-of-10000000 Into the next millionenium!
$ ls -l start-of-10000000 List the file
-rw-rw-r-- 1 jones devel 0 10000000-01-01 00:00 start-of-10000000

10.3 Creating and Using Temporary Files


Because /tmp is so heavily used,some systems make it a memory-resident filesystem
for faster access, as shown in this example from a Sun Solaris system:
$ df /tmp Show disk free space for /tmp

10.3.1 The $$ Variable
Shared directories,or multiple running instances of the same program,bring the possibility of filename collisions
The traditional solution in shell scripts is to use the
process ID (see “Process Listing” [13.2]),available in the shell variable $$,to form
part of temporary filenames
To deal with the possibility of a full temporary filesystem,it is also conventional to allow the directory name to be overridden by an environment variable,traditionally called TMPDIR. In addition,you should use a trap
command to request deletion of temporary files on job completion

umask 077 Remove access for all but user
TMPFILE=${TMPDIR-/tmp}/myprog.$$ Generate a temporary filename
trap 'rm -f $TMPFILE' EXIT Remove temporary file on completion

10.3.2 The mktemp Program
Filenames like /tmp/myprog.$$ have a problem: they are readily guessable
To deal with this security issue
mktemp takes an optional filename template containing a string of trailing X characters,preferably at least a dozen of them. It replaces them with an alphanumeric
string derived from random numbers and the process ID,creates the file with no
access for group and other, and prints the filename on standard output.

$ TMPFILE=`mktemp /tmp/myprog.XXXXXXXXXXXX` || exit 1 Make unique temporary file
$ ls -l $TMPFILE List the temporary file
-rw------- 1 jones devel 0 Mar 17 07:30 /tmp/myprog.hJmNZbq25727

The –d option requests the creation of a temporary directory:
$ SCRATCHDIR=`mktemp -d -t myprog.XXXXXXXXXXXX` || exit 1 Create temporary directory
$ ls -lFd $SCRATCHDIR List the directory itself
drwx------ 2 jones devel 512 Mar 17 07:38 /tmp/myprog.HStsWoEi6373/

10.3.3 The /dev/random and /dev/urandom Special Files

10.4 Finding Files
Shell pattern matching is not powerful enough to match files recursively through an
entire file tree,and ls and stat provide no way to select files other than by shell patterns. 

10.4.1 Finding Files Quickly
locate uses a compressed database of all of the filenames in the filesystem
to quickly find filenames that match shell-like wildcard patterns,without having to
search a possibly huge directory tree. The database is created by updatedb in a suitably privileged job,usually run nightly via cron. locate can be invaluable for users,
allowing them to answer questions like,Where does the system manager store the
gcc distribution?:
$ locate gcc-3.3.tar Find the gcc-3.3 release
/home/gnu/src/gcc/gcc-3.3.tar-lst
/home/gnu/src/gcc/gcc-3.3.tar.gz
In the absence of wildcard patterns, locate reports files that contain the argument as
a substring; here, two files matched.

Because locate’s output can be voluminous,it is often piped into a pager,such as
less, or a search filter, such as grep:
$ locate gcc-3.3 | fgrep .tar.gz Find gcc-3.3, but report only its distribution archives
/home/gnu/src/gcc/gcc-3.3.tar.gz

Wildcard patterns must be protected from shell expansion so that locate can handle
them itself:
$ locate '*gcc-3.3*.tar*' Find gcc-3.3 using wildcard matching inside locate
...
/home/gnu/src/gcc/gcc-3.3.tar.gz
/home/gnu/src/gcc/gcc-3.3.1.tar.gz

10.4.2 Finding Where Commands Are Stored
$ type gcc Where is gcc?
gcc is /usr/local/bin/gcc
$ type type What is type?
type is a shell builtin
$ type newgcc What is newgcc?
newgcc is an alias for /usr/local/test/bin/gcc
$ type mypwd What is mypwd?
mypwd is a function
$ type foobar What is this (nonexistent) command?
foobar not found

10.4.3 The find Command
If you want to select,say,files larger than a certain size,or modified in the last three
days,belonging to you,or having three or more hard links,you need the find command, one of the most powerful in the Unix toolbox

10.4.3.1 Using the find command
Unlike ls and the shells, find has no concept of hidden files: if a dotted filename is
present, find will find it.
Also unlike ls, find does not sort filenames. It just takes them in whatever order they
are found in directories that it reads,and that order is effectively random.*

$ ls #Verify that we have an empty directory
$ mkdir -p sub/sub1 #Create a directory tree
$ touch one two .uno .dos #Create some empty top-level files
$ touch sub/three sub/sub1/four #Create some empty files deeper in the tree
$ find #Find everything from here down

find | LC_ALL=C sort

find has a useful option, –ls,that gives output vaguely similar to what ls -liRs
$ find -ls
$ find -ls Find files, and use ls-style output
$ find -ls | sort -k11 Find files, and sort by filename

For comparison, here is how ls displays the same file metadata:
$ ls -liRs *

Now let’s give the find command some file patterns:
$ find 'o*' Find files in this directory starting with "o"
$ find sub Find files in directory sub
Next, we suppress directory descent:
$ find -prune #Find without looking inside this directory
.
$ find . -prune #Another way to do the same thing
$ find * -prune #Find files in this directory
$ ls -d * #List files, but not directory contents

You probably expect that all of the files in your login directory tree are owned by
you. To make sure,run the command find $HOME/. ! -user $USER. The exclamation argument means not,


The –perm option requires a following permission mask as an octal string,optionally
signed. When the mask is unsigned,an exact match on the permissions is required.

The –type option requires a following single-letter argument to specify the file type.
The important choices are d for directory, f for ordinary file, and l for symbolic link.
The –follow option asks find to follow symbolic links. You can use this to find broken links:
$ ls Show that we have an empty directory
$ ln -s one two Create a soft (symbolic) link to a nonexistent file
$ file two Diagnose this file
two: broken symbolic link to one
$ find . Find all files
.
./two
$ find . -type l Find soft links only
./two
$ find . -type l -follow Find soft links and try to follow them
find: cannot follow symbolic link ./two: No such file or directory

$ find . -size +0 -a -size -10 Find nonempty files smaller than 10 blocks (5120 bytes)
...
$ find . -size 0 -o -atime +365 Find files that are empty or unread in the past year

In “Substitution details” [3.2.7.1],we presented a
simple sed script to (begin to) convert HTML to XHTML:
$ cat $HOME/html2xhtml.sed Show sed commands for converting HTML to XHTML

cd top level web site directory
find . -name '*.html' -type f | #Find all HTML files
 while read file #Read filename into variable
 do
 echo $file #Print progress
 mv $file $file.save #Save a backup copy
 sed -f $HOME/html2xhtml.sed < $file.save > $file #Make the change
 done

10.4.3.3 A complex find script

10.4.4 Finding Problem Files
$ find -print0 | od -ab Convert NUL-terminated filenames to octal and ASCII

We can make this somewhat more readable with the help of tr,turning spaces into
S, newlines into N, and NULs into newline:
$ find -print0 | tr ' \n\0' 'SN\n' Make problem characters visible as S and N

10.5 Running Commands: xargs
$ grep POSIX_OPEN_MAX /dev/null $(find /usr/include -type f | sort)

That limit can be found with getconf:
$ getconf ARG_MAX Get system configuration value of ARG_MAX
# 131072

Here is an example that eliminates the obnoxious Argument list too long error:
$ find /usr/include -type f | xargs grep POSIX_OPEN_MAX /dev/null

The solution to the ARG_MAX problem is provided by xargs: it takes a list of arguments
on standard input,one per line,
 find /usr/include -type f | xargs grep POSIX_OPEN_MAX /dev/null

10.6 Filesystem Space Information
 find -ls | awk '{Sum += $7} END {printf("Total: %.0f bytes\n", Sum)}'
Total: 23079017 bytes

However,that report underestimates the space used,because files are allocated in
fixed-size blocks,and it tells us nothing about the used and available space in the
entire filesystem. T

10.6.1 The df Command
df (disk free) gives a one-line summary of used and available space on each mounted
filesystem
 df -k
 df -h
You can supply a list of one or more filesystem names or mount points to limit the
output to just those:
$ df -lk /dev/sda6 /var

For network-mounted filesystems,entries in the Filesystem column are prefixed by
hostname:
$ df

df’s reports about the free space on remote filesystems may be inaccurate,because of
software implementation inconsistencies in accounting for the space reserved for
emergency use

The –i (inode units) option provides a way to assess inode usage. Here is an
example, from the same web server:
$ df -i

10.6.2 The du Command
df summarizes free space by filesystem,but does not tell you how much space a particular directory tree requires. That job is done by du (disk usage).

$ du /tmp
$ du -s /tmp
$ du -s /var/log /var/spool /var/tmp

The GNU version provides the –h (human-readable) option:
$ du -h -s /var/log /var/spool /var/tmp

Some managers automate the regular processing of du reports,sending warning mail to users with unexpectedly large directory trees,such
as with the script in Example 7-1 in Chapter 7

10.7 Comparing Files
10.7.1 The cmp and diff Utilities
 cp /bin/ls /tmp Make a private copy of /bin/ls
$ cmp /bin/ls /tmp/ls Compare the original with the copy
No output means that the files are identical
$ cmp /bin/cp /bin/ls Compare different files
/bin/cp /bin/ls differ: char 27, line 1 Output identifies the location of the first difference

cmp is silent when its two argument files are identical. If you are interested only in its
exit status, you can suppress the warning message with the –s option:
$ cmp -s /bin/cp /bin/ls Compare different files silently
$ echo $? Display the exit code
1 Nonzero value means that the files differ

If you want to know the differences between two similar files, diff does the job:
$ echo Test 1 > test.1 Create first test file
$ echo Test 2 > test.2 Create second test file
$ diff test.[12] Compare the two files
1c1

10.7.2 The patch Utility
The patch utility uses the output of diff and either of the original files to reconstruct
the other one

$ diff -c test.[12] > test.dif Save a context difference in test.dif
$ patch < test.dif Apply the differences
patching file test.1
$ cat test.1 Show the patched test.1 file
Test 2

10.7.3 File Checksum Matching
































































































