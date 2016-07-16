// Copyright (c) 2016 AzerothCore
// Author: mik1893
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
            player->Whisper("This specific area has crossfaction disabled", LANG_UNIVERSAL, player->GetGUID());
            sLog->outError("Crossfaction disabled for player %s", player->GetName().c_str());
        }

        // if not reset, set the player's race to the group leader race
        if (!reset)
            if(!disable)
                if (group)
                    if (Player* groupLeader = ObjectAccessor::FindPlayer(group->GetLeaderGUID()))
                        player->setFactionForRace(groupLeader->getRace());

        // ANY OTHER CASE: just reset it back
        player->setFactionForRace(player->getRace());
    }
}

void CrossFaction::LoadConfig(bool reload)
{
    if (reload)
    {
        mapDisable.clear();
        zoneDisable.clear();
        areaDisable.clear();
    }

    QueryResult mapResult = ExtraDatabase.PQuery("SELECT id FROM crossfaction_disable where type = 1");
    QueryResult zoneResult = ExtraDatabase.PQuery("SELECT id FROM crossfaction_disable where type = 2");
    QueryResult areaResult = ExtraDatabase.PQuery("SELECT id FROM crossfaction_disable where type = 3");

    // load in the vector the different types of disable
    if (mapResult)
    {
        do
            mapDisable.push_back((*mapResult)[0].GetUInt32());
        while (mapResult->NextRow());
    }

    if (zoneResult)
    {
        do
            zoneDisable.push_back((*zoneResult)[0].GetUInt32());
        while (zoneResult->NextRow());
    }

    if (areaResult)
    {
        do
            areaDisable.push_back((*areaResult)[0].GetUInt32());
        while (areaResult->NextRow());
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


