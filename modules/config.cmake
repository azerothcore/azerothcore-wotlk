#DISABLED ALL MODULES
#Default: 0 
#         1 - disable all module.
set (DISABLED_ALL_MODULES 0)

#Sets which modules need to be disabled.
set(DISABLED_AC_MODULES 
  #mod-transmog
  #mod-eluna-lua-engine
)

if ( DISABLED_ALL_MODULES )
  CU_SUBDIRLIST(sub_DIRS  "${CMAKE_SOURCE_DIR}/modules" FALSE FALSE)
  FOREACH(subdir ${sub_DIRS})
    get_filename_component(MODULENAME ${subdir} NAME)
    set(DISABLED_AC_MODULES ${DISABLED_AC_MODULES} ${MODULENAME})
  ENDFOREACH()
  message("Disable all modules.")
endif()