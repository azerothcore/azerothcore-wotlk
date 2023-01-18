APP_NAME=$1
CONFIG_FOLDER=${2:-"etc"}
BIN_FOLDER=${3-"bin"}
MYSQL_ROOT_PASSWORD=${4:-""}


echo "LoginDatabaseInfo     = \"localhost;3306;root;$MYSQL_ROOT_PASSWORD;acore_auth\"" >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf

# worldserver or dbimport
if [[ $APP_NAME != "authserver" ]]; then
    {
        echo "WorldDatabaseInfo     = \"localhost;3306;root;$MYSQL_ROOT_PASSWORD;acore_world\""
        echo "CharacterDatabaseInfo = \"localhost;3306;root;$MYSQL_ROOT_PASSWORD;acore_characters\""
		# Required for database update check
		echo "Updates.EnableDatabases = 7"
		# Realm ID required for startup
		echo "RealmID = 1"
		# Loggers required for log error checking
		echo "Appender.Console=1,4,0,\"1 9 3 6 5 8\""
		echo "Appender.Server=2,5,0,Server.log,w"
		echo "Appender.GM=2,5,15,gm_%s.log"
		echo "Appender.DBErrors=2,5,0,DBErrors.log"
		echo "Logger.root=2,Console Server"
		echo "Logger.commands.gm=4,Console GM"
		echo "Logger.diff=3,Console Server"
		echo "Logger.mmaps=4,Server"
		echo "Logger.scripts.hotswap=4,Console Server"
		echo "Logger.server=4,Console Server"
		echo "Logger.sql.sql=2,Console DBErrors"
		echo "Logger.sql=4,Console Server"
		echo "Logger.time.update=4,Console Server"
		echo "Logger.module=4,Console Server"
		# Some default values just to reduce the amount of "errors" in the logs
		echo "MySQLExecutable = \"\""
		echo "TempDir = \"\""
		echo "SourceDirectory = \"\""
    } >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf
fi

if [[ $APP_NAME == "authserver" ]]; then
	{
		# Required for database update check
		echo "Updates.EnableDatabases = 1"
		# Loggers required for log error checking
		echo "Appender.Console=1,5,0,\"1 9 3 6 5 8\""
		echo "Appender.Auth=2,5,0,Auth.log,w"
		echo "Logger.root=4,Console Auth"
		# Some default values just to reduce the amount of "errors" in the logs
		echo "MySQLExecutable = \"\""
		echo "TempDir = \"\""
		echo "SourceDirectory = \"\""
	} >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf
fi

if [[ $APP_NAME == "worldserver" ]]; then
    echo "DataDir = \"./data/\"" >> ./env/dist/$CONFIG_FOLDER/$APP_NAME.conf

    git clone --depth=1 --branch=master --single-branch https://github.com/ac-data/ac-data.git ./env/dist/$BIN_FOLDER/data
fi
