Create a remoting endpoint named TestPoint on your local computer. Configure the
endpoint so that the SmbShare module is loaded automatically, but so that only the
Get-SmbShare cmdlet is visible from that module. Also ensure that key cmdlets such as
Exit-PSSession are available, but no other core PowerShell cmdlets can be used.
Don’t worry about specifying special endpoint permissions or designating a “run as”
credential.
 Test your endpoint by connecting to it using Enter-PSSession (specify localhost
as the computer name, and TestPoint as the configuration name). When connected,
run Get-Command to ensure that only the designated handful of commands can be seen.
 Note that this lab might be possible only on Windows 8, Windows Server 2012, and
later versions of Windows; the SmbShare module didn’t ship with earlier versions of
Windows.
Lab answer
#create the session configuration file in the current location
#this is one long line
New-PSSessionConfigurationFile -Path .\SMBShareEndpoint.pssc
-ModulesToImport SMBShare -SessionType RestrictedRemoteServer
-CompanyName "My Company" -Author "Jane Admin"
-Description "restricted SMBShare endpoint" -PowerShellVersion '4.0'
#register the configuration
Register-PSSessionConfiguration -Path .\SMBShareEndpoint.pssc -Name TestPoint
#enter the restricted endpoint
Enter-PSSession -ComputerName localhost -ConfigurationName TestPoint
get-command
exit-pssession