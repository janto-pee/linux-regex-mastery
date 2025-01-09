#! /bin/sh
# Filter an input stream formatted like /etc/passwd,
# and output an office directory derived from that data.
#
# Usage:
# passwd-to-directory < /etc/passwd > office-directory-file
# ypcat passwd | passwd-to-directory > office-directory-file
# niscat passwd.org_dir | passwd-to-directory > office-directory-file
umask 077
PERSON=/tmp/pd.key.person.$$
OFFICE=/tmp/pd.key.office.$$
TELEPHONE=/tmp/pd.key.telephone.$$
USER=/tmp/pd.key.user.$$
trap "exit 1" HUP INT PIPE QUIT TERM
trap "rm -f $PERSON $OFFICE $TELEPHONE $USER" EXIT
awk -F: '{ print $1 ":" $5 }' > $USER
sed -e 's=/.*= =' \
 -e 's=^\([^:]*\):\(.*\) \([^ ]*\)=\1:\3, \2=' < $USER | sort > $PERSON
sed -e 's=^\([^:]*\):[^/]*/\([^/]*\)/.*$=\1:\2=' < $USER | sort > $OFFICE
sed -e 's=^\([^:]*\):[^/]*/[^/]*/\([^/]*\)=\1:\2=' < $USER | sort > $TELEPHONE
join -t: $PERSON $OFFICE |
 join -t: - $TELEPHONE |
 cut -d: -f 2- |
 sort -t: -k1,1 -k2,2 -k3,3 |
 awk -F: '{ printf("%-39s\t%s\t%s\n", $1, $2, $3) }'


#  The real power of shell scripting shows itself when we want to modify the script to
# do a slightly different job,such as insertion of the job title from a separately maintained key:jobtitle file. All that we need to do is modify the final pipeline to look
# something like this:
# join -t: $PERSON /etc/passwd.job-title | Extra join with job title
#  join -t: - $OFFICE |
#  join -t: - $TELEPHONE |
#  cut -d: -f 2- |
#  sort -t: -k1,1 -k3,3 -k4,4 | Modify sort command
#  awk -F: '{ printf("%-39s\t%-23s\t%s\t%s\n",
#  $1, $2, $3, $4) }' And formatting command