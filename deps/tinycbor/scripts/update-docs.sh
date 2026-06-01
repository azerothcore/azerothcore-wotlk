#!/bin/sh -ex
tuple="$TRAVIS_BRANCH${TRAVIS_TAG:+tag:$TRAVIS_TAG},$TRAVIS_PULL_REQUEST"
case "$tuple" in
    dev,false|main,false|tag:*)
        ;;
    *)
        exit 0
        ;;
esac
V=`cut -f1-2 -d. <VERSION`
git fetch origin gh-pages

# Fail if the library sizes file isn't present
test -r sizes

# Run doxygen (maybe)
if [ -n "${TRAVIS_TAG-$FORCE_DOCS}" ] && make -s docs 2>/dev/null; then
    git checkout -b gh-pages FETCH_HEAD
    if [ -d "$V" ]; then
        mv "$V" "old-$V"
    fi
    mv doc/html "$V"
    git add -A "$V"
else
    git checkout -b gh-pages FETCH_HEAD
    mkdir -p "$V"
fi

# Update the symlink for the branch name
rm -f "./$TRAVIS_BRANCH"
ln -s "$V" "$TRAVIS_BRANCH"
git add "./$TRAVIS_BRANCH"

# Update the library sizes file
# (will fail if the release build failed)
mkdir -p "library_sizes/$TRAVIS_BRANCH"
mv sizes "library_sizes/$TRAVIS_BRANCH/$QMAKESPEC"
(cd "library_sizes/$TRAVIS_BRANCH/";
 for f in *; do echo "$f:"; cat  "$f" ; done) > "$V/library_sizes.txt"
git add "library_sizes/$TRAVIS_BRANCH" "$V/library_sizes.txt"
git diff --cached -U0 "$V/library_sizes.txt"

# Commit everything
if git commit -m "Update docs for $V (Travis build $TRAVIS_BUILD_NUMBER)

Matching commit $TRAVIS_COMMIT:
$TRAVIS_COMMIT_MESSAGE"; then
    # We've made a commit, push it
    set +x
    url=`git config --get remote.origin.url | sed -e s,://github,://$GITHUB_AUTH@github,`
    git push "$url" @:gh-pages
fi
