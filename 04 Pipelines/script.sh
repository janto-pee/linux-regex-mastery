# 5.1 Extracting Data from Structured Text Files

# One obvious useful thing that we can do with such a file is to write some software to
# create an office directory. That way,only a single file, /etc/passwd,needs to be kept
# up-to-date,and derived files can be created when the master file is changed,or more
# sensibly,by a cron job that runs at suitable intervals. (We will discuss cron in
# “crontab: Rerun at Specified Times” [13.6.4].)

# For our first attempt,we make the office directory a simple text file,with entries like
# this:
# Franklin, Ben   •OSD212•555-0022
# Gale, Dorothy   •KNS321•555-0044
# ...
# where • represents an ASCII tab character. We put the personal name in conventional directory order (family name first),padding the name field with spaces to a convenient fixed length. We prefix the office number and telephone with tab characters to preserve some useful structure that other tools can exploit

# AWK is best but lets do it in unix
# For each password file line,we need to extract field five,split it into three subfields,
# rearrange the names in the first subfield,and then write an office directory line to a
# sorting process.

# awk and cut are convenient tools for field extraction:
# ... | awk -F: '{ print $5 }' | ...
# ... | cut -d: -f5 | ...

There is a slight complication in that we have two field-processing tasks that we
want to keep separate for simplicity,but we need to combine their output to make a
directory entry. The join command is just what we need: it expects two input files,
each ordered by a common unique key value,and joins lines sharing a common key
into a single output line, with user control over which fields are output

Since our directory entries contain three fields,to use join we need to create three
intermediate files containing the colon-separated pairs key:person, key:office,and
key:telephone,one pair per line. These can all be temporary files,since they are
derived automatically from the password file.









































































































