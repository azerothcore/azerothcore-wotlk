#!/usr/bin/env bash

## Set a local git commit template
git config --local commit.template ".git_commit_template.txt" ;
echo "--- Successfully set the default commit template for this AzerothCore repository only. Verify with: git config -e"
