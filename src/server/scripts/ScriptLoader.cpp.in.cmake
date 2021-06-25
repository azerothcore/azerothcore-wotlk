/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

// This file was created automatically from your script configuration!
// Use CMake to reconfigure this file, never change it on your own!

#cmakedefine ACORE_IS_DYNAMIC_SCRIPTLOADER

#include "Define.h"
#include <vector>
#include <string>

// Add deprecated api loaders include
@AC_SCRIPTS_INCLUDES@
// Add module scripts define
@AC_MODULE_LIST@
// Add default scripts include
@ACORE_SCRIPTS_FORWARD_DECL@
#ifdef ACORE_IS_DYNAMIC_SCRIPTLOADER
#  include "revision.h"
#  define AC_SCRIPT_API AC_API_EXPORT
extern "C" {

/// Exposed in script modules to return the script module revision hash.
AC_SCRIPT_API char const* GetScriptModuleRevisionHash()
{
    return _HASH;
}

/// Exposed in script module to return the name of the script module
/// contained in this shared library.
AC_SCRIPT_API char const* GetScriptModule()
{
    return "@ACORE_CURRENT_SCRIPT_PROJECT@";
}

#else
#  include "ScriptLoader.h"
#  define AC_SCRIPT_API
#endif

/// Exposed in script modules to register all scripts to the ScriptMgr.
AC_SCRIPT_API void AddScripts()
{
    // Default scripts and modules
@ACORE_SCRIPTS_INVOKE@
    // Deprecated api modules
@AC_SCRIPTS_LIST@}

/// Exposed in script modules to get the build directive of the module.
AC_SCRIPT_API char const* GetBuildDirective()
{
    return _BUILD_DIRECTIVE;
}

#ifdef ACORE_IS_DYNAMIC_SCRIPTLOADER
} // extern "C"
#endif
