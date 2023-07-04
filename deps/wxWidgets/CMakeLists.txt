if(NOT BUILD_WX_WIDGETS)
    set(BUILD_WX_WIDGETS 0)
endif()

if(BUILD_WX_WIDGETS)
    set(WXWIDGETS_REMOTE_REPO "https://github.com/wxWidgets/wxWidgets")
    set(WXWIDGETS_VERSION "v3.1.4")

    set(STAGED_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR})
    set(WXWIDGETS_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/${WXWIDGETS_VERSION})
    set(WXWIDGETS_SUBBUILD_DIR ${CMAKE_CURRENT_BINARY_DIR}/build)
    set(WXWIDGETS_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/bin)

    message(STATUS "BUILD_WX_WIDGETS SET TRUE")
    message(STATUS "Will be wxWidgets in ${STAGED_INSTALL_PREFIX}")

    include(FetchContent)
    FetchContent_Declare(
     wxWidgets
     GIT_REPOSITORY ${WXWIDGETS_REMOTE_REPO}
     GIT_TAG        ${WXWIDGETS_VERSION}
     GIT_PROGRESS   TRUE
     GIT_SHALLOW    TRUE
     SOURCE_DIR     ${WXWIDGETS_SOURCE_DIR}
     SUBBUILD_DIR   ${WXWIDGETS_SUBBUILD_DIR}
     BINARY_DIR     ${WXWIDGETS_BINARY_DIR}
     CONFIGURE_COMMAND
     BUILD_COMMAND
     INSTALL_COMMAND
     TEST_COMMAND ""
    )
    set(FETCHCONTENT_QUIET NO)

    # set(wxBUILD_PRECOMP OFF) # this prevents errors on recompile after the git hash changes
    if(UNIX AND NOT APPLE) # linux
     # use gtk3 on linux
     set(wxBUILD_TOOLKIT gtk3 CACHE STRING "Toolkit used by wxWidgets")
     # try to find gtk3 (this is based on wxWidget's cmake: wxWidgets/build/cmake/modules/FindGTK3.cmake)
     find_package(PkgConfig)
     pkg_check_modules(GTK3 QUIET gtk+-3.0)
     if(NOT GTK3_FOUND)
      message(FATAL_ERROR "wxWidgets needs gtk3 and libSM, make sure you have it with e.g.:\n"
                          "\tdebian 'apt-get install libgtk-3-dev libsm-dev build-essential'\n"
                          "\tcentos 'yum install gtk3-devel libSM-devel'\n")
     endif()
    endif()
    
    if(APPLE)
     set(wxUSE_WEBKIT OFF CACHE BOOL "use wxWebKitCtrl (Mac-only, use wxWebView instead)")
     set(wxUSE_WEBVIEW_WEBKIT OFF CACHE BOOL "use wxWebView WebKit background")
     set(wxUSE_LIBSDL OFF CACHE BOOL "Use SDL for wxSound implementation.")
    endif()
    
    FetchContent_MakeAvailable(wxWidgets)
else()
    find_package(wxWidgets)
    if(NOT wxWidgets_FOUND)
        message( SEND_ERROR "wxWidgets was not found, install it or set the BUILD_WX_WIDGETS flag on." )
    endif()
endif()

unset(BUILD_WX_WIDGETS CACHE)
