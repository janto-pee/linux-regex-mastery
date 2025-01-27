Once again, we’ve covered a lot of important concepts in a short amount of time. The
best way to cement your new knowledge is to put it to immediate use. We recommend
doing the following tasks in order, because they build on each other to help remind
you what you’ve learned and to help you find practical ways to use that knowledge.
 To make this a bit trickier, we’re going to force you to consider the GetADComputer command. Any Windows Server 2008 R2 or later domain controller has
this command installed, but you don’t need one. You need to know only three things:
 The Get-ADComputer command has a -filter parameter; running
Get-ADComputer -filter * retrieves all computer objects in the domain.
 Domain computer objects have a Name property that contains the computer’s
host name.
 Domain computer objects have the type name ADComputer, which means
Get-ADComputer produces objects of the type ADComputer.
That’s all you need to know. With that in mind, complete these tasks.
NOTE You’re not being asked to run these commands. This is more of a mental exercise. Instead, you’re being asked whether these commands will function and why. You’ve been told how Get-ADComputer works and what it
produces; you can read the help to discover what other commands expect
and accept.
1 Would the following command work to retrieve a list of installed hotfixes from
all computers in the specified domain? Why or why not? Write an explanation,
similar to the ones we provided earlier in this chapter.
Get-Hotfix -computerName (Get-ADComputer -filter * |
➥Select-Object -expand name)
2 Would this alternative command work to retrieve the list of hotfixes from the
same computers? Why or why not? Write an explanation, similar to the ones we
provided earlier in this chapter.
Get-ADComputer -filter * | Get-HotFix
3 Would this third version of the command work to retrieve the list of hotfixes
from the domain computers? Why or why not? Write an explanation, similar to
the ones we provided earlier in this chapter.
Get-ADComputer -filter * |
➥Select-Object @{l='computername';e={$_.name}} | Get-Hotfix
4 Write a command that uses pipeline parameter binding to retrieve a list of running processes from every computer in an Active Directory (AD) domain. Don’t
use parentheses.

5 Write a command that retrieves a list of installed services from every computer
in an AD domain. Don’t use pipeline input; instead, use a parenthetical command (a command in parentheses).
6 Sometimes Microsoft forgets to add a pipeline parameter binding to a cmdlet.
For example, would the following command work to retrieve information from
every computer in the domain? Write an explanation, similar to the ones we
provided earlier in this chapter.
Get-ADComputer -filter * |
➥Select-Object @{l='computername';e={$_.name}} |
➥Get-WmiObject -class Win32_BIOS
9.9 Further exploration
We find that many students have difficulty embracing this pipeline input concept,
mainly because it’s so abstract. Unfortunately, this stuff is also crucial to understanding the shell. Reread this chapter if you need to, rerun the example commands we’ve
provided, and look super carefully at the output. For example, why is this command’s
output
Get-Date | Select –Property DayOfWeek
slightly different from this command’s output?
Get-Date | Select –ExpandProperty DayOfWeek
If you’re still not sure, drop us a line in the Forums on http://PowerShell.org.
9.10 Lab answers
1 This should work, because the nested Get-ADComputer expression will return a
collection of computer names and the –Computername parameter can accept an
array of values.
2 This won’t work, because Get-Hotfix doesn’t accept any parameters by value. It
will accept –Computername by property name, but this command isn’t doing
that.
3 This should work. The first part of the expression is writing a custom object to
the pipeline that has a Computername property. This property can be bound to
the Computername parameter in Get-Hotfix because it accepts pipeline binding
by property name.
4 Get-Service –Computername (get-adcomputer -filter * |
Select-Object –expandproperty name)
5 get-adcomputer -filter * |
➥Select-Object @{l='computername';e={$_.name}} |
➥Get-WmiObject -class Win32_BIOS
6 This will not work. The Computername parameter in Get-WMIObject doesn’t
take any pipeline binding

