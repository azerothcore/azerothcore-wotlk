CU_SET_PATH("CMAKE_AC_MODULE_DIR" "${CMAKE_CURRENT_LIST_DIR}")

if(SCRIPTS)
  include(World/CMakeLists.txt)
  include(OutdoorPvP/CMakeLists.txt)
  include(EasternKingdoms/CMakeLists.txt)
  include(Kalimdor/CMakeLists.txt)
  include(Outland/CMakeLists.txt)
  include(Northrend/CMakeLists.txt)
  include(Events/CMakeLists.txt)
  include(Pet/CMakeLists.txt)

  if(EXISTS "Custom/CMakeLists.txt")
	include(Custom/CMakeLists.txt)
  endif()
  
  AC_ADD_SCRIPT("${scripts_STAT_SRCS}")
endif()
