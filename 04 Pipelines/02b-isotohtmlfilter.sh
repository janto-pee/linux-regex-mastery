#! /bin/sh
# Convert an input stream containing characters in ISO 8859-1
# encoding from the range 128..255 to HTML equivalents in ASCII.
# Characters 0..127 are preserved as normal ASCII.
#
# Usage:
# iso8859-1-to-html infile(s) >outfile
sed \
 -e 's= =\&nbsp;=g' \
 -e 's=¡=\&iexcl;=g' \
 -e 's=¢=\&cent;=g' \
 -e 's=£=\&pound;=g' \
...
 -e 's=ü=\&uuml;=g' \
 -e 's= =\&yacute;=g' \
 -e 's= =\&thorn;=g' \
 -e 's=ÿ=\&yuml;=g' \
 "$@"