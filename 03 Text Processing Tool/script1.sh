# 4.1 Sorting Text
# Text files that contain independent records of data are often candidates for sorting. A
# predictable record order makes life easier for human users: book indexes,

# Like awk, cut,and join, sort views its input as a stream of records made up of fields
# of variable width,with records delimited by newline characters and fields delimited
# by whitespace or a user-specifiable single character.

# 4.1.1 Sorting by Lines
# First, sort the file in strict byte order:
$ LC_ALL=C sort french-english

# Now sort the text in Canadian-French order:
$ LC_ALL=fr_CA.iso88591 sort french-english

# 4.1.2 Sorting by 
# For more control over sorting,the –k option allows you to specify the field to sort on,
# and the –t option lets you choose the field delimiter

# If a comma-separated pair of field numbers is given,the sort key starts at the beginning of the first field, and finishes at the end of the second field.
# With a dotted character position,comparison begins (first of a number pair) or ends
# (second of a number pair) at that character position: –k2.4,5.6 compares starting
# with the fourth character of the second field and ending with the sixth character of
# the fifth field.
# If the start of a sort key falls beyond the end of the record,then the sort key is empty,
# and empty sort keys sort before all nonempty ones.
# When multiple –k options are given,sorting is by the first key field,and then,when
# records match in that key, by the second key field, and so on.
 sort -t: -k1,1 /etc/passwd #Sort by username
# For more control,add a modifier letter in the field selector to define the type of data
# in the field and the sorting order. Here’s how to sort the password file by descending
# UID:
$ sort -t: -k3nr /etc/passwd Sort by descending UID

$ sort -t: -k4n -u /etc/passwd Sort by unique GID

4.1.3 Sorting Text Blocks
Sometimes you need to sort data composed of multiline records

cat my-friends | #Pipe in address file
 awk -v RS="" '{ gsub("\n", "^Z"); print }' | #Convert addresses to single lines
 sort -f | #Sort address bundles, ignoring case
 awk -v ORS="\n\n" '{ gsub("^Z", "\n"); print }' | #Restore line structure
 grep -v '# SORTKEY' Remove markup lines

# The beauty of this approach is that we can easily include additional keys in each
# address that can be used for both sorting and selection: for example,an extra
# markup line of the form:
# COUNTRY: UK

# sort -t_ -k1,1 -k2,2 << EOF #Sort four lines by first two fields
# > one_two
# > one_two_three
# > one_two_four
# > one_two_five
# > EOF


$ sort latin-numbers | uniq #Show unique sorted records
 sort latin-numbers | uniq -c #Count unique sorted records
 sort latin-numbers | uniq -d #Show only duplicate records
$ sort latin-numbers | uniq -u #Show only nonduplicate records

# 4.3 Reformatting Paragraphs

# Although some implementations of fmt have more options,only two find frequent
# use: –s means split long lines only,but do not join short lines to make longer ones,
# and –w n sets the output line width to n characters (default: usually about 75 or so).

 sed -n -e 9991,10010p /usr/dict/words | fmt #Reformat 20 dictionary words
$ sed -n -e 9995,10004p /usr/dict/words | fmt -w 30 #Reformat 10 words into short lines

#  fmt -s -w 10 << END_OF_DATA Reformat long lines only
# > one two three four five
# > six
# > seven
# > eight
# > END_OF_DATA

4.4 Counting Lines, Words, and Characters

$ echo This is a test of the emergency broadcast system | wc #Report counts
echo Testing one two three | wc -c #Count bytes
echo Testing one two three | wc -l #Count lines
echo Testing one two three | wc -w #Count word

 wc /etc/passwd /etc/group #Count data in two files





