MACRO(AZTH_LOAD_SRC dir)
    CU_SUBDIRLIST(sub_DIRS  "${CMAKE_AZTH_SRC_DIR}/${dir}" TRUE TRUE)
    FOREACH(subdir ${sub_DIRS})
        get_filename_component(azth_dir_name ${subdir} DIRECTORY)

        if (NOT (${azth_dir_name} STREQUAL "tests") OR AZTH_WITH_UNIT_TEST)
            file(GLOB sources "${subdir}/*.cpp" "${subdir}/*.h")

            set(azth_STAT_SRCS
                ${azth_STAT_SRCS}
                ${sources}
            )

            set(azth_DIRS
                ${subdir}
                ${azth_DIRS}
            )
        endif()
    ENDFOREACH()
ENDMACRO()

CU_ADD_HOOK(BEFORE_SRC_LOAD "${CMAKE_AZTH_SRC_DIR}/cmake/before_src_load.cmake")

CU_ADD_HOOK(AFTER_GAME_LIBRARY "${CMAKE_AZTH_SRC_DIR}/cmake/after_game_library.cmake")

CU_ADD_HOOK(AFTER_SRC_LOAD "${CMAKE_AZTH_SRC_DIR}/cmake/after_src_load.cmake")

AC_ADD_SCRIPT_LOADER("Azth" "AzthPlgLoader.h")
