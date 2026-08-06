#!/usr/bin/env bash

# shellcheck source=../../../deps/acore/bash-lib/src/common/boolean.sh
source "$AC_BASH_LIB_PATH/common/boolean.sh"

# Set SUDO variable - one liner
SUDO=""

IS_SUDO_ENABLED=${AC_ENABLE_ROOT_CMAKE_INSTALL:-0}

# Allow callers to opt-out from privilege escalation during install/perms adjustments
if [[ $IS_SUDO_ENABLED == 1 ]]; then
  SUDO=$([ "$EUID" -ne 0 ] && echo "sudo" || echo "")
fi

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

# clang builds against the newest GCC toolchain on the box, and that is not always one
# it can parse: Ubuntu 26.04 defaults to GCC 15 but drags GCC 16 in through libstdc++6,
# and clang 21 then dies inside <shared_mutex> and <numeric>. When that happens, point it
# at the toolchain behind the default g++, which is the pairing the distro supports.
#
# The probe instantiates rather than only including: these failures live in templates the
# compiler does not look at until something actually uses them.
function comp_selectGccToolchain() {
  [[ "$($CCOMPILERCXX --version 2>/dev/null | head -1)" == *clang* ]] || return 0

  local probe="#include <chrono>
#include <memory>
#include <numeric>
#include <shared_mutex>
#include <string>
#include <vector>
int main()
{
    std::vector<int> values{3, 1, 2};
    std::shared_timed_mutex mutex;
    auto text = std::make_unique<std::string>(\"probe\");

    (void)std::reduce(values.begin(), values.end());
    (void)mutex.try_lock_for(std::chrono::milliseconds(1));
    return int(text->size() & 0u);
}"

  echo "$probe" | "$CCOMPILERCXX" -x c++ -std=c++20 -fsyntax-only - 2>/dev/null && return 0

  # the default g++ first, then anything else installed, newest first
  local candidates
  candidates="$(dirname "$(g++ -print-libgcc-file-name 2>/dev/null)") $(ls -d /usr/lib/gcc/*/[0-9]* 2>/dev/null | sort -Vr)"

  echo "$CCOMPILERCXX cannot use its default GCC toolchain, trying: $candidates"

  local dir
  for dir in $candidates; do
    [[ -d "$dir" ]] || continue
    echo "$probe" | "$CCOMPILERCXX" -x c++ -std=c++20 -fsyntax-only "--gcc-install-dir=$dir" - 2>/dev/null || continue

    # C++ only: the C compiler is configured separately and never sees libstdc++,
    # so it must not be handed a flag its own driver may not know
    echo "using GCC toolchain $dir"
    export CXXFLAGS="${CXXFLAGS:+$CXXFLAGS }--gcc-install-dir=$dir"
    return 0
  done

  echo "WARNING: no installed GCC toolchain works with $CCOMPILERCXX"
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
  comp_selectGccToolchain

  OSOPTIONS=""


    echo "Platform: $OSTYPE"
    case "$OSTYPE" in
      darwin*)
        OSOPTIONS=" -DMYSQL_ADD_INCLUDE_PATH=/usr/local/include -DMYSQL_LIBRARY=/usr/local/lib/libmysqlclient.dylib -DREADLINE_INCLUDE_DIR=/usr/local/opt/readline/include -DREADLINE_LIBRARY=/usr/local/opt/readline/lib/libreadline.dylib -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl@3/include -DOPENSSL_SSL_LIBRARIES=/usr/local/opt/openssl@3/lib/libssl.dylib -DOPENSSL_CRYPTO_LIBRARIES=/usr/local/opt/openssl@3/lib/libcrypto.dylib "
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
      local confDir
      confDir=${CONFDIR:-"$AC_BINPATH_FULL/../etc"}

      # create the folders before installing to
      # set the current user and permissions
      echo "Creating $AC_BINPATH_FULL..."
      mkdir -p "$AC_BINPATH_FULL"
      echo "Creating $confDir..."
      mkdir -p "$confDir"
      mkdir -p "$confDir/modules"

      confDir=$(realpath "$confDir")

      echo "Cmake install..."
      $SUDO cmake --install . --config $CTYPE

      popd >> /dev/null || exit 1

      # set all aplications SUID bit
      if [[ $IS_SUDO_ENABLED == 0 ]]; then
        echo "Skipping root ownership and SUID changes (IS_SUDO_ENABLED=0)"
      else
        echo "Setting permissions on binary files"
        find "$AC_BINPATH_FULL"  -mindepth 1 -maxdepth 1 -type f -exec $SUDO chown root:root -- {} +
        find "$AC_BINPATH_FULL"  -mindepth 1 -maxdepth 1 -type f -exec $SUDO chmod u+s  -- {} +
        $SUDO setcap cap_sys_nice=eip "$AC_BINPATH_FULL/worldserver"
        $SUDO setcap cap_sys_nice=eip "$AC_BINPATH_FULL/authserver"
      fi


      if ( isTrue "$AC_ENABLE_CONF_COPY_ON_INSTALL" ) then
        echo "Copying default configuration files to $confDir ..."
        [[ -f "$confDir/worldserver.conf.dist" && ! -f "$confDir/worldserver.conf" ]] && \
            cp -v "$confDir/worldserver.conf.dist" "$confDir/worldserver.conf"
        [[ -f "$confDir/authserver.conf.dist" && ! -f "$confDir/authserver.conf"  ]] && \
            cp -v "$confDir/authserver.conf.dist" "$confDir/authserver.conf"
        [[ -f "$confDir/dbimport.conf.dist" && ! -f "$confDir/dbimport.conf" ]] && \
            cp -v "$confDir/dbimport.conf.dist" "$confDir/dbimport.conf"

        for f in "$confDir/modules/"*.dist
        do
            [[ -e $f ]] || break  # handle the case of no *.dist files
            if [[ ! -f "${f%.dist}" ]]; then
                echo "Copying module config $(basename "${f%.dist}")"
                cp -v "$f" "${f%.dist}";
            fi
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
