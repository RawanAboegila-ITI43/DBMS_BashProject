### Colors ##

export YELLOW=226
export BLACK=232
export DEFAULT_BK=235
export BLUE=26
export WHITE=15

#### Terminal Variables ##

BLINK=\e[5m
export Width=$(tput cols)
export Height=$(tput lines)
export st_Standout=$(tput smso)
export end_Standout=$(tput rmso)
### Color Functions ##

function MiddlePrint {

    tput cup $(((Height / 2) + $1)) $(((Width / 2) + $2))
    tput sc

}

function styleOutput {
    #echo -e "Width = $(tput cols) Height = $(tput lines)\n"
    tput setab $1
    tput setaf $2
    #tput smso
    #tput cup 5 5
    echo -e $3
    tput sgr0

}
