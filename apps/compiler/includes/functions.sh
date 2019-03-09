
function comp_clean() {
  echo "Cleaning build files"

  CWD=$(pwd)

  cd $BUILDPATH

  make -f Makefile clean || true
  make clean || true
  find -iname '*cmake*' -not -name CMakeLists.txt -exec rm -rf {} \+

  cd $CWD
}

function comp_configure() {
  CWD=$(pwd)

  cd $BUILDPATH

  echo "Build path: $BUILDPATH"
  echo "DEBUG info: $CDEBUG"
  echo "Compilation type: $CTYPE"
  # -DCMAKE_BUILD_TYPE=$CCTYPE disable optimization "slow and huge amount of ram"
  # -DWITH_COREDEBUG=$CDEBUG compiled with debug information

  #-DSCRIPTS_COMMANDS=$CSCRIPTS -DSCRIPTS_CUSTOM=$CSCRIPTS -DSCRIPTS_EASTERNKINGDOMS=$CSCRIPTS -DSCRIPTS_EVENTS=$CSCRIPTS -DSCRIPTS_KALIMDOR=$CSCRIPTS \
  #-DSCRIPTS_NORTHREND=$CSCRIPTS -DSCRIPTS_OUTDOORPVP=$CSCRIPTS -DSCRIPTS_OUTLAND=$CSCRIPTS -DSCRIPTS_PET=$CSCRIPTS -DSCRIPTS_SPELLS=$CSCRIPTS -DSCRIPTS_WORLD=$CSCRIPTS \
  #-DAC_WITH_UNIT_TEST=$CAC_UNIT_TEST -DAC_WITH_PLUGINS=$CAC_PLG \

  local DCONF=""
  if [ ! -z "$CONFDIR" ]; then
    DCONF="-DCONF_DIR=$CONFDIR"
  fi

  cmake $SRCPATH -DCMAKE_INSTALL_PREFIX=$BINPATH $DCONF -DSERVERS=$CSERVERS \
  -DSCRIPTS=$CSCRIPTS \
  -DTOOLS=$CTOOLS -DUSE_SCRIPTPCH=$CSCRIPTPCH -DUSE_COREPCH=$CCOREPCH -DWITH_COREDEBUG=$CDEBUG  -DCMAKE_BUILD_TYPE=$CTYPE -DWITH_WARNINGS=$CWARNINGS \
  -DCMAKE_C_COMPILER=$CCOMPILERC -DCMAKE_CXX_COMPILER=$CCOMPILERCXX "-DDISABLED_AC_MODULES=$CDISABLED_AC_MODULES" $CCUSTOMOPTIONS

  cd $CWD

  runHooks "ON_AFTER_CONFIG"
}


function comp_compile() {
  [ $MTHREADS == 0 ] && MTHREADS=`grep -c ^processor /proc/cpuinfo` && MTHREADS=$(($MTHREADS + 2))

  echo "Using $MTHREADS threads"

  CWD=$(pwd)

  cd $BUILDPATH

  time make -j $MTHREADS
  make -j $MTHREADS install

  cd $CWD

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
