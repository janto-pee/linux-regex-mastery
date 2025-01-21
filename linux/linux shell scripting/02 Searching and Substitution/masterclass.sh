grep "^[[:alnum:]]*$" ./02-content #strings that contain only set of chracters
grep "^ab*$" ./02-content # string that has an a followed by zero or more b
grep "ab*" ./02-content # string that has an a followed by zero or more b

egrep "^a(b+)$" ./02-content # string that has an a followed by one or more b
egrep "ab+" ./02-content # string that has an a followed by one or more b

egrep "^a(b?)$" ./02-content # string that has an a followed by zero or one b
egrep "ab?" ./02-content # string that has an a followed by zero or one b

grep "ab\{3\}" ./02-content # string that has an a followed by zero or one b
grep "^ab\{3\}$" ./02-content # string that has an a followed by zero or one b

grep "ab\{2,3\}" ./02-content # string that has an a followed by zero or one b
grep "^ab\{2,3\}$" ./02-content # string that has an a followed by zero or one b

grep "^[[:lower:]_]*$" ./02-content #sequence of lowercase letters joined with an underscore
egrep "^(([[:upper:]][[:lower:]])*)$" ./02-content #sequence of one uppercase letter followed by lowercase letters

grep "^a.*b$" ./02-content  
egrep "a.*?b$" ./02-content # matches an a followed by anything, ending in b

grep "^\w" ./02-content 
egrep "^\w+" ./02-content
grep "\<lamb" ./02-content #mtch word at the beginning of  string

grep "\w[[:punct:]]*$" ./02-content
egrep "\w([[:punct:]]?)$" ./02-content #mtch word at the end of  string

grep "\w*z.\w*" ./02-content
grep "\wz" ./02-content #mtch word containing z

grep "\Bz\B" ./02-content #mtch word containing z not at start or end of the word
grep "^[A-Za-z0-9_]*$" ./02-content  #string that contains only upper and lowercase letters, numbers and underscores
grep "^[[:digit:]]" ./02-content # starting with number

sed -e "s/\.[0]*/./" ./ip-digit #remove leading zeros from an ip address
grep "[[:digit:]]$" ./02-content
grep ".*[[:digit:]]$" ./02-content #checkfor number at the end of a string

grep "^[[:digit:]]\{1,3\}"  ./02-content
grep "^[[:digit:]]\{1,3\}"  ./02-content







