# you can choose build type from cmd argument
if [ ! -z $1 ]
then
    CCTYPE=$1
    CCTYPE=${CCTYPE^} # capitalize first letter if it's not yet
fi

