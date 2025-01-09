# wait_for_user --- wait for a user to log in
#
# usage: wait_for_user user [ sleeptime ]
wait_for_user ( ) {
 until who | grep "$1" > /dev/null
 do
 echo $1
 sleep ${2:-30}
 done
}

wait_for_user tolstoy #Wait for tolstoy, check every 30 seconds
wait_for_user tolstoy 60 #Wait for tolstoy, check every 60 seconds