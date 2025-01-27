PowerShell Core

You will find the latest stable PowerShell Core version here: https://aka.ms/powershellrelease?tag=stable.
Download it and start the installation
After the setup is complete, you can launch the new PowerShell console and pin it to your taskbar or
the Start menu:

Installing PowerShell Core Group Policy definitions
To define consistent options for your servers in your environment, Group Policy helps with
the configuration.
When installing PowerShell 7, Group Policy templates, along with an installation script, will be
populated under $PSHOME
Group Policy requires two kinds of templates (.admx, .adml) to allow the configuration of
registry-based settings.
You can find the templates as well as the installation script using the Get-ChildItem -Path $PSHOME -Filter *Core*Policy* command:
Type $PSHOME\InstallPSCorePolicyDefinitions.ps1 into your domain controller,
press Tab, and confirm with Enter.
The Group Policy templates for PowerShell Core will be installed, and you can access them by
navigating to the following:
• Computer Configuration | Administrative Templates | PowerShell Core
• User Configuration |Administrative Templates | PowerShell Core
You can now use them to configure PowerShell Core in your environment, in parallel to
Windows PowerShell.

Working with the PowerShell history
Enter-PSSession -ComputerName PSEC-PC01 -Credential $cred
If you want to initiate another PowerShell remoting session to PSSEC-PC02 instead of PSSEC-PC01,
you don't have to type in the whole command again: just use the arrow up key once, then change
-ComputerName to PSSEC-PC02 and hit Enter to execute it

Searching the PowerShell history
Get-History | Select-String <string to search>
here's an example of how you'd search the history, using the same commands but abbreviated as an alias:
h | sts <string to search>
If you want to see all the PowerShell remoting sessions that were established in this session, you can
search for the Enter-PSSession string:
Get-History | Select-String "Enter-PSSession"
When you are looking for a command that was run recently, you don't have to query the entire history.
To only get the last X history entries, you can specify the -Count parameter.
In this example, to get the last five entries, specify -Count 5:
Get-History -count 5
When you close a PowerShell session, the session history is deleted. That means you will get no results
if you use the session-bound Get-History command upon starting a new session.
But there's also a persistent history that you can query, as provided by the PSReadline module
The history is stored in a file, which is stored under the path configured in (Get-PSReadlineOption). HistorySavePath:
You can either open the file or inspect the content using Get-Content:
> Get-Content (Get-PSReadlineOption).HistorySavePath
If you just want to search for a command to execute it once more, the interactive search might be
helpful. Press Ctrl + R to search backward, and type in characters or words that were part of the
command that you executed earlier.
Ctrl + S works just like Ctrl + R but searches forward. You can use both shortcuts to move back and
forth in the search results.
Ctrl + R and Ctrl + S allow you to search the permanent history, so you are not restricted to search
for the commands run during this session

Clearing the screen
clear
Instead of Clear, you can also use the cls alias or the Ctrl + L shortcut.

Canceling a command
 Ctrl + C is your friend

Execution Policy
Execution Policy is a feature that restricts the execution of PowerShell scripts on the system.
Use Get-ExecutionPolicy to find out how the Execution Policy setting is configured:
While the default setting on all Windows clients is Restricted, the default setting on Windows servers
is RemoteSigned. Having the Restricted setting configured, the system does not run scripts at all, while
RemoteSigned allows the execution of local scripts and remote scripts that were signed.

Configuring Execution Policy
it is a feature that protects you from your own mistakes – for example, if you have downloaded
a script from the internet that you want to inspect before running, and you double-click on it by
mistake, Execution Policy helps you to prevent this

Execution Policy options
The following are the Execution Policy options that determine whether it is allowed to run scripts on
the current system or whether they need to be signed to run:
• AllSigned: Only scripts that are signed by a trusted publisher can be executed, including
local scripts.
In 1, AppLocker, Application Control, and Code Signing, you can find out more about script
signing, or you can refer to the online documentation at https://docs.microsoft.
com/en-us/powershell/module/microsoft.powershell.core/about/
about_signing.
• Bypass: Nothing is blocked, and scripts run without generating a warning or a prompt.
• RemoteSigned: Only locally created scripts can run if they are unsigned. All scripts that
were downloaded from the internet, or are stored on a remote network location, need to be
signed by a trusted publisher.
• Restricted: This is the default configuration. It is not possible to run PowerShell scripts or
load configuration files. It is still possible to run interactive code.
• Unrestricted: All scripts can be run, regardless of whether they were downloaded from
the internet or were created locally. If scripts were downloaded from the internet, you will still
get prompted if you want to run the file.

The Execution Policy scope
To specify who or what will be affected by the Execution Policy feature, you can define scopes. The
-scope parameter allows you to set the scope that is affected by the Execution Policy feature:
• CurrentUser: This means that the current user on this computer is affected.
• LocalMachine: This is the default scope. All users on this computer are affected.
• MachinePolicy: This affects all users on this computer.
• Process: This only affects the current PowerShell session

One good way is to sign all scripts that are being run in your organization. Through this, you can
not only identify which scripts are allowed, but it also allows you to use further mitigations such as
AppLocker in a better way 

To maintain protection from running scripts unintentionally, but to have the ability to run locally
developed scripts nevertheless, the RemoteSigned setting is a good approach. In this case, only local
scripts (that is, scripts that weren't downloaded from the internet and signed) can be run; unsigned
scripts from the internet will be blocked from running.
Use the Set-ExecutionPolicy cmdlet as an administrator to configure the Execution Policy setting:
Set-ExecutionPolicy

Windows PowerShell – configuring Execution Policy via Group Policy 
If you don't want to set the Execution Policy setting for every machine in your organization manually,
you can also configure it globally via Group Policy.
To configure Group Policy for Windows PowerShell, create a new Group Policy Object (GPO) that
is linked to the root folder in which all your devices are located and that you want to configure
Execution Policy for.
Then, navigate to Computer Configuration | Policies | Administrative Templates | Windows
Components | Windows PowerShell:
Configure the Turn on Script Execution setting, and choose the Allow local scripts and remote
signed scripts option, which configures Execution Policy to RemoteSigned.
PowerShell Core – configuring Execution Policy via Group Policy
Since Windows PowerShell and PowerShell Core are designed to run in parallel, you also need to
configure the Execution Policy settings for PowerShell Core.
The Group Policy settings for PowerShell Core are located in the following paths:
• Computer Configuration | Administrative Templates | PowerShell Core

Execution Policy is not a security control – avoiding Execution Policy
Essentially, when we speak of bypassing Execution Policy, we are simply avoiding Execution Policy,
as you will see in this section. Although it's not a real hack, some people in the security community
still like to call avoiding Execution Policy a bypass.
Avoiding Execution Policy is quite easy – the easiest way is by using its own -Bypass parameter
I created a simple script that just writes Hello World! into the console, which you can find on GitHub
at https://github.com/PacktPublishing/PowerShell-Automation-andScripting-for-Cybersecurity/blob/master/Chapter01/HelloWorld.ps1.
With Execution Policy set to restricted, I get an error message when I try to run the script without
any additional parameters.
However, if I run the script using powershell.exe as an administrator with the -ExecutionPolicy
parameter set to Bypass, the script runs without any issues:

If Execution Policy is configured via Group Policy, it can't be avoided just by using the -Bypass parameter.
As Execution Policy only restricts the execution of scripts, another way is to simply pass the content
of the script to Invoke-Expression
Again, the content of the script is run without any issues
– even if Execution Policy was configured using Group Policy:
Get-Content .\HelloWorld.ps1 | Invoke-Expression
Hello World!

Piping the content of the script into Invoke-Expression causes the content of the script to be
handled as if the commands were executed locally using the command line; this bypasses Execution
Policy and Execution Policy only applies to executing scripts and not local commands.
Those are only some examples out of many ways to avoid ExecutionPolicy, there are some
examples of avoiding ExecutionPolicy in "8" on page 337, Red Team Tasks and Cookbook.
Therefore, don't be under the false impression that ExecutionPolicy protects you from attackers.

Help system

There are three functions that make your life easier when you are working with PowerShell:
• Get-Help
• Get-Command
• Get-Member

Get-Help -Name Get-Help
Update-Help

The easiest way to get all the information that the help file provides is by using the -Full parameter:
Get-Help -Name Get-Content -Full

Get-Command
Additionally, it can show you which commands are available for a certain module. In this case, we
investigate the EventList module that we have installed from the PowerShell Gallery, which is a
central repository for the modules, scripts, and other PowerShell-related resources:
> Get-Command -Module EventList
Get-Command can be also very helpful if you are looking for a specific cmdlet, but you can't remember
its name. For example, if you want to find out all the cmdlets that are available on your computer that
have Alias in their name, Get-Command can be very helpful:
> Get-Command -Name "*Alias*" -CommandType Cmdlet
If you don't remember a certain command exactly, use the -UseFuzzyMatching parameter. This
shows you all of the related commands:
Get-Command get-commnd -UseFuzzyMatching

Get-Member
Get-Member helps you to display the members within an object.
In PowerShell, everything is an object, even a simple string. Get-Member is very useful for seeing
which operations are possible.
So, if you want to see what operations are possible when using your "Hello World!" string, just
type in the following:
"Hello World!" | Get-Member
All available methods and properties will be displayed, and you can choose from the list the one that
best fits your use case:

 "Hello World!" | Get-Member| Sort-Object Name
After you have chosen the operation that you want to run, you can use it by adding.(a dot), followed
by the operation. So, if you want to find out the length of your string, add the Length operation:
> ("Hello World!").Length
12
To display the data type of a variable, you can use GetType(). In this example, we use GetType()
to find out that the data type of the $x variable is integer:
> $x = 4
> $x.GetType()

PowerShell versions
$PSVersionTable.PSVersion
















































































































































































































































