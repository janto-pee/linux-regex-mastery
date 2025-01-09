# Updatable help
# PS C:\> help Get-Service

# Updating PowerShell’s help should be your first task. These files are stored in the System32 directory, which means your shell must be running under elevated privileges
PS C:\> update-help
# if it fails to update these help topics, start Window
# PowerShell with the "Run as Administrator" option and try the command
# again

# Help works much like the base Get-Help, but it pipes the help output to More, allowing you to have a nice paged view instead of seeing all the help fly by at once

# Running Help Get-Content and Get-Help Get-Content produces the same results, but the former has a page-at-a-time display. You could run Get-Help Get-Content | More to produce that paged display, but that requires a lot more typing. We typically use only
# Help,

# Technically, Help is a function, and Man is an alias, or nickname, for
# Help. But you get the same results using either

# Using help to find commands

# For example, suppose you want to do something with an event log. You don’t know
# what commands might be available, and you decide to search for help topics that
# cover event logs. You might run either of these two commands:
Help *log*
Help *event*
# The first command returns a list like the following on your computer:

# When you have a cmdlet that you think will do the job (Get-EventLog looks like a
# good candidate for what you’re after in the example), you can ask for help on that
# specific topic:
Help Get-EventLog
Help Get-EventL*
#  This file, called the summary help
# We mentioned that the Help command doesn’t search for cmdlets; it searches for
# help topics. Because every cmdlet has a help file, we could say that this search
# retrieves the same results. But you can also directly search for cmdlets by using the
# Get-Command cmdlet (or its alias, Gcm). 

# A better approach is to use the -Noun or -Verb parameters. Because only cmdlet
# names have nouns and verbs, the results will be limited to cmdlets. 
Get-Command -noun *event* 
#returns a list of cmdlets dealing with events; Get-Command -verb
# Get returns all cmdlets capable of retrieving things

# : Get-Command *log* -type cmdlet
# shows a list of all cmdlets that include log in their names, and the list won’t include
# any external applications or commands

we mentioned that PowerShell’s help system includes background topics as well as help for specific cmdlets. These background topics are often
called about topics, because their filenames all start with about_.

# You may also recall
# from earlier in this chapter that all cmdlets support a set of common parameters. How
# do you think you could learn more about those common parameters?

# You start by using wildcards
Help *common*
# The about topics in the help system are tremendously important, but because
# they’re not related to a specific cmdlet, they can be easy to overlook. If you run 
help about* 
# for a list of all of them, you might be surprised at how much extra documentation is hidden away inside the shell

# 3.7 Accessing online help
# In addition to updating the help files (which you can do by running Update-Help),
# Microsoft publishes help on its website. The -online parameter of PowerShell’s help
# command will attempt to open the web-based help—even on macOS or Linux!—for a
# given command:
Help Get-EventLog -online

# Lab

Update-Help 
Run Update-Help and ensure that it completes without errors, so that you have
a copy of the help on your local computer. You need an internet connection,
and the shell needs to run under elevated privileges (which means Administrator
must appear in the shell window’s title bar).

2)
# Windows-only: can you find any cmdlets capable of converting other cmdlets’
# output into HTML?
help html
# Or you could try with Get-Command:
get-command –noun html

3)
# Partially Windows-only: are there any cmdlets that can redirect output into a
# file, or to a printer?
get-command -noun file,printer

# 4 How many cmdlets are available for working with processes? (Hint: remember
# that cmdlets all use a singular noun.)
Get-command –noun process
or
Help *Process

# 5 What cmdlet might you use to write to an event log? (This one’s possible on nonWindows operating systems, but you’ll get a different answer.)
get-command -verb write -noun eventlog
Or if you aren’t sure about the noun, use a wildcard:
help *log

# 6 You’ve learned that aliases are nicknames for cmdlets; what cmdlets are available to create, modify, export, or import aliases?
help *alias
or
get-command –noun alias

# 7 Is there a way to keep a transcript of everything you type in the shell, and save
# that transcript to a text file?
help transcript

# 8 Windows-only: it can take a long time to retrieve all of the entries from the
# Security event log. How can you get only the 100 most recent entries?
help Get-Eventlog –parameter Newest

# 9 Windows-only: is there a way to retrieve a list of the services that are installed on
# a remote computer?
help Get-Service –parameter computername

# 10 Is there a way to see what processes are running on a remote computer? (You can
# find the answer on non-Windows operating systems, but the command itself
# might not work for you.)
help Get-Process –parameter computername

# 11 Examine the help file for the Out-File cmdlet. The files created by this cmdlet
# default to a width of how many characters? Is there a parameter that would
# enable you to change that width?
# Help Out-File –full
# or
Help Out-File –parameter Width
should show you 80 characters as the default for the PowerShell console. You
would use this parameter to change it as well.

# 12 By default, Out-File overwrites any existing file that has the same filename as
# what you specify. Is there a parameter that would prevent the cmdlet from overwriting an existing file?
If you run Help Out-File –full and look at parameters, you should see
-NoClobber.

# 13 How could you see a list of all aliases defined in PowerShell?
Get-Alias

# 14 Using both an alias and abbreviated parameter names, what is the shortest command line you could type to retrieve a list of running processes from a computer named Server1?
ps –c server1

# 15 How many cmdlets are available that can deal with generic objects? (Hint:
# remember to use a singular noun like object rather than a plural one like objects.)
get-command –noun object

# 16 This chapter briefly mentioned arrays. What help topic could tell you more
# about them?
help about_arrays
Or you could use wildcards:
help *array*
















