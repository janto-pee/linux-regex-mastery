# set flag vars to empty
file= verbose= quiet= long=
while [ $# -gt 0 ] #Loop until no args left
do
 case $1 in Check first arg
 -f) file=$2
 shift #Shift off "–f" so that shift at end gets value in $2
 ;;
 -v) verbose=true
 quiet=
 ;;
 -q) quiet=true
 verbose=
 ;;
 -l) long=true
 ;;
 --) shift #By convention, – – ends options
 break
 ;;
 -*) echo $0: $1: unrecognized option >&2
 ;;
 *) break #Nonoption argument, break while loop
 ;;
 esac
 shift #Set up for next iteration
done