#!/usr/bin/env bash

# Set SUDO variable - one liner
if [[ "$OSTYPE" == "msys"* ]]; then
    SUDO=""
else
    SUDO=$([ "$EUID" -ne 0 ] && echo "sudo" || echo "")
fi

function inst_configureOS() {
    echo "Platform: $OSTYPE"
    case "$OSTYPE" in
        solaris*) echo "Solaris is not supported yet" ;;
        darwin*)  source "$AC_PATH_INSTALLER/includes/os_configs/osx.sh" ;;
        linux*)
            # If $OSDISTRO is set, use this value (from config.sh)
            if [ ! -z "$OSDISTRO" ]; then
                DISTRO=$OSDISTRO
            # If available, use LSB to identify distribution
            elif command -v lsb_release >/dev/null 2>&1 ; then
                DISTRO=$(lsb_release -is)
            # Otherwise, use release info file
            else
                DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
            fi

            case $DISTRO in
            # add here distro that are debian or ubuntu based
            # TODO: find a better way, maybe checking the existance
            # of a package manager
                "neon" | "ubuntu" | "Ubuntu")
                    DISTRO="ubuntu"
                ;;
                "debian" | "Debian")
                    DISTRO="debian"
                ;;
                *)
                    echo "Distro: $DISTRO, is not supported. If your distribution is based on debian or ubuntu,
                        please set the 'OSDISTRO' environment variable to one of these distro (you can use config.sh file)"
                ;;
            esac


            DISTRO=${DISTRO,,}

            echo "Distro: $DISTRO"

            # TODO: implement different configurations by distro
            source "$AC_PATH_INSTALLER/includes/os_configs/$DISTRO.sh"
        ;;
        *bsd*)     echo "BSD is not supported yet" ;;
        msys*)    source "$AC_PATH_INSTALLER/includes/os_configs/windows.sh" ;;
        *)        echo "This platform is not supported" ;;
    esac
}

# Use the data/sql/create/create_mysql.sql to initialize the database
function inst_dbCreate() {
    echo "Creating database..."

    # Attempt to connect with MYSQL_ROOT_PASSWORD
    if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
        if $SUDO mysql -u root -p"$MYSQL_ROOT_PASSWORD" < "$AC_PATH_ROOT/data/sql/create/create_mysql.sql" 2>/dev/null; then
            echo "Database created successfully."
            return 0
        else
            echo "Failed to connect with provided password, falling back to interactive mode..."
        fi
    fi

    # In CI environments or when no password is set, try without password first
    if [[ "$CONTINUOUS_INTEGRATION" == "true" ]]; then
        echo "CI environment detected, attempting connection without password..."

        if $SUDO mysql -u root < "$AC_PATH_ROOT/data/sql/create/create_mysql.sql" 2>/dev/null; then
            echo "Database created successfully."
            return 0
        else
            echo "Failed to connect without password, falling back to interactive mode..."
        fi
    fi

    # Try with password (interactive mode)
    echo "Please enter your sudo and your MySQL root password if prompted."
    $SUDO mysql -u root -p < "$AC_PATH_ROOT/data/sql/create/create_mysql.sql"
    if [ $? -ne 0 ]; then
        echo "Database creation failed. Please check your MySQL server and credentials."
        exit 1
    fi
    echo "Database created successfully."
}

function inst_updateRepo() {
    cd "$AC_PATH_ROOT"
    if [ ! -z $INSTALLER_PULL_FROM ]; then
        git pull "$ORIGIN_REMOTE" "$INSTALLER_PULL_FROM"
    else
        git pull "$ORIGIN_REMOTE" $(git rev-parse --abbrev-ref HEAD)
    fi
}

function inst_resetRepo() {
    cd "$AC_PATH_ROOT"
    git reset --hard $(git rev-parse --abbrev-ref HEAD)
    git clean -f
}

function inst_compile() {
    comp_configure
    comp_build
}

function inst_cleanCompile() {
    comp_clean
    inst_compile
}

function inst_allInOne() {
    inst_configureOS
    inst_compile
    inst_dbCreate
    inst_download_client_data
}

############################################################
# Module helpers and dispatcher                             #
############################################################

# Returns the default branch name of a GitHub repo in the azerothcore org.
# If the API call fails, defaults to "master".
function inst_get_default_branch() {
    local repo="$1"
    local def
    def=$(curl --silent "https://api.github.com/repos/azerothcore/${repo}" \
        | "$AC_PATH_DEPS/jsonpath/JSONPath.sh" -b '$.default_branch')
    if [ -z "$def" ]; then
        def="master"
    fi
    echo "$def"
}

# =============================================================================
# Module Management System
# =============================================================================
# Load the module manager functions from the dedicated modules-manager directory
source "$AC_PATH_INSTALLER/includes/modules-manager/modules.sh"

function inst_simple_restarter {
    echo "Running $1 ..."
    bash "$AC_PATH_APPS/startup-scripts/src/simple-restarter" "$AC_BINPATH_FULL" "$1"
    echo
    #disown -a
    #jobs -l
}

function inst_download_client_data {
    # change the following version when needed
    local VERSION=v19

    echo "#######################"
    echo "Client data downloader"
    echo "#######################"

    # first check if it's defined in env, otherwise use the default
    local path="${DATAPATH:-$AC_BINPATH_FULL}"
    local zipPath="${DATAPATH_ZIP:-"$path/data.zip"}"

    dataVersionFile="$path/data-version"

    [ -f "$dataVersionFile" ] && source "$dataVersionFile"

    # create the path if doesn't exists
    mkdir -p "$path"

    if [ "$VERSION" == "$INSTALLED_VERSION" ]; then
        echo "Data $VERSION already installed. If you want to force the download remove the following file: $dataVersionFile"
        return
    fi

    echo "Downloading client data in: $zipPath ..."
    curl -L https://github.com/wowgaming/client-data/releases/download/$VERSION/data.zip > "$zipPath" \
        && echo "unzip downloaded file in $path..." && unzip -q -o "$zipPath" -d "$path/" \
        && echo "Remove downloaded file" && rm "$zipPath" \
        && echo "INSTALLED_VERSION=$VERSION" > "$dataVersionFile"
}


