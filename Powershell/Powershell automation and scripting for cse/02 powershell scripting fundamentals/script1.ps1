In this chapter, we are going to cover the following topics:
• Variables
• Operators
• Control structures
• Naming conventions
• Cmdlets
• Functions
• Aliases
• Modules

Variables
A variable is a storage location that developers can use to store information with a so-called value. 
> $i = 1
> $string = "Hello World!"
> $this_is_a_variable = "test"

Variables are great for storing simple values, strings, and also the output of commands:
> Get-Date
Monday, November 2, 2020 6:43:59 PM
> $date = Get-Date
> Write-Host "Today is" $date
Today is 11/2/2020 6:44:40 PM

Data types
In contrast to other scripting or programming languages, you don’t necessarily need to define the data
type for variables. When defining a variable, the data type that makes the most sense is automatically set:
> $x = 4
> $string = "Hello World!"
> $date = Get-Date
You can find out which data type was used with the GetType() method:
> $x.GetType().Name
Int32
> $string.GetType().Name
String
> $date.GetType().Name
DateTime

Casting variables
> $number = "4"
> $number.GetType().Name
String

If the $number variable was declared as a string and we perform an addition, a mathematical operation
will not be performed. Instead, both are concatenated as a string:
> $number + 2
42
> ($number + 2).GetType().Name
String

If we want, for example, to process $number as a normal integer, we need to cast the variable type
to [int]:
> $int_number = [int]$number
> $int_number.GetType().Name
Int32

You can also cast a Unicode hex string into a character in PowerShell by using the hex value of the
Unicode string and casting it to [char]:
> 0x263a
9786
> [char]0x263a
☺

Most of the time, the right variable data type is already set automatically by PowerShell. Casting data
types helps you to control how to process the data, avoiding wrong results and error messages.
Automatic variables
Automatic variables are built-in variables that are created and maintained by PowerShell.

$?: The execution status of the last command. If the last command succeeded, it is set to True,
otherwise, it is set to False.
• $_: When processing a pipeline object, $_ can be used to access the current object ($PSItem).
It can also be used in commands that execute an action on every item, as in the following example:
Get-ChildItem -Path C:\ -Directory -Force -ErrorAction
SilentlyContinue | ForEach-Object {
 Write-Host $_.FullName
}
• $Error: Contains the most recent errors, collected in an array. The most recent error can be
found in $Error[0].
• $false: Represents the traditional Boolean value of False.
• $LastExitCode: Contains the last exit code of the program that was run.
• $null: Contains null or an empty value. It can be used to check whether a variable contains
a value or to set an undefined value when scripting, as $null is still treated like an object
with a value.
• $PSScriptRoot: The location of the directory from which the script is being run. It can
help you to address relative paths.
• $true: Contains True. You can use $true to represent True in commands and scripts.

Environment variables
Environment variables store information about the operating system and paths that are frequently
used by the system.
To show all environment variables within your session, you can leverage dir env:, as shown in
the following screenshot:

You can directly access and reuse those variables by using the prefix $env::
> $env:PSModulePath
C:\Users\PSSec\Documents\WindowsPowerShell\Modules;C:\Program Files\
WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\
Modules

Reserved words and language keywords
Some words are reserved by the system and should not be used as variables or function names, as this
would lead to confusion and unexpected behavior of your code.

By using Get-Help, you can get a list and more information on reserved words:
> Get-Help about_reserved_words

Also see the about_Language_Keywords help pages to get a detailed overview and explanation
of all language keywords:
> Get-Help about_Language_Keywords

To learn more about a certain language keyword, you can use Get-Help:
> Get-Help break
Some reserved words (such as if, for, foreach, and while) have their own help articles. To read
them, add about_ as a prefix:
> Get-Help about_If
If you don’t find a help page for a certain reserved word, as not every one has its own page, you can
use Get-Help to find help pages that write about the word you are looking for:
> Get-Help filter -Category:HelpFile

Variable scope
In general, variables are only available in the context in which they were set, unless the scope is modified:
$script:ModuleRoot = $PSScriptRoot
# Sets the scope of the variable $ModuleRoot to script

Scope modifier
Using the scope modifier, you can configure the scope in which your variables will be available. Here
is an overview of the most commonly used scope modifiers:
global: Sets the scope to global. This scope is effective when PowerShell starts or if you
create a new session.
local: This is the current scope. The local scope can be the global scope, the script
scope, or any other scope.
• script: This scope is only effective within the script that sets this scope. It can be very useful
if you want to set a variable only within a module that should not be available after the function
was called.

If the same script tries to access the defined variables outside of the function in which the variables were
configured, it can still access the variables that were configured for the script and global scope.
The variable with the local scope is inaccessible, as the variables were called in the script scope

After running the Get-VariableScope.ps1 script, try to access the variables on the command
line yourself (global scope):
Figure 2.3 – Accessing the variables on the command line
You can imagine scopes as containers for variables therefore, in this case, we can only access variables
within the global scope container. The variables with the local and script scopes are inaccessible
from the command line when not called from the script they were defined in.
When working with scopes, it is advisable to choose the scope that offers the minimum required privileges
for your use case. This can help prevent accidental script breakage when running scripts multiple times
in the same session. While using the global scope is not necessarily problematic from a security
standpoint, it is still best to avoid it when not strictly necessary.

Scopes are not only restricted to variables; they can also be used to restrict functions, aliases, and
PowerShell drives. Of course, there are also many more use cases for scopes than the ones I described
in this section.

Arithmetic operators
Arithmetic operators can be used to calculate values. They are as follows:
• Addition (+):
> $a = 3; $b = 5; $result = $a + $b
> $result
8

Comparison operators
> $a = 1; $b = 1; $a -eq $b
True
> $a = 1; $b = 2; $a -eq $b
False
In an array context, operators behave differently: when an array is used as the left-hand operand
in a comparison, PowerShell performs the comparison operation against each element in the array
> "A", "B", "C", "D" -lt "C"
A
B
> "A","B","C" -eq "A"
A
> $a = 1; $b = 2; $a -ne $b
True
> $a = 1; $b = 1; $a -ne $b
False
> "Hello World!" -ne $null
True
> "A","B","C" -ne "A"
B
C

Not equal (-ne): Returns True if both values are not equal:
> $a = 1; $b = 2; $a -ne $b
True
> $a = 1; $b = 1; $a -ne $b
False
> "Hello World!" -ne $null
True
> "A","B","C" -ne "A"
B
C
• Less equal (-le): Returns True if the first value is less than or equal to the second value:
> $a = 1; $b = 2; $a -le $b
True
> $a = 2; $b = 2; $a -le $b
True
> $a = 3; $b = 2; $a -le $b
False
> "A","B","C" -le "A"
A
• Greater equal (-ge): Returns True if the first value is greater than or equal to the second value:
> $a = 1; $b = 2; $a -ge $b
False
> $a = 2; $b = 2; $a -ge $b
True
> $a = 3; $b = 2; $a -ge $b
True
> "A","B","C" -ge "A"
A
B
C
Less than (-lt): Returns True if the first value is less than the second value:
> $a = 1; $b = 2; $a -lt $b
True
> $a = 2; $b = 2; $a -lt $b
False
> $a = 3; $b = 2; $a -lt $b
False
> "A","B","C" -lt "A" # results in no output
• Greater than (-gt): Returns True if the first value is greater than the second value:
> $a = 1; $b = 2; $a -gt $b
False
> $a = 2; $b = 2; $a -gt $b
False
> $a = 3; $b = 2; $a -gt $b
True
> "A","B","C" -gt "A"
B
C

-like: Can be used to check whether a value matches a wildcard expression when used with
a scalar. If used in an array context, the -like operator returns only the elements that match
the specified wildcard expression:
> "PowerShell" -like "*owers*"
True
> "PowerShell", "Dog", "Cat", "Guinea Pig" -like "*owers*"
PowerShell
> "PowerShell" -notlike "*owers*"
False
> "PowerShell", "Dog", "Cat", "Guinea Pig" -notlike "*owers*"
Dog
Cat
Guinea Pig

-match: Can be used to check whether a value matches a regular expression:
> "PowerShell scripting and automation for Cybersecurity" -match
"shell\s*(\d)"
False
> "Cybersecurity scripting in PowerShell 7.3" -match "shell\
s*(\d)"
True
• -notmatch: Can be used to check whether a value does not match a regular expression:
> "Cybersecurity scripting in PowerShell 7.3" -notmatch "^Cyb"
False
> "PowerShell scripting and automation for Cybersecurity"
-notmatch "^Cyb"
True

Assignment operators
When working with variables, it is vital to understand assignment operators:
• =: Assigns a value:
> $a = 1; $a
1

Assignment operators

Assignment operators
When working with variables, it is vital to understand assignment operators:
• =: Assigns a value:
> $a = 1; $a
1

Logical operators
-and: Can be used to combine conditions. The defined action is triggered only if both
conditions are met:
> $a = 1; $b = 2
> if (($a -eq 1) -and ($b -eq 2)) {Write-Host "Condition is
true!"}
Condition is true!

• -or: If one of the defined conditions is met, the action is triggered:
• -not or !: Can be used to negate a condition. The following example tests whether the folder
specified using the $path variable is available. If it is missing, it will be created:
$path = $env:TEMP + "\TestDirectory"
if( -not (Test-Path -Path $path )) {
 New-Item -ItemType directory -Path $path
}
if (!(Test-Path -Path $path)) {
 New-Item -ItemType directory -Path $path
}
• -xor: Logical exclusive -or. Is True if only one statement is True (but returns False if
both are True):

Conditions
If/elseif/else
if (<condition>)
{
 <action>
}
elseif (<condition 2>)
{
 <action 2>
}
...
else
{
 <action 3>
}
You can use the if statement to check whether a condition is True:
> if (1+2 -eq 3) { Write-Host "Good job!" }
 Good job!
> if (1+2 -eq 5) { Write-Host "Something is terribly wrong!" }
# returns no Output
You can also check whether one of several conditions is True by using elseif. The action of the
first condition that is met will be executed:
$color = "green"
if ($color -eq "blue") {
 Write-Host "The color is blue!"
}
elseif ($color -eq "green"){
 Write-Host "The color is green!"
}
# returns: The color is green!
$color = "red"
if ($color -eq "blue") {
 Write-Host "The color is blue!"
}
elseif ($color -eq "green"){
 Write-Host "The color is green!"
}
else {
 Write-Host "That is also a very beautiful color!"
}
# returns: That is also a very beautiful color!

Switch
Sometimes, it can happen that you want to check one variable against a long list of values.
switch (<value to test>) {
 <condition 1> {<action 1>}
 <condition 2> {<action 2>}
 <condition 3> {<action 3>}
 ...
 default {}
}

Here is an example:
$color = Read-Host "What is your favorite color?"
switch ($color) {
 "blue" { Write-Host "I'm BLUE, Da ba dee da ba di..." }
 "yellow" { Write-Host "YELLOW is the color of my true love's
hair." }
 "red" { Write-Host "Roxanne, you don't have to put on the RED
light..." }
 "purple" { Write-Host "PURPLE rain, purple rain!" }
 "black" { Write-Host "Lady in BLACK... she came to me one
morning, one lonely Sunday morning..." }
 default { Write-Host "The color is not in this list." }
}
In this example, the user is prompted to enter a value: What is your favorite color?

or example, you can use the -Regex parameter to use a regular expression to match against the
input, like this:
switch -Regex ($userInput) {
 "^[A-Z]" { "User input starts with a letter." }
 "^[0-9]" { "User input starts with a number." }
 default { "User input doesn't start with a letter or number." }
}

You can also use the -File parameter to process the contents of a file with the switch statement.
The -Wildcard parameter enables you to use the wildcard logic with switch:
$path = $env:TEMP + "\example.txt"
switch -Wildcard -File $path {
 "*Error*" { Write-Host "Error was found!: $_" }
}

Loops and iterations
ForEach-Object
ForEach-Object accepts a list or an array of items and allows you to perform an action against each
of them. ForEach-Object is best used when you use the pipeline to pipe objects to ForEachObject
> $path = $env:TEMP + "\baselines"
> Get-ChildItem -Path $path | ForEach-Object {Write-Host $_}

Foreach
To iterate through a collection of items in PowerShell, you can use the Foreach-Object cmdlet,
the foreach statement, or the foreach method. The Foreach-Object cmdlet accepts pipeline
objects, making it a useful tool for working with object-oriented data
$path = $env:TEMP + "\baselines"
$items = Get-ChildItem -Path $path
foreach ($file in $items) {
 Write-Host $file
}
You can use the .foreach({}) method to iterate through a collection of items. Here’s an example
of how to use it:
$path = $env:TEMP + "\baselines"
$items = Get-ChildItem -Path $path
$items.foreach({
 Write-Host "Current item: $_"
})

while
while does something (<actions>) as long as the defined condition is fulfilled:
while ( <condition> ){ <actions> }
In this example, user input is read, and as long as the user doesn’t type in quit, the while loop
still runs:
while(($input = Read-Host -Prompt "Choose a command (type in 'help'
for an overview)") -ne "quit"){
 switch ($input) {
 "hello" {Write-Host "Hello World!"}
 "color" {Write-Host "What's your favorite color?"}
 "help" {Write-Host "Options: 'hello', 'color', 'help' 'quit'"}
 }
}

for
This defines the initializing statement, a condition, and loops through until the defined condition is
not fulfilled anymore:
for (<initializing statement>; <condition>; <repeat>)
{
 <actions>
}
If you need iterating values, for is a great solution:
> for ($i=1; $i -le 5; $i++) {Write-Host "i: $i"}

do-until/do-while
Compared to other loops, do-until or do-while already starts running the defined commands
and then checks whether the condition is still met or not met:
do{
 <action>
}
<while/until><condition>

break
break can be used to exit the loop (for example, for/foreach/foreach-object/…):
> for ($i=1; $i -le 10; $i++) {
 Write-Host "i: $i"
 if ($i -eq 3) {break}
}

continue
The continue statement is used to skip the current iteration of a loop and move to the next one.
It does not affect the loop’s condition, which will be re-evaluated at the beginning of the next iteration:
> for ($i=1; $i -le 10; $i++) {
 if (($i % 2) -ne 0) {continue}
 Write-Host "i: $i"
}

The preceding example demonstrates that every time the remainder returned is not 0, the current
iteration is skipped. This code could also be simplified by writing the following:
for ($i=1; $i -le 10; $i++) {
 if ($i % 2){ continue }
 Write-Host “i: $i”
}

Cmdlets and functions both follow the schema verb-noun, such as Get-Help or Stop-Process. So, if
you write your own functions or cmdlets, make sure to follow the name guidelines and recommendations
Microsoft has released a list of approved verbs. Although it is not technically enforced to use approved
verbs, it is strongly recommended to do so in order to comply with PowerShell best practices and
avoid conflicts with automatic variables and reserved words. 

Finding the approved verbs
If you are in the process of writing your code and quickly want to check which approved verbs exist,
you can leverage the Get-Verb command
Get-Verb | Sort-Object Verb
You can also use wildcards to prefilter the list:
> Get-Verb re*

If you just want to get all approved verbs from a certain group (in this case, Security), you can
filter Group using Where-Object:
> Get-Verb | Where-Object Group -eq Security

PowerShell profiles
PowerShell profiles are configuration files that allow you to personalize your PowerShell environment.
These profiles can be used to customize the behavior and environment of PowerShell sessions. They
are scripts that are executed when a PowerShell session is started, allowing users to set variables, define
functions, create aliases, and more

There are several different types of profiles and more than one can be processed by PowerShell. PowerShell
profiles are stored as plain text files on your system, and there are several types of profiles available:
• All Users, All Hosts ($profile.AllUsersAllHosts): This profile applies to all users
for all PowerShell hosts.
• All Users, Current Host ($profile.AllUsersCurrentHost): This profile applies to
all users for the current PowerShell host.
• Current User, All Hosts ($profile.CurrentUserAllHosts): This profile applies to
the current user for all PowerShell hosts.
• Current User, Current Host ($profile.CurrentUserCurrentHost): This profile
applies only to the current user and the current PowerShell host.

A PowerShell host is an application that hosts the PowerShell engine. Examples of PowerShell hosts
include the Windows PowerShell console, the PowerShell Integrated Scripting Environment (ISE),
and the PowerShell terminal in Visual Studio Code

To access the file path of one particular profile, such as the one for CurrentUserCurrentHost,
you can use the variable that is defined in $profile.CurrentUserCurrentHost:
> $profile.CurrentUserCurrentHost
C:\Users\pssecuser\Documents\PowerShell\Microsoft.PowerShell_profile.
ps1
Use the following code snippet to check whether the file already exists; if it does not yet, the file is created:
if ( !( Test-Path $profile.CurrentUserCurrentHost ) ) {
 New-Item -ItemType File -Path $profile.CurrentUserCurrentHost
}
Finally, add the commands, functions, or aliases to the user profile:
> Add-Content -Path $profile -Value “New-Alias -Name Get-Ip -Value
‘ipconfig.exe’”

Understanding PSDrives in PowerShell
PowerShell includes a feature called PowerShell drives (PSDrives). PSDrives in PowerShell are similar
to filesystem drives in Windows, but instead of accessing files and folders, you use PSDrives to access
a variety of data stores. These data stores can include directories, registry keys, and other data sources,
which can be accessed through a consistent and familiar interface.

PSDrives are powered by PSProviders, which are the underlying components that provide access to
data stores. PSProviders are similar to drivers in Windows, which allow access to different hardware
devices.
For example, the Env:\ PSDrive is a built-in PowerShell drive that provides access to environment
variables. To retrieve all environment variables that have the path string in their name, you can use
the Get-ChildItem cmdlet with the Env:\ PSDrive:
> Get-ChildItem Env:\*path*

To access a PSDrive, you use a special prefix in the path. For example, to access the filesystem drive,
you use the prefix C:, and to access the registry drive, you use the prefix HKLM:. In the case of the
Env:\ PSDrive, the prefix is Env:, which allows you to access environment variables as if they were
files or folders.
There are several built-in PSDrives in PowerShell

Cmdlets
A cmdlet (pronounced as commandlet) is a type of PowerShell command that performs a specific task
and can be written in C# or in another .NET language
Get-Command can help you to differentiate cmdlets from functions. Additionally, you can also see
the version and the provider:
> Get-Command new-item

To find out all cmdlets that are currently installed on the machine you are using, you can leverage
Get-Command with the CommandType parameter:
Get-Command -CommandType Cmdlet

If you want to dig deeper into cmdlets, I recommend reviewing the official PowerShell documentation.
Microsoft has published a lot of advice, as well as recommendations and guidelines:
• https://docs.microsoft.com/en-us/powershell/scripting/developer/
cmdlet/cmdlet-overview
• https://docs.microsoft.com/en-us/powershell/scripting/developer/
cmdlet/windows-powershell-cmdlet-concepts

Functions
Functions are a collection of PowerShell commands that should be run following a certain logic.
This skeleton function using pseudocode should demonstrate the basic structure of a function:
function Verb-Noun {
<#
 <Optional help text>
#>
param (
 [data_type]$Parameter
)
<...Code: Function Logic...>
}

Once the function is loaded into the session, it needs to be called so that it will be executed:
Verb-Noun -Parameter "test"
Parameters
A function does not necessarily need to support parameters, but if you want to process input within
the function, parameters are required:
function Invoke-Greeting {
 param (
 [string]$Name
 )
 Write-Output "Hello $Name!"
}

If the parameter is specified, the provided value is stored in the $Name variable and can be used
within the function:
> Invoke-Greeting -Name "Miriam"
Hello Miriam!

One way to use cmdletbinding is to declare a parameter as mandatory, positional, or in a parameter
set, which can automatically turn your function into a cmdlet with additional common parameters. 

function Invoke-Greeting {
 [cmdletbinding()]
 param (
 [Parameter(Mandatory)]
 $Name
 )
 Write-Output "Hello $Name!"
}

This will automatically add the [<CommonParameters >] section to the output of Get-Command,
and you will see all the common parameters that are also available in many other cmdlets, such as
Verbose, Debug, ErrorAction, and others.

SupportsShouldProcess
If a function makes changes, you can use SupportsShouldProcess to add an additional layer of
protection to your function. By adding [CmdletBinding(SupportsShouldProcess)], you
can enable the -WhatIf and -Confirm parameters in your function, which help users understand
the effect of their actions before executing the function.
To use SupportsShouldProcess
effectively, you will also need to call ShouldProcess() for each item being processed

function Invoke-Greeting {
 [CmdletBinding(SupportsShouldProcess)]
 param (
 $Name
 )
 foreach ($item in $Name) {
 if ($PSCmdlet.ShouldProcess($item)) {
 Write-Output "Hello $item!"
 }
 }
}

With this code, the function can be executed with the -Confirm parameter to prompt the user for
confirmation before processing each item, or with the -WhatIf parameter to display a list of changes
that would be made without actually processing the items.
> Get-Command -Name Invoke-Greeting -Syntax
Invoke-Greeting [[-Name] <Object>] [-WhatIf] [-Confirm]
[<CommonParameters>]


The following example shows the Invoke-Greeting function, which accepts input both by value
and property name for its mandatory $Name parameter:
function Invoke-Greeting {
 [CmdletBinding()]
 param (
 [Parameter(Mandatory, ValueFromPipeline,
ValueFromPipelineByPropertyName)]
 [string]$Name
 )
 process {
 Write-Output "Hello $Name!"
 }
}

To configure a function to accept input by value, we can use ValueFromPipeline; to accept input
by property name use ValueFromPipelineByPropertyName. Of course, both can be combined
with each other and with other parameter options as well, such as Mandatory

The following example shows the Invoke-Greeting function, which accepts input both by value
and property name for its mandatory $Name parameter:
function Invoke-Greeting {
 [CmdletBinding()]
 param (
 [Parameter(Mandatory, ValueFromPipeline,
ValueFromPipelineByPropertyName)]
 [string]$Name
 )
 process {
 Write-Output "Hello $Name!"
 }
}
You can now pass input by value to this function, as shown in the following example:
> "Alice","Bob" | Invoke-Greeting
Hello Alice!
Hello Bob!

But it also works to pass input by property name, as the following code snippet demonstrates:
> [pscustomobject]@{Name = "Miriam"} | Invoke-Greeting
Hello Miriam!

Comment-based help
Writing comment-based help for your functions is crucial; others might reuse your function or if you
want to adjust or reuse the function yourself some months after you wrote it, having good commentbased help will simplify the usage:
<#
.SYNOPSIS
<Describe the function shortly.>
.DESCRIPTION
<More detailed description of the function.>
.PARAMETER Name
<Add a section to describe each parameter, if your function has one or
more parameters.>
.EXAMPLE
<Example how to call the funtion>
<Describes what happens if the example call is run.>
#>

Error handling
If you are not sure whether your command will succeed, use try and catch:
try {
 New-PSSession -ComputerName $Computer -ErrorAction Stop
}
catch {
 Write-Warning -Message "Couldn't connect to Computer: $Computer"
}

The difference between cmdlets and script cmdlets (advanced
functions)

When I heard for the first time about cmdlets and advanced functions, I was like Okay great, but what’s
the difference? They both sound pretty alike.
One significant difference is that cmdlets can be written in a .NET language such as C# and reside
within a compiled binary. Script cmdlets, also known as advanced functions, are similar to cmdlets,
but they are written in PowerShell script rather than a .NET language. Script cmdlets are a way to
create custom cmdlets using PowerShell script instead of compiling code in a .NET language

Aliases
An alias is some kind of a nickname for a PowerShell command, an alternate name
For example, one of the most used aliases is the famous cd command, which administrators use to
change the directory on the command line. But cd is only an alias for the Set-Location cmdlet:
PS C:\> cd 'C:\tmp\PSSec\'
PS C:\tmp\PS Sec>
PS C:\> Set-Location 'C:\tmp\PSSec\'
PS C:\tmp\PS Sec>

To see all available cmdlets that have the word Alias in their name, you can leverage Get-Command:
Get-Command -Name "*Aliases*"
Next, let’s have a closer look at how to work with aliases, using the Get-Alias, New-Alias,
Set-Alias, Export-Alias, and Import-Alias cmdlets.
Get-Alias
To see all aliases that are currently configured on the computer you are working on, use the
Get-Alias cmdlet:

New-Alias
You can use New-Alias to create a new alias within the current PowerShell session:
> New-Alias -Name Get-Ip -Value ipconfig
> Get-Ip

This alias is not set permanently, so once you exit the session, the alias will not be available anymore.

If you want to add parameters to the command that your alias runs, you can create a function and
use New-Alias to link the new function to your existing command.
Set-Alias
Set-Alias can be used to either create or change an alias

So if you want to change, for example, the content of the formerly created Get-Ip alias to
Get-NetIPAddress, you would run the following command:
> Set-Alias -Name Get-Ip -Value Get-NetIPAddress

Export-Alias
Export one or more aliases with Export-Alias – either as a .csv file or as a script:
Export-Alias -Path "alias.csv"
Using this command, we first export all aliases to a .csv file:
Export-Alias -Path "alias.ps1" -As Script
The -As Script parameter allows you to execute all currently available aliases as a script that can
be executed:
Export-Alias -Path "alias.ps1" -Name Get-Ip -As Script

alias.csv
The alias.csv file that we created using the Export-Alias command can now be reused to
create or import all aliases of this session in another session:
You can now use the file to set your aliases automatically whenever you run the .ps1 script, or you
can use the code to edit your profile file (see New-Alias) to configure permanent aliases:
set-alias -Name:"Get-Ip" -Value:"Get-NetIPAddress" -Description:""
-Option:"None"

Import-Alias
You can use Import-Alias to import aliases that were exported as .csv:
> Set-Alias -Name Get-Ip -Value Get-Iponfig
> Export-Alias -Name Get-Ip -Path Get-Ip_alias.csv

Import the file to make the alias available in your current session:
> Import-Alias -Path .\Get-Ip_alias.csv
> Get-Ip

Modules
Modules are a collection of PowerShell commands and functions that can be easily shipped and
installed on other systems. They are a great way to enrich your sessions with other functionalities.
Find Module-Related Cmdlets
To find module-related cmdlets, leverage Get-Command and have a look at their help pages
and the official documentation to understand their function:
Get-Command -Name "*Module*"

All modules that are installed on the system can be found in one of the PSModulePath folders,
which are part of the Env:\ PSDrive:
> Get-Item -Path Env:\PSModulePath
Query the content with Env:\PSModulePath to find out which paths were set on your system

Finding and installing modules
To search for a certain module in a repository, you can leverage Find-Module -Name
<modulename>. It queries the repositories that are configured on your operating system:
> Find-Module -Name EventList

Once you have found the desired module, you can download and install it to your local system
using Install-Module:
> Install-Module <modulename>
If you have already installed a module for which a newer version exists, update it with UpdateModule:
> Update-Module <modulename> -Force

To see which repositories are available on your system, use the following:
> Get-PSRepository

Working with modules
To find out which modules are already available in the current session, you can use Get-Module:
> Get-Module

To see which modules are available to import, including those that come pre-installed with Windows,
you can use the ListAvailable parameter with the Get-Module cmdlet. This will display a
list of all available modules on the computer, including their version numbers, descriptions, and
other information:
> Get-Module -ListAvailable
Find out which commands are available by using Get-Command:
> Get-Command -Module <modulename>

If you have, for example, an old version loaded in your current session and you want to unload it,
Remove-Module unloads the current module from your session:
> Remove-Module <modulename>

Creating your own modules
Creating your own modules
To make your functions easier to ship to other systems, creating a module is a great way. As the
description of full-blown modules would exceed the scope of this book, I will describe the basics of
how to quickly get started.
Please also have a look at the official PowerShell module documentation to better understand how
modules work and how they should be created: https://docs.microsoft.com/en-us/
powershell/scripting/developer/module/writing-a-windows-powershellmodule.
When working more intensively with PowerShell modules, you might also come across many different
files, such as files that end with .psm1, .psd1, .ps1xml, or .dll, help files, localization files,
and many others.

Developing a basic module
Creating a basic PowerShell module can be as simple as writing a script containing one or more
functions, and saving it with a .psm1 file extension.
First, we define the path where the module should be saved in the $path variable and create the
MyModule folder if it does not exist yet. We then use the New-ModuleManifest cmdlet to create
a new module manifest file named MyModule.psd1 in the MyModule folder. The -RootModule
parameter specifies the name of the PowerShell module file, which is MyModule.psm1.
Using the Set-Content cmdlet, we create the MyModule.psm1 file and define the InvokeGreeting function, which we wrote earlier in this chapter:
$path = $env:TEMP + "\MyModule\"
if (!(Test-Path -Path $path)) {
 New-Item -ItemType directory -Path $path
}
New-ModuleManifest -Path $path\MyModule.psd1 -RootModule MyModule.psm1
Set-Content -Path $path\MyModule.psm1 -Value {
 function Invoke-Greeting {
 [CmdletBinding()]
 param(
 [Parameter(Mandatory=$true)]
 [string]$Name
 )
 "Hello, $Name!"
 }
}





































































































