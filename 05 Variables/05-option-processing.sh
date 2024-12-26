
# set flag vars to empty
# file= verbose= quiet= long=
# while getopts f:vql opt
# do
#  case $opt in Check option letter
#  f) file=$OPTARG
#  ;;
#  v) verbose=true
#  quiet=
#  ;;
#  q) quiet=true
#  verbose=
#  ;;
#  l) long=true
#  ;;
#  esac
# done
# shift $((OPTIND - 1)) Remove options, leave argument


# set flag vars to empty
file= verbose= quiet= long=
# leading colon is so we do error handling
while getopts :f:vql opt
do
 case $opt in #Check option letter
 f) file=$OPTARG
 ;;
 v) verbose=true
 quiet=
 ;;
 q) quiet=true
 verbose=
 ;;
 l) long=true
 ;;
 '?') echo "$0: invalid option -$OPTARG" >&2
 echo "Usage: $0 [-f file] [-vql] [files ...]" >&2
 exit 1
 ;;
 esac
done
shift $((OPTIND - 1)) Remove options, leave arguments