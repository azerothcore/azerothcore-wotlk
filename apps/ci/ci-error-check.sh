#!/usr/bin/env bash

ERRORS_FILE="./env/dist/bin/Errors.log";

echo "Checking Startup Errors"
echo

if [[ -s ${ERRORS_FILE} ]]; then
     printf "The StartupErrors.log file contains startup errors:\n\n";
     cat ${ERRORS_FILE};
     printf "\nPlease solve the startup errors listed above!\n";
     exit 1;
else
     echo "> No startup errors found in Errors.log";
fi
done

echo
echo "Done"
