# wait_for_user --- wait for a user to log in
#
# usage: wait_for_user user [ sleeptime ]
wait_for_user ( ) {
 until who | grep "$1" > /dev/null
 do
 sleep ${2:-30}
 done
}