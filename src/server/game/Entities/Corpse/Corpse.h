/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_CORPSE_H
#define AZEROTHCORE_CORPSE_H

#include "Object.h"
#include "DatabaseEnv.h"
#include "GridDefines.h"
#include "LootMgr.h"

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
        ~Corpse();

        void AddToWorld() override;
        void RemoveFromWorld() override;

        bool Create(uint32 guidlow, Map* map);
        bool Create(uint32 guidlow, Player* owner);

        void SaveToDB();
        bool LoadCorpseFromDB(uint32 guid, Field* fields);

        void DeleteFromDB(SQLTransaction& trans);

        uint64 GetOwnerGUID() const { return GetUInt64Value(CORPSE_FIELD_OWNER); }

        time_t const& GetGhostTime() const { return m_time; }
        void ResetGhostTime() { m_time = time(nullptr); }
        CorpseType GetType() const { return m_type; }

        GridCoord const& GetGridCoord() const { return _gridCoord; }
        void SetGridCoord(GridCoord const& gridCoord) { _gridCoord = gridCoord; }

        Loot loot;                                          // remove insignia ONLY at BG
        Player* lootRecipient;

        bool IsExpired(time_t t) const;

    private:
        CorpseType m_type;
        time_t m_time;
        GridCoord _gridCoord;                                    // gride for corpse position for fast search
};
#endif
