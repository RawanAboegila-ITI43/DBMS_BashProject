### Colors ##

export YELLOW=226
export BLACK=232
export DEFAULT_BK=235
export BLUE=26
export WHITE=15
export RED=1

#### Terminal Variables ##

export Width=$(tput cols)
export Height=$(tput lines)
### Color Functions ##

function MiddlePrint {

    tput cup $(((Height / 2) + $1)) $(((Width / 2) + $2))

}

function styleOutput {

    tput setab $1
    tput setaf $2
    echo -e $3
    tput sgr0

}
