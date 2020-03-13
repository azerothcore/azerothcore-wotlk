CU_SET_PATH("CMAKE_TEMPLATE_SRC_DIR" "${CMAKE_CURRENT_LIST_DIR}")

AC_ADD_SCRIPT("${CMAKE_TEMPLATE_SRC_DIR}/learn_highest_talent_rank.cpp")

AC_ADD_SCRIPT_LOADER("learn_highest_talent_rank" "${CMAKE_TEMPLATE_SRC_DIR}/learn_highest_talent_rank_loader.h")