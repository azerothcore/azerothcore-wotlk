set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_DIR}/Events/brewfest.cpp
  ${AC_SCRIPTS_DIR}/Events/childrens_week.cpp
  ${AC_SCRIPTS_DIR}/Events/hallows_end.cpp
  ${AC_SCRIPTS_DIR}/Events/pilgrims_bounty.cpp
  ${AC_SCRIPTS_DIR}/Events/winter_veil.cpp
  ${AC_SCRIPTS_DIR}/Events/love_in_air.cpp
  ${AC_SCRIPTS_DIR}/Events/midsummer.cpp
)

AC_ADD_SCRIPT_LOADER("Event" "ScriptLoader.h")

message("  -> Prepared: Events")
