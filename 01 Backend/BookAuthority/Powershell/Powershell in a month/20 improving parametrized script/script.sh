This lab requires you to recall some of what you learned in chapter 21, because you’ll
be taking the following command, parameterizing it, and turning it into a script—just
as you did for the lab in chapter 21. But this time we also want you to make the
-computerName parameter mandatory and give it a hostname alias. Have your script
display verbose output before and after it runs this command, too. Remember, you
have to parameterize the computer name—but that’s the only thing you have to
parameterize in this case.
 Be sure to run the command as is before you start modifying it, to make sure it
works on your system:
get-wmiobject win32_networkadapter -computername localhost |
 where { $_.PhysicalAdapter } |
 select MACAddress,AdapterType,DeviceID,Name,Speed
To reiterate, here’s your complete task list:
 Make sure the command runs as is before modifying it.
 Parameterize the computer name.
 Make the computer name parameter mandatory.
 Give the computer name parameter an alias, hostname.
 Add comment-based help with at least one example of how to use the script.
 Add verbose output before and after the modified command.
 Save the script as Get-PhysicalAdapters.ps1.
22.8 Lab answer
#Get-PhysicalAdapters.ps1
<#
.Synopsis
Get physical network adapters
.Description
Display all physical adapters from the Win32_NetworkAdapter class.
.Parameter Computername
The name of the computer to check.
.Example
PS C:\> c:\scripts\Get-PhysicalAdapters -computer SERVER01
#>
[cmdletbinding()]
Param (
[Parameter(Mandatory=$True,HelpMessage="Enter a computername to query")]
[alias('hostname')]
[string]$Computername
)
Write-Verbose "Getting physical network adapters from $computername"
Get-Wmiobject -class win32_networkadapter –computername $computername |
 where { $_.PhysicalAdapter } |
 select MACAddress,AdapterType,DeviceID,Name,Speed
Write-Verbose "Script finished."