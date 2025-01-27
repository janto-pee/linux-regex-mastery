Now it’s your turn. We’re assuming that you’re working in a virtual machine or other
machine that is OK to mess up a little in the name of learning. Please don’t do this in
a production environment on a mission-critical computer!
 Windows 8 and Windows Server 2012 (and later) include a module for working
with file shares. Your task is to create a directory called LABS on your computer and
share it. For the sake of this exercise, you can assume that the folder and share don’t
already exist. Don’t worry about NTFS permissions, but make sure that the share permissions are set so that Everyone has read/write access, and local Administrators have
full control. Because the share will be primarily for files, you may want to set the
share’s caching mode for documents. Your script should output an object showing the
new share and its permissions.
12.6 Lab answer
#create the folder
New-item -Path C:\Labs -Type Directory | Out-Null
#create the share
$myShare = New-SmbShare -Name Labs -Path C:\Labs\ `
-Description "MoL Lab Share" -ChangeAccess Everyone `
-FullAccess Administrators -CachingMode Documents
#get the share permissions
$myShare | Get-SmbShareAccess