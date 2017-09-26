# you can choose build type from cmd argument
if [ ! -z $1 ]
then
    CCTYPE=$1
    CCTYPE=${CCTYPE^} # capitalize first letter if it's not yet
fi

[ $CTYPE == "Debug" ] && BUILDPATH="$BUILDPATH/debug/" ||  BUILDPATH="$BUILDPATH/release/"

[ $CTYPE == "Debug" ] && BINPATH="$BINPATH/debug/" || BINPATH="$BINPATH/release/"
