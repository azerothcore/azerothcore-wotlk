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
            echo "  ./acore.sh module install  [--all | modules...]"
            echo "      modules can be specified as: name[:branch[:commit]]"
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
# Parse a module spec of the form: name[:branch[:commit]]
# Prints: "name branch commit" (empty fields if omitted)
function inst_parse_module_spec() {
    local spec="$1"
    local parts i n repo_part branch commit
    IFS=':' read -r -a parts <<< "$spec"
    n=${#parts[@]}
    # Default values
    commit=""
    branch=""
    repo_part=""

    # Detect URL-like specs which contain '://' or start with git@ (they include ':' in the URL)
    if [[ "$spec" =~ :// ]] || [[ "$spec" =~ ^git@ ]]; then
        # For URL forms, repo is comprised by the first two parts when splitting by ':'
        # e.g. git@github.com:owner/name.git[:branch[:commit]] -> parts[0]=git@github.com, parts[1]=owner/name.git
        if (( n >= 3 )); then
            # repo is parts[0] + ':' + parts[1]
            repo_part="${parts[0]}:${parts[1]}"
            if (( n == 3 )); then
                branch="${parts[2]}"
            elif (( n >= 4 )); then
                # last may be commit
                last="${parts[n-1]}"
                prev="${parts[n-2]}"
                if [[ "$last" =~ ^[0-9a-fA-F]{7,40}$ ]]; then
                    commit="$last"
                    branch="$prev"
                else
                    branch="$last"
                fi
            fi
        elif (( n == 2 )); then
            repo_part="${parts[0]}:${parts[1]}"
        else
            repo_part="$spec"
        fi
    else
        # Non-URL form: owner/name or name[:branch[:commit]]
        if (( n >= 3 )); then
            last="${parts[n-1]}"
            prev="${parts[n-2]}"
            if [[ "$last" =~ ^[0-9a-fA-F]{7,40}$ ]]; then
                commit="$last"
                branch="$prev"
                repo_part="${parts[0]}"
                for ((i=1;i<=n-3;i++)); do repo_part+=":${parts[i]}"; done
            else
                branch="$last"
                repo_part="${parts[0]}"
                for ((i=1;i<=n-2;i++)); do repo_part+=":${parts[i]}"; done
            fi
        elif (( n == 2 )); then
            repo_part="${parts[0]}"
            branch="${parts[1]}"
        else
            repo_part="${parts[0]}"
        fi
    fi

    # Normalize repo reference and extract owner/name.
    local repo_ref owner name url owner_repo
    repo_ref="$repo_part"

    # If repo_ref is a URL, extract owner/name from path when possible
    if [[ "$repo_ref" =~ :// ]] || [[ "$repo_ref" =~ ^git@ ]]; then
        # Extract owner/name (last two path components)
        owner_repo=$(echo "$repo_ref" | sed -E 's#(git@[^:]+:|https?://[^/]+/|ssh://[^/]+/)?(.*?)(\.git)?$#\2#')
        owner="$(echo "$owner_repo" | awk -F'/' '{print $(NF-1)}')"
        name="$(echo "$owner_repo" | awk -F'/' '{print $NF}' | sed -E 's/\.git$//')"
    else
        owner_repo="$repo_ref"
        if [[ "$owner_repo" == *"/"* ]]; then
            owner="$(echo "$owner_repo" | cut -d'/' -f1)"
            name="$(echo "$owner_repo" | cut -d'/' -f2)"
        else
            owner="azerothcore"
            name="$owner_repo"
            repo_ref="$owner/$name"
        fi
    fi

    # Build URL only if repo_ref is not already a URL
    if [[ "$repo_ref" =~ :// ]] || [[ "$repo_ref" =~ ^git@ ]]; then
        url="$repo_ref"
    else
        url="https://github.com/${repo_ref}"
    fi

    echo "$repo_ref" "$owner" "$name" "${branch:--}" "${commit:--}" "$url"
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

# ----------------------------------------------
# Modules list helpers (branch + commit tracking)
# ----------------------------------------------

# Extract owner/name from any repository reference (URL, owner/name, or simple name)
# This enables intelligent matching regardless of how the module was specified
function inst_extract_owner_name() {
    local spec="$1"
    
    # If it's already in owner/name format (and not a URL)
    if [[ "$spec" =~ ^[^/]+/[^/]+$ ]] && [[ ! "$spec" =~ :// ]] && [[ ! "$spec" =~ ^git@ ]]; then
        echo "$spec"
        return
    fi
    
    # If it's just a name, add default azerothcore owner
    if [[ ! "$spec" =~ [/:] ]]; then
        echo "azerothcore/$spec"
        return
    fi
    
    # Extract from URL (any git host)
    local path
    if [[ "$spec" =~ ^git@ ]]; then
        # git@host:owner/name.git -> owner/name.git
        path="${spec#*:}"
    elif [[ "$spec" =~ :// ]]; then
        # https://host/owner/name.git -> extract path after host
        # Remove protocol and host, keep only path
        path="${spec}"
        path="${path#*://}"      # Remove protocol
        path="${path#*/}"        # Remove host
        # Now we have owner/name.git or similar
    else
        # Fallback for other formats
        path="$spec"
    fi
    
    # Remove .git extension and any query parameters
    path="${path%.git}"
    path="${path%\?*}"  # remove query params
    path="${path%\#*}"  # remove fragments
    
    echo "$path"
}

# Check if a module is already installed by comparing owner/name
# Returns the existing repo_ref if found, empty if not found
function inst_mod_is_installed() {
    local spec="$1"
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$spec")
    
    # Use a different approach: read into a variable first, then process
    local modules_content
    modules_content=$(inst_mod_list_read)
    
    # Process each line
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        read -r repo_ref branch commit <<< "$line"
        local existing_owner_name
        existing_owner_name=$(inst_extract_owner_name "$repo_ref")
        if [[ "$existing_owner_name" == "$target_owner_name" ]]; then
            echo "$repo_ref"  # Return the existing entry
            return 0
        fi
    done <<< "$modules_content"
    
    return 1
}

# Returns path to modules list file (configurable via MODULES_LIST_FILE).
function inst_modules_list_path() {
    local path="${MODULES_LIST_FILE:-"$AC_PATH_ROOT/conf/modules.list"}"
    echo "$path"
}

# Ensure the modules list file exists and its directory is created.
function inst_mod_list_ensure() {
    local file
    file="$(inst_modules_list_path)"
    mkdir -p "$(dirname "$file")"
    [ -f "$file" ] || touch "$file"
}

# Read modules list into stdout as triplets: "name branch commit"
# Skips comments (# ...) and blank lines.
function inst_mod_list_read() {
    local file
    file="$(inst_modules_list_path)"
    [ -f "$file" ] || return 0
    # shellcheck disable=SC2013
    while IFS= read -r line; do
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        echo "$line"
    done < "$file"
}

# Add or update an entry in the list: repo_ref branch commit
# Removes any existing entries with the same owner/name to avoid duplicates
function inst_mod_list_upsert() {
    local repo_ref="$1"; shift
    local branch="$1"; shift
    local commit="$1"; shift
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$repo_ref")
    
    inst_mod_list_ensure
    local file tmp
    file="$(inst_modules_list_path)"
    tmp="${file}.tmp"

    # Remove any existing entries with same owner/name, then add new entry
    {
        inst_mod_list_read | while read -r existing_ref existing_branch existing_commit; do
            local existing_owner_name
            existing_owner_name=$(inst_extract_owner_name "$existing_ref")
            if [[ "$existing_owner_name" != "$target_owner_name" ]]; then
                echo "$existing_ref $existing_branch $existing_commit"
            fi
        done
        # Add the new entry (preserving original repo_ref format)
        echo "$repo_ref $branch $commit"
    } > "$tmp" && mv "$tmp" "$file"
}

# Remove an entry from the list by matching owner/name.
# This allows removing modules regardless of how they were specified (URL vs owner/name)
function inst_mod_list_remove() {
    local repo_ref="$1"
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$repo_ref")
    
    local file
    file="$(inst_modules_list_path)"
    [ -f "$file" ] || return 0
    
    local tmp="${file}.tmp"
    
    # Keep only lines where owner/name doesn't match
    inst_mod_list_read | while read -r existing_ref existing_branch existing_commit; do
        local existing_owner_name
        existing_owner_name=$(inst_extract_owner_name "$existing_ref")
        if [[ "$existing_owner_name" != "$target_owner_name" ]]; then
            echo "$existing_ref $existing_branch $existing_commit"
        fi
    done > "$tmp" && mv "$tmp" "$file"
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
    # Support multiple modules and the --all flag; prompt if none specified.
    local args=("$@")
    local use_all=false
    if [ ${#args[@]} -gt 0 ] && { [ "${args[0]}" = "--all" ] || [ "${args[0]}" = "-a" ]; }; then
        use_all=true
        shift || true
    fi

    local modules=("$@")

    echo "Installing modules: ${modules[*]}"

    if $use_all; then
        # Install all modules from the list (respecting recorded branch and commit).
        inst_mod_list_ensure
        local line name branch commit
        while read -r line; do
            [ -z "$line" ] && continue
            repo_ref=$(echo "$line" | awk '{print $1}')
            branch=$(echo "$line" | awk '{print $2}')
            commit=$(echo "$line" | awk '{print $3}')
            parsed_output=$(inst_parse_module_spec "$repo_ref")
            IFS=' ' read -r _ owner modname _ _ url <<< "$parsed_output"
            basedir="$owner"
            if [ -d "$J_PATH_MODULES/$basedir/$modname" ]; then
                echo "[$repo_ref] Already installed (skipping)."
                continue
            fi
            if Joiner:add_repo "$url" "$modname" "$branch" "$basedir"; then
                # Checkout the recorded commit if present
                if [ -n "$commit" ]; then
                    git -C "$J_PATH_MODULES/$basedir/$modname" fetch --all --quiet || true
                    if git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse --verify "$commit" >/dev/null 2>&1; then
                        git -C "$J_PATH_MODULES/$basedir/$modname" checkout --quiet "$commit"
                    fi
                fi
                local curCommit
                curCommit=$(git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$branch" "$curCommit"
                echo "[$repo_ref] Installed."
            else
                echo "[$repo_ref] Install failed."
            fi
        done < <(inst_mod_list_read)
    else
        # Install specified modules; prompt if none specified.
        if [ ${#modules[@]} -eq 0 ]; then
            echo "Type the name(s) of the module(s) to install"
            read -p "Insert name(s): " _line
            read -r -a modules <<< "$_line"
        fi

        local spec name override_branch override_commit v b def curCommit existing_repo_ref
        for spec in "${modules[@]}"; do
            [ -z "$spec" ] && continue
            
            # Check if module is already installed (by owner/name matching)
            existing_repo_ref=$(inst_mod_is_installed "$spec" || true)
            if [ -n "$existing_repo_ref" ]; then
                echo "[$spec] Already installed as [$existing_repo_ref] (skipping)."
                continue
            fi
            
            parsed_output=$(inst_parse_module_spec "$spec")
            IFS=' ' read -r repo_ref owner modname override_branch override_commit url <<< "$parsed_output"
            [ -z "$repo_ref" ] && continue

            # override_branch takes precedence; otherwise consult acore-module.json on azerothcore unless repo_ref contains owner or URL
            if [ -n "$override_branch" ] && [ "$override_branch" != "-" ]; then
                b="$override_branch"
            else
                # For GitHub repositories, use raw.githubusercontent.com to check acore-module.json
                if [[ "$url" =~ github.com ]] || [[ "$repo_ref" =~ ^[^/]+/[^/]+$ ]]; then
                    read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/${owner}/${modname}/master/acore-module.json")
                else
                    # Unknown host: try the repository URL as-is (may fail)
                    read v b < <(inst_getVersionBranch "${url}/master/acore-module.json")
                fi
                if [[ "$v" == "none" || "$v" == "not-defined" || "$b" == "none" ]]; then
                    def="$(inst_get_default_branch "$repo_ref")"
                    echo "Warning: $repo_ref has no compatible acore-module.json; installing from branch '$def' (latest commit)."
                    b="$def"
                fi
            fi

            basedir="$owner"
            if [ -d "$J_PATH_MODULES/$basedir/$modname" ]; then
                echo "[$repo_ref] Already installed (skipping)."
                curCommit=$(git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$b" "$curCommit"
                continue
            fi

            if Joiner:add_repo "$url" "$modname" "$b" "$basedir"; then
                # If a commit was provided, try to checkout it
                if [ -n "$override_commit" ] && [ "$override_commit" != "-" ]; then
                    git -C "$J_PATH_MODULES/$basedir/$modname" fetch --all --quiet || true
                    if git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse --verify "$override_commit" >/dev/null 2>&1; then
                        git -C "$J_PATH_MODULES/$basedir/$modname" checkout --quiet "$override_commit"
                    else
                        echo "[$repo_ref] Warning: provided commit '$override_commit' not found; staying on branch '$b' HEAD."
                    fi
                fi
                curCommit=$(git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$b" "$curCommit"
                echo "[$repo_ref] Done, please re-run compiling and db assembly. Read instructions on module repository for more information"
            else
                echo "[$repo_ref] Install failed or module not found"
            fi
        done
    fi

    echo ""
    echo ""
}

function inst_module_update {
    # Support multiple modules and the --all flag; prompt if none specified.
    local args=("$@")
    local use_all=false
    if [ ${#args[@]} -gt 0 ] && { [ "${args[0]}" = "--all" ] || [ "${args[0]}" = "-a" ]; }; then
        use_all=true
        shift || true
    fi

    local _tmp=$PWD

    if $use_all; then
        local line repo_ref branch commit newCommit owner modname url
        while read -r line; do
            [ -z "$line" ] && continue
            repo_ref=$(echo "$line" | awk '{print $1}')
            branch=$(echo "$line" | awk '{print $2}')
            commit=$(echo "$line" | awk '{print $3}')
            parsed_output=$(inst_parse_module_spec "$repo_ref")
            IFS=' ' read -r _ owner modname _ _ url <<< "$parsed_output"

            basedir="$owner"
            if [ ! -d "$J_PATH_MODULES/$basedir/$modname/" ]; then
                echo "[$repo_ref] Not installed locally, skipping."
                continue
            fi

            if Joiner:upd_repo "$url" "$modname" "$branch" "$basedir"; then
                newCommit=$(git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$branch" "$newCommit"
                echo "[$repo_ref] Updated to latest commit on '$branch'."
            else
                echo "[$repo_ref] Cannot update"
            fi
        done < <(inst_mod_list_read)
    else
        local modules=("$@")
        if [ ${#modules[@]} -eq 0 ]; then
            echo "Type the name(s) of the module(s) to update"
            read -p "Insert name(s): " _line
            read -r -a modules <<< "$_line"
        fi

        local spec repo_ref override_branch override_commit owner modname url v b branch def newCommit
        for spec in "${modules[@]}"; do
            [ -z "$spec" ] && continue
            parsed_output=$(inst_parse_module_spec "$spec")
            IFS=' ' read -r repo_ref owner modname override_branch override_commit url <<< "$parsed_output"

            basedir="$owner"
            if [ -d "$J_PATH_MODULES/$basedir/$modname/" ]; then
                # determine preferred branch if not provided
                if [ -n "$override_branch" ] && [ "$override_branch" != "-" ]; then
                    b="$override_branch"
                else
                    # try reading acore-module.json for this repo
                    if [[ "$url" =~ github.com ]]; then
                        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/${owner}/${modname}/master/acore-module.json")
                    else
                        read v b < <(inst_getVersionBranch "${url}/master/acore-module.json")
                    fi
                    if [[ "$v" == "none" || "$v" == "not-defined" || "$b" == "none" ]]; then
                        if branch=$(git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse --abbrev-ref HEAD 2>/dev/null); then
                            echo "Warning: $repo_ref has no compatible acore-module.json; updating current branch '$branch'."
                            b="$branch"
                        else
                            def="$(inst_get_default_branch "$repo_ref")"
                            echo "Warning: $repo_ref has no compatible acore-module.json and no git branch detected; updating default branch '$def'."
                            b="$def"
                        fi
                    fi
                fi

                if Joiner:upd_repo "$url" "$modname" "$b" "$basedir"; then
                    newCommit=$(git -C "$J_PATH_MODULES/$basedir/$modname" rev-parse HEAD 2>/dev/null || echo "")
                    inst_mod_list_upsert "$repo_ref" "$b" "$newCommit"
                    echo "[$repo_ref] Done, please re-run compiling and db assembly"
                else
                    echo "[$repo_ref] Cannot update"
                fi
            else
                echo "[$repo_ref] Cannot update! Path doesn't exist ($J_PATH_MODULES/$basedir/$modname/)"
            fi
        done
    fi

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

    local spec repo_ref owner modname url override_branch override_commit
    for spec in "${modules[@]}"; do
        [ -z "$spec" ] && continue
        parsed_output=$(inst_parse_module_spec "$spec")
        IFS=' ' read -r repo_ref owner modname override_branch override_commit url <<< "$parsed_output"
        [ -z "$repo_ref" ] && continue
        
        basedir="$owner"
        if Joiner:remove "$modname" "$basedir"; then
            inst_mod_list_remove "$repo_ref"
            echo "[$repo_ref] Done, please re-run compiling"
        else
            echo "[$repo_ref] Cannot remove"
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
