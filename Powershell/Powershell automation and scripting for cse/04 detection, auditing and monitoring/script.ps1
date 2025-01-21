For many years while working at Microsoft, I have preached the protect, detect, and respond approach.
Most companies try to just protect their devices, but that’s where they stop. To detect and respond, there
needs to be not only a working Security Operations Center (SOC) in place but also infrastructure
and resources
Over the years, I saw more and more organizations that actually had operating SOCs in place, which
made me really happy. But unfortunately – especially when looking at small and medium-sized
enterprises – most organizations have either no monitoring in place or are just starting their journey

PowerShell has been covered in the media several times when it comes to attacks. Ransomware malware
was distributed, sending malicious emails that launched PowerShell in the background to execute
a payload, a fileless attack in which the malware does not need to be downloaded on the client but
runs in the memory instead, and even legitimate system tools that have been abused by adversaries
to execute their attacks (also known as Living Off the Land or LOLbins)

aving an extensive (not exclusively restricted to) PowerShell logging infrastructure in place helps your
SOC team to identify attackers and get insights into what commands and code adversaries executed.
It also helps to improve your detection and security controls

Configuring PowerShell Event Logging
In this section, we will discuss the different types of PowerShell logging that you can enable, including
PowerShell Module Logging, PowerShell Script Block Logging, Protected Event Logging, and PowerShell
transcripts. We will also look into how to configure these logging features to meet your organization’s
specific security requirements

PowerShell Module Logging was added with PowerShell 3.0. This feature provides extensive logging
of all PowerShell commands that are executed on the system. If Module Logging is enabled, pipeline
execution events are generated and written to the Microsoft-Windows-Powershell/
Operational event log in the context of event ID 4103

To enable Module Logging within the current session, only for a certain module, you need to import
the module first. In this example, we will use the EventList module:
> Import-Module EventList
> (Get-Module EventList).LogPipelineExecutionDetails = $true
> (Get-Module EventList).LogPipelineExecutionDetails
True
Of course, you can replace the module name, EventList, with any other module name that you
want to log pipeline execution details for:
Import-Module <Module-Name>
(Get-Module <Module-Name>).LogPipelineExecutionDetails = $true

If you want to monitor a managed environment, you don’t want to enable PowerShell Module Logging
manually on every host. In this case, you can use Group Policy to enable Module Logging.
Create a new Group Policy Object (GPO). As Windows PowerShell and PowerShell Core were
designed to co-exist and can be configured individually, it depends on what PowerShell version you
want to configure:
• To configure Windows PowerShell, navigate to Computer Configuration | Policies | Administrative
Templates | Windows Components | Windows PowerShell
• To configure PowerShell Core, navigate to Computer Configuration | Administrative Templates
| PowerShell Core

PowerShell Script Block Logging
A script block is a collection of expressions and commands that is grouped together and executed as
one unit. Of course, a single command can be also executed as a script block.
Many commands support the -ScriptBlock parameter, such as the Invoke-Command command.
which you can use to run entire script blocks, locally or remotely:

> Invoke-Command -ComputerName PSSec-PC01 -ScriptBlock {RestartService -Name Spooler -Verbose}
VERBOSE: Performing the operation "Restart-Service" on target "Print
Spooler (Spooler)".
It is important to note that all actions performed in PowerShell are considered script blocks
and will be logged if Script Block Logging is enabled – regardless of whether or not they use the
-ScriptBlock parameter
Therefore, the PowerShell team made the decision that security-relevant script blocks
should be logged by default
This basic version of Script Block Logging does not replace full Script Block Logging; it should only
be considered as a last resort, if logging was not in place when an attack happened

Additionally, there’s an even more verbose option when configuring Script Block Logging – Script
Block Invocation Logging
Enabling Script Block Invocation Logging can generate a high volume of events, which may flood the
log and roll out useful security data from other events. Be careful with enabling Script Block Invocation
Logging, as a high volume of events will be generated – usually, you don’t need it for incident analysis.

There are several ways to configure Script Block Logging – manually as well as centrally managed
To manually enable Script Block Logging, you can edit the registry. The settings that you want to
change are within the following registry path:
HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\PowerShell\
ScriptBlockLogging
Using the EnableScriptBlockLogging (REG_DWORD) registry key, you can configure to
enable Script Block Logging:
• Enabled: Set the value to 1 to enable it
• Disabled: Set the value to 0 to disable it
If Script Block Logging is enabled, you will find all the executed code under event ID 4104.
Using the EnableScriptBlockInvocationLogging (REG_DWORD) registry key, you can
configure it to enable Script Block Invocation Logging (event IDs 4105 and 4106):
• Enabled: Set the value to 1 to enable it
• Disabled: Set the value to 0 to disable it

You can configure Script Block Logging manually by running the following commands in an elevated
PowerShell console:
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\
ScriptBlockLogging" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\
PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Value
1 -Force

When enabling ScriptBlockLogging using the described commands, ScriptBlockLogging
will be enabled for both 32-bit and 64-bit applications. You can verify that both settings were configured
under the following:
• HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\
PowerShell\ScriptBlockLogging
• HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Microsoft\
Windows\PowerShell\ScriptBlockLogging

 managed environments, it makes sense to manage your machines centrally. Of course, this can
be done via PowerShell and/or Desired State Configuration (DSC), but it can be also done using
Group Policy.
Create a new GPO. Depending on which PowerShell version you want to configure, navigate to either
of the following:
• Computer Configuration | Policies | Administrative Templates | Windows Components |
Windows PowerShell for Windows PowerShell
• Computer Configuration | Administrative Templates | PowerShell Core for PowerShell Core


Protected Event Logging encrypts data using the Internet Engineering Task Force (IETF) Cryptographic
Message Syntax (CMS) standard, which relies on public key cryptography. This means that a public
key is deployed on all systems that should support Protected Event Logging. Then, the public key is
used to encrypt event log data before it is forwarded to a central log collection server.
On this machine, the highly sensitive private key is used to decrypt the data, before the data is inserted
into the SIEM. This machine is sensitive and, therefore, needs special protection.

Enabling Protected Event Logging
To enable Protected Event Logging, you can deploy a base64-encoded X.509 certificate or another
option (for example, deploying a certificate through Public Key Infrastructure (PKI) and providing
a thumbprint, or providing a path to a local or file share-hosted certificate). In our example, we’ll use
a base64-encoded X.509 certificate.
Here are the certificate requirements:
• The certificate must also have the “Document Encryption” Enhanced Key Usage (EKU) with
the OID number (1.3.6.1.4.1.311.80.1) included
• The certificate properties must include either the “Data Encipherment” or “Key Encipherment”
key usage
Be careful that the certificate file that you plan to deploy does not contain the private key. Once you
have obtained the certificate, you can either enable it manually or by using Group Policy
To leverage this script, save your certificate in the $cert variable, which you will use in the second
command to pass the public key certificate to the Enable-ProtectedEventLogging function,
enabling Protected Event Logging on the local system:
> $cert = Get-Content C:\tmp\PEL_certificate.cer –Raw
> Enable-ProtectedEventLogging –Certificate $cert
You can also enable Protected Event Logging using Group Policy. Create a new GPO or reuse an
existing GPO, and then navigate to Computer Configuration | Policies | Administrative Templates
| Windows Components | Event Logging

PowerShell transcripts have been available in PowerShell since PowerShell version 1.0 as part of the
Microsoft.PowerShell.Host module. Transcripts are a great way to monitor what happens
in a PowerShell session.

If a PowerShell transcript is started, all executed PowerShell commands and their output are recorded
and saved into the folder that was specified. If not specified otherwise, the default output folder is the
My Documents folder (%userprofile%\Documents) of the current user.
There are several options for enabling transcripts. However, the simplest method to record PowerShell
transcripts is by simply typing the Start-Transcript command in the current session and hitting
Enter. In this case, only commands that are run in this local session will be captured.
When running the Start-Transcript cmdlet directly, the most interesting parameters are
-OutputDirectory, -Append, -NoClobber, and -IncludeInvocationHeader:
Transcripts that were initialized with Start-Transcript are only recorded as long as the
session is active or until Stop-Transcript is executed, which stops the recording of executed
PowerShell commands

Enabling transcripts by default
To enable transcripts by default on a system, you can either configure transcripts via a registry or by
using Group Policy to configure transcripts for multiple systems.
Enabling transcripts by registry or script
When PowerShell transcripts are configured, the following registry hive is used:
HKLM:\Software\Policies\Microsoft\Windows\PowerShell\
Transcription
For example, to enable transcription, using invocation headers and the C:\tmp output folder, you
need to configure the following values to the registry keys:
• [REG_DWORD]EnableTranscripting = 1
• [REG_DWORD]EnableInvocationHeader = 1
• [REG_SZ]OutputDirectory = C:\tmp
Enabling transcripts using Group Policy
In Active Directory-managed environments, the easiest way to configure transcripts is by using
Group Policy
Create a new GPO or reuse an existing one. Then, navigate to Computer Configuration | Policies |
Administrative Templates | Windows Components | Windows PowerShell.

Enabling transcripts for PowerShell Remoting sessions
Custom endpoints are an excellent way to apply default settings to PowerShell Remoting sessions.

To get started, create a session configuration file, using the New-PSSessionConfigurationFile
cmdlet with the -TranscriptDirectory parameter to specify where transcripts should be
written to:
> New-PSSessionConfigurationFile -Path "$env:userprofile\Documents\
PSSession.pssc" -TranscriptDirectory "C:\tmp"

This command creates a new session configuration file, enforcing transcription, and stores it in
%userprofile%\Documents\PSSession.pssc, the path that was defined within the
-Path parameter.
Best practices for PowerShell transcripts
As a security best practice, use session transcripts for every user
credential theft is a real threat, and if your administrator’s identity
is stolen and misused, you will be happy to understand what was done by the adversary.
If you use transcripts, make sure that they cannot be modified. If they can be altered by an attacker,
they are of almost no use at all.

And last but not least, it makes sense to forward all the transcript files to a central logging server or
your SIEM to analyze them regularly.
One effective approach to centralizing the transcript files is to configure their destination as a Uniform
Naming Convention (UNC) path with a dynamic filename. For example, you can set the transcript
directory to a network share with write-only permission, using the PowerShell profile to log all activity
to a file with a unique name, such as the following:
\\server\share$\env:computername-$($env:userdomain)-$($env:username)-
$(Get-Date Format YYYYMMddhhmmss).txt

Analyzing event logs
The easiest option if you just want to analyze events or create new events is the *-WinEvent cmdlets,
which are still available in PowerShell Core 7. You can use Get-Command to find all available cmdlets
Get-Command *-WinEvent
Get-Command *-EventLog (removed)
wevtutil /?
For example, clearing the Security event log can be achieved with the following command:
> wevtutil.exe cl Security
Finding out which logs exist on a system
If you want to find out which event logs exist on a system, you can leverage the -ListLog parameter
followed by a wildcard (*) – Get-WinEvent -ListLog *:
You might want to pipe the output to Sort-Object to sort by record count, maximum log size,
log mode, or log name.

Querying events in 
Using the Get-WinEvent command, you can get all the event IDs from the event log that you
specified – 
Get-WinEvent Microsoft-Windows-PowerShell/Operational
In this example, you would see all event IDs that were generated in the PowerShell Operational log.
If you only want to query the last x events, the -MaxEvents parameter will help you to achieve
this task. For example to query the last 15 events of the security event log use 
Get-WinEvent Security -MaxEvents 15
This is especially helpful if you want to analyze recent events without querying the entire event log.
Using the -Oldest parameter reverts the order so that you see the oldest events in this
log – 
Get-WinEvent Security -MaxEvents 15 -Oldest
To find all events in the Microsoft Windows PowerShell Operational log that contain code that was
executed and logged by ScriptBlockLogging, filter for event id 4104: 
Get-WinEvent Microsoft-Windows-PowerShell/Operational | Where-Object { $_.Id -eq 4104 } | fl:
You can also filter for certain keywords in the message part. For example, to find all events that contain
the "logon" string in the message, use the -match comparison operator – Get-WinEvent
Security | Where-Object { $_.Message -match "logon" }:
You can also filter using XPath-based queries, using the -FilterXPath parameter:
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational"
-FilterXPath "*[System[(EventID=4100 or EventID=4101 or EventID=4102 or EventID=4103 or EventID=4104)]]"

It is also possible to filter by a specified hash table, using the -FilterHashtable parameter:
> $eventLog = @{ ProviderName="Microsoft-Windows-PowerShell"; Id =
4104 }
> Get-WinEvent -FilterHashtable $eventLog
If you want to query complex event structures, you can use the -FilterXml parameter and provide an
XML string. I have prepared such an example and uploaded it to this book’s GitHub repository: https://
github.com/PacktPublishing/PowerShell-Automation-and-Scripting-forCybersecurity/blob/master/Chapter04/Get-AllPowerShellEvents.ps1:

This example queries the Microsoft-Windows-PowerShell/Operational,
PowerShellCore/Operational, and Windows PowerShell event logs and retrieves all
the events that I will describe in the Basic PowerShell event logs section in this chapter

Now that you know how to work with event logs and query events, let’s look at how to detect and
analyze which code was run on a system.

Which code was run on a system?
In general, all events that contain logged code can be found either in the Microsoft Windows PowerShell
or the PowerShell Core Operational log, indicated by event ID 4104:
> Get-WinEvent Microsoft-Windows-PowerShell/Operational | Where-Object
Id -eq 4104
> Get-WinEvent PowerShellCore/Operational | Where-Object Id -eq 4104
To better find and filter what code was executed, I have written the Get-ExecutedCode function, which
you can find in the GitHub repository for this book: https://github.com/PacktPublishing/
PowerShell-Automation-and-Scripting-for-Cybersecurity/blob/master/
Chapter04/Get-ExecutedCode.ps1.

A downgrade attack can be executed by specifying the version number when running powershell.
exe:
> powershell.exe -version 2 –command <command>
On Windows 8, PowerShell version 2.0 can be disabled by running the following command in an
elevated console:
Disable-WindowsOptionalFeature -Online -FeatureName
MicrosoftWindowsPowerShellV2Root
.NET Framework 2.0, which is required to run PowerShell version 2.0, is by default not installed on
newer systems such as Windows 10.
So, if you try to run powershell.exe -version 2, you get an error message, stating that
version 2 of .NET Framework is missing:
> powershell.exe -version 2
As .NET Framework 2.0 can be installed manually – either by system administrators or attackers –
make sure to check for PowerShell version 2.0 and disable it.
Run the following command to check whether PowerShell version 2.0 is enabled or disabled:
> Get-WindowsOptionalFeature -Online | Where-Object {$_.FeatureName
-match "PowerShellv2"}

So, it seems like PowerShell version 2.0 is still enabled on this machine. Therefore, if the missing .NET
Framework 2.0 is installed, this system will be vulnerable to a downgrade attack.
Therefore, let’s disable PowerShell version 2.0 to harden your system by running the following command:
Get-WindowsOptionalFeature -Online | Where-Object {$_.
FeatureName -match "PowerShellv2"} | ForEach-Object {DisableWindowsOptionalFeature -Online -FeatureName $_.FeatureName -Remove}
You will see in the output that a restart is needed, so after you restart your PC, the changes are applied
and PowerShell version 2.0 is disabled:
> Get-WindowsOptionalFeature -Online | Where-Object {$_.
FeatureName -match "PowerShellv2"} | ForEach-Object {DisableWindowsOptionalFeature -Online -FeatureName $_.FeatureName -Remove}

So, if you verify once again, you will see that the state is set to Disabled:
> Get-WindowsOptionalFeature -Online | Where-Object {$_.FeatureName
-match "PowerShellv2"}

However, on Windows 7, PowerShell version 2.0 cannot be disabled. The only way to disallow
PowerShell version 2.0 usage is to leverage Application Control or AppLocker
For adversaries, there is also another way to run a downgrade attack – if, for example, a compiled
application leverages an older PowerShell version, and links against the compiled PowerShell v2 binaries,
a downgrade attack can be launched by exploiting the application. So, whenever this application runs,
PowerShell v2 is also active, and it can be used by the attacker if they manage to exploit the application
In this case, disabling PowerShell version 2.0 can help to protect against this type of attack by blocking
the deprecated binaries in the Global Assembly Cache (GAC) or removing the PowerShell component
altogether. Nevertheless, it’s important to note that other applications that rely on these binaries will
be blocked as well, as they usually don’t ship with all of the PowerShell binaries

Lee Holmes, who was part of the Windows PowerShell team at Microsoft, provides a great example
of how to monitor for potential downgrade attacks by looking for event ID 400 in the PowerShell
event log in his blog article Detecting and Preventing PowerShell Downgrade Attacks: https://www.
leeholmes.com/detecting-and-preventing-powershell-downgrade-attacks/.
Use this example to find lower versions of the PowerShell engine being loaded:
Get-WinEvent -LogName "Windows PowerShell" | Where-Object Id -eq 400 |
Foreach-Object {
 $version = [Version] ($_.Message -replace
'(?s).*EngineVersion=([\d\.]+)*.*','$1')
 if($version -lt ([Version] "5.0")) { $_ }
}

EventList
When talking about hardening Windows environments, you can’t ignore the Microsoft Security and
Compliance Toolkit (SCT): https://www.microsoft.com/en-us/download/details.
aspx?id=55319.

Working with EventList
To get started, EventList can be easily installed from the PowerShell Gallery:
> Install-Module EventList

EventList is built in PowerShell; therefore, even if you want to work solely with the user interface,
you need to run at least one PowerShell command. Open the PowerShell console as an administrator
and type in the following:
> Open-EventListGUI


Getting started with logging
To improve your detection, it makes sense to set up a SIEM system for event collection so that you
have all event logs in one place, allowing you to hunt and even build automated alerting.
There are many options if you want to choose a SIEM system – for every budget and scenario. Over the
years, I have seen many different SIEM systems – and each one just fitted perfectly for each organization.
The most popular SIEM systems that I have seen out in the wild were Splunk, Azure Sentinel, ArcSight,
qRadar, and the “ELK stack” (Elastic, LogStash, and Kibana), just to mention a few. I also saw and
used Windows Event Forwarding (WEF) to realize event log monitoring.

An overview of important PowerShell-related log files
Basic PowerShell event logs
When working with PowerShell, there are three event logs that are of interest – the Windows PowerShell
log, the Microsoft Windows PowerShell Operational log, and the PowerShellCore Operational log.
Let’s discuss each of them in the following subsections.



































































































