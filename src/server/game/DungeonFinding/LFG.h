/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _LFG_H
#define _LFG_H

#include "Common.h"
#include "ObjectDefines.h"
#include "SharedDefines.h"
#include "WorldPacket.h"

namespace lfg
{

enum LFGEnum
{
    LFG_TANKS_NEEDED                             = 1,
    LFG_HEALERS_NEEDED                           = 1,
    LFG_DPS_NEEDED                               = 3
};

enum LfgRoles
{
    PLAYER_ROLE_NONE                             = 0x00,
    PLAYER_ROLE_LEADER                           = 0x01,
    PLAYER_ROLE_TANK                             = 0x02,
    PLAYER_ROLE_HEALER                           = 0x04,
    PLAYER_ROLE_DAMAGE                           = 0x08
};

enum LfgUpdateType
{
    LFG_UPDATETYPE_DEFAULT                       = 0,      // Internal Use
    LFG_UPDATETYPE_LEADER_UNK1                   = 1,      // FIXME: At group leave
    LFG_UPDATETYPE_LEAVE_RAIDBROWSER             = 2,
    LFG_UPDATETYPE_JOIN_RAIDBROWSER              = 3,
    LFG_UPDATETYPE_ROLECHECK_ABORTED             = 4,
    LFG_UPDATETYPE_JOIN_QUEUE                    = 5,
    LFG_UPDATETYPE_ROLECHECK_FAILED              = 6,
    LFG_UPDATETYPE_REMOVED_FROM_QUEUE            = 7,
    LFG_UPDATETYPE_PROPOSAL_FAILED               = 8,
    LFG_UPDATETYPE_PROPOSAL_DECLINED             = 9,
    LFG_UPDATETYPE_GROUP_FOUND                   = 10,
    LFG_UPDATETYPE_ADDED_TO_QUEUE                = 12,
    LFG_UPDATETYPE_PROPOSAL_BEGIN                = 13,
    LFG_UPDATETYPE_UPDATE_STATUS                 = 14,
    LFG_UPDATETYPE_GROUP_MEMBER_OFFLINE          = 15,
    LFG_UPDATETYPE_GROUP_DISBAND_UNK16           = 16,     // FIXME: Sometimes at group disband
};

enum LfgState
{
    LFG_STATE_NONE,                                        // Not using LFG / LFR
    LFG_STATE_ROLECHECK,                                   // Rolecheck active
    LFG_STATE_QUEUED,                                      // Queued
    LFG_STATE_PROPOSAL,                                    // Proposal active
    LFG_STATE_BOOT,                                        // Vote kick active
    LFG_STATE_DUNGEON,                                     // In LFG Group, in a Dungeon
    LFG_STATE_FINISHED_DUNGEON,                            // In LFG Group, in a finished Dungeon
    LFG_STATE_RAIDBROWSER                                  // Using Raid finder
};

/// Instance lock types
enum LfgLockStatusType
{
    LFG_LOCKSTATUS_INSUFFICIENT_EXPANSION        = 1,
    LFG_LOCKSTATUS_TOO_LOW_LEVEL                 = 2,
    LFG_LOCKSTATUS_TOO_HIGH_LEVEL                = 3,
    LFG_LOCKSTATUS_TOO_LOW_GEAR_SCORE            = 4,
    LFG_LOCKSTATUS_TOO_HIGH_GEAR_SCORE           = 5,
    LFG_LOCKSTATUS_RAID_LOCKED                   = 6,
    LFG_LOCKSTATUS_ATTUNEMENT_TOO_LOW_LEVEL      = 1001,
    LFG_LOCKSTATUS_ATTUNEMENT_TOO_HIGH_LEVEL     = 1002,
    LFG_LOCKSTATUS_QUEST_NOT_COMPLETED           = 1022,
    LFG_LOCKSTATUS_MISSING_ITEM                  = 1025,
    LFG_LOCKSTATUS_NOT_IN_SEASON                 = 1031,
    LFG_LOCKSTATUS_MISSING_ACHIEVEMENT           = 1034
};

/// Answer state (Also used to check compatibilites)
enum LfgAnswer
{
    LFG_ANSWER_PENDING                           = -1,
    LFG_ANSWER_DENY                              = 0,
    LFG_ANSWER_AGREE                             = 1
};

class Lfg5Guids;

typedef std::list<Lfg5Guids> Lfg5GuidsList;
typedef std::set<uint32> LfgDungeonSet;
typedef std::map<uint32, uint32> LfgLockMap;
typedef std::map<uint64, LfgLockMap> LfgLockPartyMap;
typedef std::set<uint64> LfgGuidSet;
typedef std::list<uint64> LfgGuidList;
typedef std::map<uint64, uint8> LfgRolesMap;
typedef std::map<uint64, uint64> LfgGroupsMap;

class Lfg5Guids
{
public:
    uint64 guid[5];
    LfgRolesMap* roles;
    Lfg5Guids()
    {
        memset(&guid, 0, 5*8);
        roles = nullptr;
    }

    Lfg5Guids(uint64 g)
    {
        memset(&guid, 0, 5*8);
        guid[0] = g;
        roles = nullptr;
    }

    Lfg5Guids(Lfg5Guids const& x)
    {
        memcpy(guid, x.guid, 5*8);
        roles = x.roles ? (new LfgRolesMap(*(x.roles))) : nullptr;
    }

    Lfg5Guids(Lfg5Guids const& x, bool /*copyRoles*/)
    {
        memcpy(guid, x.guid, 5*8);
        roles = nullptr;
    }

    ~Lfg5Guids() { delete roles; }
    void addRoles(LfgRolesMap const& r) { roles = new LfgRolesMap(r); }
    void clear() { memset(&guid, 0, 5*8); }
    bool empty() const { return guid[0] == 0; }
    uint64 front() const { return guid[0]; }

    uint8 size() const
    {
        if (guid[2])
        {
            if (guid[4])
            {
                return 5;
            }
            else if (guid[3])
            {
                return 4;
            }

            return 3;
        }
        else if (guid[1])
        {
            return 2;
        }
        else if (guid[0])
        {
            return 1;
        }

        return 0;
    }

    void insert(const uint64& g)
    {
        // avoid loops for performance
        if (guid[0] == 0)
        {
            guid[0] = g;
            return;
        }

        if (g <= guid[0])
        {
            if (guid[3])
            {
                guid[4] = guid[3];
            }

            if (guid[2])
            {
                guid[3] = guid[2];
            }

            if (guid[1])
            {
                guid[2] = guid[1];
            }


            guid[1] = guid[0];
            guid[0] = g;

            return;
        }

        if (guid[1] == 0)
        {
            guid[1] = g;
            return;
        }

        if (g <= guid[1])
        {
            if (guid[3])
            {
                guid[4] = guid[3];
            }

            if (guid[2])
            {
                guid[3] = guid[2];
            }

            guid[2] = guid[1];
            guid[1] = g;

            return;
        }

        if (guid[2] == 0)
        {
            guid[2] = g;
            return;
        }

        if (g <= guid[2])
        {
            if (guid[3])
            {
                guid[4] = guid[3];
            }

            guid[3] = guid[2];
            guid[2] = g;

            return;
        }

        if (guid[3] == 0)
        {
            guid[3] = g;
            return;
        }

        if (g <= guid[3])
        {
            guid[4] = guid[3];
            guid[3] = g;
            return;
        }

        guid[4] = g;
    }

    void force_insert_front(const uint64& g)
    {
        if (guid[3])
        {
            guid[4] = guid[3];
        }

        if (guid[2])
        {
            guid[3] = guid[2];
        }

        if (guid[1])
        {
            guid[2] = guid[1];
        }

        guid[1] = guid[0];
        guid[0] = g;
    }

    void remove(const uint64& g)
    {
        // avoid loops for performance
        if (guid[0] == g)
        {
            if (guid[1])
            {
                guid[0] = guid[1];
            }
            else
            {
                guid[0] = 0;
                return;
            }

            if (guid[2])
            {
                guid[1] = guid[2];
            }
            else
            {
                guid[1] = 0;
                return;
            }

            if (guid[3])
            {
                guid[2] = guid[3];
            }
            else
            {
                guid[2] = 0;
                return;
            }

            if (guid[4])
            {
                guid[3] = guid[4];
            }
            else
            {
                guid[3] = 0;
                return;
            }

            guid[4] = 0;
            return;
        }

        if (guid[1] == g)
        {
            if (guid[2])
            {
                guid[1] = guid[2];
            }
            else
            {
                guid[1] = 0;
                return;
            }

            if (guid[3])
            {
                guid[2] = guid[3];
            }
            else
            {
                guid[2] = 0;
                return;
            }

            if (guid[4])
            {
                guid[3] = guid[4];
            }
            else
            {
                guid[3] = 0;
                return;
            }

            guid[4] = 0;
            return;
        }

        if (guid[2] == g)
        {
            if (guid[3])
            {
                guid[2] = guid[3];
            }
            else
            {
                guid[2] = 0;
                return;
            }

            if (guid[4])
            {
                guid[3] = guid[4];
            }
            else
            {
                guid[3] = 0;
                return;
            }

            guid[4] = 0;
            return;
        }

        if (guid[3] == g)
        {
            if (guid[4])
            {
                guid[3] = guid[4];
            }
            else
            {
                guid[3] = 0;
                return;
            }

            guid[4] = 0;
            return;
        }

        if (guid[4] == g)
        {
            guid[4] = 0;
        }
    }

    bool hasGuid(const uint64& g) const
    {
        return g && (guid[0] == g || guid[1] == g || guid[2] == g || guid[3] == g || guid[4] == g);
    }

    bool operator<(const Lfg5Guids& x) const
    {
        if (guid[0] <= x.guid[0])
        {
            if (guid[0] != x.guid[0])
            {
                return true;
            }

            if (guid[1] <= x.guid[1])
            {
                if (guid[1] != x.guid[1])
                {
                    return true;
                }

                if (guid[2] <= x.guid[2])
                {
                    if (guid[2] != x.guid[2])
                    {
                        return true;
                    }

                    if (guid[3] <= x.guid[3])
                    {
                        if (guid[3] != x.guid[3])
                        {
                            return true;
                        }

                        if (guid[4] <= x.guid[4])
                        {
                            return !(guid[4] == x.guid[4]);
                        }
                    }
                }
            }
        }

        return false;
    }

    bool operator==(const Lfg5Guids& x) const
    {
        return guid[0] == x.guid[0] && guid[1] == x.guid[1] && guid[2] == x.guid[2] && guid[3] == x.guid[3] && guid[4] == x.guid[4];
    }

    void operator=(const Lfg5Guids& x)
    {
        memcpy(guid, x.guid, 5*8);
        delete roles;
        roles = x.roles ? (new LfgRolesMap(*(x.roles))) : nullptr;
    }

    std::string toString() const // for debugging
    {
        std::ostringstream o;
        o << GUID_LOPART(guid[0]) << "," << GUID_LOPART(guid[1]) << "," << GUID_LOPART(guid[2]) << "," << GUID_LOPART(guid[3]) << "," << GUID_LOPART(guid[4]) << ":" << (roles ? 1 : 0);
        return o.str();
    }
};

std::string ConcatenateDungeons(LfgDungeonSet const& dungeons);
std::string GetRolesString(uint8 roles);
std::string GetStateString(LfgState state);


} // namespace lfg

#endif
