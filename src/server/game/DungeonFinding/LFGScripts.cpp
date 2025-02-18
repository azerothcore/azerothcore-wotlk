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

/*
 * Interaction between core and LFGScripts
 */

#include "LFGScripts.h"
#include "Group.h"
#include "LFGMgr.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"

namespace lfg
{
    LFGPlayerScript::LFGPlayerScript() :
        PlayerScript("LFGPlayerScript",
        {
            PLAYERHOOK_ON_LEVEL_CHANGED,
            PLAYERHOOK_ON_LOGOUT,
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_ON_BIND_TO_INSTANCE,
            PLAYERHOOK_ON_MAP_CHANGED
        })
    {
    }

    void LFGPlayerScript::OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/)
    {
        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        sLFGMgr->InitializeLockedDungeons(player, player->GetGroup());
    }

    void LFGPlayerScript::OnPlayerLogout(Player* player)
    {
        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        if (!player->GetGroup() || !player->GetGroup()->isLFGGroup())
        {
            player->GetSession()->SendLfgLfrList(false);
            sLFGMgr->LeaveLfg(player->GetGUID());
            sLFGMgr->LeaveAllLfgQueues(player->GetGUID(), true, player->GetGroup() ? player->GetGroup()->GetGUID() : ObjectGuid::Empty);

            // pussywizard: after all necessary actions handle raid browser
            // pussywizard: already done above
            //if (sLFGMgr->GetState(player->GetGUID()) == LFG_STATE_RAIDBROWSER)
            //  sLFGMgr->LeaveLfg(player->GetGUID());
        }

        sLFGMgr->LfrSearchRemove(player);
    }

    void LFGPlayerScript::OnPlayerLogin(Player* player)
    {
        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        // Temporal: Trying to determine when group data and LFG data gets desynched
        ObjectGuid guid = player->GetGUID();
        ObjectGuid gguid = sLFGMgr->GetGroup(guid);

        Group const* group = player->GetGroup();
        if (group)
        {
            ObjectGuid gguid2 = group->GetGUID();
            if (gguid != gguid2)
            {
                sLFGMgr->SetupGroupMember(guid, group->GetGUID());
            }
        }

        sLFGMgr->InitializeLockedDungeons(player, group);
        sLFGMgr->SetTeam(player->GetGUID(), player->GetTeamId());
        /// @todo - Restore LfgPlayerData and send proper status to player if it was in a group
    }

    void LFGPlayerScript::OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapId, bool /*permanent*/)
    {
        MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);
        if (mapEntry->IsDungeon() && difficulty > DUNGEON_DIFFICULTY_NORMAL)
            sLFGMgr->InitializeLockedDungeons(player, player->GetGroup());
    }

    void LFGPlayerScript::OnPlayerMapChanged(Player* player)
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
                LOG_DEBUG("lfg", "LFGPlayerScript::OnMapChanged, Player {} ({}) is in LFG dungeon map but does not have a valid group! Teleporting to homebind.",
                    player->GetName(), player->GetGUID().ToString());
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

    LFGGroupScript::LFGGroupScript() :
        GroupScript("LFGGroupScript",
        {
            GROUPHOOK_ON_ADD_MEMBER,
            GROUPHOOK_ON_REMOVE_MEMBER,
            GROUPHOOK_ON_DISBAND,
            GROUPHOOK_ON_CHANGE_LEADER,
            GROUPHOOK_ON_INVITE_MEMBER
        })
    {
    }

    void LFGGroupScript::OnAddMember(Group* group, ObjectGuid guid)
    {
        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        ObjectGuid gguid = group->GetGUID();
        ObjectGuid leader = group->GetLeaderGUID();

        if (leader == guid)
        {
            LOG_DEBUG("lfg", "LFGScripts::OnAddMember [{}]: added [{}] leader [{}]", gguid.ToString(), guid.ToString(), leader.ToString());
            sLFGMgr->SetLeader(gguid, guid);
        }
        else
        {
            LfgState gstate = sLFGMgr->GetState(gguid);
            LfgState state = sLFGMgr->GetState(guid);
            LOG_DEBUG("lfg", "LFGScripts::OnAddMember [{}]: added [{}] leader [{}] gstate: {}, state: {}",
                gguid.ToString(), guid.ToString(), leader.ToString(), gstate, state);

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

    void LFGGroupScript::OnRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, char const* reason)
    {
        // used only with EXTRA_LOGS
        (void)kicker;
        (void)reason;

        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        ObjectGuid gguid = group->GetGUID();
        LOG_DEBUG("lfg", "LFGScripts::OnRemoveMember [{}]: remove [{}] Method: {} Kicker: [{}] Reason: {}",
            gguid.ToString(), guid.ToString(), method, kicker.ToString(), (reason ? reason : ""));

        bool isLFG = group->isLFGGroup();
        LfgState state = sLFGMgr->GetState(gguid);
        uint32 dungeonId = sLFGMgr->GetDungeon(gguid, false);

        // If group is being formed after proposal success do nothing more
        if (state == LFG_STATE_PROPOSAL && method == GROUP_REMOVEMETHOD_DEFAULT)
        {
            // LfgData: Remove player from group
            sLFGMgr->SetGroup(guid, ObjectGuid::Empty);
            sLFGMgr->RemovePlayerFromGroup(gguid, guid);
            return;
        }

        sLFGMgr->LeaveLfg(guid);
        sLFGMgr->LeaveAllLfgQueues(guid, true, gguid);
        sLFGMgr->SetGroup(guid, ObjectGuid::Empty);
        uint8 players = sLFGMgr->RemovePlayerFromGroup(gguid, guid);

        // pussywizard: after all necessary actions handle raid browser
        // pussywizard: already done above
        //if (sLFGMgr->GetState(guid) == LFG_STATE_RAIDBROWSER)
        //  sLFGMgr->LeaveLfg(guid);

        // Xinef: only LFG groups can go below
        if (!isLFG)
            return;

        if (state != LFG_STATE_FINISHED_DUNGEON && group) // Need more players to finish the dungeon
        {
            if (Player* leader = ObjectAccessor::FindConnectedPlayer(sLFGMgr->GetLeader(gguid)))
            {
                sLFGMgr->SetDungeon(gguid, dungeonId);
                leader->GetSession()->SendLfgOfferContinue(sLFGMgr->GetDungeon(gguid, false));
            }
        }

        if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
        {
            // xinef: fixed dungeon deserter
            if (method != GROUP_REMOVEMETHOD_KICK_LFG && state != LFG_STATE_FINISHED_DUNGEON &&
                    player->HasAura(LFG_SPELL_DUNGEON_COOLDOWN) && players >= LFG_GROUP_KICK_VOTES_NEEDED &&
                    sWorld->getBoolConfig(CONFIG_LFG_CAST_DESERTER))
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
    }

    void LFGGroupScript::OnDisband(Group* group)
    {
        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        ObjectGuid gguid = group->GetGUID();
        LOG_DEBUG("lfg", "LFGScripts::OnDisband [{}]", gguid.ToString());

        // pussywizard: after all necessary actions handle raid browser
        if (sLFGMgr->GetState(group->GetLeaderGUID()) == LFG_STATE_RAIDBROWSER)
            sLFGMgr->LeaveLfg(group->GetLeaderGUID());

        sLFGMgr->RemoveGroupData(gguid);
    }

    void LFGGroupScript::OnChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid)
    {
        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        ObjectGuid gguid = group->GetGUID();

        LOG_DEBUG("lfg", "LFGScripts::OnChangeLeader [{}]: old [{}] new [{}]",
            gguid.ToString(), newLeaderGuid.ToString(), oldLeaderGuid.ToString());
        sLFGMgr->SetLeader(gguid, newLeaderGuid);

        // pussywizard: after all necessary actions handle raid browser
        if (sLFGMgr->GetState(oldLeaderGuid) == LFG_STATE_RAIDBROWSER)
            sLFGMgr->LeaveLfg(oldLeaderGuid);
    }

    void LFGGroupScript::OnInviteMember(Group* group, ObjectGuid guid)
    {
        // used only with EXTRA_LOGS
        (void)guid;

        if (!sLFGMgr->isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER | LFG_OPTION_ENABLE_SEASONAL_BOSSES))
            return;

        ObjectGuid gguid = group->GetGUID();
        ObjectGuid leader = group->GetLeaderGUID();
        LOG_DEBUG("lfg", "LFGScripts::OnInviteMember [{}]: invite [{}] leader [{}]", gguid.ToString(), guid.ToString(), leader.ToString());
        // No gguid ==  new group being formed
        // No leader == after group creation first invite is new leader
        // leader and no gguid == first invite after leader is added to new group (this is the real invite)
        if (leader && !gguid)
        {
            sLFGMgr->LeaveLfg(leader);
            sLFGMgr->LeaveAllLfgQueues(leader, true);
        }
    }

    void AddSC_LFGScripts()
    {
        new LFGPlayerScript();
        new LFGGroupScript();
    }
} // namespace lfg
