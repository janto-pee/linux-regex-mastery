Write-Host and Write-Output can be a bit tricky to work with. See how many of these
tasks you can complete, and if you get stuck, it’s OK to peek at the sample answers
available at the end of this chapter.
1 Use Write-Output to display the result of 100 multiplied by 10.
2 Use Write-Host to display the result of 100 multiplied by 10.
3 Prompt the user to enter a name, and then display that name in yellow text.
4 Prompt the user to enter a name, and then display that name only if it’s longer
than five characters. Do this all with a single PowerShell expression—don’t use
a variable.
That’s all for this lab. Because these cmdlets are all straightforward, we want you to
spend more time experimenting with them on your own. Be sure to do that—we’ll
offer some ideas in the next section.
TRY IT NOW After you’ve completed this lab, try completing review lab 3,
which you’ll find in the appendix of this book.
19.7 Further exploration
Spend some time getting comfortable with all of the cmdlets in this chapter. Make sure
you can display verbose output, accept input, and even display a graphical input box.
You’ll be using the commands from this chapter often from here on out, so you should
read their help files and even jot down quick syntax reminders for future reference.
19.8 Lab answers
1 write-output (100*10)
or simply type the formula: 100*10
2 Any of these approaches work:
$a=100*10
Write-Host $a
Write-Host "The value of 100*10 is $a"
Write-Host (100*10)
3 $name=Read-Host "Enter a name" Write-host $name -ForegroundColor Yellow
4 Read-Host "Enter a name" | where {$_.length -gt 5}