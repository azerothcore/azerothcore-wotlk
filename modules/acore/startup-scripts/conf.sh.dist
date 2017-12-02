# enable/disable GDB execution
export GDB_ENABLED=0

# [optional] gdb file
# default: gdb.txt
export GDB=""

# directory where binary are stored
export BINPATH=""

# Put here the pid you configured on your worldserver.conf file
# needed when GDB_ENABLED=1
export SERVERPID=""
 
# path to configuration file (including the file name)
# ex: /home/user/azerothcore/etc/worldserver.conf
export CONFIG=""

# path of log files
# needed by restarter to store its logs
export LOGS_PATH="";

# exec name
# ex: worldserver
export SERVERBIN=""

# prefix name for log files
# to avoid collision with other restarters
export LOG_PREFIX_NAME=""

# [optional] name of screen service
# if no specified, screen util won't be used
export SCREEN_NAME=""

# [optional] overwrite default screen options: -A -m -d -S
# WARNING: if you are running it under a systemd service
# please do not remove -m -d arguments from screen if are you using it,
# or keep WITH_CONSOLE=0 .  
# otherwise the journald-logging system will take 100% of CPU slowing 
# down the whole machine. It's because a systemd service should have 
# low console output.
export SCREEN_OPTIONS=""

# enable/disable it to show the output
# within console, if disable the output will be redirect to
# logging files
#
export WITH_CONSOLE=0


