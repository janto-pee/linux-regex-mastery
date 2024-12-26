# cat > finduser Create new file

#! /bin/sh
# finduser --- see if user named by first argument is logged in
echo finding user....
who | grep $1
# ctrl+D
# chmod +x finduser
# ./finduser betsy
# ./finduser benjamin
# mv finduser $HOME/bin