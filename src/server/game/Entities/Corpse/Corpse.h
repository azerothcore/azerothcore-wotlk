/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

    bool Create(ObjectGuid::LowType guidlow);
    bool Create(ObjectGuid::LowType guidlow, Player* owner);

    void SaveToDB();
    bool LoadCorpseFromDB(ObjectGuid::LowType guid, Field* fields);

    void DeleteFromDB(CharacterDatabaseTransaction trans);
    static void DeleteFromDB(ObjectGuid const ownerGuid, CharacterDatabaseTransaction trans);

    [[nodiscard]] ObjectGuid GetOwnerGUID() const { return GetGuidValue(CORPSE_FIELD_OWNER); }

    [[nodiscard]] time_t const& GetGhostTime() const { return m_time; }
    void ResetGhostTime() { m_time = time(nullptr); }
    [[nodiscard]] CorpseType GetType() const { return m_type; }

    CellCoord const& GetCellCoord() const { return _cellCoord; }
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
