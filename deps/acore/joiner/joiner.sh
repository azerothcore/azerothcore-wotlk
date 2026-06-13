#!/usr/bin/env bash

#
# bash >= 4.x required
#

#
# DEFINES
#

# boolean bash convention ( inverse )
declare -A J_OPT;

TRUE=0
FALSE=1

J_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

unamestr=`uname`
if [ -z "$J_PATH_MODULES" ]; then
    if [[ "$unamestr" == 'Darwin' ]]; then
        J_PATH_MODULES=$(greadlink -f "$J_PATH/../../")
    else
        J_PATH_MODULES=$(readlink -f "$J_PATH/../../")
    fi
fi

for i in "$@"
do
case $i in
    --parent=*) #internally used
        J_OPT[parent]="${i#*=}"
        shift
    ;;
    --child=*) #internally used
        J_OPT[child]="${i#*=}"
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

J_PARAMS="$@"

function Joiner:is_submodule()
{
    path=$1
    (cd "$path" && cd "$(git rev-parse --show-toplevel 2>&1)/.."
    git rev-parse --is-inside-work-tree 2>&1) | grep -q true
}


function Joiner:_help() {
    hasReq=$1
    firstParam=$2
    msg=$3

    if [ $hasReq = false ]; then
        echo "Argument missing: $msg"
        exit 1
    fi

    if [[ "$firstParam" = "--help" || "$firstParam" = "-h" ]]; then
        echo "Help: $msg"
        exit 1
    fi
}

function Joiner:_searchFirstValiPath() {
    path="$1"
    until $(cd -- "$path")
    do
        case   "$path"  in(*[!/]/*)
            path="${path%/*}"
        ;;
        (*)
            ! break
    esac
    done  2>/dev/null
    echo "$path"
}

#
# JOINER FUNCTIONS
#

function Joiner:add_repo() (
    set -e
    url="$1"
    name=${2:-""}
    branch=${3:-"master"}
    basedir="${4:-""}"

    [[ -z $url ]] && hasReq=false || hasReq=true
    Joiner:_help "$hasReq" "$1" "Syntax: joiner.sh add-repo [-d] [-e] url name branch [basedir]"

    # retrieving info from url if not set
    if [[ -z $name ]]; then
        basename=$(basename "$url")
        name=${basename%%.*}

        if [[ -z "$basedir" ]]; then
            dir=$(dirname "$url")
            basedir=$(basename "$dir")
        fi

        name="${name,,}" #to lowercase
        basedir="${basedir,,}" #to lowercase
    fi

    path="$J_PATH_MODULES/$basedir/$name"
    changed="yes"

    if [ -e "$path/.git/" ]; then
        # if exists , update
        echo "Updating $name on branch $branch..."
        if ! git --git-dir="$path/.git/" --work-tree="$path" rev-parse >/dev/null 2>&1; then
            echo "Unable to read repository at $path/.git/"
            return $FALSE
        fi

        local pull_output
        if ! pull_output=$(git --git-dir="$path/.git/" --work-tree="$path" pull origin "$branch" 2>&1); then
            printf "%s\n" "$pull_output"
            return $FALSE
        fi

        printf "%s\n" "$pull_output"
        if echo "$pull_output" | grep -qE 'Already up[- ]to-date.'; then
            changed="no"
        fi
    else
        # otherwise clone
        echo "Cloning $name on branch $branch..."
        git clone "$url" -c advice.detachedHead=0 -b "$branch" "$path"
    fi

    if [ "$?" -ne "0" ]; then
        return $FALSE
    fi

    # parent/child to avoid redundancy
    [[ -f $path/install.sh && "$changed" = "yes"
    && "${J_OPT[parent]}" != "$path" && "${J_OPT[child]}" != "$path" ]] && bash "$path/install.sh" --child="${J_OPT[parent]}" --parent="$path" $J_PARAMS

    return $TRUE
)

function Joiner:add_git_submodule() (
    set -e
    url=$1
    name=${2:-""}
    branch=${3:-"master"}
    basedir=${4:-""}

    [[ -z $url ]] && hasReq=false || hasReq=true
    Joiner:_help "$hasReq" "$1" "Syntax: joiner.sh add-git-submodule [-d] [-e] url name branch [basedir]"

    # retrieving info from url if not set
    if [[ -z $name ]]; then
        basename=$(basename "$url")
        name=${basename%%.*}

        if [[ -z $basedir ]]; then
            dir=$(dirname "$url")
            basedir=$(basename "$dir")
        fi

        name="${name,,}" #to lowercase
        basedir="${basedir,,}" #to lowercase
    fi

    path="$J_PATH_MODULES/$basedir/$name"
    valid_path=`Joiner:_searchFirstValiPath "$path"`
    rel_path=${path#"$valid_path"}
    rel_path=${rel_path#/}

    if [ -e "$path/" ]; then
        # if exists , update
        (cd "$path" && git pull origin "$branch")
        (cd "$valid_path" && git submodule update -f --init "$rel_path")
    else
        # otherwise add
        (cd "$valid_path" && git submodule add -f -b "$branch" "$url" "$rel_path")
        (cd "$valid_path" && git submodule update -f --init "$rel_path")
    fi

    if [ "$?" -ne "0" ]; then
        return $FALSE
    fi

    # parent/child to avoid redundancy
    [[ -f $path/install.sh && "$changed" = "yes"
    && "${J_OPT[parent]}" != "$path" && "${J_OPT[child]}" != "$path" ]] && bash "$path/install.sh" --child="${J_OPT[parent]}" --parent="$path" $J_PARAMS

    return $TRUE
)

function Joiner:add_file() (
    set -e
    declare -A _OPT;
    for i in "$@"
    do
    case $i in
        --unzip|-z)
            _OPT[unzip]=true
            shift
        ;;
        *)
            # unknown option
        ;;
    esac
    done

    source=$1
    destination="$J_PATH_MODULES/$2"

    [[ -z $source ]] && hasReq=false || hasReq=true
    Joiner:_help $hasReq "$1" "Syntax: joiner.sh add-file [-d] [-e] [-z] source [destination]"

    if [[ "$destination" =~ '/'$ ]]; then
        mkdir -p "$destination"
    else
        mkdir -p "$(dirname $destination)"
    fi

    [ ! -e $J_PATH_MODULES/$2 ] && curl -o "$destination" "$source"

    if [ "${_OPT[unzip]}" = true ]; then
        dir=$(dirname $destination)
        unzip -d $dir $destination
        rm $destination

        filename=$(basename -- "$destination")
        newpath="$dir${filename%%.*}"

        # parent/child to avoid redundancy
        [[ -f $newpath/install.sh && "$changed" = "yes"
        && "${J_OPT[parent]}" != "$newpath" && "${J_OPT[child]}" != "$newpath" ]] && bash "$newpath/install.sh" --child="${J_OPT[parent]}" --parent="$newpath" $J_PARAMS
    fi

    if [ "$?" -ne "0" ]; then
        return $FALSE
    fi

    return $TRUE
)

function Joiner:upd_repo() (
    set -e
    url=$1
    name=${2:-""}
    branch=${3:-"master"}
    basedir=${4:-""}

    [[ -z $url ]] && hasReq=false || hasReq=true
    Joiner:_help $hasReq "$1" "Syntax: joiner.sh upd-repo [-d] [-e] url name branch [basedir]"

    # retrieving info from url if not set
    if [[ -z $name ]]; then
        basename=$(basename $url)
        name=${basename%%.*}

        if [[ -z $basedir ]]; then
            dir=$(dirname $url)
            basedir=$(basename $dir)
        fi

        name="${name,,}" #to lowercase
        basedir="${basedir,,}" #to lowercase
    fi

    path="$J_PATH_MODULES/$basedir/$name"

    if [[ -z $url ]]; then
        url=`git --git-dir="$path/.git" remote get-url origin`
    fi

    if [[ `Joiner:is_submodule "$path"` = true ]]; then
        Joiner:add_git_submodule $@
    else
        Joiner:add_repo $@
    fi

    if [ "$?" -ne "0" ]; then
        return $FALSE
    fi

    return $TRUE
)

function Joiner:remove() (
    set -e
    name=$1
    basedir=$2

    [[ -z $name ]] && hasReq=false || hasReq=true
    Joiner:_help $hasReq "$1" "Syntax: joiner.sh remove name [basedir]"

    path="$J_PATH_MODULES/$basedir/$name"

    if [ -d "$path" ]; then
        rm -r --interactive=never "$path"
        [[ -f $path/uninstall.sh ]] && bash "$path/uninstall.sh" $J_PARAMS
    elif [ -f "$path" ]; then
        rm --interactive=never "$path"
    else
        return $FALSE
    fi

    return $TRUE
)

function Joiner:with_dev() (
    set -e
    if [ "${J_OPT[dev]}" = true ]; then
        return $TRUE;
    else
        return $FALSE;
    fi
)

function Joiner:with_extras() (
    set -e
    if [ "${J_OPT[extra]}" = true ]; then
        return $TRUE;
    else
        return $FALSE;
    fi
)

#
# Parsing parameters
#
function Joiner:self_update() {
    if [ -e "$J_PATH/.git/" ]; then
        # self update
        if [ ! -z "$J_VER_REQ" ]; then
            # if J_VER_REQ is defined then update only if tag is different
            _cur_branch=`git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" rev-parse --abbrev-ref HEAD`
            _cur_ver=`git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" name-rev --tags --name-only "$_cur_branch"`
            if [ "$_cur_ver" != "$J_VER_REQ" ]; then
                git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" rev-parse && git --git-dir="$J_PATH/.git/" fetch --tags origin "$_cur_branch" --quiet
                git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" checkout "tags/$J_VER_REQ" -b "$_cur_branch"
            fi
        else
            # else always try to keep at latest available version (worst performances)

            git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" rev-parse && git --git-dir="$J_PATH/.git/" --work-tree="$J_PATH/" fetch origin "$_cur_branch" --quiet
        fi
    fi
}

function Joiner:_checkOptions() {
        for i in "$@"
        do
        case $i in
            -e=*|--extras=*)
                echo "Extras enabled"
                J_OPT[extra]="${i#*=}"
                shift
            ;;
            --dev|-d)
                echo "Development enabled"
                J_OPT[dev]=true
                shift
            ;;
            *)
                # unknown option
            ;;
        esac
        done
}

function Joiner:menu() {
    PS3='[Please enter your choice]: '
    options=(
        "add-repo (a): download and install a module from git repository."                  # 1
        "upd-repo (u): update a module."            # 2
        "add-git-submodule (s): download and install module from git repository as git submodule."                   # 3
        "add-file (f): download and install a file or zipped folder."           # 4
        "remove (r): uninstall and remove a module."               # 5
        "self-update (j): Update joiner version to the latest stable (master branch)"
        "quit: Exit from this menu"
        )

    function _switch() {
        _reply="$1"
        shift

        Joiner:_checkOptions

        _opt="$@"

        case $_reply in
            ""|"a"|"add-repo"|"1")
                Joiner:add_repo $_opt
                ;;
            ""|"u"|"upd-repo"|"2")
                Joiner:upd_repo $_opt
                ;;
            ""|"s"|"add-git-submodule"|"3")
                Joiner:add_git_submodule $_opt
                ;;
            ""|"f"|"add-file"|"4")
                Joiner:add_file $_opt
                ;;
            ""|"r"|"remove"|"5")
                Joiner:remove $_opt
                ;;
            ""|"j"|"self-update"|"6")
                Joiner:self_update
                ;;
            ""|"quit"|"7")
                echo "Goodbye!"
                exit
                ;;
            ""|"--help")
                echo "Available commands:"
                printf '%s\n' "${options[@]}"
                echo "Arguments:"
                echo "-d, --dev: install also dev dependencies"
                echo "-e, --extras: install extra dependencies (suggested by module)"
                echo "-z, --unzip: extract a zipped file downloaded by add-file command"
                ;;
            *) echo "invalid option, use --help option for the commands list";;
        esac
    }

    while true
    do
        # run option directly if specified in argument
        [ ! -z "$1" ] && _switch $@
        [ ! -z "$1" ] && exit 0

        echo ""
        echo "==== JOINER MENU ===="
        select opt in "${options[@]}"
        do
            echo ""
            _switch $REPLY
            break
        done
    done
}

# Call menu only when run from command line.
# if you wish to run joiner menu when sourced
# you must call the relative function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    Joiner:menu $@
else
    Joiner:_checkOptions $@
fi
