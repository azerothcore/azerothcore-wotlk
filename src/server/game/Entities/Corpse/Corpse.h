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

#ifndef AZEROTHCORE_CORPSE_H
#define AZEROTHCORE_CORPSE_H

#include "DatabaseEnv.h"
#include "GridDefines.h"
#include "LootMgr.h"
#include "Object.h"

enum CorpseType
{
    CORPSE_BONES             = 0,
    CORPSE_RESURRECTABLE_PVE = 1,
    CORPSE_RESURRECTABLE_PVP = 2
};
#define MAX_CORPSE_TYPE        3

// Value equal client resurrection dialog show radius.
#define CORPSE_RECLAIM_RADIUS 39

enum CorpseFlags
{
    CORPSE_FLAG_NONE        = 0x00,
    CORPSE_FLAG_BONES       = 0x01,
    CORPSE_FLAG_UNK1        = 0x02,
    CORPSE_FLAG_UNK2        = 0x04,
    CORPSE_FLAG_HIDE_HELM   = 0x08,
    CORPSE_FLAG_HIDE_CLOAK  = 0x10,
    CORPSE_FLAG_LOOTABLE    = 0x20
};

class Corpse : public WorldObject, public GridObject<Corpse>
{
public:
    explicit Corpse(CorpseType type = CORPSE_BONES);
    ~Corpse() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target) override;

    bool Create(ObjectGuid::LowType guidlow);
    bool Create(ObjectGuid::LowType guidlow, Player* owner);

    void SaveToDB();
    bool LoadCorpseFromDB(ObjectGuid::LowType guid, Field* fields);

    void DeleteFromDB(CharacterDatabaseTransaction trans);
    static void DeleteFromDB(ObjectGuid const& ownerGuid, CharacterDatabaseTransaction trans);

    [[nodiscard]] ObjectGuid GetOwnerGUID() const { return GetGuidValue(CORPSE_FIELD_OWNER); }

    [[nodiscard]] time_t const& GetGhostTime() const { return m_time; }
    void ResetGhostTime();
    [[nodiscard]] CorpseType GetType() const { return m_type; }

    [[nodiscard]] CellCoord const& GetCellCoord() const { return _cellCoord; }
    void SetCellCoord(CellCoord const& cellCoord) { _cellCoord = cellCoord; }

    Loot loot;                                          // remove insignia ONLY at BG
    Player* lootRecipient;

    [[nodiscard]] bool IsExpired(time_t t) const;

private:
    CorpseType m_type;
    time_t m_time;
    CellCoord _cellCoord;
};
#endif
