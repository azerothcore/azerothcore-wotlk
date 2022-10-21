APP_NAME=$1
CONFIG_FOLDER=$2

echo "LoginDatabaseInfo     = \"localhost;3306;root;root;acore_auth\"" >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf

# worldserver or dbimport
if [[ $APP_NAME != "authserver" ]]; then
    {
        echo "WorldDatabaseInfo     = \"localhost;3306;root;root;acore_world\""
        echo "CharacterDatabaseInfo = \"localhost;3306;root;root;acore_characters\""
    } >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf
fi

if [[ $APP_NAME == "worldserver" ]]; then
    echo "DataDir = \"../data/\"" >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf

    git clone --depth=1 --branch=master --single-branch https://github.com/ac-data/ac-data.git ./env/dist/data
fi
