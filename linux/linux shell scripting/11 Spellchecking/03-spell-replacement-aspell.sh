#!/bin/sh
# Unix spell treats a first argument of `+file' as providing a
# personal spelling list. Let's do that too.
mydict=cat
case $1 in
+?*) mydict=${1#+} # strip off leading +
 mydict="fgrep -v -f $mydict"
 shift
 ;;
esac
# aspell -l mimics the standard Unix spell program, roughly.
cat "$@" | aspell -l --mode=none | sort -u | eval $mydict