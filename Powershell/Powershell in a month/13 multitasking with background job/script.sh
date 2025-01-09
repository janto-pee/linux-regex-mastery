The following exercises should help you understand how to work with various types
of jobs and tasks in PowerShell. As you work through these exercises, don’t feel you
have to write a one-line solution. Sometimes it’s easier to break things down into separate steps.
1 Create a one-time background job to find all the PowerShell scripts on the C:
drive. Any task that might take a long time to complete is a great candidate for a
job.
2 You realize it would be helpful to identify all PowerShell scripts on some of your
servers. How would you run the same command from task 1 on a group of
remote computers?
3 Create a background job that will get the latest 25 errors from the system event
log on your computer and export them to a CliXML file. You want this job to
run every day, Monday through Friday, at 6 a.m., in order for it to be ready for
you to look at when you come in to work.
4 What cmdlet would you use to get the results of a job, and how would you save
the results in the job queue?
 Lab answers
1 Start-Job {dir c:\ -recurse –filter '*.ps1'}
2 Invoke-Command –scriptblock {dir c:\ -recurse –filter *.ps1}
–computername (get-content computers.txt) -asjob
3 $Trigger=New-JobTrigger -At "6:00AM" -DaysOfWeek "Monday",
"Tuesday","Wednesday","Thursday","Friday" –Weekly
$command={ Get-EventLog -LogName System -Newest 25 -EntryType Error
| Export-Clixml c:\work\25SysErr.xml}
Register-ScheduledJob -Name "Get 25 System Errors" -ScriptBlock
$Command -Trigger $Trigger
#check on what was created
Get-ScheduledJob | Select *
4 Receive-Job –id 1 –keep
Of course, you would use whatever job ID was applicable or the job name.
