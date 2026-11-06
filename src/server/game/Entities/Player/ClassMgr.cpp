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

#include "ClassMgr.h"
#include "DBCStores.h"
#include "Log.h"
#include "SharedDefines.h"

uint8  ClassMgr::_maxClasses = 0;

uint32 ClassMgr::_playableClassMask = 0;

ClassMgr::ClassMgr()
{
}

ClassMgr::~ClassMgr()
{
}

ClassMgr* ClassMgr::instance()
{
    static ClassMgr instance;
    return &instance;
}

void ClassMgr::LoadClasses()
{
    SetMaxClasses(1);
    _playableClassMask = 0;

    for (auto const& classEntry : sChrClassesStore)
    {
        if (!classEntry)
            continue;

        uint32 classId = classEntry->ClassID;

        if (classId == 0 || classId > 32)
        {
            LOG_ERROR("server.loading", "Invalid class ID {} in ChrClasses.dbc, skipped.", classId);
            continue;
        }

        // the class stays valid everywhere else, only the hand-written per-class tables lack a row for it
        if (classId >= MAX_CLASSES)
            LOG_ERROR("server.loading", "Class {} in ChrClasses.dbc has no rows in the hand-written per-class tables "
                "(stat caps, dodge, item spell lists): it gets no diminishing returns, no parry and no item spell procs "
                "until rows are added.", classId);

        if (GetMaxClasses() <= classId)
            SetMaxClasses(static_cast<uint8>(classId + 1));

        uint32 classBit = uint32(1) << (classId - 1);

        _playableClassMask |= classBit;
    }
}
