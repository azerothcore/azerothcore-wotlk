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
        bsd*)     echo "BSD is not supported yet" ;;
        msys*)    source "$AC_PATH_INSTALLER/includes/os_configs/windows.sh" ;;
        *)        echo "This platform is not supported" ;;
    esac
}

function inst_updateRepo() {
    cd "$AC_PATH_ROOT"
    git pull origin $(git rev-parse --abbrev-ref HEAD)
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
    dbasm_import true true true
}

function inst_getVersionBranch() {
    local res="master"
    local v="not-defined"
    local MODULE_MAJOR=0
    local MODULE_MINOR=0
    local MODULE_PATCH=0
    local MODULE_SPECIAL=0;
    local ACV_MAJOR=0
    local ACV_MINOR=0
    local ACV_PATCH=0
    local ACV_SPECIAL=0;
    local curldata=$(curl -f --silent -H 'Cache-Control: no-cache' "$1" || echo "{}")
    local parsed=$(echo "$curldata" | "$AC_PATH_DEPS/jsonpath/JSONPath.sh" -b '$.compatibility.*.[version,branch]')

    semverParseInto "$ACORE_VERSION" ACV_MAJOR ACV_MINOR ACV_PATCH ACV_SPECIAL

    if [[ ! -z "$parsed" ]]; then
        readarray -t vers < <(echo "$parsed")
        local idx
        res="none"
        # since we've the pair version,branch alternated in not associative and one-dimensional
        # array, we've to simulate the association with length/2 trick
        for idx in `seq 0 $((${#vers[*]}/2-1))`; do
            semverParseInto "${vers[idx*2]}" MODULE_MAJOR MODULE_MINOR MODULE_PATCH MODULE_SPECIAL
            if [[ $MODULE_MAJOR -eq $ACV_MAJOR && $MODULE_MINOR -le $ACV_MINOR ]]; then
                res="${vers[idx*2+1]}"
                v="${vers[idx*2]}"
            fi
        done
    fi

    echo "$v" "$res"
}

function inst_module_search {

    local res="$1"
    local idx=0;

    if [ -z "$1" ]; then
        echo "Type what to search or leave blank for full list"
        read -p "Insert name: " res
    fi

    local search="+$res"

    echo "Searching $res..."
    echo "";

    readarray -t MODS < <(curl --silent "https://api.github.com/search/repositories?q=org%3Aazerothcore${search}+fork%3Atrue+topic%3Acore-module+sort%3Astars&type=" \
        | "$AC_PATH_DEPS/jsonpath/JSONPath.sh" -b '$.items.*.name')
    while (( ${#MODS[@]} > idx )); do
        mod="${MODS[idx++]}"
        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/azerothcore/$mod/master/acore-module.json")

        if [[ "$b" != "none" ]]; then
            echo "-> $mod (tested with AC version: $v)"
        else
            echo "-> $mod (no revision available for AC v$AC_VERSION, it could not work!)"
        fi
    done

    echo "";
    echo "";
}

function inst_module_install {
    local res
    if [ -z "$1" ]; then
        echo "Type the name of the module to install"
        read -p "Insert name: " res
    else
        res="$1"
    fi

    read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/azerothcore/$res/master/acore-module.json")

    if [[ "$b" != "none" ]]; then
        Joiner:add_repo "https://github.com/azerothcore/$res" "$res" "$b" && echo "Done, please re-run compiling and db assembly. Read instruction on module repository for more information"
    else
        echo "Cannot install $res module: it doesn't exists or no version compatible with AC v$ACORE_VERSION are available"
    fi

    echo "";
    echo "";
}

function inst_module_update {
    local res;
    local _tmp;
    local branch;
    local p;

    if [ -z "$1" ]; then
        echo "Type the name of the module to update"
        read -p "Insert name: " res
    else
        res="$1"
    fi

    _tmp=$PWD

    if [ -d "$J_PATH_MODULES/$res/" ]; then
        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/azerothcore/$res/master/acore-module.json")

        cd "$J_PATH_MODULES/$res/"

        # use current branch if something wrong with json
        if [[ "$v" == "none" || "$v" == "not-defined" ]]; then
            b=`git rev-parse --abbrev-ref HEAD`
        fi

        Joiner:upd_repo "https://github.com/azerothcore/$res" "$res" "$b" && echo "Done, please re-run compiling and db assembly" || echo "Cannot update"
        cd $_tmp
    else
        echo "Cannot update! Path doesn't exist"
    fi;

    echo "";
    echo "";
}

function inst_module_remove {
    if [ -z "$1" ]; then
        echo "Type the name of the module to remove"
        read -p "Insert name: " res
    else
        res="$1"
    fi

    Joiner:remove "$res" && echo "Done, please re-run compiling"  || echo "Cannot remove"

    echo "";
    echo "";
}


function inst_simple_restarter {
    echo "Running $1 ..."
    bash "$AC_PATH_APPS/startup-scripts/simple-restarter" "$AC_BINPATH_FULL" "$1"
    echo
    #disown -a
    #jobs -l
}

function inst_download_client_data {
    # change the following version when needed
    local VERSION=v12

    echo "#######################"
    echo "Client data downloader"
    echo "#######################"

    # first check if it's defined in env, otherwise use the default
    local path="${DATAPATH:-$AC_BINPATH_FULL}"
    local zipPath="${DATAPATH_ZIP:-"$DATAPATH/data.zip"}"

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
