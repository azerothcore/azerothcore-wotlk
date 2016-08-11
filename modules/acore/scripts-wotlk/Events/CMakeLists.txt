set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${CMAKE_AC_MODULE_DIR}/Events/brewfest.cpp
  ${CMAKE_AC_MODULE_DIR}/Events/childrens_week.cpp
  ${CMAKE_AC_MODULE_DIR}/Events/hallows_end.cpp
  ${CMAKE_AC_MODULE_DIR}/Events/pilgrims_bounty.cpp
  ${CMAKE_AC_MODULE_DIR}/Events/winter_veil.cpp
  ${CMAKE_AC_MODULE_DIR}/Events/love_in_air.cpp
  ${CMAKE_AC_MODULE_DIR}/Events/midsummer.cpp
)

AC_ADD_SCRIPT_LOADER("Event" "ScriptWotlkLoader.h")

message("  -> Prepared: Events")
