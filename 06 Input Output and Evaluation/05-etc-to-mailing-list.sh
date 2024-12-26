#! /bin/sh
# passwd-to-mailing-list
#
# Generate a mailing list of all users of a particular shell.
#
# Usage:
# passwd-to-mailing-list < /etc/passwd
# ypcat passwd | passwd-to-mailing-list
# niscat passwd.org_dir | passwd-to-mailing-list
# Possibly a bit of overkill:
rm -f /tmp/*.mailing-list
# Read from standard input
while IFS=: read user passwd uid gid name home shell
do
 shell=${shell:-/bin/sh} # Empty shell field means /bin/sh
 file="/tmp/$(echo $shell | sed -e 's;^/;;' -e 's;/;-;g').mailing-list"
 echo $user, >> $file
done