See if you can complete the following tasks:
1 Display a table of processes that includes only the process names, IDs, and
whether they’re responding to Windows (the Responding property has that
information). Have the table take up as little horizontal room as possible, but
don’t allow any information to be truncated.
2 Display a table of processes that includes the process names and IDs. Also
include columns for virtual and physical memory usage, expressing those values
in megabytes (MB).
3 Use Get-EventLog on Windows to display a list of available event logs. (Hint:
you need to read the help to learn the correct parameter to accomplish that.)
Format the output as a table that includes, in this order, the log display name
and the retention period. The column headers must be LogName and RetDays.
4 Display a list of services so that a separate table is displayed for services that are
started and services that are stopped. Services that are started should be displayed first. (Hint: use a -groupBy parameter.)
5 Display a four-column-wide list of all directories in the root of the C: drive.
6 Create a formatted list of all .exe files in C:\Windows displaying the name, version information, and file size. PowerShell uses the length property, but to
make it clearer, your output should show Size.
10.11 Further exploration
This is the perfect time to experiment with the formatting system. Try using the three
main Format- cmdlets to create different forms of output. The labs in upcoming
chapters often ask you to use specific formatting, so you might as well hone your skills
with these cmdlets and start memorizing the more often-used parameters covered in
this chapter.
1 get-process | format-table Name,ID,Responding -autosize -Wrap
2 get-process | format-table Name,ID,
@{l='VirtualMB';e={$_.vm/1mb}},
@{l='PhysicalMB';e={$_.workingset/1MB}} -autosize
3 Get-EventLog -List | Format-Table
@{l='LogName';e={$_.LogDisplayname}},
@{l='RetDays';e={$_.MinimumRetentionDays}} -autosize
4 Get-Service | sort Status -descending | format-table -GroupBy Status
5 Dir c:\ -directory | format-wide –column 4
6 dir c:\windows\*.exe |
➥Format-list Name,VersionInfo,@{Name="Size";Expression={$_.length}}
