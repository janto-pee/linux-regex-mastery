# Example 3-1. A version of the head command using sed
# head --- print first n lines
#
# usage: head N file
count=$1
sed ${count}q "$2"
# sed ends up being invoked as sed 10q foo.xml.