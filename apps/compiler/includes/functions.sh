
function comp_clean() {
  DIRTOCLEAN=${BUILDPATH:-var/build/obj}
  PATTERN="$DIRTOCLEAN/*"

  echo "Cleaning build files in $DIRTOCLEAN"

  [ -d "$DIRTOCLEAN" ] && rm -rf $PATTERN
}

function comp_ccacheEnable() {
    [ "$AC_CCACHE" != true ] && return

    export CCACHE_MAXSIZE=${CCACHE_MAXSIZE:-'1000MB'}
    #export CCACHE_DEPEND=true
    export CCACHE_SLOPPINESS=${CCACHE_SLOPPINESS:-pch_defines,time_macros,include_file_mtime}
    export CCACHE_CPP2=${CCACHE_CPP2:-true} # optimization for clang
    export CCACHE_COMPRESS=${CCACHE_COMPRESS:-1}
    export CCACHE_COMPRESSLEVEL=${CCACHE_COMPRESSLEVEL:-9}
    export CCACHE_COMPILERCHECK=${CCACHE_COMPILERCHECK:-content}
    export CCACHE_LOGFILE=${CCACHE_LOGFILE:-"$CCACHE_DIR/cache.debug"}
    #export CCACHE_NODIRECT=true

    export CCUSTOMOPTIONS="$CCUSTOMOPTIONS -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache"
}

function comp_ccacheClean() {
    [ "$AC_CCACHE" != true ] && echo "ccache is disabled" && return

    echo "Cleaning ccache"
    ccache -C
    ccache -s
}

function comp_ccacheResetStats() {
    [ "$AC_CCACHE" != true ] && return

    ccache -zc
}

function comp_ccacheShowStats() {
    [ "$AC_CCACHE" != true ] && return

    ccache -s
}

function comp_configure() {
  CWD=$(pwd)

  cd $BUILDPATH

  echo "Build path: $BUILDPATH"
  echo "DEBUG info: $CDEBUG"
  echo "Compilation type: $CTYPE"
  echo "CCache: $AC_CCACHE"
  # -DCMAKE_BUILD_TYPE=$CCTYPE disable optimization "slow and huge amount of ram"
  # -DWITH_COREDEBUG=$CDEBUG compiled with debug information

  #-DSCRIPTS_COMMANDS=$CSCRIPTS -DSCRIPTS_CUSTOM=$CSCRIPTS -DSCRIPTS_EASTERNKINGDOMS=$CSCRIPTS -DSCRIPTS_EVENTS=$CSCRIPTS -DSCRIPTS_KALIMDOR=$CSCRIPTS \
  #-DSCRIPTS_NORTHREND=$CSCRIPTS -DSCRIPTS_OUTDOORPVP=$CSCRIPTS -DSCRIPTS_OUTLAND=$CSCRIPTS -DSCRIPTS_PET=$CSCRIPTS -DSCRIPTS_SPELLS=$CSCRIPTS -DSCRIPTS_WORLD=$CSCRIPTS \
  #-DAC_WITH_UNIT_TEST=$CAC_UNIT_TEST -DAC_WITH_PLUGINS=$CAC_PLG \

  local DCONF=""
  if [ ! -z "$CONFDIR" ]; then
    DCONF="-DCONF_DIR=$CONFDIR"
  fi

  comp_ccacheEnable

  OSOPTIONS=""


    echo "Platform: $OSTYPE"
    case "$OSTYPE" in
      darwin*)
        OSOPTIONS=" -DMYSQL_ADD_INCLUDE_PATH=/usr/local/include -DMYSQL_LIBRARY=/usr/local/lib/libmysqlclient.dylib -DREADLINE_INCLUDE_DIR=/usr/local/opt/readline/include -DREADLINE_LIBRARY=/usr/local/opt/readline/lib/libreadline.dylib -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl@1.1/include -DOPENSSL_SSL_LIBRARIES=/usr/local/opt/openssl@1.1/lib/libssl.dylib -DOPENSSL_CRYPTO_LIBRARIES=/usr/local/opt/openssl@1.1/lib/libcrypto.dylib "
        ;;
      msys*)
        OSOPTIONS=" -DMYSQL_INCLUDE_DIR=C:\tools\mysql\current\include -DMYSQL_LIBRARY=C:\tools\mysql\current\lib\mysqlclient.lib "
        ;;
    esac

  cmake $SRCPATH -DCMAKE_INSTALL_PREFIX=$BINPATH $DCONF \
  -DAPPS_BUILD=$CAPPS_BUILD \
  -DTOOLS_BUILD=$CTOOLS_BUILD \
  -DSCRIPTS=$CSCRIPTS \
  -DMODULES=$CMODULES \
  -DBUILD_TESTING=$CBUILD_TESTING \
  -DUSE_SCRIPTPCH=$CSCRIPTPCH \
  -DUSE_COREPCH=$CCOREPCH \
  -DCMAKE_BUILD_TYPE=$CTYPE \
  -DWITH_WARNINGS=$CWARNINGS \
  -DCMAKE_C_COMPILER=$CCOMPILERC \
  -DCMAKE_CXX_COMPILER=$CCOMPILERCXX \
  $CBUILD_APPS_LIST $CBUILD_TOOLS_LIST $OSOPTIONS $CCUSTOMOPTIONS

  cd $CWD

  runHooks "ON_AFTER_CONFIG"
}

function comp_compile() {
  [ $MTHREADS == 0 ] && MTHREADS=$(grep -c ^processor /proc/cpuinfo) && MTHREADS=$(($MTHREADS + 2))

  echo "Using $MTHREADS threads"

  pushd "$BUILDPATH" >> /dev/null || exit 1

  comp_ccacheEnable

  comp_ccacheResetStats

  time cmake --build . --config $CTYPE  -j $MTHREADS

  comp_ccacheShowStats

  echo "Platform: $OSTYPE"
  case "$OSTYPE" in
    msys*)
      cmake --install . --config $CTYPE

      popd >> /dev/null || exit 1

      echo "Done"
      ;;
    linux*|darwin*)
      local confDir=${CONFDIR:-"$AC_BINPATH_FULL/../etc"}

      # create the folders before installing to
      # set the current user and permissions
      echo "Creating $AC_BINPATH_FULL..."
      mkdir -p "$AC_BINPATH_FULL"
      echo "Creating $confDir..."
      mkdir -p "$confDir"

      echo "Cmake install..."
      sudo cmake --install . --config $CTYPE

      popd >> /dev/null || exit 1

      # set all aplications SUID bit
      echo "Setting permissions on binary files"
      find "$AC_BINPATH_FULL"  -mindepth 1 -maxdepth 1 -type f -exec sudo chown root:root -- {} +
      find "$AC_BINPATH_FULL"  -mindepth 1 -maxdepth 1 -type f -exec sudo chmod u+s  -- {} +

      DOCKER_ETC_FOLDER=${DOCKER_ETC_FOLDER:-"env/dist/etc"}

      if [[ $DOCKER = 1 && $DISABLE_DOCKER_CONF != 1 ]]; then
        echo "Generating confs..."

        # Search for all configs under DOCKER_ETC_FOLDER
        for dockerdist in "$DOCKER_ETC_FOLDER"/*.dockerdist; do
          # Grab "base" conf. turns foo.conf.dockerdist into foo.conf
          baseConf="$(echo "$dockerdist" | rev | cut -f1 -d. --complement | rev)"
          # env/dist/etc/foo.conf becomes foo.conf
          filename="$(basename "$baseConf")"
          # the dist files should be always found inside $confDir
          # which may not be the same as DOCKER_ETC_FOLDER
          distPath="$confDir/$filename.dist"
          # if dist file doesn't exist, skip this iteration
          [ ! -f "$distPath" ] && continue

          # replace params in foo.conf.dist with params in foo.conf.dockerdist
          conf_layer "$dockerdist" "$distPath" " # Copied from dockerdist"

          # Copy modified dist file to $confDir/$filename
          # Don't overwrite foo.conf if it already exists.
          cp --no-clobber --verbose "$distPath" "$confDir/$filename"
        done
      fi

      echo "Done"
      ;;
  esac

  runHooks "ON_AFTER_BUILD"
}

function comp_build() {
  comp_configure
  comp_compile
}

function comp_all() {
  comp_clean
  comp_build
}

# conf_layer FILENAME FILENAME
# Layer the configuration parameters from the first argument onto the second argument
function conf_layer() {
  LAYER="$1"
  BASE="$2"
  COMMENT="$3"

  # Loop over all defined params in conf file
  grep -E "^[a-zA-Z\.0-9]+\s*=.*$" "$LAYER" \
    | while read -r param
      do
        # remove spaces from param
        # foo       = bar becomes foo=bar
        NOSPACE="$(tr -d '[:space:]' <<< "$param")"

        # split into key and value
        KEY="$(cut -f1 -d= <<< "$NOSPACE")"
        VAL="$(cut -f2 -d= <<< "$NOSPACE")"
        # if key in base and val not in line
        if grep -qE "^$KEY" "$BASE" && ! grep -qE "^$KEY.*=.*$VAL" "$BASE"; then
          # Replace line
          # Prevent issues with shell quoting 
          sed -i \
            's,^'"$KEY"'.*,'"$KEY = $VAL$COMMENT"',g' \
            "$BASE"
        else
          # insert line
          echo "$KEY = $VAL$COMMENT" >> "$BASE"
        fi
      done
  echo "Layered $LAYER onto $BASE"
}
