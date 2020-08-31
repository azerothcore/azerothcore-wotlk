/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Interaction between core and LFGScripts
 */

#include "Common.h"
#include "SharedDefines.h"
#include "Player.h"
#include "Group.h"
#include "LFGScripts.h"
#include "LFGMgr.h"
#include "ScriptMgr.h"
#include "ObjectAccessor.h"
#include "WorldSession.h"

namespace lfg
{

LFGPlayerScript::LFGPlayerScript() : PlayerScript("LFGPlayerScript")
{
}

void LFGPlayerScript::OnLevelChanged(Player* player, uint8 /*oldLevel*/)
{
    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    sLFGMgr->InitializeLockedDungeons(player);
}

void LFGPlayerScript::OnLogout(Player* player)
{
    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    if (!player->GetGroup() || !player->GetGroup()->isLFGGroup())
    {
        player->GetSession()->SendLfgLfrList(false);
        sLFGMgr->LeaveLfg(player->GetGUID());
        sLFGMgr->LeaveAllLfgQueues(player->GetGUID(), true, player->GetGroup() ? player->GetGroup()->GetGUID() : 0);

        // pussywizard: after all necessary actions handle raid browser
        // pussywizard: already done above
        //if (sLFGMgr->GetState(player->GetGUID()) == LFG_STATE_RAIDBROWSER)
        //  sLFGMgr->LeaveLfg(player->GetGUID());
    }

    sLFGMgr->LfrSearchRemove(player);
}

void LFGPlayerScript::OnLogin(Player* player)
{
    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    // Temporal: Trying to determine when group data and LFG data gets desynched
    uint64 guid = player->GetGUID();
    uint64 gguid = sLFGMgr->GetGroup(guid);

    if (Group const* group = player->GetGroup())
    {
        uint64 gguid2 = group->GetGUID();
        if (gguid != gguid2)
        {
            //sLog->outError("%s on group %u but LFG has group %u saved... Fixing.",
            //    player->GetSession()->GetPlayerInfo().c_str(), GUID_LOPART(gguid2), GUID_LOPART(gguid));
            sLFGMgr->SetupGroupMember(guid, group->GetGUID());
        }
    }

    sLFGMgr->InitializeLockedDungeons(player);
    sLFGMgr->SetTeam(player->GetGUID(), player->GetTeamId());
    // TODO - Restore LfgPlayerData and send proper status to player if it was in a group
}

void LFGPlayerScript::OnBindToInstance(Player* player, Difficulty difficulty, uint32 mapId, bool /*permanent*/)
{
    MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);
    if (mapEntry->IsDungeon() && difficulty > DUNGEON_DIFFICULTY_NORMAL)
        sLFGMgr->InitializeLockedDungeons(player);
}

void LFGPlayerScript::OnMapChanged(Player* player)
{
    Map const* map = player->GetMap();

    if (sLFGMgr->inLfgDungeonMap(player->GetGUID(), map->GetId(), map->GetDifficulty()))
    {
        Group* group = player->GetGroup();
        // This function is also called when players log in
        // if for some reason the LFG system recognises the player as being in a LFG dungeon,
        // but the player was loaded without a valid group, we'll teleport to homebind to prevent
        // crashes or other undefined behaviour
        if (!group)
        {
            sLFGMgr->LeaveLfg(player->GetGUID());
            sLFGMgr->LeaveAllLfgQueues(player->GetGUID(), true);
            player->RemoveAurasDueToSpell(LFG_SPELL_LUCK_OF_THE_DRAW);
            player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, 0.0f);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_LFG, "LFGPlayerScript::OnMapChanged, Player %s (%u) is in LFG dungeon map but does not have a valid group! Teleporting to homebind.", player->GetName().c_str(), player->GetGUIDLow());
#endif
            return;
        }

        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            if (Player* member = itr->GetSource())
                player->GetSession()->SendNameQueryOpcode(member->GetGUID());

        if (group->IsLfgWithBuff())
            player->CastSpell(player, LFG_SPELL_LUCK_OF_THE_DRAW, true);
    }
    else
    {
        player->RemoveAurasDueToSpell(LFG_SPELL_LUCK_OF_THE_DRAW);

        // Xinef: Destroy group if only one player is left
        if (Group* group = player->GetGroup())
            if (group->GetMembersCount() <= 1u)
                group->Disband();
    }
}

LFGGroupScript::LFGGroupScript() : GroupScript("LFGGroupScript")
{
}

void LFGGroupScript::OnAddMember(Group* group, uint64 guid)
{
    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    uint64 gguid = group->GetGUID();
    uint64 leader = group->GetLeaderGUID();

    if (leader == guid)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_LFG, "LFGScripts::OnAddMember [" UI64FMTD "]: added [" UI64FMTD "] leader " UI64FMTD "]", gguid, guid, leader);
#endif
        sLFGMgr->SetLeader(gguid, guid);
    }
    else
    {
        LfgState gstate = sLFGMgr->GetState(gguid);
        LfgState state = sLFGMgr->GetState(guid);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_LFG, "LFGScripts::OnAddMember [" UI64FMTD "]: added [" UI64FMTD "] leader " UI64FMTD "] gstate: %u, state: %u", gguid, guid, leader, gstate, state);
#endif

        if (state == LFG_STATE_QUEUED)
            sLFGMgr->LeaveLfg(guid);

        if (gstate == LFG_STATE_QUEUED)
            sLFGMgr->LeaveLfg(gguid);
    }

    if (!group->isLFGGroup())
    {
        sLFGMgr->LeaveAllLfgQueues(leader, true, gguid); // pussywizard: invited, queued, party formed, neither party nor new member are queued, but leader is in queue solo!
        sLFGMgr->LeaveAllLfgQueues(guid, false);
    }

    sLFGMgr->SetGroup(guid, gguid);
    sLFGMgr->AddPlayerToGroup(gguid, guid);

    // pussywizard: after all necessary actions handle raid browser
    if (sLFGMgr->GetState(guid) == LFG_STATE_RAIDBROWSER)
        sLFGMgr->LeaveLfg(guid);
}

void LFGGroupScript::OnRemoveMember(Group* group, uint64 guid, RemoveMethod method, uint64 kicker, char const* reason)
{
    // used only with EXTRA_LOGS
    UNUSED(kicker);
    UNUSED(reason);

    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    uint64 gguid = group->GetGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGScripts::OnRemoveMember [" UI64FMTD "]: remove [" UI64FMTD "] Method: %d Kicker: [" UI64FMTD "] Reason: %s", gguid, guid, method, kicker, (reason ? reason : ""));
#endif

    bool isLFG = group->isLFGGroup();
    LfgState state = sLFGMgr->GetState(gguid);

    // If group is being formed after proposal success do nothing more
    if (state == LFG_STATE_PROPOSAL && method == GROUP_REMOVEMETHOD_DEFAULT)
    {
        // LfgData: Remove player from group
        sLFGMgr->SetGroup(guid, 0);
        sLFGMgr->RemovePlayerFromGroup(gguid, guid);
        return;
    }

    sLFGMgr->LeaveLfg(guid);
    sLFGMgr->LeaveAllLfgQueues(guid, true, gguid);
    sLFGMgr->SetGroup(guid, 0);
    uint8 players = sLFGMgr->RemovePlayerFromGroup(gguid, guid);

    // pussywizard: after all necessary actions handle raid browser
    // pussywizard: already done above
    //if (sLFGMgr->GetState(guid) == LFG_STATE_RAIDBROWSER)
    //  sLFGMgr->LeaveLfg(guid);

    // Xinef: only LFG groups can go below
    if (!isLFG)
        return;

    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
    {
        // xinef: fixed dungeon deserter
        if (method != GROUP_REMOVEMETHOD_KICK_LFG && state != LFG_STATE_FINISHED_DUNGEON && 
            player->HasAura(LFG_SPELL_DUNGEON_COOLDOWN) && players >= LFG_GROUP_KICK_VOTES_NEEDED)
        {
            player->AddAura(LFG_SPELL_DUNGEON_DESERTER, player);
        }
        //else if (state == LFG_STATE_BOOT)
            // Update internal kick cooldown of kicked

        player->GetSession()->SendLfgUpdateParty(LfgUpdateData(LFG_UPDATETYPE_LEADER_UNK1));
        if (player->GetMap()->IsDungeon())            // Teleport player out the dungeon
        {
            // Xinef: no longer valid sLFGMgr->TeleportPlayer(player, true);
            if (!player->IsBeingTeleportedFar() && player->GetMapId() == sLFGMgr->GetDungeonMapId(gguid))
                player->TeleportToEntryPoint();
        }
    }

    if (state != LFG_STATE_FINISHED_DUNGEON) // Need more players to finish the dungeon
        if (Player* leader = ObjectAccessor::FindPlayerInOrOutOfWorld(sLFGMgr->GetLeader(gguid)))
            leader->GetSession()->SendLfgOfferContinue(sLFGMgr->GetDungeon(gguid, false));
}

void LFGGroupScript::OnDisband(Group* group)
{
    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    uint64 gguid = group->GetGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGScripts::OnDisband [" UI64FMTD "]", gguid);
#endif

    // pussywizard: after all necessary actions handle raid browser
    if (sLFGMgr->GetState(group->GetLeaderGUID()) == LFG_STATE_RAIDBROWSER)
        sLFGMgr->LeaveLfg(group->GetLeaderGUID());

    sLFGMgr->RemoveGroupData(gguid);
}

void LFGGroupScript::OnChangeLeader(Group* group, uint64 newLeaderGuid, uint64 oldLeaderGuid)
{
    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    uint64 gguid = group->GetGUID();

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGScripts::OnChangeLeader [" UI64FMTD "]: old [" UI64FMTD "] new [" UI64FMTD "]", gguid, newLeaderGuid, oldLeaderGuid);
#endif
    sLFGMgr->SetLeader(gguid, newLeaderGuid);

    // pussywizard: after all necessary actions handle raid browser
    if (sLFGMgr->GetState(oldLeaderGuid) == LFG_STATE_RAIDBROWSER)
        sLFGMgr->LeaveLfg(oldLeaderGuid);
}

void LFGGroupScript::OnInviteMember(Group* group, uint64 guid)
{
    // used only with EXTRA_LOGS
    UNUSED(guid);

    if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    uint64 gguid = group->GetGUID();
    uint64 leader = group->GetLeaderGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGScripts::OnInviteMember [" UI64FMTD "]: invite [" UI64FMTD "] leader [" UI64FMTD "]", gguid, guid, leader);
#endif
    // No gguid ==  new group being formed
    // No leader == after group creation first invite is new leader
    // leader and no gguid == first invite after leader is added to new group (this is the real invite)
    if (leader && !gguid)
    {
        sLFGMgr->LeaveLfg(leader);
        sLFGMgr->LeaveAllLfgQueues(leader, true);
    }
}

} // namespace lfg
