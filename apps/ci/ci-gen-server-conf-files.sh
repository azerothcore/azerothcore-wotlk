APP_NAME=$1
CONFIG_FOLDER=${2:-"etc"}
BIN_FOLDER=${3-"bin"}
MYSQL_ROOT_PASSWORD=${4:-""}

# copy dist files to conf files
cp ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf.dist ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf

# replace login info
sed -i "s/127.0.0.1;3306;acore;acore/localhost;3306;root;$MYSQL_ROOT_PASSWORD/" ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf

if [[ $APP_NAME == "worldserver" ]]; then
    sed -i 's/DataDir = \".\"/DataDir = \".\/data"/' ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf
    git clone --depth=1 --branch=master --single-branch https://github.com/ac-data/ac-data.git ./env/dist/$BIN_FOLDER/data
fi