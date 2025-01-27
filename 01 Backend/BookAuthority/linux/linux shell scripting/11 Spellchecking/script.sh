This chapter uses the task of spellchecking to demonstrate several different dimensions of shell scripting. After introducing the spell program,we show how a simple
but useful spellchecker can be constructed almost entirely out of stock Unix tools.

We then proceed to show how simple shell scripts can be used to modify the output
of two freely available spellchecking programs to produce results similar to those of
the traditional Unix spell program

12.1 The spell Program
The spell program does what you think it does: it checks a file for spelling errors. It
reads through all the files named on the command line,producing,on standard output,a sorted list of words that are not in its dictionary or that cannot be derived from
such words by the application of standard English grammatical rules (e.g.,“words”
from “word”). Interestingly enough,POSIX does not standardize spell

12.2 The Original Unix Spellchecking Prototype
 Bentley then sketched a reconstruction
credited to Kernighan and Plauger‡ of that program as a Unix pipeline that we can
rephrase in modern terms like this

prepare filename | Remove formatting commands
 tr A-Z a-z | Map uppercase to lowercase
 tr -c a-z '\n' | Remove punctuation
 sort | Put words in alphabetical order
 uniq | Remove duplicate words
 comm -13 dictionary - Report words not in dictionary

12.3 Improving ispell and aspell
Unix spell supports several options,most of which are not helpful for day-to-day
use. One exception is the –b option,which causes spell to prefer British spelling:
“centre” instead of “center,” “colour” instead of “color,” and so on.* See the manual
page for the other options.
You can create,and over time maintain,your own list of valid but
unusual words,and then use this list when running spell. You indicate the pathname to the local spelling list by supplying it before the file to be checked,and by
preceding it with a + character:
spell +/usr/local/lib/local.words myfile > myfile.errs

12.3.2 ispell and aspell
There are two different,freely available spellchecking programs: ispell and aspell.
ispell is an interactive spellchecker; it displays your file,highlighting any spelling
errors and providing suggested changes. aspell is a similar program; for English it
does a better job of providing suggested corrections,and its author would like it to
eventually replace ispell
#!/bin/sh
# aspell -l mimicks the standard unix spell program, roughly.
cat "$@" | aspell -l --mode=none | sort -u

The ––mode option causes aspell to ignore certain kinds of markup,such as SGML
and TEX. Here, --mode=none indicates that no filtering should be done. The sort -u
command sorts the output and suppresses duplicates,producing output of the
nature expected by an experienced Unix user. This could also be done using ispell:
cat "$@" | ispell -l | sort -u

checkout 02-spell-replacement-ispell, 03-spell-replacement-aspell

This same trick of post-processing with fgrep can be used with Unix spell if you do
not want to have to keep your personal dictionary sorted,or if you do not want to
have to worry about different locales’ sorting order.

12.4 A Spellchecker in awk










































































































































































































































































































