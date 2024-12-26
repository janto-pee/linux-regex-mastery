#! /bin/sh

# commands:
# who; wc; cat; cd; ls

# script to display the number of users logged in:
who | wc -l


#2
# difference between commands and arg
# commands are executed while arguments are provided to commands e.g cd work
# cd is command, work is argument
# The shell recognizes three fundamental kinds of commands: built-in commands,
# shell functions, and external commands:
# Built-in commands are just that: commands that the shell itself executes.
# Shell functions are self-contained chunks of code,written in the shell language,
# that are invoked in the same way as a command is.
# External commands are those that the shell runs by creating a separate process


#3
# Variables

stri=4          #assign variables
myvar=this_is_a_long_string_that_does_not_mean_much #assign variables
echo $stri
echo $myvar

first=isaac middle=bashevis last=singer #Multiple assignments allowed on one line
fullname="isaac bashevis singer" #Use quotes for whitespace in value
echo $fullname

oldname=$fullname #Quotes not needed to preserve spaces in value
fullname="$first $middle $last" #Double quotes required here
echo "oldname is $oldname but fullname is $fullname"


#4
# echo

echo Now is the time for all good men
# Now is the time for all good men
echo to come to the aid of their country.
# to come to the aid of their country.
# Unfortunately,over time,different versi
 echo -n "Enter your name: " #Print prompt
#  Enter your name: _ Enter data
echo "Enter your name: \c" #Print prompt
# Enter your name: _ Enter data

#5 
# Printf

printf "Hello, world\n"
printf "The first program always prints '%s, %s!'\n" Hello world
# The first program always prints 'Hello, world!'

#6
#  Basic I/O Redirection

#cat With no arguments, read standard input, write standard output
# now is the time Typed by the user
# now is the time Echoed back by cat
# for all good men
# for all good men
# to come to the aid of their country
# to come to the aid of their country

#7
# Redirection and pipelines

# Change standard input with <
tr -d '\r' < dos-file.txt ...
# Change standard output with >
tr -d '\r' < dos-file.txt > unix-file.txt
# Append to a file with >>
for f in dos-file*.txt
do
 tr -d '\r' < $f >> big-unix-file.txt
done
# Create pipelines with |
tr -d '\r' < dos-file.txt | sort > unix-file.txt


#8
# Special files: /dev/null and /dev/tty
if grep pattern myfile > /dev/null
then
 echo ... Pattern is there
else
 echo ... Pattern is not there
fi

# /dev/null,is often known as the “bit bucket.” Data sent to this
# file is thrown away by the system

# /dev/tty. When a program opens this file,Unix automatically 
# redirects it to the real terminal (physical console or serial port,
# or pseudoterminal for network and windowed logins) associated with the program


printf "Enter new password: " #Prompt for input
# stty -echo #Turn off echoing of typed characters
read pass < /dev/tty #Read password
printf "Enter again: " #Prompt again
read pass2 < /dev/tty #Read again for verification
# stty echo #Don't forget to turn echoing back on

# 9
# Basic Command Searching

echo $PATH

# how do you create your own bin and add it to the list in path
mkdir bin #Make a personal “bin” directory
mv nusers bin #Put our script there
PATH=$PATH:$HOME/bin #Append our bin directory to PATH
nusers #Test it out
#  6 The shell finds it

# To make the change permanent,add your bin directory to $PATH in your .profile

#10
#Accessing Shell Script Arguments
# The so-called positional parameters represent a shell script’s command-line arguments.
echo first arg is $1
echo tenth arg is ${10}

$ who | grep betsy #Where is betsy?

# checkout script finduser
# cat > finduser Create new file
# #! /bin/sh
# # finduser --- see if user named by first argument is logged in
# who | grep $1
# ctrl+D
# chmod +x finduser
# ./finduser betsy
# ./finduser benjamin
# mv finduser $HOME/bin
# 


#11
# 2.7 Simple Execution Tracing

# This causes the shell to print out
# each command as it’s executed,preceded by “+ ”

sh -x nusers #test in workout bin

# cat > trace1.sh Create script
# #! /bin/sh
# set -x Turn on tracing
# echo 1st echo Do something
# set +x Turn off tracing
# echo 2nd echo



# 12
# Internationalization
# local environment variable

# LANG Default value for any LC_xxx variable that is not otherwise set
# LC_ALL Value that overrides all other LC_xxx variables
# LC_COLLATE Locale name for collation (sorting)
# LC_CTYPE Locale name for character types (alphabetic, digit, punctuation, and so on)
# LC_MESSAGES Locale name for affirmative and negative responses and for messages; POSIX only
# LC_MONETARY Locale name for currency formatting
# LC_NUMERIC Locale name for number formatting
# LC_TIME Locale name for date and time formatting