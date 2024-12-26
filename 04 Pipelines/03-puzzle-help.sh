#! /bin/sh
# Match an egrep(1)-like pattern against a collection of
# word lists.
#
# Usage:
# puzzle-help egrep-pattern [word-list-files]
FILES="
 /usr/dict/words
 /usr/share/dict/words
 /usr/share/lib/dict/words
 /usr/local/share/dict/words.biology
 /usr/local/share/dict/words.chemistry
 /usr/local/share/dict/words.general
 /usr/local/share/dict/words.knuth
 /usr/local/share/dict/words.latin
 /usr/local/share/dict/words.manpages
 /usr/local/share/dict/words.mathematics
 /usr/local/share/dict/words.physics
 /usr/local/share/dict/words.roget
 /usr/local/share/dict/words.sciences
 /usr/local/share/dict/words.unix
 /usr/local/share/dict/words.webster
 "
pattern="$1"
egrep -h -i "$pattern" $FILES 2> /dev/null | sort -u -f
# $ puzzle-help '^b.....[xz]...$' | fmt
#  puzzle-help '[^aeiouy]{6}' /usr/dict/words

# We could readily exclude the contractions from the word lists by a final filter step—
# egrep -i '^[a-z]+$'—but there is little harm in leaving them in the word lists.