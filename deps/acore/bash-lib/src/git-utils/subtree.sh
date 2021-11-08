function subtreeFlow {
    local name=$1
    local path=$2
    local repo=$3
    local branch=$4
    local prefix="$path/$name"

    echo "> Adding subtree if not exists"
    git subtree add   --prefix "$prefix" "$repo" "$branch"
    echo "> Pulling latest changes from remote subtree"
    git subtree pull  --prefix "$prefix" "$repo" "$branch"
}
