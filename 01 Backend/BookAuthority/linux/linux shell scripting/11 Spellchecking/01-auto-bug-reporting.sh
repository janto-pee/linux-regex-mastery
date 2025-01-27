#! /bin/sh -
# probreport --- simple problem reporting program
file=/tmp/report.$$
echo "Type in the problem, finish with Control-D."
cat > $file
while true
do
 printf "[E]dit, Spell [C]heck, [S]end, or [A]bort: "
 read choice
 case $choice in
 [Ee]*) ${EDITOR:-vi} $file
 ;;
 [Cc]*) spell $file
 ;;
 [Aa]*) exit 0
 ;;
 [Ss]*) break # from loop
 ;;
 esac
done
... Send report
