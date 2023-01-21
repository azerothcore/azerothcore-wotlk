#!/bin/bash

CURRENT_LOCATION=`pwd`

cd $CURRENT_LOCATION

all()
{
    echo ""
    echo "         All files"
    createDirectory
    baseFiles
    updatesFiles
}

bases()
{
    echo ""
    echo "         All bases files"
    createDirectory
    baseFiles
}

customs()
{
    echo ""
    echo "         All customs files"
    createDirectory
    customFiles
}

updates()
{
    echo ""
    echo "         All updates files"
    createDirectory
    updatesFiles
}

leave()
{
    echo ""
    echo -e "\e[1;32m"
    echo "         Good bye. Thank you for using our script."
}

invalid()
{
    echo ""
    echo -e "\e[1;31m"
    echo "         Invalid option. You must run the script again"
}

createDirectory()
{
    cd ..
    cd env/dist/
    if [ -d sql ]; then
        rm -rf sql
        mkdir sql
    else
        mkdir sql
    fi
}

baseFiles()
{
    assembler data/sql/base/db_auth/ env/sql/auth_base.sql
    assembler data/sql/base/db_characters/ env/sql/characters_base.sql
    assembler data/sql/base/db_world/ env/sql/world_base.sql
}

customFiles()
{
    assembler data/sql/custom/db_auth/ env/sql/auth_custom.sql
    assembler data/sql/custom/db_characters/ env/sql/characters_custom.sql
    assembler data/sql/custom/db_world/ env/sql/world_custom.sql
}

updatesFiles()
{
    assembler data/sql/updates/db_auth env/sql/auth_updates.sql
    assembler data/sql/updates/db_characters env/sql/characters_updates.sql
    assembler data/sql/updates/db_world env/sql/world_updates.sql
}

assembler()
{
    if [[ `find $1 -type f -iname "*.sql" | wc -l` -gt 0 ]]; then
        cat $1/*.sql > $2
    fi
}

clear
echo ""
echo -e "\e[1;37m"
echo "         Remember that the files are generated in the env folder."
echo "         That is in the root of the project. Just at the same height as src."
echo -e "\e[1;32m"
echo "         ------  DB Assembler Version 1  ------"
echo ""
echo "         1. Assemble all SQL (Base, Custom and Updates)"
echo "         2. Assemble only base files"
echo "         3. Assemble only custom files"
echo "         4. Assemble only updates files"
echo "         5. Exit"
echo ""
echo -e "\e[1;37m"
read -p "         Choose a number from 1 to 3: " opcion

case $opcion in
    1) all ;;
    2) bases ;;
    3) customs ;;
    4) updates ;;
    5) leave ;;
    *) invalid ;;
esac
