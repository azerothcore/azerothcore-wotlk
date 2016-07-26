// Copyright (c) 2016 AzerothCore
// Author: mik1893 - kepler - yehonal
//
// This software is provided 'as-is', without any express or implied
// warranty.  In no event will the authors be held liable for any damages
// arising from the use of this software.

#include "CrossFaction.h"

// Crossfaction class functionalities
void CrossFaction::UpdatePlayerTeam(Group* group, uint64 guid, bool reset /* = false */)
{
    Player* player = ObjectAccessor::FindPlayer(guid);

    if (player)
    {
        bool disable = true;

        // Check disables
        if (isMapEnabled(player->GetMapId()) && isZoneEnabled(player->GetZoneId()) && isAreaEnabled(player->GetAreaId()))
            disable = false;
        else
        {
            // message player when crossfaction disabled in a specific area
            player->Whisper("Quest'area ha il crossfaction disabilitato", LANG_UNIVERSAL, player->GetGUID());
            sLog->outDebug(LOG_FILTER_CROSSFACTION, "Crossfaction: disabled for player %s", player->GetName().c_str());
        }

        // if not reset or disable, check and change
        if (!reset && !disable)
        {
            // battleground group
            if (player->InBattleground())
            {
                if (Battleground * bg = player->GetBattleground())
                {
                    player->setTeamId(player->GetBgTeamId());
                    player->setFaction(player->GetTeamId() == TEAM_ALLIANCE ? 1 : 2);
                    sLog->outDebug(LOG_FILTER_CROSSFACTION, "Crossfaction: Battleground team id set for player %s", player->GetName().c_str());
                    return;
                }
            }

            // standard group
            uint64 leaderGuid = group ? group->GetLeaderGUID() : player->GetGUID();
            if (leaderGuid != player->GetGUID())
            {
                if (Player* leader = ObjectAccessor::FindPlayer(leaderGuid))
                {
                    player->setTeamId(leader->GetTeamId());
                    player->setFaction(leader->getFaction());
                    return;
                }
                else // if leader guid is offline, access is race from the leader map
                {
                    UNORDERED_MAP<uint64, uint8>::iterator itr = LeaderRaceMap.find(leaderGuid);
                    if (itr != LeaderRaceMap.end())
                    {
                        uint8 raceid = itr->second;
                        ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(raceid);
                        player->setFaction(rEntry ? rEntry->FactionID : 0);
                    }
                }
            }
        }

        // all the other cases: reset to the original faction

        player->setTeamId(player->GetTeamId(true));
        ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(player->getRace());
        player->setFaction(rEntry ? rEntry->FactionID : 0);
        sLog->outDebug(LOG_FILTER_CROSSFACTION, "Crossfaction: reset done for player %s", player->GetName().c_str());
    }
    else
        sLog->outError("CrossFaction: tried to update faction of player %u but he's not online... ", GUID_LOPART(guid));
}

void CrossFaction::LoadConfig(bool reload)
{
    sLog->outError("Loading Crossfaction disable rules...");
    if (reload)
    {
        mapDisable.clear();
        zoneDisable.clear();
        areaDisable.clear();
    }

    QueryResult mapResult  = ExtraDatabase.PQuery("SELECT id FROM crossfaction_disable where type = 1");
    QueryResult zoneResult = ExtraDatabase.PQuery("SELECT id FROM crossfaction_disable where type = 2");
    QueryResult areaResult = ExtraDatabase.PQuery("SELECT id FROM crossfaction_disable where type = 3");

    // load in the vector the different types of disable
    uint32 mapcount = 0;
    uint32 zonecount = 0;
    uint32 areacount = 0;

    if (mapResult)
    {
        do
        {
            mapDisable.push_back((*mapResult)[0].GetUInt32());
            mapcount++;
        }
        while (mapResult->NextRow());
    }
    
    if (zoneResult)
    {
        do
        {
            zoneDisable.push_back((*zoneResult)[0].GetUInt32());
            zonecount++;
        } 
        while (zoneResult->NextRow());
    }

    if (areaResult)
    {
        do
        {
            areaDisable.push_back((*areaResult)[0].GetUInt32());
            areacount++;
        }   
        while (areaResult->NextRow());
    }

    sLog->outError("%u maps, %u zones, %u areas have been disabled for crossfaction ", mapcount,zonecount,areacount);

    sLog->outError("Loading offline group leaders...");

    LeaderRaceMap.clear();
    QueryResult groupResult = CharacterDatabase.PQuery("SELECT c.guid, c.race from characters c, groups g where g.leaderguid = c.guid");

    if (groupResult)
    {
        while (groupResult->NextRow());
            LeaderRaceMap[(*groupResult)[0].GetUInt64()] = (*groupResult)[0].GetUInt8();
    }
}

// This function is used to retrieve 
uint8 CrossFaction::GetPlayerRace(uint64 playerGuid)
{
    if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
        return player->getRace();
    else
    {
        // Query informations from the DB
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PINFO);
        stmt->setUInt32(0, GUID_LOPART(playerGuid));
        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        ASSERT(result); //you cannot have a player non-existing in db that is playing... / a group leader...

        Field* fields = result->Fetch();
        uint8 raceid = fields[4].GetUInt8();

        return raceid;
    }
}

// ALL THE SCRIPT FUNCTIONS AFTER THIS POINT: GROUPSCRIPT, PLAYERSCRIPT, WORLDSCRIPT
class CrossFactionGroup : public GroupScript
{
public:

    CrossFactionGroup() : GroupScript("CrossFactionGroup") { }

    void OnAddMember(Group* group, uint64 guid) override
    {
        sCrossFaction->UpdatePlayerTeam(group, guid);
    }

    // This script is called when a member is removed, but after a new leader has been already picked up - so it's valid to update in here.
    void OnRemoveMember(Group* group, uint64 guid, RemoveMethod /*method*/, uint64 /*kicker*/, const char* /*reason*/) override
    {
        sCrossFaction->UpdatePlayerTeam(group, guid, true);
    }

    // This script is called at the end of the leader change function - m_leader has already been set, we can use the group already (not the guids)
    void OnChangeLeader(Group* group, uint64 newLeaderGuid, uint64 oldLeaderGuid) override
    {
        sCrossFaction->UpdateGroupLeaderMap(newLeaderGuid);

        std::list<Group::MemberSlot> memberSlots = group->GetMemberSlots();
        for (std::list<Group::MemberSlot>::iterator membersIterator = memberSlots.begin(); membersIterator != memberSlots.end(); membersIterator++)
            sCrossFaction->UpdatePlayerTeam(group, (*membersIterator).guid);
    }

    // On disband, reset all the players to their default race
    void OnDisband(Group* group) override
    {
        std::list<Group::MemberSlot> memberSlots = group->GetMemberSlots();
        for (std::list<Group::MemberSlot>::iterator membersIterator = memberSlots.begin(); membersIterator != memberSlots.end(); membersIterator++)
            sCrossFaction->UpdatePlayerTeam(group, (*membersIterator).guid, true);
    }
};

class CrossFactionPlayer : public PlayerScript
{
public:

    CrossFactionPlayer() : PlayerScript("CrossFactionPlayer") { }

    // Called when a player switches to a new zone
    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea) override
    {
        sCrossFaction->UpdatePlayerTeam(player->GetGroup(), player->GetGUID());
    }

    // Called when a player changes to a new map (after moving to new map)
    void OnMapChanged(Player* player) override
    {
        sCrossFaction->UpdatePlayerTeam(player->GetGroup(), player->GetGUID());
    }

    void OnLogin(Player* player) override
    {
        sCrossFaction->UpdatePlayerTeam(player->GetGroup(), player->GetGUID());
    }

    void OnUpdateFaction(Player *player) override
    {
        sCrossFaction->UpdatePlayerTeam(player->GetGroup(), player->GetGUID());
    }

    void OnLogout(Player* player) override
    {
        // force faction reset on logout to prevent issues with DB save
        sCrossFaction->UpdatePlayerTeam(player->GetGroup(), player->GetGUID(),true);
    }
};

class CrossFactionWorld : public WorldScript
{
public:
    CrossFactionWorld() : WorldScript("CrossFactionWorld") { }

    void OnConfigLoad(bool reload) override
    {
        sCrossFaction->LoadConfig(reload);
    }

    void OnStartup() override
    {
        sCrossFaction->LoadConfig(false);
    }
};

void AddSC_CrossFactionGroups()
{
    new CrossFactionGroup();
    new CrossFactionPlayer();
    new CrossFactionWorld();
}


