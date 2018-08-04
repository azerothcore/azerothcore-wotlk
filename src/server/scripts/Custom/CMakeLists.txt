set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_DIR}/Custom/npc_solo3v3.cpp
  ${AC_SCRIPTS_DIR}/Custom/npc_solo3v3.h
)

AC_ADD_SCRIPT_LOADER("Custom" "ScriptLoader.h")

message("  -> Prepared: My custom scripts")