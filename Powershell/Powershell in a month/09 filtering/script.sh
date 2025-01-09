Remember that Where-Object isn’t the only way to filter, and it isn’t even the one you
should turn to first. We’ve kept this chapter brief to allow you more time to work on
the hands-on examples, so keeping in mind the principle of filter left, try to accomplish
the following:
1 Import the NetAdapter module (available in the latest version of Windows,
both client and server). Using the Get-NetAdapter cmdlet, display a list of nonvirtual network adapters (adapters whose Virtual property is False, which
PowerShell represents with the special $False constant).
2 Import the DnsClient module (available in the latest version of Windows, both
client and server). Using the Get-DnsClientCache cmdlet, display a list of A
and AAAA records from the cache. Hint: if your cache comes up empty, try visiting a few web pages first to force some items into the cache.
3 Display all EXE files under C:\Windows\System32 that are larger than 5 MB.
4 Display a list of hotfixes that are security updates.
5 Display a list of hotfixes that were installed by the Administrator, and which are
updates. If you don’t have any, try finding hotfixes installed by the System
account. Note that some hotfixes won’t have an “installed by” value—that’s OK.
6 Display a list of all processes running with either the name Conhost or the name
Svchost.
11.8 Further exploration
Practice makes perfect, so try filtering some of the output from the cmdlets you’ve
already learned about, such as Get-Hotfix, Get-EventLog, Get-Process, Get-Service,
and even Get-Command. For example, you might try to filter the output of Get-Command
to show only cmdlets. Or use Test-Connection to ping several computers, and show the
results only from computers that didn’t respond. We’re not suggesting that you need to
use Where-Object in every case, but you should practice using it when it’s appropriate.
11.9 Lab answers
1 import-module NetAdapter
get-netadapter -physical
2 Import-Module DnsClient
Get-DnsClientCache -type AAAA,A
3 Dir c:\windows\system32\*.exe | where {$_.length –gt 5MB}
4 Get-Hotfix -Description 'Security Update'
5 get-hotfix -Description Update | where {$_.InstalledBy
-match "administrator"}
or any of these:
get-hotfix -Description Update | where {$_.InstalledBy
-match "system"}
get-hotfix -Description Update | where {$_.InstalledBy -eq
"NT Authority\System"}
6 get-process -name svchost,conhost