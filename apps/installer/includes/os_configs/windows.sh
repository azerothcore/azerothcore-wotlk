# install chocolatey before

# powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# install automatically following packages:
# cmake
# git
# microsoft-build-tools
# mysql

INSTALL_ARGS=()

if [[ $CONTINUOUS_INTEGRATION ]]; then
    INSTALL_ARGS+=(--no-progress)
else
    { # try
        choco uninstall -y -n cmake.install cmake # needed to make sure that following install set the env properly
    } || { # catch
        echo "nothing to do"
    }

    choco install -y --skip-checksums "${INSTALL_ARGS[@]}"  git visualstudio2022community
fi

choco install -y --skip-checksums "${INSTALL_ARGS[@]}"  cmake.install -y --installargs 'ADD_CMAKE_TO_PATH=System'
choco install -y --skip-checksums "${INSTALL_ARGS[@]}"  visualstudio2022-workload-nativedesktop
choco install -y --skip-checksums "${INSTALL_ARGS[@]}"  openssl --force --version=3.6.1
choco install -y --skip-checksums "${INSTALL_ARGS[@]}"  boost-msvc-14.3 --force --version=1.87.0
choco install -y --skip-checksums "${INSTALL_ARGS[@]}"  mysql --force --version=8.4.6
