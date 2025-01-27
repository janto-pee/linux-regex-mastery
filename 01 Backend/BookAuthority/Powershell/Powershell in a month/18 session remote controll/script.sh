To complete this lab, you should have two computers: one to remote from, and
another to remote to. If you have only one computer, use its computer name to
remote to it. You should get a similar experience that way.
TIP In chapter 1, we mentioned a multicomputer virtual environment at
CloudShare (www.cloudshare.com). You’ll find other, similar services that
offer cloud-based virtual machines. By using CloudShare, we didn’t have to
set up the Windows OS, because the service had ready-made templates for us
to use. You do have to pay a fee for the service, and it isn’t available in all
countries, but if you can use it, it’s a great way to get a lab environment running if you’re not able to run one locally
1 Close all open sessions in your shell.
2 Establish a session to a remote computer. Save the session in a variable named
$session.
3 Use the $session variable to establish a one-to-one remote shell session with
the remote computer. Display a list of processes and then exit.
4 Use the $session variable with Invoke-Command to get a list of services from the
remote computer.
5 Use Get-PSSession and Invoke-Command to get a list of the 20 most recent
Security event log entries from the remote computer.
6 Use Invoke-Command and your $session variable to load the ServerManager
module on the remote computer.
7 Import the ServerManager module’s commands from the remote computer to
your computer. Add the prefix rem to the imported commands’ nouns.
8 Run the imported Get-WindowsFeature command.
9 Close the session that’s in your $session variable.
NOTE Thanks to a new feature in PowerShell v3, you could also accomplish
steps 6 and 7 with a single step, by using the Import-Module command. Feel
free to review the help for this command and see if you can figure out how to
use it to import a module from a remote computer.
20.8 Further exploration
Take a quick inventory of your environment: What PowerShell-enabled products do
you have? Exchange Server? SharePoint Server? VMware vSphere? System Center Virtual Machine Manager? These and other products all include PowerShell modules or
snap-ins, many of which are accessible via PowerShell remoting.
20.9 Lab answers
1 get-pssession | Remove-PSSession
2 $session=new-pssession –computername localhost
3 enter-pssession $session
Get-Process
Exit
4 invoke-command -ScriptBlock { get-service } -Session $session
5 Invoke-Command -ScriptBlock {get-eventlog -LogName System
➥-Newest 20} -Session (Get-PSSession)
6 Invoke-Command -ScriptBlock {Import-Module ServerManager}
➥-Session $session
7 Import-PSSession -Session $session -Prefix rem
➥-Module ServerManager
8 Get-RemWindowsFeature
9 Remove-PSSession -Session $session