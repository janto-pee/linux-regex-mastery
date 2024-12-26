# The idea is that programs should have a data source,a data sink (where data
# goes),and a place to report problems. These are referred to by the names standard
# input, standard output,and standard error,respectively. A program should neither
# know,nor care,what kind of device lies behind its input and outputs

# 7.2 Reading Lines with read
printf "x is now '%s'" $x 
$ x=abc ; printf "x is now '%s'. Enter new value: " $x ; read x
# x is now 'abc'. Enter new value: PDQ
$ echo $x
# PDQ

# read can read values into multiple variables at one time. In this case,characters in
# $IFS separate the input line into individual words. For example:
printf "Enter name, rank, serial number: "
read name rank serno

# For example:
# jones:*:32713:899:Adrian W. Jones/OSD211/555-0123:/home/jones:/bin/ksh
while IFS=: read user pass uid gid fullname homedir shell
do
#  ... Process each user's' line
echo version- $user $pass $uid $gid $fullname $homedir $shell
done < /etc/passwd


# Incorrect use of redirection:
while IFS=: read user pass uid gid fullname homedir shell < /etc/passwd
do
#  ... Process each user's line
done
it would never terminate! Each time around the loop,the shell would open /etc/
passwd anew, and read would read just the first line of the file!

# Easier to read, with tiny efficiency loss in using cat:
cat /etc/passwd |
 while IFS=: read user pass uid gid fullname homedir shell
 do
#  ... Process each user's line
# echo version- $user $pass $uid $gid $fullname $homedir $shell
 done

# This is a general technique: any command can be used to pipe input into read. 
find /home/tolstoy -type d -print | #Find all directories
 sed 's;/home/tolstoy/;/home/lt/;' | #Change name, note use of semicolon delimiter
 sed 's/^/mkdir /' | #Insert mkdir command
 sh -x Execute, with shell tracing

# However,it can be done easily,and more naturally from a shell programmer’s point
# of view, with a loop:
find /home/tolstoy -type d -print | #Find all directories
 sed 's;/home/tolstoy/;/home/lt/;' | #Change name, note use of semicolon delimiter
 while read newdir #Read new directory name
 do
 mkdir $newdir #Make new directory
 done

# the default behavior of read has been to treat a trailing backslash on an input line as an indicator of line continuation

$ printf "Enter name, rank, serial number: " ; read name rank serno
# Enter name, rank, serial number: Jones \
# > Major \
# > 123-45-6789
$ printf "Name: %s, Rank: %s, Serial number: %s\n" $name $rank $serno
# Name: Jones, Rank: Major, Serial number: 123-45-6789

# Occasionally,however,you want to read exactly one line,no matter what it contains.
 read -r name rank serno
$ echo $name $rank $serno

# 7.3 More About Redirections
# 7.3.1 Additional Redirection Operators
Use >| with set -C
# The POSIX shell has an option that prevents accidental file truncation.

# Provide inline input with << and <<-
# Use program << delimiter to provide input data within the body of a shell script.
see 01-inline-input
This example sends email to the top ten “disk hogs” on the system,asking them
to clean up their home directories.

If the delimiter is quoted in any fashion,the shell does no processing on the
body of the input:
# $ i=5 #Set a variable
# $ cat << 'E'OF Delimiter is quoted
# > This is the value of i: $i Try a variable reference
# > Here is a command substitution: $(echo hello, world) Try command substitution
# > EOF
# This is the value of i: $i Text comes out verbatim
# Here is a command substitution: $(echo hello, world)


# The second form of the here document redirector has a trailing minus sign. In
# this case,all leading tab characters are removed from the here document and the
# closing delimiter before being passed to the program as input. (Note that only
# leading tab characters are removed,not leading spaces!) This makes shell scripts
# much easier to read.

# Open a file for input and output with <>
# Use program <> file to open file for both reading and writing. The default is to
# open file on standard input.
# Normally, < opens a file read-only,and > opens a file write-only

# 7.3.2 File Descriptor Manipulation
# File descriptors 0,1,and 2 correspond to standard input,standard output,and standard error,respectively. 
make 1> results 2> ERRS
# This sends make’s* standard output (file descriptor 1) to results and its standard
# error (file descriptor 2) to ERRS.

#  Catching the error
# messages in a separate file is often useful; this way you can review them with a pager
# or editor while you fix the problems

 A different take on this is to be cavalier and throw error messages away:
make 1> results 2> /dev/null

This next example sends both output and error messages to the same file:
make > results 2>&1

# Ordering here is significant: the shell processes redirections left to right. Had the
# example been:
make 2>&1 > results
# the shell would first send standard error to wherever file descriptor 1 is—which is
# still the terminal—and then change file descriptor 1 (standard output) to be results

Finally,the exec command may be used to change the shell’s own I/O settings.
exec 2> /tmp/$0.log #Redirect shell's own standard error
exec 3< /some/file #Open new file descriptor 3
...
read name rank serno <&3 #Read from that file

exec 5>&2 Save original standard error on fd 5
exec 2> /tmp/$0.log Redirect standard error
... Stuff here
exec 2>&5 Copy original back to fd 2
exec 5>&- Close fd 5, no longer needed

7.4 The Full Story on printf
$ printf "a string, no processing: <%s>\n" "A\nB"
# a string, no processing: <A\nB>

$ printf "a string, with processing: <%b>\n" "A\nB"
# a string, with processing: <A
# B>
The printf command can be used to specify the width and alignment of output
fields.
The first example right-justifies the text:
$ printf "|%10s|\n" hello
| hello|
The next example left-justifies the text:
$ printf "|%-10s|\n" hello
|hello |
$ printf "%.5d\n" 15
00015
$ printf "%.10s\n" "a very long string"
a very lon
$ printf "%.2f\n" 123.4567
123.46

$ width=5 prec=6 myvar=42.123456
$ printf "|%${width}.${prec}G|\n" $myvar POSIX
|42.1235|
$ printf "|%*.*G|\n" 5 6 $myvar ksh93 and bash
|42.1235|

$ printf "|%-10s| |%10s|\n" hello world Left-, right-justified strings
|hello | | world|
$ printf "|% d| |% d|\n" 15 -15 Space flag
| 15| |-15|
$ printf "%+d %+d\n" 15 -15 + flag
+15 -15
$ printf "%x %#x\n" 15 15 # flag
f 0xf
$ printf "%05d\n" 15 0 flag
00015

$ printf "%s is %d\n" a "'a"
a is 97


# 7.5 Tilde Expansion and Wildcards
# 7.5.1 Tilde Expansion
# The purpose of tilde expansion is to replace a symbolic representation for a user’s
# home directory with the actual path to that directory

 vi ~/.profile #Same as vi $HOME/.profile
$ vi ~tolstoy/.profile #Edit user tolstoy's' .profile file
# In the first case,the shell replaces the ~ with $HOME,the current user’s home directory. In the second case,the shell looks up user tolstoy in the system’s password
# database,and replaces ~tolstoy with tolstoy’s home directory,whatever that may
# be

printf "Enter username: " #Print prompt
read user #Read user
vi /home/$user/.profile #Edit user's .profile file

printf "Enter username: " #Print prompt
read user #Read user
vi ~$user/.profile #Edit user's .profile file

7.5.2 Wildcarding
Basic wildcards
? #Any single character
* #Any string of characters
[set] #Any character in set
[!set] #Any character not in set

The expression whizprog.* matches all three files in the previous paragraph; web designers can use the expression *.html to match their input files

7.5.2.1 Hidden files
Examples include $HOME/.profile for the shell, $HOME/.exrc for the
ex/vi editor,and $HOME/.inputrc for the GNU readline library used by bash and gdb

echo .* Show hidden files
 ls -la

7.6 Command Substitution
There are two forms for command substitution. The first form uses so-called backquotes, or grave accents (`…`), to enclose the command to be run:
for i in `cd /old/code/dir ; echo *.c` #Generate list of files in /old/code/dir
do #Loop over them
 diff -c /old/code/dir/$i $i | more #Compare old version to new in pager program
done

# The shell first executes cd /old/code/dir ; echo *.c. The resulting output (a list of
# files) then becomes the list to use in the for loop.

$ echo outer `echo inner1 \`echo inner2\` inner1` outer
outer inner1 inner2 inner1 outer

Things get worse with double-quoted strings:
$ echo "outer +`echo inner -\`echo \"nested quote\" here\`- inner`+ outer"
outer +inner -nested quote here- inner+ outer

$ echo "outer +`echo inner -\`echo \"nested quote\" here\`- inner`+ outer"
outer +inner -nested quote here- inner+ outer

the Korn shell. Instead of
using backquotes,enclose the command in $(…)

$ echo outer $(echo inner1 $(echo inner2) inner1) outer
outer inner1 inner2 inner1 outer
$ echo "outer +$(echo inner -$(echo "nested quote" here)- inner)+ outer"
outer +inner -nested quote here- inner+ outer
This style is recommended for all new development

for i in $(cd /old/code/dir ; echo *.c) Generate list of files in /old/code/dir
do Loop over them
 diff -c /old/code/dir/$i $i Compare old version to new
done | more Run all results through pager program

7.6.1 Using sed for the head Command
$ head -n 5 ../00\ Content/etc-password
# Earlier,Example 3-1 in Chapter 3 showed a simple version of the head command that
# used sed to print the first n lines of a file. The real head command allows you to specify with an option how many lines to show; e.g., head -n 10 /etc/passwd.
# Example 7-2. The head command as a script using sed, revised version
# see 04-head-command.sh

7.6.2 Creating a Mailing List
Consider the following problem. New versions of the various Unix shells appear
from time to time,and at many sites users are permitted to choose their login shell
from among the authorized ones listed in /etc/shells. Thus,it would be nice for system management to notify users by email when a new version of a particular shell
has been installed.

see 05-etc-to-mailing-list
 cat /tmp/bin-bash.mailing-list
 cat /tmp/bin-tcsh.mailing-list
$ cat /tmp/bin-ksh.mailing-list

Being able to create mailing lists can be generally useful. For example,if process
accounting is enabled,it is easy to make a mailing list for every program on the system by extracting program names and the names of the users who ran the program
from the process accounting records

# sa -u
sa -u | awk '{ print $1 "::::::" $8 }' | sort -u | passwd-to-mailing-list

7.6.3 Simple Math: expr
$((…)).
$ i=1 #Initialize counter
$ while [ "$i" -le 5 ] #Loop test
> do
> echo i is $i #Loop body: real code goes here
> i=`expr $i + 1` #Increment loop counter
> done
 echo $i

 i=1 #Initialize counter
$ while [ "$i" -le 5 ] #Loop test
> do
> echo i is $i #Loop body: real code goes here
> i=$((i + 1)) #Increment loop counter
> done
 echo $i


7.7 Quoting
# There are three ways to quote things:
# Backslash escaping => Preceding a character with a backslash (\)
$ echo here is a real star: \* and a real question mark: \?
# here is a real star: * and a real question mark: ?

Single quotes ('…') 
$ echo 'here are some metacharacters: * ? [abc] ` $ \'
# here are some metacharacters: * ? [abc] ` $ \

 echo 'He said, "How'\''s tricks?"'
He said, "How's tricks?"
$ echo "She replied, \"Movin' along\""
She replied, "Movin' along"

Double quotes ("…") 
$ x="I am x"
$ echo "\$x is \"$x\". Here is some output: '$(echo Hello World)'"
# $x is "I am x". Here is some output: 'Hello World'

7.8 Evaluation Order and eval
7.8.1 The eval Statement

7.8.2 Subshells and Code Blocks
# Two other constructs are occasionally useful: subshells and code blocks.
# A subshell is a group of commands enclosed in parentheses. The commands are run
# in a separate process

# This is particularly useful if you need a small group of commands to run in a different directory,without changing the directory of the main
# script. 

tar -cf - . | (cd /newdir; tar -xpf -)

The lefthand tar command creates a tar archive of the current directory,sending it
to standard output

A code block is conceptually similar to a subshell,but it does not create a new process.

cd /some/directory || { Start code block
    echo could not change to /some/directory! >&2 What went wrong
    echo you lose! >&2 Snide remark
    exit 1 Terminate whole script
} End of code block

Subshell ( ) Anywhere on the line Yes
Code block { } After newline, semicolon, or keyword No

7.9 Built-in Commands
































































































































































