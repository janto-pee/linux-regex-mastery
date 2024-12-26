# 3.2.6 Making Substitutions in Text Files
# 3.2.7 Basic Usage
# sed 's/:.*//' /etc/passwd | #Remove everything after the first colon
#  sort -u #Sort list and remove duplicates

# sed 's/\(:\).*\1.*\1.*\1.*\1/ /' ../15\ Workbook/bin/etcfile | sort -u

# the / character acts as a delimiter

find ../ -type d -print | #Find all directories
 sed 's;../;../ch/;' | #Change name, note use of semicolon delimiter
 sed 's/^/mkdir /' | #Insert mkdir command
 sh -x #Execute, with shell tracing

# 3.2.7.1 Substitution details
# We’ve already mentioned that any delimiter may be used besides slash. It is also possible to escape the delimiter within the regular expression or the replacement text,
# but doing so can be much harder to read:
sed 's/\/home\/tolstoy\//\/home\/lt\//'

# the use of backreferences in regular expressions.
echo /home/tolstoy/ | sed 's;\(/home\)/tolstoy/;\1/lt/;'
# Finally,the & in the replacement text means “substitute at this point the entire text matched by the regular
# expression.” For example

mv atlga.xml atlga.xml.old
sed 's/Atlanta/&, the capital of the South/' < atlga.xml.old > atlga.xml

# To get a literal & character in the replacement text,backslash-escape it.
sed 's/\\/\&bsol;/g'

echo Tolstoy reads well. Tolstoy writes well. > example.txt #Sample input
sed 's/Tolstoy/Camus/' < example.txt #No "g"
# Camus reads well. Tolstoy writes well.
sed 's/Tolstoy/Camus/g' < example.txt #With "g"
# Camus reads well. Camus writes well.
sed 's/Tolstoy/Camus/2' < example.txt #Second occurrence only
# Tolstoy reads well. Camus writes well.

sed -e 's/foo/bar/g' -e 's/chicken/cow/g' myfile.xml > myfile2.xml

# When you have more than a few edits,though,this form gets tedious. At some point,
# it’s better to put all your edits into a script file, and then run sed using the –f option:

#  cat fixup.sed
# s/foo/bar/g
# s/chicken/cow/g
# s/draft animal/horse/g
sed -f fixup.sed myfile.xml > myfile2.xml

sed 's/foo/bar/g ; s/chicken/cow/g' myfile.xml > myfile2.xml

# 3.2.8.1 To print or not to print
sed -n '/<HTML>/p' *.html #Only print <HTML> lines

# 3.2.9 Matching Specific Lines
# As mentioned,by default, sed applies every editing command to every input line. It is
# possible to restrict the lines to which a command applies by prefixing the command
# with an address.

# Regular expressions > Prefixing a command with a pattern limits the 
# command to lines matching the pattern. This can be used with the s command:
/oldfunc/ s/$/# XXX: migrate to newfunc/
# An empty pattern in the s command means “use the previous regular
# expression”:
/Tolstoy/ s//& and Camus/g

# The last line
# The symbol $ (as in ed and ex) means “the last line.” For example,this script is a
# quick way to print the last line of a file:
sed -n '$p' "$1"

# Ranges and line no
# You can specify a range of lines by separating addresses with a comma:
sed -n '10,42p' foo.xml #Print only lines 10–42
sed '/foo/,/bar/ s/baz/quux/g' #Make substitution only on range of lines
# The second command says “starting with lines matching foo,and continuing
# through lines matching bar,replace all occurrences of baz with quux.” (Readers
# familiar with ed, ex,or the colon command prompt in vi will recognize this
# usage.)

# Negated regular expressions
# Occasionally it’s useful to apply a command to all lines that don’t match a particular pattern. You specify this by adding an ! character after a regular expression
# to look for:
/used/!s/new/used/g #Change new to used on lines not matching used

# checkout head command using sed

# As we’ve seen so far, sed uses / characters to delimit patterns to search for. 
# However,there is provision for using a different delimiter in patterns. 
# This is done by preceding the character with a backslash:
$ grep tolstoy /etc/passwd #Show original line
# tolstoy:x:2076:10:Leo Tolstoy:/home/tolstoy:/bin/bash
$ sed -n '\:tolstoy: s;;Tolstoy;p' /etc/passwd #Make a change
# Tolstoy:x:2076:10:Leo Tolstoy:/home/tolstoy:/bin/bash
# In this example,the colon delimits the pattern to search for,and semicolons act as
# delimiters for the s command. (The editing operation itself is trivial; our point here is
# to demonstrate the use of different delimiters,not to make the change for its own
# sake.)

# 3.2.10 How Much Text Gets Changed?
echo Tolstoy writes well | sed 's/Tolstoy/Camus/' #Use fixed strings
# Camus writes well

$ echo Tolstoy is worldly | sed 's/T.*y/Camus/' #Try a regular expression
# Camus
$ echo Tolstoy is worldly | sed 's/T[[:alpha:]]*y/Camus/'
# Camus is worldly

# Finally,as we’ve seen,it’s possible to match the null string when doing text searching. This is also true when doing text replacement, allowing you to insert text:
echo abc | sed 's/b*/1/' #Replace first match
# 1abc
echo abc | sed 's/b*/1/g' #Replace all matches
# 1a1c1


# 3.3 Working with Fields
# 3.3.2 Selecting Fields with cut
$ cut -d : -f 1,5 /etc/passwd
# root:root
# By choosing a different field number, we can extract each user’s home directory:
$ cut -d : -f 6 /etc/passwd
# /root
$ ls -l | cut -c 1-10

# checkout merge-sales.sh in workbook
#! /bin/sh
# merge-sales.sh
#
# Combine quota and sales data
# Remove comments and sort datafiles
sed '/^#/d' quotas | sort > quotas.sorted
sed '/^#/d' sales | sort > sales.sorted
# Combine on first key, results to standard output
join quotas.sorted sales.sorted
# Remove temporary files
rm quotas.sorted sales.sorted


3.3.4 Rearranging Fields with awk

# awk reads records (lines) one at a time from each file named on the command line (or
# standard input if none). For each line,it applies the commands as specified by the
# program to the line.
awk '{ print $1 }' #Print first field (no pattern)
awk '{ print $2, $5 }' #Print second and fifth fields (no pattern)
awk '{ print $1, $NF }' #Print first and last fields (no pattern)
awk 'NF > 0 { print $0 }' #Print nonempty lines (pattern and action)
awk 'NF > 0' #Same (no action, default is to print)


# 3.3.4.3 Setting the field separators
awk -F: '{ print $1, $5 }' /etc/passwd

# You can change the output field
# separator by setting the OFS variable. You do this on the command line with the –v
# option, which sets awk’s variables

awk -F: -v 'OFS=**' '{ print $1, $5 }' /etc/passwd

# 3.3.4.4 Printing lines
awk -F: '{ print "User", $1, "is really", $5 }' /etc/passwd

awk -F: '{ printf "User %s is really %s\n", $1, $5 }' /etc/passwd

# Be sure to separate arguments to print with a comma! Without the
# comma, awk concatenates adjacent values:
# $ awk -F: '{ print "User" $1 "is really" $5 }' /etc/passwd

# 3.3.4.5 Startup and cleanup actions
# awk 'BEGIN { FS = ":" ; OFS = "**" } Use BEGIN to set variables
# > { print $1, $5 }' /etc/passwd
















