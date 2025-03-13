/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _DISABLEMGR_H
#define _DISABLEMGR_H

#include "Define.h"
#include "Map.h"

class Unit;

enum DisableType
{
    DISABLE_TYPE_SPELL                  = 0,
    DISABLE_TYPE_QUEST                  = 1,
    DISABLE_TYPE_MAP                    = 2,
    DISABLE_TYPE_BATTLEGROUND           = 3,
    DISABLE_TYPE_ACHIEVEMENT_CRITERIA   = 4,
    DISABLE_TYPE_OUTDOORPVP             = 5,
    DISABLE_TYPE_VMAP                   = 6,
    DISABLE_TYPE_GO_LOS                 = 7,
    DISABLE_TYPE_LFG_MAP                = 8,
    DISABLE_TYPE_GAME_EVENT             = 9,
    DISABLE_TYPE_LOOT                   = 10,
    MAX_DISABLE_TYPES
};

enum SpellDisableTypes
{
    SPELL_DISABLE_PLAYER            = 0x1,
    SPELL_DISABLE_CREATURE          = 0x2,
    SPELL_DISABLE_PET               = 0x4,
    SPELL_DISABLE_DEPRECATED_SPELL  = 0x8,
    SPELL_DISABLE_MAP               = 0x10,
    SPELL_DISABLE_AREA              = 0x20,
    SPELL_DISABLE_LOS               = 0x40,
    MAX_SPELL_DISABLE_TYPE          = (SPELL_DISABLE_PLAYER | SPELL_DISABLE_CREATURE | SPELL_DISABLE_PET |
                                       SPELL_DISABLE_DEPRECATED_SPELL | SPELL_DISABLE_MAP | SPELL_DISABLE_AREA |
                                       SPELL_DISABLE_LOS)
};

struct DisableData
{
    uint8 flags;
    std::set<uint32> params[2];                             // params0, params1
};

class DisableMgr
{
private:
    DisableMgr();
    ~DisableMgr();

public:
    static DisableMgr* instance();

    void LoadDisables();
    void AddDisable(DisableType type, uint32 entry, uint8 flags, std::string const& param0, std::string const& param1);
    bool HandleDisableType(DisableType type, uint32 entry, uint8 flags, std::string const& params_0, std::string const& params_1, DisableData& data);
    static bool IsDisabledFor(DisableType type, uint32 entry, Unit const* unit, uint8 flags = 0);
    void CheckQuestDisables();
    static bool IsVMAPDisabledFor(uint32 entry, uint8 flags);
    static bool IsPathfindingEnabled(Map const* map);

    // single disables here with optional data
    typedef std::unordered_map<uint32, DisableData> DisableTypeMap;
    // global disable map by source
    typedef std::array<DisableTypeMap, MAX_DISABLE_TYPES> DisableMap;

private:
    static DisableMap m_DisableMap;
};

#define sDisableMgr DisableMgr::instance()

#endif //_DISABLEMGR_H
