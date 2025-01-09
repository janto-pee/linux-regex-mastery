count=$(wc -l < dupids) # Total duplicate ids
# This is a hack, it'd be better if POSIX sh had arrays:
set -- $(newuids.sh -c $count unique-ids)
IFS=:
while read user passwd uid gid fullname homedir shell
do
 newuid=$1
 shift
 echo "$user:$passwd:$newuid:$gid:$fullname:$homedir:$shell"
 printf "%s\t%s\t%s\n" $user $uid $newuid >> old-new-list
done < dupids > unique3
IFS=$old_ifs