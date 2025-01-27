Try to answer the following questions and complete the specified tasks. This is an
important lab, because it draws on skills you’ve learned in many previous chapters,
and you should be continuing to use and reinforce these skills as you progress
through the remainder of this book.
1 What method of a ServiceController object (produced by Get-Service) will
pause the service without stopping it completely?
2 What method of a Process object (produced by Get-Process) would terminate
a given process?
3 What method of a WMI Win32_Process object would terminate a given process?
4 Write four commands that could be used to terminate all processes named
Notepad, assuming that multiple processes might be running under that same
name.
5 Assume you have a text list of computer names but want to display them in all
uppercase. What PowerShell expression could you use?
16.7 Lab answers
1 Find the methods like this: get-service | Get-Member -MemberType Method
and you should see a Pause() method.
2 Find the methods like this: get-process | Get-Member -MemberType Method
and you should see a Kill() method. You could verify by checking the MSDN
documentation for this process object type. Of course you shouldn’t need to
invoke the method because there is a cmdlet, Stop-Process, that will do the
work for you.
3 You could search the MSDN documentation for the Win32_Process class. Or
you might use the CIM cmdlets because they also work with WMI to list all possible methods.
Get-CimClass win32_process | select -ExpandProperty methods
In either event, you should see the Terminate() method.
4 get-process Notepad | stop-process
stop-process -name Notepad
get-process notepad | foreach {$_.Kill()}
Get-WmiObject win32_process -filter {name='notepad.exe'} |
Invoke-WmiMethod -Name Terminate
5 Get-content computers.txt | foreach {$_.ToUpper()}