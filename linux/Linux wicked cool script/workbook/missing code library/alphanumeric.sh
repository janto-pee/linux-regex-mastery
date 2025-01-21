#! /bin/sh

checkAlphanumeric() {
    value=$1
    userInput="$(echo $value | sed -e 's/[^[:alnum:]]//g')"
    userWithSpaceInput="$(echo $value | sed -e 's/^[[:alnum:]]*[[:space:]]*$//')"
    userWithSpecialInput="$(echo $value | sed -e 's/^[[:alnum:]]*\$*\#*$//')"
    case $value in 
    $userInput)
        printf "user input is alphanumeric"
        return 0
        ;;
    $userWithSpaceInput)
        printf "user input has space"
        return 1
        ;;
    $userWithSpecialInput)
        printf "user input has special char"
        return 1
        ;;
    *)
        echo $value: not allowed
        # exit
        return 1
        ;;
    esac
    
}

alphanumeric(){
    var=$1
    
    if [ "$var" = "" ] ; then
        return 2
    elif ! checkAlphanumeric $var; then
        return 2
    fi
}
alphanumeric re4ee_e