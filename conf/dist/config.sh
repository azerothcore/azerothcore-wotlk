# absolute root path of your azerothcore repository
# It should not be modified if you don't really know what you're doing
SRCPATH="$AC_PATH_ROOT"

# absolute path where build files must be stored
BUILDPATH=${BUILDPATH:-"$AC_PATH_VAR/build/obj"}

# absolute path where azerothcore will be installed
# NOTE: on linux the binaries are stored in a subfolder (/bin)
# of the $BINPATH
BINPATH="$AC_PATH_ROOT/env/dist"

# bash fills it by default with your os type. No need to change it.
# Change it if you really know what you're doing.
# OSTYPE=""

# When using linux, our installer automatically get information about your distro
# using lsb_release. If your distro is not supported but it's based on ubuntu or debian,
# please change it to one of these values.
# OSDISTRO="ubuntu"

# absolute path where config. files must be stored
# default: the system will use binpath by default
# CONFDIR="$AC_PATH_ROOT/env/dist/etc/"

# absolute path where maps and client data will be downloaded
# by the AC dashboard
# default: the system will use binpath by default
# DATAPATH="$BINPATH/bin"
# DATAPATH_ZIP="$DATAPATH/data.zip"

# azerothcore's official remote source address to pull from
# by default git will fetch form the azrothcore remote
# You can change it to "origin" if you want to fetch/pull from the set remote
ORIGIN_REMOTE="https://github.com/azerothcore/azerothcore-wotlk.git"

# Branch configuration for the installer to pull from.
# By default git will select the current working branch
# You can set it to "master" if you want the latest updates
INSTALLER_PULL_FROM=

##############################################
#
#  COMPILER_CONFIGURATIONS
#
##############################################
# Set preferred compilers.
# To use gcc (not suggested) instead of clang change in:
#  CCOMPILERC="/usr/bin/gcc"
#  CCOMPILERCXX="/usr/bin/g++"
#
CCOMPILERC="/usr/bin/clang"
CCOMPILERCXX="/usr/bin/clang++"

# how many thread must be used for compilation ( leave zero to use all available )
MTHREADS=${MTHREADS:-0}
# enable/disable warnings during compilation
CWARNINGS=ON
# enable/disable some debug informations ( it's not a debug compilation )
CDEBUG=OFF
# specify compilation type:
# * Release: high optimization level, no debug info, code or asserts.
# * Debug: No optimization, asserts enabled, [custom debug (output) code enabled],
#    debug info included in executable (so you can step through the code with a
#    debugger and have address to source-file:line-number translation).
# * RelWithDebInfo: optimized, *with* debug info, but no debug (output) code or asserts.
# * MinSizeRel: same as Release but optimizing for size rather than speed.
CTYPE=${CTYPE:-Release}

# compile scripts
CSCRIPTS=${CSCRIPTS:-static}

# compile modules
CMODULES=${CMODULES:-static}

# compile unit tests
CBUILD_TESTING=OFF

# use precompiled headers ( fatest compilation but not optimized if you change headers often )
CSCRIPTPCH=${CSCRIPTPCH:-ON}
CCOREPCH=${CCOREPCH:-ON}

# build apps list variable
CAPPS_BUILD=${CAPPS_BUILD:-all}

# build tools list variable
CTOOLS_BUILD=${CTOOLS_BUILD:-none}

# build apps list
CBUILD_APPS_LIST=${CBUILD_APPS_LIST:-''}

# build tools list
CBUILD_TOOLS_LIST=${CBUILD_TOOLS_LIST:-''}

# you can add your custom definitions here ( -D )
# example:  CCUSTOMOPTIONS=" -DWITH_PERFTOOLS=ON
#
CCUSTOMOPTIONS=${CCUSTOMOPTIONS:-''}

# Enable ccache to speedup
# recompilations
#
AC_CCACHE=${AC_CCACHE:-false}
export CCACHE_DIR=${CCACHE_DIR:-"$AC_PATH_VAR/ccache"}

##############################################
#
#  GOOGLE PERF TOOLS
#
#  Repository: https://github.com/gperftools/gperftools#readme
#  Documentation: https://gperftools.github.io/gperftools/
#
# Install (Ubuntu):
#  sudo apt-get install google-perftools libgoogle-perftools-dev
# Note: dependencies above are already installed in docker
#
# Usage:
#  1. To enable the gperftools you need to compile with the -DWITH_PERFTOOLS=ON compiler flag. You can use CCUSTOMOPTIONS above to set it for the dashboard compiler
#  2. Configure the variable below accordingly to your needs
#  3. run the worldserver with the "./acore.sh run-worldserver"
#  4. run "killall -12 worldserver"  This command will start the monitoring process. Run "killall -12 worldserver" again to stop the process when you want
#  5. At this time you will have the .prof file ready in the folder configured below.
#  Run "google-pprof --callgrind <path/of/worldserver/bin> </path/of/prof/file>" This will generate a callgrind file that can be read with
#  QCacheGrind, KCacheGrind and any other compatible tools
#
##############################################

# files used by gperftools to store monitored information
export CPUPROFILE=${CPUPROFILE:-"$BINPATH/logs/worldserver-cpu.prof"}
# heap profile is disabled by default. Uncomment this line to enable it
# export HEAPPROFILE=${HEAPPROFILE:-"$BINPATH/logs/worldserver-heap.prof"}

# signal to send to the kill command to start/stop the profiling process. kill -12
export CPUPROFILESIGNAL=${CPUPROFILESIGNAL:-12}

# How many interrupts/second the cpu-profiler samples.
#export CPUPROFILE_FREQUENCY=${CPUPROFILESIGNAL:-100}

# If set to any value (including 0 or the empty string), use ITIMER_REAL instead of ITIMER_PROF to gather profiles.
# In general, ITIMER_REAL is not as accurate as ITIMER_PROF, and also interacts badly with use of alarm(),
# so prefer ITIMER_PROF unless you have a reason prefer ITIMER_REAL.
#export CPUPROFILE_REALTIME=${CPUPROFILE_REALTIME}

# Other values for HEAPCHECK: minimal, normal (equivalent to "1"), strict, draconian
#export HEAPCHECK=${HEAPCHECK:-normal}


