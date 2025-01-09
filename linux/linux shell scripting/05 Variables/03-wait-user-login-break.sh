# wait for specified user to log in, check every 30 seconds
printf "Enter username: "
read user
while true
do
 if who | grep "$user" > /dev/null
 then
 break
 fi
 sleep 30
done