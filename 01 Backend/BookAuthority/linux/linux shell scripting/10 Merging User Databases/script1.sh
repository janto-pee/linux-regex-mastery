System administration tasks often revolve around manipulation of the password file (and the corresponding group file, /etc/group). The format is well known:*
tolstoy:x:2076:10:Leo Tolstoy:/home/tolstoy:/bin/bash
There are seven fields: username,encrypted password,user ID number (UID),group
ID number (GID),full name,home directory,and login shell. It’s a bad idea to leave
any field empty: in particular,if the second field is empty,the user can log in without a password,and anyone with access to the system or a terminal on it can log in as
that user. 

As is discussed in detail in Appendix B,it is the user and group ID numbers that
Unix uses for permission checking when accessing files. If two users have different
names but the same UID number,then as far as Unix knows,they are identical.

There are rare occasions when you want such a situation,but usually having two
accounts with the same UID number is a mistake. In particular,NFS requires a uniform UID space; user number 2076 on all systems accessing each other via NFS had
better be the same user (tolstoy), or else there will be serious security problems.

Now,return with us for a moment to yesteryear (around 1986),when Sun’s NFS was
just beginning to become popular and available on non-Sun systems. At the time,
one of us was a system administrator of two separate 4.2 BSD Unix minicomputers.
These systems communicated via TCP/IP,but did not have NFS. However,a new
OS vendor was scheduled to make 4.3 BSD + NFS available for these systems. There
were a number of users with accounts on both systems; typically the username was
the same,but the UID wasn’t! These systems were soon to be sharing filesystems via
NFS; it was imperative that their UID spaces be merged. The task was to write a
series of scripts that would:
• Merge the /etc/passwd files of the two systems. This entailed ensuring that all
users from both systems had unique UID numbers.
• Change the ownership of all files to the correct users in the case where an existing UID was to be used for a different user.

Example 11-1. u1 /etc/passwd file

11.3 Merging Password Files
The first step is to create a merged /etc/passwd file. This involves several substeps:
1. Physically merge the files,bringing duplicate usernames together. This becomes
the input for the following steps.
2. Split the merged file into three separate parts for use in later processing:
• Users for whom the username and UID are the same go into one file,named
unique1. Users with nonrepeated usernames also go into this file.
• Users with the same username and different UIDs go into a second file,
named dupusers.
• Users with the same UID and different usernames go into a third file,named
dupids.
3. Create a list of all unique UID numbers that already are in use. This will be
needed so that we can find new,unused UID numbers when a conflict occurs
and we need to do a UID change (e.g., users jhancock and ben).
4. Given the list of in-use UID numbers,write a separate program to find a new,
unused UID number
5. Create a list of (username,old UID,new UID) triples to be used in creating final
/etc/passwd entries,and more importantly,in generating commands to change
the ownership of files in the filesystem.
At the same time,create final password file entries for the users who originally
had multiple UIDs and for UIDs that had multiple users.
6. Create the final password file.
7. Create the list of commands to change file ownership,and then run the commands. As will be seen, this has some aspects that require careful planning.

In passing,we note that all the code here operates under the assumption that usernames and UID numbers are not reused more than twice. This shouldn’t be a problem in practice,but it is worth being aware of in case a more complicated situation
comes along one day.

11.3.1 Separating Users by Manageability
Merging the password files is easy. The files are named u1.passwd and u2.passwd,
respectively. The sort command does the trick. We use tee to save the file and
simultaneously print it on standard output where we can see it:
$ sort u1.passwd u2.passwd | tee merge1

01-spitout.awk presents splitout.awk. This script separates the merged file into three
new files, named dupusers, dupids, and unique1, respectively.

11.3.2 Managing UIDs
Now that we have separated the users by categories,the next task is to create a list of
all the UID numbers in use:
awk -F: '{ print $3 }' merge1 | sort -n -u > unique-ids
We can verify that we have only the unique UID numbers by counting lines in merge1
and unique-ids:
$ wc -l merge1 unique-ids

Continuing through our task list,the next step is to write a program that produces
unused UIDs. By default,the program reads a sorted list of in-use UID numbers and
prints the first available UID number. However,since we’ll be working with multiple users,we’ll want it to generate a batch of unused UIDs. This is done with the –c
option,which provides a count of UIDs to generate. Example 11-4 presents the
newuids.sh script


11.3.3 Creating User–Old UID–New UID Triples
We now have to process the dupusers and dupids files. The output file lists the username,old UID and new UID numbers,separated by whitespace,one record per line,
for further processing. For dupusers,the processing is pretty straightforward: the first
entry encountered will be the old UID,and the next one will be the new chosen UID.
(In other words,we arbitrarily decide to use the second,larger UID for all of the
user’s files.) At the same time,we can generate the final /etc/passwd records for the
users listed in both files.

$ cat unique2 #Those who had two UIDs
$ cat unique3 #Those who get new UIDs
$ cat old-new-list List of user-old-new triples

The final password file is created by merging the three unique? files. While cat would
do the trick, it’d be nice to merge them in UID order:
sort -k 3 -t : -n unique[123] > final.password

The wildcard unique[123] expands to the three filenames unique1, unique2,and
unique3. Here is the final, sorted result:
$ cat final.password


11.4 Changing File Ownership
At first blush,changing file ownership is pretty easy. Given the list of usernames and
new UID numbers, we ought to be able to write a loop like this (to be run as root):
while read user old new
do
 cd /home/$user #Change to user's directory
 chown -R $new . #Recursively change ownership, see chown(1)
done < old-new-list

The idea is to change to the user’s home directory and recursively chown everything to
the new UID number. However,this isn’t enough. It’s possible for users to have files
in places outside their home directory. For example,consider two users, ben and
jhancock, working on a joint project in /home/ben/declaration:
$ cd /home/ben/declaration
$ ls -l draft*
-rw-r--r-- 1 ben fathers 2102 Jul 3 16:00 draft10
-rw-r--r-- 1 jhancock fathers 2191 Jul 3 17:09 draft.final

If we just did the recursive chown,both files would end up belonging to ben,and
jhancock wouldn’t be too happy upon returning to work the day after the Great Filesystem Reorganization.
Even worse,though,is the case in which users have files that live outside their home
directory. /tmp is an obvious example,but consider a source code management system,such as CVS. CVS stores the master files for a project in a repository that is typically not in any home directory,but in a system directory somewhere. Source files in
the repository belong to multiple users. The ownership of these files should also be
changed over.
Thus,the only way to be sure that all files are changed correctly everywhere is to do
things the hard way,using find,starting from the root directory. The most obvious
way to accomplish our goal is to run chown from find, like so:
find / -user $user -exec chown $newuid '{ }' \;

This runs an exhaustive file search,examining every file and directory on the system
to see if it belongs to whatever user is named by $user. For each such file or directory, find runs chown on it,changing the ownership to the UID in $newuid. (The find
command was covered in “The find Command” [10.4.3]. The –exec option runs the
rest of the arguments,up to the semicolon,for each file that matches the given criteria. The { } in the find command means to substitute the found file’s name into the
command at that point.) However,using find this way is very expensive,since it creates a new chown process for every file or directory. Instead,we combine find and
xargs:

# Regular version:
find / -user $user -print | xargs chown $newuid
# If you have the GNU utilities:
# fThere is an ordering problem here. If we change all of juser’s files to have the UID 10
before we change the ownership on mrwizard’s files,all of juser’s files will end up
being owned by mrwizard!
This can be solved with the Unix tsort program,which does topological sorting.ind / -user $user -print0 | xargs --null chown $newuid

(Topological sorting imposes a complete ordering on partially ordered data.) For our
purposes, we need to feed the data to tsort in the order new UID, old UID:
$ tsort << EOF
> 30 10
> 10 25
> EOF
30
10
25

The output tells us that 10 must be changed to 30 before 25 can be changed to 10.
As you might imagine,careful scripting is required. However,we have managed to
avoid this problem entirely! Remember the case of duplicate UID numbers with different names?
$ cat dupids

We gave all of these users brand-new UIDs:
$ cat final.passwd
The final part of our main program generates the list of find and xargs commands.
We have chosen to write the list of commands into a file, chown-files,that can be
executed separately in the background. This is because the program is likely to take a
long time to run,and undoubtedly our system administrator,after spending hours
developing and testing the scripts here,wants to start it running and then go home
and get some sleep. Here’s the script’s conclusion:
while read user old new
do
 echo "find / -user $user -print | xargs chown $new"
done < old-new-list > chown-files
chmod +x chown-files
rm merge1 unique[123] dupusers dupids unique-ids old-new-list
Here is what chown-files looks like:
$ cat chown-files
find / -user ben -print | xargs chown 301
find / -user jhancock -print | xargs chown 300
find / -user abe -print | xargs chown 4
find / -user tj -print | xargs chown 5
find / -user dorothy -print | xargs chown 6
find / -user toto -print | xargs chown 7

Remember the old-new-list file?
$ cat old-new-list
ben 201 301
jhancock 200 300
abe 105 4
tj 105 5
dorothy 110 6
toto 110 7

You may have noted that both abe and tj start out with the same UID. Similarly for
dorothy and toto. What happens when we run chown-files? Won’t all of tj’s files
end up belonging to the new UID 4? Won’t all of toto’s files end up belonging to the
new UID 6? Haven’t we just created the mess that we thought we had avoided?
The answer is that we’re safe,as long as we run these commands separately on each
system, before we put the new /etc/passwd file in place on each system. Remember
that originally, abe and dorothy were only on u1,and that tj and toto were only on
u2. Thus,when chown-files runs on u1 with the original /etc/passwd in place, find
will never find tj’s or toto’s files, since those users don’t exist:
$ find / -user toto -print
find: invalid argument `toto' to `-user'
Things will fail similarly,but for the opposite pair of users,on u2. The full mergesystems.sh script is presented in Example 11-5.

11.5 Other Real-World Issues
First,and most obvious,is that the /etc/group file is also likely to need merging.
With this file, it’s necessary to:
• Make sure that all the groups from each individual system exist in the merged /etc/
group file,and with the same unique GID. This is completely analogous to the username/UID issue we just solved, only the format of the file is different.
• Do a logical merge of users in the same group on the different systems. For
example:
floppy:x:5:tolstoy,camus In u1 /etc/group
floppy:x:5:george,betsy In u2 /etc/group
When the files are merged, the entry for group floppy needs to be:
floppy:x:5:tolstoy,camus,george,betsy Order of users doesn't matter
• The GID of all files must be brought into sync with the new,merged /etc/group
file,just as was done with the UID. If you’re clever,it’s possible to generate the
find … | xargs chown … command to include the UID and GID so that they
need to be run only once. This saves machine processing time at the expense of
additional programming time.
Second,any large system that has been in use for some time will have files with UID
or GID values that no longer (or never did) exist in /etc/passwd and /etc/group. It is
possible to find such files with:
find / '(' -nouser -o -nogroup ')' -ls

This produces a list of files in an output format similar to that of ls -dils. Such a list
probably should be examined manually to determine the users and/or groups to
which they should be reassigned,or new users (and/or groups) should be created for
them
Finally,there may be efficiency issues. Consider the series of commands shown
earlier:
find / -user ben -print | xargs chown 301
find / -user jhancock -print | xargs chown 300

find / -ls | awk -f make-commands.awk old-to-new.txt - > /tmp/commands.sh
... examine /tmp/commands.sh before running it ...
sh /tmp/commands.sh

Here, make-commands.awk would be an awk program that first reads the old-to-new
UID changes from old-to-new.txt




































































































































































































































