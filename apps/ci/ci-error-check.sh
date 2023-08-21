#!/usr/bin/env bash

STARTUP_ERRORS_FILE="./env/dist/bin/StartupErrors.log";

echo "Checking Startup Errors"
echo

if [[ -s ${STARTUP_ERRORS_FILE} ]]; then
     printf "The StartupErrors.log file contains errors:\n\n";
     cat ${STARTUP_ERRORS_FILE};
     printf "\nPlease solve the startup errors listed above!\n";
     exit 1;
else
     echo "> No startup errors found in StartupErrors.log";
fi
done

echo
echo "Done"
