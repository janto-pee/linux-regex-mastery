# Since the shell is mostly a string processing language,there are lots of things you can do with the string values of shell variables.

# 6.1 Variables and Arithmetic
# 6.1.1 Variable Assignment and the Environment
hours_per_day=24 seconds_per_hour=3600 days_per_week=7 Assign values
readonly hours_per_day seconds_per_hour days_per_week Make read-only

# The export command adds new variables to the environment:
# The environment is simply a list of name-value pairs that is available to
# every running program. New processes inherit the environment from their parent,
# and are able to modify it before creating new child processes of their own. 

PATH=$PATH:/usr/local/bin #Update PATH
export PATH #Export it

# simple one line assignment or export
readonly hours_per_day=24 seconds_per_hour=3600 days_per_week=7
export PATH=$PATH:/usr/local/bin

# The export command may also be used to print the current environment:
$ export -p #Print current environment

# Variables may be added to a program’s environment without permanently affecting
# the environment of the shell or subsequent commands. This is done by prefixing the
# assignment to the command name and arguments:
PATH=/bin:/usr/bin awk '...' file1 file2
# This changes the value of PATH only for execution of the single awk command. Any
# subsequent commands, however, see the current value of PATH in their environment.

# The env command
# may be used to remove variables from a program’s environment,or to temporarily
# change environment variable values:
env -i PATH=$PATH HOME=$HOME LC_ALL=C awk '...' file1 file2
# The –i option initializes the environment; i.e.,throws away any inherited values,
# passing in to the program only those variables named on the command line.

# The unset command removes variables and functions from the running shell. By
# default it unsets variables, although this can be made explicit with -v:
unset full_name #Remove the full_name variable
unset -v first middle last #Remove the other variables
# Use unset -f to remove functions:
who_is_on ( ) { #Define a function
 who | awk '{ print $1 }' | sort -u #Generate sorted list of users
}
...
unset -f who_is_on #Remove the function

6.1.2 Parameter Expansion
# Parameter expansion is the process by which the shell provides the value of a variable for use in the program
reminder="Time to go to the dentist!" #Save value in reminder
sleep 120 #Wait two minutes
echo $reminder #Print message

6.1.2.1 Expansion operators
# Table 6-1. Substitution operators
${varname:-word} If varname exists and isn’t null, return its value; otherwise, return word
${varname:=word} If varname exists and isn’t null, return its value; otherwise, set it to word and then return
its value
${varname:?message} If varname exists and isn’t null, return its value; otherwise, print varname: message,
and abort the current command or script. Omitting message produces the default message parameter null or not set.
${varname:+word} If varname exists and isn’t null, return word; otherwise, return null.


# Table 6-2. Pattern-matching operators
${variable#pattern} If the pattern matches the beginning of the variable’s value,
delete the shortest part that matches and return the rest.
Example: ${path#/*/} Result: tolstoy/mem/long.file.name
${variable##pattern} If the pattern matches the beginning of the variable’s value,
delete the longest part that matches and return the rest.
Example: ${path##/*/} Result: long.file.name
${variable%pattern} If the pattern matches the end of the variable’s value, delete
the shortest part that matches and return the rest.
Example: ${path%.*} Result: /home/tolstoy/mem/long.file
${variable%%pattern} If the pattern matches the end of the variable’s value, delete
the longest part that matches and return the rest.
Example: ${path%%.*} Result: /home/tolstoy/mem/


6.1.2.2 Positional parameters
echo first arg is $1
echo tenth arg is ${10}
filename=${1:-/dev/tty} #Use argument if given, /dev/tty if not

Special “variables” provide access to the total number of arguments that were
passed, and to all the arguments at once:

$# - Provides the total number of arguments passed to the shell script or function.
while [ $# != 0 ] #$# decremented by shift, loop will terminate
do
 case $1 in
 #... Process first argument
 esac
 shift #Shift first argument away (see later in text)
done

$*, $@ -Represents all the command-line arguments at once. They can be used to pass
the command-line arguments to a program being run by a script or function.

"$*" -Represents all the command-line arguments as a single string. Equivalent to "$1, $2 …". 
The first character of $IFS is used as the separator for the different values
to create the string. For example:
printf "The arguments were %s\n" "$*"

"$@" -Represents all the command-line arguments as separate,individual strings.
Equivalent to "$1" "$2" …. This is the best way to pass the arguments on to
another program,since it preserves any whitespace embedded within each argument. For example:
lpr "$@" Print each file

The set command serves a number of purposes. When invoked without options,it sets the value of
the positional parameters, throwing away any previously existing values:
set -- hi there how do you do #The – – ends options; "hi" starts new arguments

see 01-special-variables.sh

# OTHER SPECIAL VARIABLES
# Number of arguments given to current process.
@ Command-line arguments to current process. Inside double quotes, expands to individual arguments.
* Command-line arguments to current process. Inside double quotes, expands to a single argument.
- (hyphen) Options given to shell on invocation.
? Exit status of previous command.
$ Process ID of shell process.
0 (zero) The name of the shell program.
! Process ID of last background command. Use this to save process ID numbers for later use with the wait
command.
ENV Used only by interactive shells upon invocation; the value of $ENV is parameter-expanded. The result
should be a full pathname for a file to be read and executed at startup. This is an XSI requirement.
HOME Home (login) directory.
IFS Internal field separator; i.e., the list of characters that act as word separators. Normally set to space, tab,
and newline.
LANG Default name of current locale; overridden by the other LC_* variables.
LC_ALL Name of current locale; overrides LANG and the other LC_* variables.
LC_COLLATE Name of current locale for character collation (sorting) purposes.


6.1.3 Arithmetic Expansion
For example, $((3 > 2)) has the value 1; $(( (3 > 2) || (4 <= 1) )) also has the
value 1, since at least one of the two subexpressions is true.

6.2.1 Exit Status Values
By convention,an exit status of 0 indicates “success”; i.e.,that the program ran and
didn’t encounter any problems. Any other exit status indicates failure

 ls -l /dev/null
$ echo $?

$ ls foo
$ echo $?

6.2.2 if–elif–else–f
if pipeline
 [ pipeline … ]
then
 statements-if-true-1
[ elif pipeline
 [ pipeline … ]
then
 statements-if-true-2
… ]
[ else
 statements-if-all-else-fails ]
fi


6.2.3 Logical NOT, AND, and OR
if ! grep pattern myfile > /dev/null
then
 ... Pattern is not there
fi

if grep pattern myfile > /dev/null
then
 : # do nothing
else
 ... Pattern is not there
fi

if grep pattern1 myfile && grep pattern2 myfile
then
 ... myfile contains both patterns
fi
# In contrast,the || operator is used when you want to test if one condition or the
# other is true:
if grep pattern1 myfile || grep pattern2 myfile
then
 ... One or the other is present
fi

who | grep tolstoy > /dev/null && echo tolstoy is logged on
6.2.4 The test Command
Thus, these two statements test two strings for equality:
if test "$str1" = "$str2"   if [ "$str1" = "$str2" ]
then                        then
 ...                        ...
fi                          fi

# checkout Table 6-6. test expressions
if [ -f "$file" ]
then
 echo $file is a regular file
elif [ -d "$file" ]
then
 echo $file is a directory
fi
if [ ! -x "$file" ]
then
 echo $file is NOT executable
fi
Expressions can
be combined with -a (for logical AND) and with -o (for logical OR). -a has higher
precedence than -o,and = and != have higher precedence than the other binary operators. Parentheses may be used for grouping and to change evaluation order.

There is a difference between using -a and -o,which are test operators, and && and ||, which are shell operators.
# if [ -n "$str" -a -f "$file" ] #Two conditions, one test command
# if [ -n "$str" ] && [ -f "$file ] #Two commands, short-circuit evaluation
# if [ -n "$str" && -f "$file" ] #Syntax error, see text

In the first case, test evaluates both conditions. In the second one,the
shell runs the first test command,and runs the second one only if the
first one was successful. In the last case, && is a shell operator,so it terminates the first test command. This command will complain that
there is no terminating ] character,and exits with a failure value. Even
if test were to exit successfully,the subsequent check would fail,since
the shell (most likely) would not find a command named -f.

For portability,the POSIX standard recommends the use of shell-level tests for multiple conditions,instead of the -a and -o operators. (We also recommend this.) For
example:
if [ -f "$file" ] && ! [ -w "$file" ]
then
 # $file exists and is a regular file, but is not writable
 echo $0: $file is not writable, giving up. >&2
 exit 1
fi

Arguments are required
For this reason,all shell variable expansions should be quoted so that test
receives an argument, even if it turns out to be the null string. For example:
if [ -f "$file" ] ... Correct
if [ -f $file ] ... Incorrect

String comparisons are tricky
String comparisons are tricky
In particular,if a string value is empty,or starts with a minus, test could become
confused. This leads to the rather ugly,but widespread convention of prefixing
string values with the letter X. (The use of X is arbitrary, but traditional.)
if [ "X$answer" = "Xyes" ] ...
You will see this used in many shell scripts,and it is in fact used in examples
throughout the POSIX standard.

test can be fooled
test -r a_file && cat a_file

it can fail in practice.* About all you can do is
add another layer of defensive programming:
if test -r a_file && cat a_file
then
 # cat worked, proceed on
else
 # attempt to recover, issue an error message, etc.
fi

e.g finduser script requires an argument

6.3 The case Statement
If you need to check a variable for one of many values,you could use a cascading
series of if and elif tests, together with test:
if [ "X$1" = "X-f" ]
then
 ... Code for –f option
elif [ "X$1" = "X-d" ] || [ "X$1" = "X--directory" ] # long option allowed
then
 ... Code for –d option
else
 echo $1: unknown option >&2 #The >&2 sends the output to standard error (file descriptor).
 exit 1
fi

Lets rewrite the code above in case statement
case $1 in
-f)
 ... Code for –f option
 ;;
-d | --directory) # long option allowed
 ... Code for –d option
 ;;
*)
 echo $1: unknown option >&2
 exit 1
 # ;; is good form before `esac', but not required
esac


6.4 Looping
6.4.1 for Loops

mv atlga.xml atlga.xml.old
sed 's/Atlanta/&, the capital of the South/' < atlga.xml.old > atlga.xml

# Now suppose,as is much more likely,that we have a number of XML files that make
# up our brochure. In this case,we want to make the change in all the XML files. The
# for loop is perfect for this:
for i in atlbrochure*.xml
do
 echo $i
 mv $i $i.old
 sed 's/Atlanta/&, the capital of the South/' < $i.old > $i
done

The in list part of the for loop is optional. When omitted,the shell loops over the
command-line arguments. Specifically, it’s as if you had typed for i in "$@":
for i # loop over command-line args
do
 case $i in
 -f) ...
 ;;
 ...
 esac
done

6.4.2 while and until Loops
The only difference between while and until is how the exit status of condition is
treated. while continues to loop as long as condition exited successfully. until loops
as long as condition exits unsuccessfully

pattern=... #pattern controls shortening of string
while [ -n "$string" ] #While string is not empty
do
process current value of $string
 string=${string%$pattern} #Lop off part of string
done
In practice,the until loop is used much less than the while loop,but it can be useful
when you need to wait for an event to happen.

Checkout Example 6-2. Wait for a user to log in, using until

# It is possible to pipe into a while loop,for iterating over each line of input,as shown
# here:
generate data |
 while read name rank serial_no
 do
 echo $name $rank $serial_no
 done
In such cases,the command used for the while loop’s condition is usually the read
command.

6.4.3 break and continue
The shell borrowed the
break and continue commands from C. They are used to leave a loop,or to skip the
rest of the loop body,respectively.
checkout 

while condition1 #Outer loop
do ...
 while condition2 #Inner loop
 do ...
 break 2 #Break out of outer loop
 done
done
# ... Execution continues here after break

6.4.4 shift and Option Processing
checkout 04-shift-processing

The getopts command simplifies option processing. It understands the POSIX
option conventions that allow grouping of multiple option letters together,and can
be used to loop through command-line arguments one at a time.
The first argument to getopts is a string listing valid option letters. If an option letter
is followed by a colon,then that option requires an argument,which must be supplied. Upon encountering such an option, getopts places the argument value into the
variable OPTARG. The variable OPTIND contains the index of the next argument to be
processed. The shell initializes this variable to 1.
The second argument is a variable name. This variable is updated each time getopts
is called; its value is the found option letter. When getopts finds an invalid option,it

sets the variable to a question mark character. Here is the previous example,using
getopts:
checkout 05 options processing

6.5 Functions
checkout example 06-function user logged
The wait_for_user function can be invoked in
one of two ways:
wait_for_user tolstoy #Wait for tolstoy, check every 30 seconds
wait_for_user tolstoy 60 #Wait for tolstoy, check every 60 seconds


Within a function body,the positional parameters ($1, $2,etc., $#, $*,and $@) refer
to the function’s arguments.

Functions return integer exit status values,just like commands. For functions also,
zero means success,nonzero means failure


Example 5-6 in “Tag Lists” [5.5],showed a nine-stage pipeline to produce a sorted
list of SGML/XML tags from an input file. It worked only on the one file named on
the command line. We can use a for loop for argument processing,and a shell function to encapsulate the pipeline,in order to easily process multiple files. The modified script is shown in Example 6-5.





















































