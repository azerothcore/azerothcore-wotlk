
#!/usr/bin/env bash



CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

echo "> Init and updating submodules..."

function subrepoUpdate() {
    repo=$1
    branch=$2
    folder=$3

    toClone=$(git ls-remote --heads "$repo" "$branch" | wc -l)

    if [[ -d "$folder" ]]; then
        if [[ ! -f "$folder/.gitrepo" ]]; then
            git subrepo init "$folder" -r "$repo" -b "$branch"
        fi

        if [[ $toClone -eq 0 ]]; then
            git subrepo push "$folder"
        fi
    else
        # try-catch
        set +e
        git subrepo clone "$repo" "$folder" -b "$branch"
        set -e
    fi

    git subrepo clean "$folder"
    git subrepo pull "$folder"
    git subrepo push "$folder" -s
    git subrepo clean "$folder"
}
