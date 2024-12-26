while [ $# -gt 1 ] Loop over arguments
do
 case $1 in Process options
 -f) # code for -f here
 ;;
 -q) # code for -q here
 ;;
 ...
 *) break ;; Nonoption, break loop
 esac
 shift Move next argument down
done
# exec real-app -q "$qargs" -f "$fargs" "$@" Run the program
# echo real-app failed, get help! 1>&2 Emergency message