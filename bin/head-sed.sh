# head --- print first n lines
#
# usage: head N file
count=$1
sed ${count}q "$2"

# When invoked as head 10 foo.xml, sed ends up being invoked as sed 10q foo.xml.
# The q command causes sed to quit,immediately; no further input is read or commands executed.