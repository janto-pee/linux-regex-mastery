Flip back to chapter 15 and refresh your memory on working with background jobs.
Then, at the command line, do the following:
1 Create a background job that queries the Win32_BIOS information from two
computers (use localhost twice if you have only one computer to experiment
with).
2 When the job finishes running, receive the results of the job into a variable.
3 Display the contents of that variable.
4 Export the variable’s contents to a CliXML file.
18.11 Further exploration
Take a few moments and skim through some of the previous chapters in this book.
Given that variables are primarily designed to store something you might use more
than once, can you find a use for variables in our topics in previous chapters?
 For example, in chapter 13 you learned to create connections to remote computers.
In that chapter, you created, used, and closed a connection more or less in one step;
wouldn’t it be useful to create the connection, store it in a variable, and use it for several
commands? That’s only one instance of where variables can come in handy (and we’ll
show you how to do that in chapter 20). See if you can find any more examples.
18.12 Lab answers
1 PS C:\> invoke-command {get-wmiobject win32_bios} –computername
 localhost,$env:computername –asjob
2 PS C:\>$results=Receive-Job 4 –keep
3 PS C:\>$results
4 PS C:\>$results | export-clixml bios.xml