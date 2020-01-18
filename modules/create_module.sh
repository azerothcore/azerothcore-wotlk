#!/bin/bash

## TODO:
# - replace module name directly in the README.md (but must work on windows too) and MAYBE in include.sh and conf/ files, ( sed -i 's/MY_NEW_MODULE/$MODULE_NAME/gI'  README.md )
# - prompt for user name
# - prompt for keeping or removing other language README_X.md

## Just run it with bash or `git bash` on windows, and it will ask for the module's name and tada!

##------------------------------- VARIABLES ---------------------------------##

MODULE_TEMPLATE_URL="https://github.com/azerothcore/skeleton-module/"

GIT_COMMIT_MSG_SETUP="setup_git_commit_template.sh"

##------------------------------- CODE ---------------------------------##

read -p "--- Enter the name of your future module: " "MODULE_NAME"
echo $MODULE_NAME | fgrep -q ' '

while [ $? -eq 0 ]
do
  echo -e "\n--- Blanks are not allowed!"
  read -p "--- Enter the name of your future module: " MODULE_NAME
  echo $MODULE_NAME | fgrep -q ' '
done

if test -n "$MODULE_NAME"
then
    echo -e "\n--- Cloning 'skeleton-module' master branch as $MODULE_NAME/"
    git clone --depth 1 -b master "$MODULE_TEMPLATE_URL" $MODULE_NAME

    echo -e "\n--- Removing 'skeleton-module/.git/' history"
    cd $MODULE_NAME && rm -rf .git/

    echo -e "\n--- Removing 'skeleton-module' original README.md and preparing the new README.md"
    rm README.md README_ES.md
    mv README_example.md README.md
    mv README_example_ES.md README_ES.md

    echo -e "\n--- Initiating new git repository"
    git init
    git add -A
    ## DO NOT COMMIT FILES THAT REQUIRE MODIFICATION OR ARE NOT NEEDED
    git reset README* sql/README* include.sh
    git commit -m "init: Initial commit - $MODULE_NAME"

    echo -e "\n--- Configuring git for nice commit messages"
    source "$GIT_COMMIT_MSG_SETUP" || bash "$GIT_COMMIT_MSG_SETUP"

    echo -e "\n--- Recap"
    git log
    echo ""
    ls -la

    echo -e "\n--- You can remove the file \"sql/README.md\" if you have read it."
    echo -e "\n--- Ready to code!"
fi


# ## TODO Set the remote origin with username, repo url etc

    # $USER_NAME/$MODULE_NAME.git

    # echo "Do you want to set your git remote?"
    # select yn in "Yes" "No"; do
    #     case $yn in
    #         Yes )
    #             CONFIGURE_GIT=1; break;;
    #         No )
    #             CONFIGURE_GIT=0;
    #             exit;;
    #     esac
    # done


    # if test "$CONFIGURE_GIT" == "1"
    # then
    #     PS3='Where do you want to push your module?'
    #     options=("github.com" "gitlab.com" "bitbucket.org" "Quit")
    #     select opt in "${options[@]}"
    #     do
    #         case $opt in
    #             "github.com")
    #                 echo "you chose choice 1"
    #                 break
    #                 ;;
    #             "gitlab.com")
    #                 echo "you chose choice 2"
    #                 break
    #                 ;;
    #             "bitbucket.org")
    #                 echo "you chose choice $REPLY which is $opt"
    #                 break
    #                 ;;
    #             "Quit")
    #                 break
    #                 ;;
    #             *) echo "invalid option $REPLY";;
    #         esac
    #     done

    #     REMOTE_HOST="$opt"

    #     PS3='HTTPS or SSH?'
    #     options=("HTTPS (default)" "SSH" "Quit")
    #     select opt in "${options[@]}"
    #     do
    #         case $opt in
    #             "HTTPS")
    #                 echo "you chose choice 1"
    #                 break
    #                 ;;
    #             "SSH")
    #                 echo "you chose choice $REPLY which is $opt"
    #                 break
    #                 ;;
    #             "Quit")
    #                 break
    #                 ;;
    #             *) echo "invalid option $REPLY";;
    #         esac
    #     done

    #     REMOTE_PROTOCOL="$opt"
    # fi
