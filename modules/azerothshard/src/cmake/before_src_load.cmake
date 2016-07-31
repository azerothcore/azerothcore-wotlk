#AZTH_LOAD_SRC("libs")
AZTH_LOAD_SRC("game")
AZTH_LOAD_SRC("plugins")

if( NOT WIN32 )
  message("defined: ${_AZTH_MOD_CONFIG}")
  if (NOT DEFINED _AZTH_MOD_CONFIG)
    set(_AZTH_MOD_CONFIG "${CONF_DIR}/azth_mod.conf")
  endif()
  message("mod_config: ${_AZTH_MOD_CONFIG}")

  add_definitions(-D_AZTH_MOD_CONFIG="\\"${_AZTH_MOD_CONFIG}\\"")
  
  unset(_AZTH_MOD_CONFIG CACHE)
endif()

AZTH_ADD_INC_PATH("${azth_DIRS}")

AZTH_LOAD_INC_PATHS()

AZTH_SET_CACHE("CMAKE_AZTH_SRCS" "${azth_STAT_SRCS}")
