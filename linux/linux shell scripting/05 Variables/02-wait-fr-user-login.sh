
# wait for specified user to log in, check every 30 seconds
printf "Enter username: "
read user
until who | grep "$user" > /dev/null
do
 echo $user
 sleep 30
done

# 