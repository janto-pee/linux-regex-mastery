It’s time to combine some of what you’ve learned about remoting with what you’ve
learned in previous chapters. See if you can accomplish the following tasks:
1 Make a one-to-one connection with a remote computer (or with localhost if
you have only one computer). Launch Notepad.exe. What happens?
2 Using Invoke-Command, retrieve a list of services that aren’t started from one or
two remote computers (it’s OK to use localhost twice if you have only one
computer). Format the results as a wide list. (Hint: it’s OK to retrieve results and
have the formatting occur on your computer—don’t include the Formatcmdlets in the commands that are invoked remotely.)
3 Use Invoke-Command to get a list of the top 10 processes for virtual memory
(VM) usage. Target one or two remote computers, if you can; if you have only
one computer, target localhost twice.
4 Create a text file that contains three computer names, with one name per line.
It’s OK to use the same computer name, or localhost, three times if you have
access to only one computer. Then use Invoke-Command to retrieve the 100 newest Application event log entries from the computer names listed in that file.
5 Using Invoke-Command, query one or more remote computers to display the
properties ProductName, EditionID, and CurrentVersion from the registry key
HKEY_Local_Machine\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ .
(Hint: this requires you to get the property of an item.)
13.10 Further exploration
We could cover a lot more about remoting in PowerShell—enough that you’d be reading about it for another month of lunches. Unfortunately, some of its trickier bits aren’t
well documented. We suggest heading up to PowerShell.org, and more specifically to
their e-book resources, where Don and fellow MVP Dr. Tobias Weltner have put
together a comprehensive (and free!) Secrets of PowerShell Remoting mini e-book for you.
The guide rehashes some of the basics you learned in this chapter, but it primarily
focuses on detailed, step-by-step directions (with color screenshots) that show how to
configure a variety of remoting scenarios. The guide also digs into some of the grittier
details of the protocol and troubleshooting, and even has a short section on how to talk
to information security people about remoting. The guide is updated periodically, so
check back every few months to make sure you have the latest edition. Don’t forget that
you can also reach Don with your questions in the Forums at PowerShell.org.
13.11 Lab answers
1 Enter-PSSession Server01
[Server01] PS C:\Users\Administrator\Documents> Notepad
The Notepad process will launch, but there won’t be any interactive process
either locally or remotely. In fact, run this way, the prompt won’t return until
the Notepad process ends—although an alternative command to launch it is
Start-Process Notepad.
2 Invoke-Command –scriptblock {get-service | where {$_.status -eq
"stopped"}} -computername Server01,Server02 | format-wide -Column 4
3 Invoke-Command -scriptblock {get-process | sort VM -Descending |
Select-first 10} –computername Server01,Server02
4 Invoke-Command -scriptblock {get-eventlog -LogName Application -
Newest 100} -ComputerName (Get-Content computers.txt)
5 invoke-command –scriptblock{get-itemproperty
'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' | Select
ProductName,EditionID,CurrentVersion} -computername Server01,
Server02