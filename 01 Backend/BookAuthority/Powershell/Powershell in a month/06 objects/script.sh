This chapter has probably covered more, and more difficult, new concepts than any
chapter to this point. We hope that you were able to make sense of it all and that these
exercises will help you cement what you’ve learned. Some of these tasks draw on skills
you’ve learned in previous chapters, to refresh your memory and keep you sharp.



1 Identify a cmdlet that produces a random number.
2 Identify a cmdlet that displays the current date and time.
3 What type of object does the cmdlet from task 2 produce? (What is the type name
of the object produced by the cmdlet?)
4 Using the cmdlet from task 2 and Select-Object, display only the current day
of the week in a table like the following (Caution: the output will right-align, so
make sure your PowerShell window doesn’t have a horizontal scrollbar):
DayOfWeek
---------
 Monday
5 Identify a cmdlet that displays information about installed hotfixes on Windows
systems.
6 Using the cmdlet from task 5, display a list of installed hotfixes. Then extend the
expression to sort the list by the installation date, and display only the installation date, the user who installed the hotfix, and the hotfix ID. Remember that
the column headers shown in a command’s default output aren’t necessarily the
real property names—you need to look up the real property names to be sure.
7 Repeat task 6, but this time sort the results by the hotfix description, and
include the description, the hotfix ID, and the installation date. Put the results
into an HTML file.
8 Display a list of the 50 newest entries from the Security event log (you can use a
different log, such as System or Application, if your Security log is empty). Sort
the list with the oldest entries appearing first, and with entries made at the same
time sorted by their index. Display the index, time, and source for each entry.
Put this information into a text file (not an HTML file, but a plain-text file). You
may be tempted to use Select-Object and its -first or -last parameters to
achieve this; don’t. There’s a better way. Also, avoid using Get-WinEvent for
now; a better cmdlet is available for this particular task.
8.11 Lab answers
1 Get-Random
2 Get-Date
3 System.DateTime
4 Get-Date | select DayofWeek
5 Get-Hotfix
6 Get-HotFix | Sort InstalledOn | Select InstalledOn,InstalledBy,HotFixID
7 Get-HotFix | Sort Description | Select Description,
InstalledOn,InstalledBy,HotFixID | ConvertTo-Html -Title "HotFix
Report" | Out-File HotFixReport.htm
8 Get-EventLog -LogName System -Newest 50 | Sort TimeGenerated,Index |
Select Index,TimeGenerated,Source | Out-File elogs.txt