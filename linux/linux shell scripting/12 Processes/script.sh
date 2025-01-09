A process is an instance of a running program. New processes are started by the
fork( ) and execve( ) system calls,and normally run until they issue an exit( ) system call. The details of the fork( ) and execve( ) system calls are complex and not
needed for this book. Consult their manual pages if you want to learn more.

Processes are assigned priorities so that time-critical processes run before less important ones. The nice and renice commands can be used to adjust process priorities.
The average number of processes awaiting execution at any instant is called the load
average. You can display it most simply with the uptime command:

 uptime #Show uptime, user count, and load averages
 1:51pm up 298 day(s), 15:42, 32 users, load average: 3.51, 3.50, 3.55

Because the load average varies continually, uptime reports three time-averaged estimates,usually for the last 1,5,and 15 minutes. When the load average continually
exceeds the number of available CPUs,there is more work for the system to do than
it can manage, and its response may become sluggish.

13.1 Process Creation
One of the great contributions of Unix to the computing world is that process creation is cheap and easy.
This encourages the practice of writing small programs that
each do a part of a larger job,and then combining them to collaborate on the completion of that task. Because programming complexity grows much faster than linearly with program size,small programs are much easier to write,debug,and
understand than large ones.

13.2 Process Listing
The most important command for listing processes is the process status command,
ps
$ /bin/ps System V-style process status
$ /usr/ucb/ps BSD-style process status
Without command-line options,their output is quite similar,with the BSD style supplying a few more details. Output is limited to just those processes with the same
user ID and same controlling terminal as those of the invoker.

To get verbose ps output,we need quite different sets of options. In the System V style, we use:
$ ps -efl System V style
 F S UID PID PPID C PRI NI ADDR SZ WCHAN STIME TTY TIME CMD
19 T root 0 0 0 0 SY ? 0 Dec 27 ? 0:00 sched
 8 S root 1 0 0 41 20 ? 106 ? Dec 27 ? 9:53 /etc/init -
19 S root 2 0 0 0 SY ? 0 ? Dec 27 ? 0:18 pageout
19 S root 3 0 0 0 SY ? 0 ? Dec 27 ? 2852:26 fsflush

whereas in the BSD style, we use:
$ ps aux BSD style
USER PID %CPU %MEM SZ RSS TT S START TIME COMMAND
root 3 0.4 0.0 0 0 ? S Dec 27 2852:28 fsflush
smith 13680 0.1 0.2 1664 1320 pts/25 O 15:03:45 0:00 ps aux
jones 25268 0.1 2.02093619376 pts/24 S Mar 22 29:56 emacs -bg ivory
brown 26519 0.0 0.3 5424 2944 ? S Apr 19 2:05 xterm -name thesis

Both styles allow option letters to be run together,and the BSD style allows the
option hyphen to be dropped. In both examples,we removed excess whitespace to
make the lines fit on the page.

The USER and UID fields identify the owner of a process: that can be critical information if a process is hogging the system.
The PID value is the process ID,a number that uniquely identifies the process. In the
shell,that number is available as $$: we use it in other chapters to form unique
names of temporary files. Process ID assignments start out at zero,and increment for
each new process throughout the run life of the system. When the maximum representable integer is reached,process numbering starts again at zero,but avoids values
that are still in use for other processes. A typical single-user system might have a few
dozen active processes,whereas a large multiuser system might have several
thousand.
The PPID value is the parent process ID: the number of the process that created this
one. Every process,except the first,has a parent,and each process may have zero or
more child processes,so processes form a tree. Process number 0 is usually called
something like kernel, sched,or swapper,and is not shown in ps output on some systems. Process number 1 is rather special; it is called init,and is described in the
init(8) manual pages. A child process whose parent dies prematurely is assigned init
as its new parent. When a system is shut down properly,processes are killed in
approximate order of decreasing process IDs,until only init remains. When it exits,
the system halts.
The output of ps is not guaranteed to be in any particular order,and since the list of
processes is continually changing, its output usually differs on each run

Since the process list is dynamic,many users prefer to see a continually updating pslike text display,or a graphical representation thereof. Several utilities provide such
display,but none is universally available. The most common one is top,now standard in many Unix distributions.

On most systems, top requires intimate knowledge of kernel data structures,
Also, top (like
ps) is one of those few programs that needs to run with special privileges: on some
systems, it may be setuid root.

Here’s a snapshot of top output on a moderately busy multiprocessor compute
server:
$ top #Show top resource consumers

By default, top shows the most CPU-intensive processes at the top of the list,which
is usually what you are interested in
However,it accepts keyboard input to control
sort order,limit the display to certain users,and so on: type ? in a top session to see
what your version offers

In most cases,the shell waits for a process to terminate before processing the next
command. However,processes can be made to run in the background by terminating the command with an ampersand instead of a semicolon or newline: we used
that feature in the build-all script in “Automating Software Builds” [8.2]. The wait
command can be used to wait for a specified process to complete,or,without an
argument, for completion of all background processes.

Four keyboard characters interrupt foreground processes. These characters are settable with stty command options,usually to Ctrl-C (intr: kill),Ctrl-Y (dsusp: suspend,but delay until input is flushed),Ctrl-Z (susp: suspend),and Ctrl-\ (quit: kill
with core dump)

checkout 01-top-version.sh

We save command options in HEADFLAGS, PSFLAGS, SLEEPFLAGS,and SORTFLAGS to facilitate site-specific customization.

 The clear command at the start of
each loop iteration uses the setting of the TERM environment variable to determine the
escape sequences that it then sends to standard output to clear the screen,leaving the
cursor in the upper-left corner. uptime reports the load average,and echo supplies the
column headers.

The pipeline filters ps output,using sed to remove the header line,
then sorts the output by CPU usage,username,and process ID,and shows only the
first 20 lines. The final sleep command in the loop body produces a short delay that
is still relatively long compared to the time required for one loop iteration so that the
system load imposed by the script is minor

Sometimes,you would like to know who is using the system,and how many and
what processes they are running,without all of the extra details supplied by the verbose form of ps output. The puser script in Example 13-2 produces a report that
looks like this:
$ puser #Show users and their processes

After the familiar preamble,the puser script uses a loop to collect the optional command-line arguments into the EGREPFLAGS variable,with the vertical-bar separators
that indicate alternation to egrep. The if statement in the loop body handles the initial case of an empty string,to avoid producing an egrep pattern with an empty alternative

The seven-stage pipeline handles the report preparation:

13.3 Process Control and Deletion
 kill -l List supported signal names (option lowercase L)

$ top Show top resource consumers
$ kill -STOP 17787 Suspend process
$ sleep 36000 && kill -CONT 17787 & Resume process in 10 hours

13.3.1 Deleting Processes
For deleting processes,it is important to know about only four signals: ABRT (abort),
HUP (hangup), KILL, and TERM (terminate).

Some programs prefer to do some cleanup before they exit: they generally interpret a
TERM signal to mean clean up quickly and exit. kill sends that signal if you do not
specify one. ABRT is like TERM,but may suppress cleanup actions,and may produce a
copy of the process memory image in a core, program.core, or core.PID file
The HUP signal similarly requests termination,but with many daemons,it often
means that the process should stop what it is doing,and then get ready for new
work,as if it were freshly started.

The two signals that no process can catch or ignore are KILL and STOP. These two signals are always delivered immediately.

Web browsers normally require relatively little CPU time,so this one certainly looks
like a runaway process. Send it a HUP signal:
$ kill -HUP 25094 Send a HUP signal to process 25094



Run top again, and if the runaway does not soon disappear from the display, use:
$ kill -TERM 25094 Send a TERM signal to process 25094
or finally:
$ kill -KILL 25094 Send a KILL signal to process 25094
Most top implementations allow the kill command to be issued from inside top
itself.

A process that is awaiting an event,such as the completion of I/O,or the expiration of a timer,is in a suspended state called a sleep,and the process scheduler does not consider it runnable. When the event finally
happens, the process is again schedulable for execution, and is then said to be awake.

ome systems (GNU/Linux,NetBSD,and Sun Solaris) have pgrep and pkill commands that allow you to hunt down and kill processes by name. Without extra command-line options to force it to be more selective, pkill sends a signal to all
processes of the specified name. For the runaway-process example,we might have
issued:
$ pgrep netscape Find process numbers of netscape jobs
25094
followed by:
$ pkill -HUP netscape Send netscape processes a HUP signal
$ pkill -TERM netscape Send netscape processes a TERM signal
$ pkill -KILL netscape Send netscape processes a KILL signal

13.3.2 Trapping Process Signals
Processes register with the kernel those signals that they wish to handle.
They specify in the arguments of the signal( ) library call whether the signal should be caught,
should be ignored,or should terminate the process,possibly with a core dump. To
free most programs from the need to deal with signals,the kernel itself has defaults
for each signal. For example, on a Sun Solaris system, we find:
$ man -a signal Look at all manual pages for signal

The trap command causes the shell to register a signal handler to catch the specified
signals. trap takes a string argument containing a list of commands to be executed
when the trap is taken,followed by a list of signals for which the trap is set
03-sleepy-looper script

We run it in the background, and send it the two signals that it handles
$ ./looper & Run looper in the background
[1] 24179 The process ID is 24179
$ kill -HUP 24179 Send looper a HUP signal
Ignoring HUP ...
$ kill -USR1 24179 Send looper a USR1 signal
Terminating on USR1 ...
[1] + Done(1) ./looper &
Now let’s try some other signals:
$ ./looper & Run looper again in the background
[1] 24286
$ kill -CHLD 24286 Send looper a CHLD signal
$ jobs Is looper still running?
[1] + Running ./looper &
$ kill -FPE 24286 Send looper an FPE signal
[1] + Arithmetic Exception(coredump)./looper &
$ ./looper & Run looper again in the background
[1] 24395
$ kill -PIPE 24395 Send looper a PIPE signal
[1] + Broken Pipe ./looper &
$ ./looper & Run looper again in the background
[1] 24621
$ kill 24621 Send looper the default signal, TERM
[1] + Done(208) ./looper &

Notice that the CHLD signal did not terminate the process; it is one of the signals
whose kernel default is to be ignored. 

We give the modified script a new name, and run it:
$ ./looper-2 & Run looper-2 in the background
$ kill -ABRT 24668 Send looper-2 an ABRT signal



13.4 Process System-Call Tracing
Many systems provide system call tracers,programs that execute target programs,
printing out each system call and its arguments as the target program executes them.
It is likely you have one on your system; look for one of the following commands:
ktrace, par, strace, trace,or truss















































































































































































































