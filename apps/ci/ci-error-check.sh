#!/usr/bin/env bash

DB_ERRORS_FILE="/home/travis/build/azerothcore/azerothcore-wotlk/env/dist/bin/DBErrors.log";
#DB_ERRORS_FILE="./env/dist/bin/DBErrors.log";

if [[ ! -f ${DB_ERRORS_FILE} ]]; then
    echo "File ${DB_ERRORS_FILE} not found!";
    exit 1
fi

if [[ -s ${DB_ERRORS_FILE} ]]; then
     printf "The DBErrors.log file contains startup errors:\n\n";
     cat ${DB_ERRORS_FILE};
     printf "\nPlease solve the startup errors listed above!\n";
     exit 1;
else
     echo "No startup errors found in DBErrors.log, good job!";
fi
