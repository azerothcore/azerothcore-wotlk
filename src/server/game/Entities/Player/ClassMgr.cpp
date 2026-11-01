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
#include "AccountMgr.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

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
    SetMaxClasses(0 + 1);
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

        if (GetMaxClasses() <= classId)
            SetMaxClasses(static_cast<uint8>(classId + 1));

        uint32 classBit = uint32(1) << (classId - 1);

        _playableClassMask |= classBit;
    }
}
