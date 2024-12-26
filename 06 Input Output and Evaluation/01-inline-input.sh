
du -s * |  #Generate raw disk usage
 sort -nr |  #Sort numerically, highest numbers first
 sed 10q |  #Stop after first 10 lines
 while read amount name
 do
 mail -s "disk usage warning" $name << EOF
Greetings. You are one of the top 10 consumers of disk space
on the system. Your home directory uses $amount disk blocks.
Please clean up unneeded files, as soon as possible.
Thanks,
Your friendly neighborhood system administrator.
EOF
 done