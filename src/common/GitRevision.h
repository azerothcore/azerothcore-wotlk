/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __GITREVISION_H__
#define __GITREVISION_H__

#include "Define.h"

namespace GitRevision
{
    AC_COMMON_API char const* GetHash();
    AC_COMMON_API char const* GetDate();
    AC_COMMON_API char const* GetBranch();
    AC_COMMON_API char const* GetCMakeCommand();
    AC_COMMON_API char const* GetCMakeVersion();
    AC_COMMON_API char const* GetHostOSVersion();
    AC_COMMON_API char const* GetBuildDirectory();
    AC_COMMON_API char const* GetSourceDirectory();
    AC_COMMON_API char const* GetMySQLExecutable();
    AC_COMMON_API char const* GetFullVersion();
    AC_COMMON_API char const* GetCompanyNameStr();
    AC_COMMON_API char const* GetLegalCopyrightStr();
    AC_COMMON_API char const* GetFileVersionStr();
    AC_COMMON_API char const* GetProductVersionStr();
}

#endif
