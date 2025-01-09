# The awk programming language was designed to simplify many common text processing tasks

awk -F '\t' '{ ... }' files FS="[\f\v]" files
# Here,the value set with the –F option applies to the first group of files,and the value
# assigned to FS applies to the second group

awk '{...}' Pass=1 *.tex Pass=2 *.tex
# processes the list of files twice,once with Pass set to one and a second time with it
# set to two.

# awk views an input stream as a collection of records,each of which can be further
# subdivided into fields. Normally,a record is a line,and a field is a word of one or
# more nonwhitespace characters.

pattern { action }      #Run action if pattern matches
pattern                 #Print record if pattern matches
        { action }      #Run action for every record
# No action, print or No pattern run across all record

# cat showargs.awk
BEGIN {
 print "ARGC =", ARGC
 for (k = 0; k < ARGC; k++)
 print "ARGV[" k "] = [" ARGV[k] "]"
}

awk -v One=1 -v Two=2 -f showargs.awk Three=3 file1 Four=4 file2 file3

awk 'BEGIN { for (k = 0; k < ARGC; k++)
    > print "ARGV[" k "] = [" ARGV[k] "]" }' a b c

$ /usr/local/bin/gawk 'BEGIN { print ARGV[0] }'
# gawk
$ /usr/local/bin/mawk 'BEGIN { print ARGV[0] }'
# mawk
$ /usr/local/bin/nawk 'BEGIN { print ARGV[0] }'
# /usr/local/bin/nawk

# 9.3.7 Environment Variables
$ awk 'BEGIN { print ENVIRON["HOME"]; print ENVIRON["USER"] }'
# /home/jones
# jones

9.4 Records and Fields
# awk allows
# more generality through the record-separator built-in variable, RS
# RS must be either a single literal character,such as
# newline (its default value),or an empty string

# 9.4.2 Field Separators
# Fields are separated from each other by strings that match the current value of the
# field-separator regular expression, available in the built-in variable FS.

echo ' un deux trois ' | awk -F' ' '{ print NF ":" $0 }'
# 3: un deux trois

# For those rare occasions when a single space separates fields,simply set FS = "[ ]"
# to match exactly one space. With that setting,leading and trailing whitespace is no
# longer ignored.
echo ' un deux trois ' | awk -F'[ ]' '{ print NF ":" $0 }'
# 7: un deux trois

9.4.3 Fields
Fields are available to the awk program as the special names $1, $2, $3,…, $NF

# 9.5 Patterns and Actions
# 9.5.1 Patterns
NF = = 0 #Select empty records
NF > 3 #Select records with more than 3 fields
NR < 5 #Select records 1 through 4
(FNR = = 3) && (FILENAME ~ /[.][ch]$/) #Select record 3 in C source files
$1 ~ /jones/ #Select records with "jones" in field 1
/[Xx][Mm][Ll]/ #Select records containing "XML", ignoring lettercase
$0 ~ /[Xx][Mm][Ll]/ #Same as preceding selection


# Two
# expressions separated by a comma select records from one matching the left expression up to,and including,the record that matches the right expression. If both range
# expressions match a record,the selection consists of that single record. This behavior is different from that of sed,which looks for the range end only in records that
# follow the start-of-range record. Here are some examples:

(FNR = = 3), (FNR = = 10) #Select records 3 through 10 in each input file
/<[Hh][Tt][Mm][Ll]>/, /<\/[Hh][Tt][Mm][Ll]>/ #Select body of an HTML document
/[aeiouy][aeiouy]/, /[^aeiouy][^aeiouy]/ #Select from two vowels to two nonvowels

In the BEGIN action, FILENAME, FNR, NF,and NR are initially undefined; references to
them return a null string or zero

9.5.2 Actions
 Pattern is true, default action is to print
NR > 0 { print }      #Print when have records, is always true
1   { print }         #Pattern is true, explicit print, default value
    { print }         #No pattern is treated as true, explicit print, default value
    { print $0 }      #Same, but with explicit value to print


# Here are some complete awk program examples. In each,we print just the first three
# input fields,and by omitting the selection pattern,we select all records. Semicolons
# separate awk program statements,and we vary the action code slightly to change the
# output field separators:

echo 'one two three four' | awk '{ print $1, $2, $3 }'
# one two three
echo 'one two three four' | awk '{ OFS = "..."; print $1, $2, $3 }'
# one...two...three
echo 'one two three four' | awk '{ OFS = "\n"; print $1, $2, $3 }'
# one
# two
# three

# Changing the output field separator without assigning any field does not alter $0:
$ echo 'one two three four' | awk '{ OFS = "\n"; print $0 }'
# one two three four
# However,if we change the output field separator,and we assign at least one of the
# fields (even if we do not change its value),then we force reassembly of the record
# with the new field separator:
$ echo 'one two three four' | awk '{ OFS = "\n"; $1 = $1; print $0 }'
# one
# two
# three
# four


# 9.6 One-Line Programs in awk


# 9.6 One-Line Programs in awk
awk '{ C += length($0) + 1; W += NF } END { print NR, W, C }'
# Although we could have included an
# initialization block of the form BEGIN{C=W=0}, awk’s guaranteed default
# initializations make it unnecessary. The character count in C is updated at each
# record to count the record length,plus the newline that is the default record separator. The word count in W accumulates the number of fields. We do not need
# to keep a line-count variable because the built-in record count, NR,automatically
# tracks that information for us. The END action handles the printing of the oneline report that wc produces.

time cat *.xml > /dev/null

time awk '' *.xml
# Apart from issues with NUL characters, awk can easily emulate cat—these two
# examples produce identical output:
cat *.xml
awk 1 *.xml
# • To print original data values and their logarithms for one-column datafiles,use
# this:
awk '{ print $1, log($1) }' file(s)

# To print a random sample of about 5 percent of the lines from text files,use the
# pseudorandom-number generator function (see “Numeric Functions” [9.10]),
# which produces a result uniformly distributed between zero and one:
awk 'rand( ) < 0.05' file(s)
# • Reporting the sum of the n-th column in tables with whitespace-separated columns is easy:
awk -v COLUMN=n '{ sum += $COLUMN } END { print sum }' file(s)
# • A minor tweak instead reports the average of column n:
awk -v COLUMN=n '{ sum += $COLUMN } END { print sum / NR }' file(s)
# • To print the running total for expense files whose records contain a description
# and an amount in the last field,use the built-in variable NF in the computation of
# the total:
awk '{ sum += $NF; print $0, sum }' file(s)
# • Here are three ways to search for text in files:
egrep 'pattern|pattern' file(s)
awk '/pattern|pattern/' file(s)
awk '/pattern|pattern/ { print FILENAME ":" FNR ":" $0 }' file(s)
# • If you want to restrict the search to just lines 100–150,you can use two tools
# and a pipeline, albeit with loss of location information:
sed -n -e 100,150p -s file(s) | egrep 'pattern'
# We need GNU sed here for its –s option,which restarts line numbering for each
# file. Alternatively, you can use awk with a fancier pattern:
awk '(100 <= FNR) && (FNR <= 150) && /pattern/ \
 { print FILENAME ":" FNR ":" $0 }' file(s)

# To swap the second and third columns in a four-column table,assuming tab separators, use any of these:
awk -F'\t' -v OFS='\t' '{ print $1, $3, $2, $4 }' old > new
awk 'BEGIN { FS = OFS = "\t" } { print $1, $3, $2, $4 }' old > new
awk -F'\t' '{ print $1 "\t" $3 "\t" $2 "\t" $4 }' old > new
# • To convert column separators from tab (shown here as •) to ampersand,use
# either of these:
sed -e 's/•/\&/g' file(s)
awk 'BEGIN { FS = "\t"; OFS = "&" } { $1 = $1; print }' file(s)
# • Both of these pipelines eliminate duplicate lines from a sorted stream:
sort file(s) | uniq
sort file(s) | awk 'Last != $0 { print } { Last = $0 }'
# • To convert carriage-return/newline line terminators to newline terminators,use
# one of these:
sed -e 's/\r$//' file(s)
sed -e 's/^M$//' file(s)
mawk 'BEGIN { RS = "\r\n" } { print }' file(s)

#  To convert single-spaced text lines to double-spaced lines, use any of these:
sed -e 's/$/\n/' file(s)
awk 'BEGIN { ORS = "\n\n" } { print }' file(s)
awk 'BEGIN { ORS = "\n\n" } 1' file(s)
awk '{ print $0 "\n" }' file(s)
awk '{ print; print "" }' file(s)

# • Conversion of double-spaced lines to single spacing is equally easy:
gawk 'BEGIN { RS="\n *\n" } { print }' file(s)

# To locate lines in Fortran 77 programs that exceed the 72-character line-length
# limit,* either of these does the job:
egrep -n '^.{73,}' *.f
awk 'length($0) > 72 { print FILENAME ":" FNR ":" $0 }' *.f

# To extract properly hyphenated International Standard Book Number (ISBN)
# values from documents,we need a lengthy,but straightforward,regular expression,with the record separator set to match all characters that cannot be part of
# an ISBN:
gawk 'BEGIN { RS = "[^-0-9Xx]" }
/[0-9][-0-9][-0-9][-0-9][-0-9][-0-9][-0-9][-0-9][-0-9][-0-9][-0-9]-[0-9Xx]/' \
file(s)

# To strip angle-bracketed markup tags from HTML documents,treat the tags as
# record separators, like this:
mawk 'BEGIN { ORS = " "; RS = "<[^<>]*>" } { print }' *.html

$ mawk -v ORS=' ' -v RS='[ \n]' '/<title *>/, /<\/title *>/' *.xml |
> sed -e 's@</title *> *@&\n@g'

# 9.7.3 Iterative Execution
awk 'BEGIN { for (x = 0; x <= 1; x += 0.05) print x }'

# 9.7.7 Output Redirection

print "Hello, world" > file
printf("The tenth power of %d is %d\n", 2, 2^10) > "/dev/tty"
print "Hello, world" >> file

Alternatively, you can send output to a pipeline:
for (name in telephone)
 print name "\t" telephone[name] | "sort"
close("sort")

# As with input from a pipeline,close an output pipeline as soon as you are through
# with it. This is particularly important if you need to read the output in the same program. For example,you can direct the output to a temporary file,and then read it
# after it is complete:
tmpfile = "/tmp/telephone.tmp"
command = "sort > " tmpfile
for (name in telephone)
 print name "\t" telephone[name] | command
close(command)
while ((getline < tmpfile) > 0)
 print
close(tmpfile)

# 9.7.8 Running External Programs
# Here is a shorter solution to the telephone-directory sorting problem,using a temporary file and system( ) instead of an awk pipeline:
tmpfile = "/tmp/telephone.tmp"
for (name in telephone)
 print name "\t" telephone[name] > tmpfile
close(tmpfile)
system("sort < " tmpfile)

Example 9-2. Searching an array for a value
function find_key(array, value, key)
{
 # Search array[ ] for value, and return key such that
 # array[key] = = value, or return "" if value is not found
 for (key in array)
 if (array[key] = = value)
 return key
 return ""
}

As in most programming languages, awk functions can call themselves: this is known
as recursion

Example 9-3. Euclid’s greatest common denominator algorithm
function gcd(x, y, r)
{
 # return the greatest common denominator of integer x, y
 x = int(x)
 y = int(y)
 # print x, y
 r = x % y
 return (r = = 0) ? y : gcd(y, r)
}
# If we add this action
# { g = gcd($1, $2); print "gcd(" $1 ", " $2 ") =", g }
# to the code in Example 9-3 and then we uncomment the print statement and run it
# from a file, we can see how the recursion works:
$ echo 25770 30972 | awk -f gcd.awk


Example 9-4. Ackermann’s worse-than-exponential function
function ack(a, b)
{
 N++ # count recursion depth
 if (a = = 0)
 return (b + 1)
 else if (b = = 0)
 return (ack(a - 1, 1))
 else
 return (ack(a - 1, ack(a, b - 1)))
}

 echo 2 2 | awk -f ackermann.awk
ack(2, 2) = 7 [27 calls]
$ echo 3 3 | awk -f ackermann.awk
ack(3, 3) = 61 [2432 calls]
$ echo 3 4 | awk -f ackermann.awk
ack(3, 4) = 125 [10307 calls]
$ echo 3 8 | awk -f ackermann.awk
ack(3, 8) = 2045 [2785999 calls]


9.9.1 Substring Extraction
substr("abcde", 2, 3) returns "bcd". 
# The len argument can be omitted,in which case,it defaults to length(string) - start + 1,
# selecting the remainder of the string.
# It is not an error for the arguments of substr( ) to be out of bounds,but the result
# may be implementation-dependent. For example, nawk and gawk evaluate
substr("ABC", -3, 2) as "AB",
# whereas mawk produces the empty string "". All of
# them produce an empty string for substr("ABC", 4, 2) and for substr("ABC", 1, 0).
# gawk’s ––lint option diagnoses out-of-bounds arguments in substr( ) calls.

9.9.2 Lettercase Conversion
tolower(string)
toupper(string)


9.9.3 String Searching
index(string, find) searches the text in string for the string find. It returns the
starting position of find in string,or 0 if find is not found in string. For example,
index("abcdef", "de")

Example 9-5. Reverse string search
function rindex(string, find, k, ns, nf)
{
 # Return index of last occurrence of find in string,
# or 0 if not found
 ns = length(string)
 nf = length(find)
 for (k = ns + 1 - nf; k >= 1; k--)
 if (substr(string, k, nf) = = find)
 return k
 return 0
}

# 9.9.4 String Matching
match(string, regexp) matches string against the regular expression regexp,and
returns the index in string of the match,or 0 if there is no match

# 9.9.5 String Substitution
awk provides two functions for string substitution: 
sub(regexp, replacement, target)
gsub(regexp, replacement, target)

With substitution, we can use:
value = $0
sub(/^ *[a-z]+ *= *"/, "", value)
sub(/" *$/, "", value)
# whereas with indexing using code like this:
start = index($0, "\"") + 1
end = start - 1 + index(substr($0, start), "\"")
value = substr($0, start, end - start)
# we need to count characters rather carefully,we do not match the data pattern as
# precisely, and we have to create two substrings.

9.9.6 String Splitting


 print "\nField separator = FS = \"" FS "\""
 n = split($0, parts)
 for (k = 1; k <= n; k++)
 print "parts[" k "] = \"" parts[k] "\""
 print "\nField separator = \"[ ]\""
 n = split($0, parts, "[ ]")
 for (k = 1; k <= n; k++)
 print "parts[" k "] = \"" parts[k] "\""
 print "\nField separator = \":\""
 n = split($0, parts, ":")
 for (k = 1; k <= n; k++)
 print "parts[" k "] = \"" parts[k] "\""
 print ""
}









