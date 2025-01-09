#! /bin/sh -
# Run the ps command continuously, with a short pause after
# each redisplay.
#
# Usage:
# simple-top
IFS='
 '
# Customize PATH to get BSD-style ps first
PATH=/usr/ucb:/usr/bin:/bin
export PATH
HEADFLAGS="-n 20"
PSFLAGS=aux
SLEEPFLAGS=5
SORTFLAGS='-k3nr -k1,1 -k2n'
HEADER="`ps $PSFLAGS | head -n 1`"
while true
do
 clear
 uptime
 echo "$HEADER"
 ps $PSFLAGS |
 sed -e 1d |
 sort $SORTFLAGS |
 head $HEADFLAGS
 sleep $SLEEPFLAGS
done