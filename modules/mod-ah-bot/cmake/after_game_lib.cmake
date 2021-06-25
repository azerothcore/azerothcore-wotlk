#
#
#

CollectIncludeDirectories(
  ${CMAKE_MOD_AHBOT_DIR}/src
  PUBLIC_INCLUDES)

target_include_directories(game-interface
  INTERFACE
    ${PUBLIC_INCLUDES})
