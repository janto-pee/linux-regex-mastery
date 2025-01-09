# Create two similar, but different, text files. Try comparing them by using Diff. Run
# something like this: Diff -reference (Get-Content File1.txt) -difference
# (Get-Content File2.txt). If the files have only one line of text that’s different,
# the command should work.
PS C:\> "I am the walrus" | out-file file1.txt
PS C:\> "I'm a believer" | out-file file2.txt
PS C:\> $f1=get-content .\file1.txt
PS C:\> $f2=Get-Content .\file2.txt
PS C:\> diff $f1 $f2
# InputObject SideIndicator
# ----------- -------------
# I'm a believer =>
# I am the walrus <=
# 2 What happens (on Windows) if you run Get-Service | Export-CSV services
# .csv | Out-File from the console? Why does that happen?
If you don’t specify a filename with Out-File, you’ll get an error. But even if
you do, Out-File won’t do anything because the file is created by Export-CSV.
# 3 Apart from getting one or more services and piping them to Stop-Service,
# what other means does Stop-Service provide for you to specify the service or
# services you want to stop? Is it possible to stop a service without using Get
# -Service at all?
Stop-Service can accept one or more service names as parameter values for
the –Name parameter. For example, you could run this:
Stop-Service spooler
# 4 What if you want to create a pipe-delimited file instead of a comma-separated
get-service | Export-Csv services.csv -Delimiter "|"
(CSV) file? You’d still use the Export-CSV command, but what parameters
would you specify?
# 5 Use the –NoTypeInformation parameter with Export-CSV.
Is there a way to eliminate the # comment line from the top of an exported CSV
file? That line typically contains type information, but what if you want to omit
that from a particular file?
# 6 get-service | Export-Csv services.csv –noclobber
Export-CliXML and Export-CSV both modify the system because they can create and overwrite files. What parameter would prevent them from overwriting
an existing file? What parameter would ask whether you were sure before proceeding to write the output file?
get-service | Export-Csv services.csv -confirm
# 7 Windows maintains several regional settings, which include a default list separator. On U.S. systems, that separator is a comma. How can you tell Export-CSV to
# use the system’s default separator rather than a comma?
get-service | Export-Csv services.csv -UseCulture