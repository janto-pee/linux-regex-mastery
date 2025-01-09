# Microsoft has established a naming convention for cmdlets. That same naming convention should be used for functions and workflows, too, although Microsoft can’t
# force anyone but its own employees to follow that rule.
#  The rule is this: Names start with a standard verb, such as Get or Set or New or
# Pause. You can run Get-Verb to see a list of allowable verbs (you’ll see about 100,
# although only about a dozen are common). After the verb is a dash, followed by a singular noun, such as Service or Process or EventLog. Developers get to make up their
# own nouns, so there’s no Get-Noun cmdlet to display them all. 

# What’s the big deal about this rule? Well, suppose we told you that there were
# cmdlets named New-Service, Get-Service, Get-Process, Set-Service, and so forth.
# Could you guess what command would create a new Exchange mailbox? Could you
# guess what command would modify an Active Directory user? If you guessed GetMailbox, you got the first one right. If you guessed Set-User, you were close: it’s SetADUser, and you’ll find the command on domain controllers in the Active-Directory
# module


# Lab

# As always, we’re assuming that you have the latest version of Windows (client or
# server) on a computer or virtual machine to test with.
#  For this lab, you have only one task: Run the Networking troubleshooting pack.
# When you successfully do so, you’ll be asked for an Instance ID. Hit Enter, run a Web Connectivity check, and ask for help connecting to a specific web page. Use www.pluralsight
# .com/browse/it-ops as your test URL. We hope you get a “No problems were detected”
# report, meaning you ran the check successfully.
#  To accomplish this task, you need to discover a command capable of getting a troubleshooting pack, and another capable of executing a troubleshooting pack. You also
# need to discover where the packs are located and how they’re named. Everything you
# need to know is in PowerShell, and the help system will find it for you.
#  That’s all the help you get!

Here’s one way to approach this:
 get-module *trouble* -list
 import-module TroubleShootingPack
 get-command -Module TroubleShootingPack
 help get-troubleshootingpack –full
 help Invoke-TroubleshootingPack -full
 dir C:\windows\diagnostics\system
 $pack=get-troubleshootingpack
C:\windows\diagnostics\system\Networking
 Invoke-TroubleshootingPack $pack
 Enter
 1
 2
 https://www.pluralsight.com/browse/it-ops































