The following command is for you to add to a script. You should first identify any elements that should be parameterized, such as the computer name. Your final script
should define the parameter, and you should create comment-based help within the
script. Run your script to test it, and use the Help command to make sure your
comment-based help works properly. Don’t forget to read the help files referenced
within this chapter for more information.
 Here’s the command:
Get-WmiObject Win32_LogicalDisk -comp $env:computername -filter
➥"drivetype=3" |
➥Where { ($_.FreeSpace / $_.Size) -lt .1 } |
➥Select -Property DeviceID,FreeSpace,Size
Here’s a hint: At least two pieces of information need to be parameterized. This command is intended to list all drives that have less than a given amount of free disk space.
Obviously, you won’t always want to target localhost (we’re using the PowerShell equivalent of %computername% in our example), and you might not want 10% (that is, .1) to
be your free-space threshold. You could also choose to parameterize the drive type
(which is 3, here), but for this lab leave that hardcoded with the value 3.

<#
.Synopsis
Get drives based on percentage free space
.Description
This command will get all local drives that have less than the specified
percentage of free space available.
.Parameter Computername
The name of the computer to check. The default is localhost.
.Parameter MinimumPercentFree
The minimum percent free diskspace. This is the threshhold. The default value
is 10. Enter a number between 1 and 100.
.Example
PS C:\> Get-Disk -minimum 20
Find all disks on the local computer with less than 20% free space.
.Example
PS C:\> Get-Disk -comp SERVER02 -minimum 25
Find all local disks on SERVER02 with less than 25% free space.
#>
Param (
$Computername='localhost',
$MinimumPercentFree=10
)
#Convert minimum percent free
$minpercent = $MinimumPercentFree/100
Get-WmiObject –class Win32_LogicalDisk –computername $computername -filter
"drivetype=3" |
Where { $_.FreeSpace / $_.Size –lt $minpercent } |
Select –Property DeviceID,FreeSpace,Size