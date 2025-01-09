# three programs fro searching
# - grep
# - egrep
# - fgrep

who | grep austen #Where is austen logged on?
who | grep -F austen #-F stands for fixed string

# 2 
# Regular Expressions
# Regular expressions are a notation that lets you search for text that fits a particular
# criterion,such as “starts with the letter a.” The notation lets you write a single
# expression that can select, or match, multiple data strings.

# A large number of Unix utilities derive their power from regular expressions of one
# form or another. A partial list includes the following:
# • The grep family of tools for finding matching lines of text: grep and egrep,which
# are always available, as well as the nonstandard but useful agrep utility*
# • The sed stream editor,for making changes to an input stream,described later in
# the chapter
# • String processing languages,such as awk,Icon,Perl,Python,Ruby,Tcl,and
# others
# • File viewers (sometimes called pagers),such as more, page,and pg,which are
# common on commercial Unix systems, and the popular less pager*
# • Text editors,such as the venerable ed line editor,the standard vi screen editor,
# and popular add-on editors such as emacs, jed, jove, vile, vim, and others


# BRE Operator Precedence
[..] [==] [::] #Bracket symbols for character collation
\metacharacter #Escaped metacharacters
[] #Bracket expressions
\(\) #\digit Subexpressions and backreferences
* \{\} #Repetition of the preceding single-character regular expression
#no symbol Concatenation
^ $ #Anchors

# ERE Operator Precedence
[..] [==] [::] #Bracket symbols for character collation
\metacharacter #Escaped metacharacters
[] #Bracket expressions
() #Grouping
* + ? {} #Repetition of the preceding regular expression
#no symbol Concatenation
^ $ #Anchors
| #Alternation

tolstoy #The seven letters tolstoy, anywhere on a line
^tolstoy #The seven letters tolstoy, at the beginning of a line
tolstoy$ #The seven letters tolstoy, at the end of a line
^tolstoy$ #A line containing exactly the seven letters tolstoy, and nothing else
[Tt]olstoy #Either the seven letters Tolstoy, or the seven letters tolstoy, anywhere on a line
tol.toy #The three letters tol, any character, and the three letters toy, anywhere on a line
tol.*toy #The three letters tol, any sequence of zero or more characters, a

[[:alpha:]!] #character class matches any single alphabetic character or the exclamation mark,
[[.ch.]] #collating class matches the collating element ch,but does not
            # match just the letter c or the letter h. In a French locale, 
[[=e=]] #equivalence class might match any of e, è, ë, ê,or é. 

# BRE matching
# 3.2.2.1 Matching single characters 
# These include all alphanumeric characters,most whitespace characters,and most punctuation characters

# if metacharacters don’t stand for themselves,how do you match one when you
# need to? The answer is by escaping it. This is done by preceding it with a backslash. Thus, \* matches a literal *

# The . (dot) character means “any single character.” Thus, a.c matches all of abc,
# aac, aqc,and so on

# The last way to match a single character is with a bracket expression. The simplest form of a bracket expression is to enclose a list of characters between
# square brackets,such as [aeiouy],

# Within bracket expressions,all other metacharacters lose their special meanings.
# Thus, [*\.] matches a literal asterisk,a literal backslash,or a literal period.

# If you need both a right bracket
# and a minus,make the right bracket the first character,and make the minus the last
# one in the list: [ ]*\.-]

# classes
# [ab[.ch.]de] matches any of the characters a, b, d,or
# e, or the pair ch. It does not match a standalone c or h character

# n [a[=e=]iouy] would match all the lowercase
# English vowels, as well as the letters è, é, and so on


# 3.2.2.2 Backreferences
# usage
# $ grep "\(ab\)\(cd\)[def]*\2\1" ../00\ Content/02-content

\(ab\)\(cd\)[def]*\2\1 #abcdcdab, abcdeeecdab, abcdddeeffcdab, …
\(why\).*\1 #A line with two occurrences of why
\([[:alpha:]_][[:alnum:]_]*\) = \1; #Simple C/C++ assignment statement

# Backreferences are particularly useful for finding duplicated words and matching
# quotes:
# \(["']\).*\1 Match single- or double-quoted words, like 'foo' or "bar"

# 3.2.2.3 Matching multiple characters with one expression
# The simplest way to match multiple characters is to list them one after the other
# (concatenation).

# The most commonly used modifier is the asterisk or star (*),whose meaning is
# “match zero or more of the preceding single character.” Thus, ab*c means “match an
# a,zero or more b characters,and a c.” This regular expression matches ac, abc, abbc,
# abbbc, and so on.


# Interval expressions consist of one or two numbers enclosed between \{
# and \}. There are three variants, as follows:

\{n\} Exactly n occurrences of the preceding regular expression
\{n,\} At least n occurrences of the preceding regular expression
\{n,m\} Between n and m occurrences of the preceding regular expression

Given interval expressions,it becomes easy to express things like 
“exactly five occurrences of a,” or “between 10 and 42 
instances of q.” To wit: a\{5\} and q\{10,42\}.

# 3.2.2.4 Anchoring text matches

ABC Yes #Characters 4, 5, and 6, in the middle: abcABCdefDEF
^ABC No #Match is restricted to beginning of string
def Yes #Characters 7, 8, and 9, in the middle: abcABCdefDEF
def$ No #Match is restricted to end of string
[[:upper:]]\{3\} Yes #Characters 4, 5, and 6, in the middle: abcABCdefDEF
[[:upper:]]\{3\}$ Yes #Characters 10, 11, and 12, at the end: abcDEFdefDEF
^[[:alpha:]]\{3\} Yes #Characters 1, 2, and 3, at the beginning: abcABCdefDEF
aaaaaac
acaacaa
aaacaaa

# 3.2.3 Extended Regular Expressions

# 3.2.3.1 Matching single characters
# EREs are essentially the same as BREs.
# In particular,normal characters,the backslash character for escaping metacharacters, 
# and bracket expressions all behave as described earlier for BREs.

# One notable exception is that in awk, \ is special inside bracket expressions. Thus,to
# match a left bracket,dash,right bracket,or backslash,you could use [\[\-\]\\].

3.2.3.2 Backreferences don’t exist

3.2.3.3 Matching multiple regular expressions with one expression
EREs have the most notable differences from BREs in the area of matching multiple
characters. The * does work the same as in BREs.*
Interval expressions are also available in EREs; however,they are written using plain
braces,not braces preceded by 

Thus,our previous examples of “exactly
five occurrences of a” and “between 10 and 42 instances of q” are written 
a{5}
q{10,42}

EREs have two additional metacharacters for finer-grained matching control,as
follows:
? Match zero or one of the preceding regular expression
+ Match one or more of the preceding regular expression

For example, ab?c
matches both ac and abc,but nothing else. (Compare this to ab*c,which can match
any number of intermediate b characters.)

The + character is conceptually similar to the * metacharacter,except that at least
one occurrence of text matching the preceding regular expression must be present.
Thus, ab+c matches abc, abbc, abbbc,and so on


3.2.3.4 Alternation
Bracket expressions let you easily say “match this character,or that character,or ….”
However,they don’t let you specify “match this sequence,or that sequence,or ….”


3.2.3.5 Grouping

# (why)+ matches one or more occurrences of the word why.

# [Tt]he (CPU|computer) is matches sentences 
# using either CPU or computer in between The (or
# the) and is.

# read|write+ matches exactly one occurrence of the word read or an
# occurrence of the word write,followed by any number of e characters (writee,
# writeee,and so on). 

# A more useful pattern (and probably what would be meant) is
# (read|write)

# Of course, (read|write)+ makes no allowance for intervening whitespace between
# words. ((read|write)[[:space:]]*)+ is a more complicated,but more realistic,regular expression.

# The use of a * after the [[:space:]] is something of a judgment call. By using a * and
# not a +,the match gets words at the end of a line (or string). However,this opens up
# the possibility of matching words with no intervening whitespace at all. 

# Finally,grouping is helpful when using alternation together with the ^ and $ anchor
# characters. 

# Finally,grouping is helpful when using alternation together with the ^ and $ anchor
# characters. Because | has the lowest precedence of all the operators,the regular
# expression ^abcd|efgh$ means “match abcd at the beginning of the string, or match
# efgh at the end of the string.” This is different from ^(abcd|efgh)$,which means
# “match a string containing exactly abcd or exactly efgh.”

# 3.2.3.6 Anchoring text matches
#  In EREs, ^ and $ are always metacharacters.
#  since the text preceding the
# ^ and the text following the $ prevent them from matching “the beginning of the
# string” and “the end of the string,” respectively. As with the other metacharacters,
# they do lose their special meaning inside bracket expressions.



# 3.2.4 Regular Expression Extension
# The most common extensions are the operators \< and \>,which match the beginning and end of a “word,”
# The regular expression
# \<chop matches use chopsticks but does not match eat a lambchop. Similarly,the
# regular expression chop\> matches the second string,but does not match the first.
# Note that \<chop\> does not match either string.



