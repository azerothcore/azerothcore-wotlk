#!/bin/bash

# Bash strict mode 
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

function download_client_data {
    VERSION="${VERSION:-v16}"
    DATAPATH="${DATAPATH:-/azerothcore/env/dist/data}"
    DATAPATH_ZIP="${DATAPATH_ZIP:-/tmp/data.zip}"
    
    local dataVersionFile="$DATAPATH/data-version"
    local INSTALLED_VERSION="false"


    cat << EOF
##########################
# Client data downloader #
##########################

version = $VERSION
EOF


    mkdir -pv "$DATAPATH"

    if [ -f "$dataVersionFile" ]; then 
      source "$dataVersionFile"
    fi

    if [ "$VERSION" == "$INSTALLED_VERSION" ]; then
      cat << EOF
Client data $VERSION is already installed. 

If you want to force the download, remove the data version file located at $dataVersionFile:

$ rm $dataVersionFile
EOF
        return
    fi

    echo "Downloading client data to $DATAPATH_ZIP..."
    curl -L -# -o "$DATAPATH_ZIP" \
      "https://github.com/wowgaming/client-data/releases/download/$VERSION/data.zip"
    echo "Download finished"
    echo "Extracting client data to $DATAPATH..."

    unzip -q -o "$DATAPATH_ZIP" -d "$DATAPATH/"

    echo "Client data successfully extracted to $DATAPATH"
    echo "Cleanup file at $DATAPATH_ZIP"
    rm "$DATAPATH_ZIP"
    echo "INSTALLED_VERSION=$VERSION" > "$dataVersionFile"
}

download_client_data
