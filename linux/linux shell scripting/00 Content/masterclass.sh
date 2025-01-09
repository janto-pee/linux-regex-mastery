grep "Lorem" ./00\ Content/book.html #case sensitive; lorem != Lorem
grep ".*fugia.*" ./00\ Content/book.html
grep "\(ab\)\(cd\)[def]*\2\1" ./00\ Content/02-content 
egrep "whyab+c" ./00\ Content/02-content 
egrep "whyab?c" ./00\ Content/02-content 
grep "\(why\).*\1" ./00\ Content/02-content 
grep tolstoy ./00\ Content/02-content #The seven letters tolstoy, anywhere on a line
grep ^tolstoy ./00\ Content/02-content #The seven letters tolstoy, at the beginning of a line
grep tolstoy$ ./00\ Content/02-content #The seven letters tolstoy, at the end of a line
grep ^tolstoy$ ./00\ Content/02-content #A line containing exactly the seven letters tolstoy, and nothing else
grep [Tt]olstoy ./00\ Content/02-content #Either the seven letters Tolstoy, or the seven letters tolstoy, anywhere on a line
grep tol.toy ./00\ Content/02-content #The three letters tol, any character, and the three letters toy, anywhere on a line
grep tol.*toy ./00\ Content/02-content #The three letters tol, any sequence of zero or more characters, a
grep [ ]*\.-] ./00\ Content/02-content
grep [ab[.ch.]de] ./00\ Content/02-content #matches any of the characters a, b, d,or
grep [a[=e=]iouy] ./00\ Content/02-content #would match all the lowercase
grep [[:alpha:]space] ./00\ Content/book.html
grep "\(['\"]\).*\1" ./00\ Content/02-content
egrep "(['\"]).*\1" ./00\ Content/02-content
grep [[:upper:]]\{3\}  ./00\ Content/02-content #Yes Characters 4, 5, and 6, in the middle: abcABCdefDEF
grep "[[:upper:]]\{3\}$"  ./00\ Content/02-content #Yes Characters 10, 11, and 12, at the end: abcDEFdefDEF
grep "^[[:alpha:]]\{3\}"  ./00\ Content/02-content #Yes Characters 1, 2, and 3, at the beginning: abcABCdefDEF
egrep "[A]{3,42}" ./00\ Content/02-content
egrep (why)+ #matches one or more occurrences of the word why.
egrep [Tt]he (CPU|computer) #is matches sentences  CPU or computer in between The (or the) and is.
egrep read|write+ #matches exactly one occurrence of the word read or an occurrence of the word write,followed by any number of e characters (writee, writeee,and so on). 
egrep (read|write)+ #makes no allowance for intervening whitespace between words. 
egrep ((read|write)[[:space:]]*)+ #is a more complicated,but more realistic,regular expression.
grep "why[[:alpha:]].*y"  ./00\ Content/02-content


Linux Exercise
grep "[[:alnum:]]" ./00\ Content/02-content #contains a certain set of characters (a-z, A-Z, 0-9)
grep "ab*" ./00\ Content/02-content # a followed by zero or more b's --- preceeding repition
egrep "ab+" ./00\ Content/02-content # a followed by one or more b's --- preceeding repition
egrep "ab?" ./00\ Content/02-content # a followed by one or more b's --- preceeding repition
grep "ab\{2\}" ./00\ Content/02-content # a followed by one or more b's --- preceeding repition
*grep "[[:lower:]?]_"  ./00\ Content/02-content # sequence of lower case letters joined by underscore
*grep "[[:upper:]]\{1\}[[:lower:]]\{1\}" ./00\ Content/02-content # sequence of lower case letters joined by underscore
grep ".*a.*b$" ./00\ Content/02-content  # string has a followed by anything ending in 'b'
grep "[[:alpha:]].*a.*b$" ./00\ Content/02-content  # string has a followed by anything ending in 'b'
egrep "[[:alpha:]]?a.*b$" ./00\ Content/02-content  # string has a followed by anything ending in 'b'
grep "^lamb" ./00\ Content/02-content  # matches word at the beginning of a string
grep "\<lamb" ./00\ Content/02-content  # matches word at the beginning of a string
grep "chop$" ./00\ Content/02-content  # matches word at the end of a string
grep "chop\>" ./00\ Content/02-content  # matches word at the end of a string
egrep "chop[[:punct:]]?\>" ./00\ Content/02-content
