# #! /bin/sh

# inPath(){
#     cmd=$1          dirPath=$2      result=1
#     oldIFS=$IFS     IFS=:

#     for directory in $dirPath
#     do
#         if [ -x $directory/$cmd ] ; then
#             result=0
#         fi
#     done

#     IFS=$oldIFS
#     printf "$result"
#     return $result
# }

# checkForCmdInPath(){
#     userInput=$1
#     if [ "$userInput" != "" ] ; then
#         if [ ! {$userInput:0:1} != "/" ] ; then
#             if [ ! -x $userInput] ; then 
#                 return 1
#             fi
#         elif ! inPath $userInput "$PATH " ; then
#             return 2
#         fi
#     fi
# }
# # print "($checkForCmdInPath)"


checkForCmdInPath(){
    var=$1

    if [ "$var" != "" ] ; then
        if [ "${var:0:1}" != "/" ] ; then
            if [ ! -x "$var" ] ; then
                printf "not executable"
                return 1
            fi
        elif ! in_path $var "$PATH"; then
            printf "2--- not found in path"
            return 2
        fi
    fi

}

in_path(){
    cmd=$1          diPath=$2       result=1
    oldIFS=$IFS     IFS=:
    printf "inpath"

    for directory in $dirPath
    do
        if [ -x $directory/$cmd ] ; then
            result = 0
        fi
    done
    IFS=$oldIFS
    return $result
}
checkForCmdInPath echo