
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

  cmake $SRCPATH -DCMAKE_INSTALL_PREFIX=$BINPATH $DCONF -DSERVERS=$CSERVERS \
  -DSCRIPTS=$CSCRIPTS \
  -DUSE_CPP_20=$CUSE_CPP_20 \
  -DBUILD_TESTING=$CBUILD_TESTING \
  -DTOOLS=$CTOOLS \
  -DUSE_SCRIPTPCH=$CSCRIPTPCH \
  -DUSE_COREPCH=$CCOREPCH \
  -DWITH_COREDEBUG=$CDEBUG  \
  -DCMAKE_BUILD_TYPE=$CTYPE \
  -DWITH_WARNINGS=$CWARNINGS \
  -DCMAKE_C_COMPILER=$CCOMPILERC \
  -DCMAKE_CXX_COMPILER=$CCOMPILERCXX \
  "-DDISABLED_AC_MODULES=$CDISABLED_AC_MODULES" \
  $CCUSTOMOPTIONS

  cd $CWD

  runHooks "ON_AFTER_CONFIG"
}


function comp_compile() {
  [ $MTHREADS == 0 ] && MTHREADS=$(grep -c ^processor /proc/cpuinfo) && MTHREADS=$(($MTHREADS + 2))

  echo "Using $MTHREADS threads"

  CWD=$(pwd)

  cd $BUILDPATH

  comp_ccacheResetStats

  time make -j $MTHREADS
  make -j $MTHREADS install

  comp_ccacheShowStats

  cd $CWD

  if [[ $DOCKER = 1 ]]; then
    echo "Generating confs..."
    cp -n "env/dist/etc/worldserver.conf.dockerdist" "env/dist/etc/worldserver.conf"
    cp -n "env/dist/etc/authserver.conf.dockerdist" "env/dist/etc/authserver.conf"
  fi

  runHooks "ON_AFTER_BUILD"

  # set worldserver SUID bit
  sudo chown root:root "$AC_BINPATH_FULL/worldserver"
  sudo chmod u+s "$AC_BINPATH_FULL/worldserver"
}

function comp_build() {
  comp_configure
  comp_compile
}

function comp_all() {
    comp_clean
    comp_build
}
