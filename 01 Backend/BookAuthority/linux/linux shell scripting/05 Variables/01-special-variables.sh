$ set -- hello "hi there" greetings Set new positional parameters
$ echo there are $# total arguments Print the count
there are 3 total arguments
$ for i in $* #Loop over arguments individually
> do echo i is $i
> done
# i is hello #Note that embedded whitespace was lost
# i is hi
# i is there
# i is greetings
$ for i in $@ #Without quotes, $* and $@ are the same
> do echo i is $i
> done
# i is hello
# i is hi
# i is there
# i is greetings
$ for i in "$*" #With quotes, $* is one string
> do echo i is $i
> done
# i is hello hi there greetings
$ for i in "$@" #With quotes, $@ preserves exact argument values
> do echo i is $i
> done
# i is hello
# i is hi there
# i is greetings
$ shift #Lop off the first argument
$ echo there are now $# arguments #Prove that it's now gone
# there are now 2 arguments
$ for i in "$@"
> do echo i is $i
> done
# i is hi there
# i is greetings