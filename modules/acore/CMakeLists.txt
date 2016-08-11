CU_RUN_HOOK("BEFORE_ACORE_LOAD")

add_subdirectory(deps)

if( SERVERS )
  add_subdirectory(framework)
  add_subdirectory(world-engine/collision)
  add_subdirectory(scripts-wotlk)
else()
  if( TOOLS )
    add_subdirectory(extractors)
    add_subdirectory(world-engine/collision)
    add_subdirectory(framework)
  endif()
endif()

CU_RUN_HOOK("AFTER_ACORE_LOAD")

