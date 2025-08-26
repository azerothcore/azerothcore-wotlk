#!/usr/bin/env bash

# Set SUDO variable - one liner
SUDO=$([ "$EUID" -ne 0 ] && echo "sudo" || echo "")

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

# Dispatcher for the unified `module` command.
# Usage: ./acore.sh module <search|install|update|remove> [args...]
function inst_module() {
    # Normalize arguments into an array
    local tokens=()
    read -r -a tokens <<< "$*"
    local cmd="${tokens[0]}"
    local args=("${tokens[@]:1}")

    case "$cmd" in
        ""|"help"|"-h"|"--help")
            echo "Usage:"
            echo "  ./acore.sh module search   [terms...]"
            echo "  ./acore.sh module install  [modules...]"
            echo "  ./acore.sh module update   [modules...]"
            echo "  ./acore.sh module remove   [modules...]"
            ;;
        "search"|"s")
            inst_module_search "${args[@]}"
            ;;
        "install"|"i")
            inst_module_install "${args[@]}"
            ;;
        "update"|"u")
            inst_module_update "${args[@]}"
            ;;
        "remove"|"r")
            inst_module_remove "${args[@]}"
            ;;
        *)
            echo "Unknown subcommand: $cmd"
            echo "Try: ./acore.sh module help"
            ;;
    esac
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

    # Accept 0..N search terms; if none provided, prompt the user.
    local terms=("$@")
    if [ ${#terms[@]} -eq 0 ]; then
        echo "Type what to search (blank for full list)"
        read -p "Insert name(s): " _line
        if [ -n "$_line" ]; then
            read -r -a terms <<< "$_line"
        fi
    fi

    # Build GitHub search query: org + topic + fork + optional in:name filters
    local q_base="org:azerothcore+topic:azerothcore-module"
    local q_terms=""
    local t
    for t in "${terms[@]}"; do
        [ -z "$t" ] && continue
        q_terms+="+in:name+${t}"
    done

    echo "Searching ${terms[*]}..."
    echo ""

    # Ask GitHub API (per_page to widen results). Sort outside of q.
    readarray -t MODS < <(curl --silent "https://api.github.com/search/repositories?q=${q_base}${q_terms}&sort=stars&order=desc&per_page=100" \
        | "$AC_PATH_DEPS/jsonpath/JSONPath.sh" -b '$.items.*.name')

    if (( ${#MODS[@]} == 0 )); then
        echo "No results."
        echo ""
        return 0
    fi

    local idx=0
    while (( ${#MODS[@]} > idx )); do
        local mod="${MODS[idx++]}"
        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/azerothcore/$mod/master/acore-module.json")

        if [[ "$b" != "none" ]]; then
            echo "-> $mod (tested with AC version: $v)"
        else
            echo "-> $mod (no revision available for AC v$ACORE_VERSION, it could not work!)"
        fi
    done

    echo ""
    echo ""
}

function inst_module_install {
    # Support multiple modules; prompt if none specified.
    local modules=("$@")
    if [ ${#modules[@]} -eq 0 ]; then
        echo "Type the name(s) of the module(s) to install"
        read -p "Insert name(s): " _line
        read -r -a modules <<< "$_line"
    fi

    local res v b def
    for res in "${modules[@]}"; do
        [ -z "$res" ] && continue

        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/azerothcore/$res/master/acore-module.json")

        # If the module json is missing or no compat branch found, warn and use default branch
        if [[ "$v" == "none" || "$v" == "not-defined" || "$b" == "none" ]]; then
            def="$(inst_get_default_branch "$res")"
            echo "Warning: $res has no compatible acore-module.json; installing from branch '$def' (latest commit)."
            b="$def"
        fi

        if Joiner:add_repo "https://github.com/azerothcore/$res" "$res" "$b"; then
            echo "[$res] Done, please re-run compiling and db assembly. Read instructions on module repository for more information"
        else
            echo "[$res] Install failed or module not found"
        fi
    done

    echo ""
    echo ""
}

function inst_module_update {
    # Support multiple modules; prompt if none specified.
    local modules=("$@")
    if [ ${#modules[@]} -eq 0 ]; then
        echo "Type the name(s) of the module(s) to update"
        read -p "Insert name(s): " _line
        read -r -a modules <<< "$_line"
    fi

    local _tmp=$PWD
    local res v b branch def

    for res in "${modules[@]}"; do
        [ -z "$res" ] && continue

        if [ -d "$J_PATH_MODULES/$res/" ]; then
            read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/azerothcore/$res/master/acore-module.json")

            cd "$J_PATH_MODULES/$res/" || { echo "[$res] Cannot enter module directory"; cd "$_tmp"; continue; }

            # If json missing or no compat branch: prefer current branch, else fallback to default branch
            if [[ "$v" == "none" || "$v" == "not-defined" || "$b" == "none" ]]; then
                if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
                    echo "Warning: $res has no compatible acore-module.json; updating current branch '$branch'."
                    b="$branch"
                else
                    def="$(inst_get_default_branch "$res")"
                    echo "Warning: $res has no compatible acore-module.json and no git branch detected; updating default branch '$def'."
                    b="$def"
                fi
            fi

            if Joiner:upd_repo "https://github.com/azerothcore/$res" "$res" "$b"; then
                echo "[$res] Done, please re-run compiling and db assembly"
            else
                echo "[$res] Cannot update"
            fi
            cd "$_tmp"
        else
            echo "[$res] Cannot update! Path doesn't exist ($J_PATH_MODULES/$res/)"
        fi
    done

    echo ""
    echo ""
}

function inst_module_remove {
    # Support multiple modules; prompt if none specified.
    local modules=("$@")
    if [ ${#modules[@]} -eq 0 ]; then
        echo "Type the name(s) of the module(s) to remove"
        read -p "Insert name(s): " _line
        read -r -a modules <<< "$_line"
    fi

    local res
    for res in "${modules[@]}"; do
        [ -z "$res" ] && continue
        if Joiner:remove "$res"; then
            echo "[$res] Done, please re-run compiling"
        else
            echo "[$res] Cannot remove"
        fi
    done

    echo ""
    echo ""
}


function inst_simple_restarter {
    echo "Running $1 ..."
    bash "$AC_PATH_APPS/startup-scripts/src/simple-restarter" "$AC_BINPATH_FULL" "$1"
    echo
    #disown -a
    #jobs -l
}

function inst_download_client_data {
    # change the following version when needed
    local VERSION=v16

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
