Take some time to complete the following hands-on tasks. Much of the difficulty in
using WMI is in finding the class that will give you the information you need, so much
of your time in this lab will be spent tracking down the right class. Try to think in keywords (we’ll provide some hints), and use a WMI explorer to quickly search through
classes (the WMI Explorer we use lists classes alphabetically, making it easier for us to
validate our guesses). Keep in mind that PowerShell’s help system can’t help you find
WMI classes.
1 What class can you use to view the current IP address of a network adapter?
Does the class have any methods that you could use to release a DHCP lease?
(Hint: network is a good keyword here.)
2 Create a table that shows a computer name, operating system build number,
operating system description (caption), and BIOS serial number. (Hint: you’ve
seen this technique, but you need to reverse it to query the OS class first, and
then query the BIOS second.)
3 Query a list of hotfixes using WMI. (Hint: Microsoft formally refers to these as
quick-fix engineering.) Is the list different from that returned by the Get-Hotfix
cmdlet?
4 Display a list of services, including their current statuses, their start modes, and
the accounts they use to log on.
5 Using the CIM cmdlets, list all available classes in the SecurityCenter2 namespace with Product as part of the name.
6 Once you discover the name, use the CIM cmdlets to display any antispyware
application. You can also check for antivirus products.
TRY IT NOW After you’ve completed this lab, try completing review lab 2,
which you’ll find in the appendix.
14.10 Further exploration
WMI is a vast, complex technology, and someone could easily write an entire book
about it. In fact, someone did: PowerShell and WMI by fellow MVP Richard Siddaway
(Manning, 2012). The book provides tons of examples and discusses some of the new
capabilities of the CIM cmdlets introduced in PowerShell v3. We heartily recommend
this book to anyone interested in learning more about WMI.
 If you’ve found WMI to be thoroughly confusing or frustrating, don’t worry. That’s
a common reaction. But we have some good news: In PowerShell v3 and later, you can
often use WMI without seeming to “touch” WMI. That’s because Microsoft has written
hundreds of cmdlets that “wrap around” WMI. These cmdlets provide help, discoverability, examples, and all the good things cmdlets give you, but they use WMI internally. This makes it easier to take advantage of the power of WMI without having to
deal with its frustrating elements.
14.11 Lab answers
1 You can use the Win32_NetworkAdapterConfiguration class.
If you run Get-Wmiobject for this class and pipe to Get-Member, you should see
numerous DHCP-related methods. You can also find this by using a CIM cmdlet:
Get-CimClass win32_networkadapterconfiguration | select -
expand methods | where Name -match "dhcp"
2 get-wmiobject win32_operatingsystem | Select BuildNumber,Caption,
@{l='Computername';e={$_.__SERVER}},
@{l='BIOSSerialNumber';e={(gwmi win32_bios).serialnumber }} | ft
-auto
or by using the CIM cmdlets:
get-ciminstance win32_operatingsystem | Select BuildNumber,Caption,
@{l='Computername';e={$_.CSName}},
@{l='BIOSSerialNumber';e={(get-ciminstance win32_bios).serialnumber
}} | ft -auto
3 get-wmiobject win32_quickfixengineering
4 You should see that the results are similar.
5 get-wmiobject win32_service | Select Name,State,StartMode,
StartName
or
get-ciminstance win32_service | Select Name,State,StartMode,
StartName
6 get-cimclass -namespace root/SecurityCenter2 -ClassName *product
get-ciminstance -namespace root/SecurityCenter2 -ClassName
AntiSpywareProduct