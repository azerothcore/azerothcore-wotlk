/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "SharedDefines.h"
#include "DBCStores.h"
#include "DisableMgr.h"
#include "ObjectMgr.h"
#include "SocialMgr.h"
#include "Language.h"
#include "LFGMgr.h"
#include "LFGScripts.h"
#include "LFGGroupData.h"
#include "LFGPlayerData.h"
#include "LFGQueue.h"
#include "Group.h"
#include "SpellAuras.h"
#include "Player.h"
#include "GroupMgr.h"
#include "GameEventMgr.h"
#include "WorldSession.h"
#include "Opcodes.h"

namespace lfg
{

LFGMgr::LFGMgr(): m_lfgProposalId(1), m_options(sWorld->getIntConfig(CONFIG_LFG_OPTIONSMASK))
{
    new LFGPlayerScript();
    new LFGGroupScript();

    for (uint8 team=0; team<2; ++team)
    {
        m_raidBrowserUpdateTimer[team] = 10000;
        m_raidBrowserLastUpdatedDungeonId[team] = 0;
    }
}

LFGMgr::~LFGMgr()
{
    for (LfgRewardContainer::iterator itr = RewardMapStore.begin(); itr != RewardMapStore.end(); ++itr)
        delete itr->second;
}

LFGMgr* LFGMgr::instance()
{
    static LFGMgr instance;
    return &instance;
}

void LFGMgr::_LoadFromDB(Field* fields, uint64 guid)
{
    if (!fields)
        return;

    if (!IS_GROUP_GUID(guid))
        return;

    SetLeader(guid, MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER));

    uint32 dungeon = fields[17].GetUInt32();
    uint8 state = fields[18].GetUInt8();

    if (!dungeon || !state)
        return;

    SetDungeon(guid, dungeon);

    switch (state)
    {
        case LFG_STATE_DUNGEON:
        case LFG_STATE_FINISHED_DUNGEON:
            SetState(guid, (LfgState)state);
            break;
        default:
            break;
    }
}

void LFGMgr::_SaveToDB(uint64 guid)
{
    if (!IS_GROUP_GUID(guid))
        return;

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_LFG_DATA);
    stmt->setUInt32(0, GUID_LOPART(guid));
    stmt->setUInt32(1, GetDungeon(guid));
    stmt->setUInt32(2, GetState(guid));
    CharacterDatabase.Execute(stmt);
}

/// Load rewards for completing dungeons
void LFGMgr::LoadRewards()
{
    uint32 oldMSTime = getMSTime();

    for (LfgRewardContainer::iterator itr = RewardMapStore.begin(); itr != RewardMapStore.end(); ++itr)
        delete itr->second;
    RewardMapStore.clear();

    // ORDER BY is very important for GetRandomDungeonReward!
    QueryResult result = WorldDatabase.Query("SELECT dungeonId, maxLevel, firstQuestId, otherQuestId FROM lfg_dungeon_rewards ORDER BY dungeonId, maxLevel ASC");

    if (!result)
    {
        sLog->outError(">> Loaded 0 lfg dungeon rewards. DB table `lfg_dungeon_rewards` is empty!");
        return;
    }

    uint32 count = 0;

    Field* fields = nullptr;
    do
    {
        fields = result->Fetch();
        uint32 dungeonId = fields[0].GetUInt32();
        uint32 maxLevel = fields[1].GetUInt8();
        uint32 firstQuestId = fields[2].GetUInt32();
        uint32 otherQuestId = fields[3].GetUInt32();

        if (!GetLFGDungeonEntry(dungeonId))
        {
            sLog->outError("Dungeon %u specified in table `lfg_dungeon_rewards` does not exist!", dungeonId);
            continue;
        }

        if (!maxLevel || maxLevel > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            sLog->outError("Level %u specified for dungeon %u in table `lfg_dungeon_rewards` can never be reached!", maxLevel, dungeonId);
            maxLevel = sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL);
        }

        if (!firstQuestId || !sObjectMgr->GetQuestTemplate(firstQuestId))
        {
            sLog->outError("First quest %u specified for dungeon %u in table `lfg_dungeon_rewards` does not exist!", firstQuestId, dungeonId);
            continue;
        }

        if (otherQuestId && !sObjectMgr->GetQuestTemplate(otherQuestId))
        {
            sLog->outError("Other quest %u specified for dungeon %u in table `lfg_dungeon_rewards` does not exist!", otherQuestId, dungeonId);
            otherQuestId = 0;
        }

        RewardMapStore.insert(LfgRewardContainer::value_type(dungeonId, new LfgReward(maxLevel, firstQuestId, otherQuestId)));
        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u lfg dungeon rewards in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

LFGDungeonData const* LFGMgr::GetLFGDungeon(uint32 id)
{
    LFGDungeonContainer::const_iterator itr = LfgDungeonStore.find(id);
    if (itr != LfgDungeonStore.end())
        return &(itr->second);

    return nullptr;
}

void LFGMgr::LoadLFGDungeons(bool reload /* = false */)
{
    uint32 oldMSTime = getMSTime();

    LfgDungeonStore.clear();

    // Initialize Dungeon map with data from dbcs
    for (uint32 i = 0; i < sLFGDungeonStore.GetNumRows(); ++i)
    {
        LFGDungeonEntry const* dungeon = sLFGDungeonStore.LookupEntry(i);
        if (!dungeon)
            continue;

        switch (dungeon->type)
        {
            case LFG_TYPE_DUNGEON:
            case LFG_TYPE_HEROIC:
            case LFG_TYPE_RAID:
            case LFG_TYPE_RANDOM:
                LfgDungeonStore[dungeon->ID] = LFGDungeonData(dungeon);
                break;
        }
    }

    // Fill teleport locations from DB
    //                                                   0          1           2           3            4
    QueryResult result = WorldDatabase.Query("SELECT dungeonId, position_x, position_y, position_z, orientation FROM lfg_dungeon_template");

    if (!result)
    {
        sLog->outError(">> Loaded 0 lfg entrance positions. DB table `lfg_dungeon_template` is empty!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 dungeonId = fields[0].GetUInt32();
        LFGDungeonContainer::iterator dungeonItr = LfgDungeonStore.find(dungeonId);
        if (dungeonItr == LfgDungeonStore.end())
        {
            sLog->outError("table `lfg_dungeon_template` contains coordinates for wrong dungeon %u", dungeonId);
            continue;
        }

        LFGDungeonData& data = dungeonItr->second;
        data.x = fields[1].GetFloat();
        data.y = fields[2].GetFloat();
        data.z = fields[3].GetFloat();
        data.o = fields[4].GetFloat();

        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u lfg entrance positions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));

    // Fill all other teleport coords from areatriggers
    for (LFGDungeonContainer::iterator itr = LfgDungeonStore.begin(); itr != LfgDungeonStore.end(); ++itr)
    {
        LFGDungeonData& dungeon = itr->second;

        // No teleport coords in database, load from areatriggers
        if (dungeon.type != LFG_TYPE_RANDOM && dungeon.x == 0.0f && dungeon.y == 0.0f && dungeon.z == 0.0f)
        {
            AreaTriggerTeleport const* at = sObjectMgr->GetMapEntranceTrigger(dungeon.map);
            if (!at)
            {
                sLog->outError("LFGMgr::LoadLFGDungeons: Failed to load dungeon %s, cant find areatrigger for map %u", dungeon.name.c_str(), dungeon.map);
                continue;
            }

            dungeon.map = at->target_mapId;
            dungeon.x = at->target_X;
            dungeon.y = at->target_Y;
            dungeon.z = at->target_Z;
            dungeon.o = at->target_Orientation;
        }

        if (dungeon.type != LFG_TYPE_RANDOM)
            CachedDungeonMapStore[dungeon.group].insert(dungeon.id);
        CachedDungeonMapStore[0].insert(dungeon.id);
    }

    if (reload)
    {
        CachedDungeonMapStore.clear();
        // Recalculate locked dungeons
        for (LfgPlayerDataContainer::const_iterator it = PlayersStore.begin(); it != PlayersStore.end(); ++it)
            if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(it->first))
                InitializeLockedDungeons(player);
    }
}

void LFGMgr::Update(uint32 tdiff, uint8 task)
{
    if (!isOptionEnabled(LFG_OPTION_ENABLE_DUNGEON_FINDER | LFG_OPTION_ENABLE_RAID_BROWSER))
        return;

    if (task == 0)
    {
        time_t currTime = time(nullptr);

        // Remove obsolete role checks
        for (LfgRoleCheckContainer::iterator it = RoleChecksStore.begin(); it != RoleChecksStore.end();)
        {
            LfgRoleCheckContainer::iterator itRoleCheck = it++;
            LfgRoleCheck& roleCheck = itRoleCheck->second;
            if (currTime < roleCheck.cancelTime)
                continue;
            roleCheck.state = LFG_ROLECHECK_MISSING_ROLE;

            for (LfgRolesMap::const_iterator itRoles = roleCheck.roles.begin(); itRoles != roleCheck.roles.end(); ++itRoles)
            {
                uint64 guid = itRoles->first;
                RestoreState(guid, "Remove Obsolete RoleCheck");
                SendLfgRoleCheckUpdate(guid, roleCheck);
                if (guid == roleCheck.leader)
                    SendLfgJoinResult(guid, LfgJoinResultData(LFG_JOIN_FAILED, LFG_ROLECHECK_MISSING_ROLE));
            }

            RestoreState(itRoleCheck->first, "Remove Obsolete RoleCheck");
            RoleChecksStore.erase(itRoleCheck);
        }

        // Remove obsolete proposals
        for (LfgProposalContainer::iterator it = ProposalsStore.begin(); it != ProposalsStore.end();)
        {
            LfgProposalContainer::iterator itRemove = it++;
            if (itRemove->second.cancelTime < currTime)
                RemoveProposal(itRemove, LFG_UPDATETYPE_PROPOSAL_FAILED);
        }

        // Remove obsolete kicks
        for (LfgPlayerBootContainer::iterator it = BootsStore.begin(); it != BootsStore.end();)
        {
            LfgPlayerBootContainer::iterator itBoot = it++;
            LfgPlayerBoot& boot = itBoot->second;
            if (boot.cancelTime < currTime)
            {
                boot.inProgress = false;
                for (LfgAnswerContainer::const_iterator itVotes = boot.votes.begin(); itVotes != boot.votes.end(); ++itVotes)
                {
                    uint64 pguid = itVotes->first;
                    if (pguid != boot.victim)
                        SendLfgBootProposalUpdate(pguid, boot);
                    SetState(pguid, LFG_STATE_DUNGEON);
                }
                SetState(itBoot->first, LFG_STATE_DUNGEON);
                BootsStore.erase(itBoot);
            }
        }
    }
    else if (task == 1)
    {
        this->lastProposalId = m_lfgProposalId; // pussywizard: task 2 is done independantly, store previous value in LFGMgr for future use
        uint8 newGroupsProcessed = 0;
        // Check if a proposal can be formed with the new groups being added
        for (LfgQueueContainer::iterator it = QueuesStore.begin(); it != QueuesStore.end(); ++it)
        {
            newGroupsProcessed += it->second.FindGroups();
            if (newGroupsProcessed)
                break;
        }

        // Update all players status queue info
        if (!newGroupsProcessed) // don't do this on updates that precessed groups (performance)
            for (LfgQueueContainer::iterator it = QueuesStore.begin(); it != QueuesStore.end(); ++it)
                it->second.UpdateQueueTimers(tdiff);
    }
    else if (task == 2)
    {
        if (lastProposalId != m_lfgProposalId)
        {
            // pussywizard: only one proposal can be created in World::Update (during maps update), and it has id == m_lfgProposalId, so try to find only that one, dunno why for loop here xD
            for (LfgProposalContainer::const_iterator itProposal = ProposalsStore.find(m_lfgProposalId); itProposal != ProposalsStore.end(); ++itProposal)
            {
                uint32 proposalId = itProposal->first;
                LfgProposal& proposal = ProposalsStore[proposalId];

                uint64 guid = 0;
                for (LfgProposalPlayerContainer::const_iterator itPlayers = proposal.players.begin(); itPlayers != proposal.players.end(); ++itPlayers)
                {
                    guid = itPlayers->first;
                    SetState(guid, LFG_STATE_PROPOSAL);
                    if (uint64 gguid = GetGroup(guid))
                    {
                        SetState(gguid, LFG_STATE_PROPOSAL);
                        SendLfgUpdateParty(guid, LfgUpdateData(LFG_UPDATETYPE_PROPOSAL_BEGIN, GetSelectedDungeons(guid), GetComment(guid)));
                    }
                    else
                        SendLfgUpdatePlayer(guid, LfgUpdateData(LFG_UPDATETYPE_PROPOSAL_BEGIN, GetSelectedDungeons(guid), GetComment(guid)));
                    SendLfgUpdateProposal(guid, proposal);
                }

                if (proposal.state == LFG_PROPOSAL_SUCCESS) // pussywizard: no idea what's the purpose of this xD
                    UpdateProposal(proposalId, guid, true);
            }
        }

        UpdateRaidBrowser(tdiff);
    }
}

/**
    Generate the dungeon lock map for a given player

   @param[in]     player Player we need to initialize the lock status map
*/
void LFGMgr::InitializeLockedDungeons(Player* player, uint8 level /* = 0 */)
{
    uint64 guid = player->GetGUID();
    if (!level)
        level = player->getLevel();
    uint8 expansion = player->GetSession()->Expansion();
    LfgDungeonSet const& dungeons = GetDungeonsByRandom(0);
    LfgLockMap lock;

    float avgItemLevel = player->GetAverageItemLevelForDF();

    for (LfgDungeonSet::const_iterator it = dungeons.begin(); it != dungeons.end(); ++it)
    {
        LFGDungeonData const* dungeon = GetLFGDungeon(*it);
        if (!dungeon) // should never happen - We provide a list from sLFGDungeonStore
            continue;
        MapEntry const* mapEntry = sMapStore.LookupEntry(dungeon->map);

        uint32 lockData = 0;
        if (dungeon->expansion > expansion)
            lockData = LFG_LOCKSTATUS_INSUFFICIENT_EXPANSION;
        else if (DisableMgr::IsDisabledFor(DISABLE_TYPE_MAP, dungeon->map, player))
            lockData = LFG_LOCKSTATUS_RAID_LOCKED;
        else if (DisableMgr::IsDisabledFor(DISABLE_TYPE_LFG_MAP, dungeon->map, player))
            lockData = LFG_LOCKSTATUS_RAID_LOCKED;
        else if (dungeon->difficulty > DUNGEON_DIFFICULTY_NORMAL && (!mapEntry || !mapEntry->IsRaid()) && sInstanceSaveMgr->PlayerIsPermBoundToInstance(player->GetGUIDLow(), dungeon->map, Difficulty(dungeon->difficulty)))
            lockData = LFG_LOCKSTATUS_RAID_LOCKED;
        else if (dungeon->minlevel > level)
            lockData = LFG_LOCKSTATUS_TOO_LOW_LEVEL;
        else if (dungeon->maxlevel < level)
            lockData = LFG_LOCKSTATUS_TOO_HIGH_LEVEL;
        else if (dungeon->seasonal && !IsSeasonActive(dungeon->id))
            lockData = LFG_LOCKSTATUS_NOT_IN_SEASON;
        else if (AccessRequirement const* ar = sObjectMgr->GetAccessRequirement(dungeon->map, Difficulty(dungeon->difficulty)))
        {
            if (ar->achievement && !player->HasAchieved(ar->achievement))
                lockData = LFG_LOCKSTATUS_MISSING_ACHIEVEMENT;
            else if (ar->reqItemLevel && (float)ar->reqItemLevel > avgItemLevel)
                lockData = LFG_LOCKSTATUS_TOO_LOW_GEAR_SCORE;
            else if (player->GetTeamId() == TEAM_ALLIANCE && ar->quest_A && !player->GetQuestRewardStatus(ar->quest_A))
                lockData = LFG_LOCKSTATUS_QUEST_NOT_COMPLETED;
            else if (player->GetTeamId() == TEAM_HORDE && ar->quest_H && !player->GetQuestRewardStatus(ar->quest_H))
                lockData = LFG_LOCKSTATUS_QUEST_NOT_COMPLETED;
            else
                if (ar->item)
                {
                    if (!player->HasItemCount(ar->item) && (!ar->item2 || !player->HasItemCount(ar->item2)))
                        lockData = LFG_LOCKSTATUS_MISSING_ITEM;
                }
                else if (ar->item2 && !player->HasItemCount(ar->item2))
                    lockData = LFG_LOCKSTATUS_MISSING_ITEM;
        }


        sScriptMgr->OnInitializeLockedDungeons(player, level, lockData);

        /* TODO VoA closed if WG is not under team control (LFG_LOCKSTATUS_RAID_LOCKED)
            lockData = LFG_LOCKSTATUS_TOO_LOW_GEAR_SCORE;
            lockData = LFG_LOCKSTATUS_TOO_HIGH_GEAR_SCORE;
            lockData = LFG_LOCKSTATUS_ATTUNEMENT_TOO_LOW_LEVEL;
            lockData = LFG_LOCKSTATUS_ATTUNEMENT_TOO_HIGH_LEVEL;
        */

        if (lockData)
            lock[dungeon->Entry()] = lockData;
    }

    sScriptMgr->OnAfterInitializeLockedDungeons(player);

    SetLockedDungeons(guid, lock);
}

/**
    Adds the player/group to lfg queue. If player is in a group then it is the leader
    of the group tying to join the group. Join conditions are checked before adding
    to the new queue.

   @param[in]     player Player trying to join (or leader of group trying to join)
   @param[in]     roles Player selected roles
   @param[in]     dungeons Dungeons the player/group is applying for
   @param[in]     comment Player selected comment
*/
void LFGMgr::JoinLfg(Player* player, uint8 roles, LfgDungeonSet& dungeons, const std::string& comment)
{
    if (!player || dungeons.empty())
       return;

    Group* grp = player->GetGroup();
    uint64 guid = player->GetGUID();
    uint64 gguid = grp ? grp->GetGUID() : guid;
    LfgJoinResultData joinData;
    LfgGuidSet players;
    uint32 rDungeonId = 0;
    bool isContinue = grp && grp->isLFGGroup() && GetState(gguid) != LFG_STATE_FINISHED_DUNGEON;

    if (grp && (grp->isBGGroup() || grp->isBFGroup()))
        return;

    // pussywizard: can't join LFG/LFR while using LFR
    if (GetState(player->GetGUID()) == LFG_STATE_RAIDBROWSER)
    {
        LfgDungeonSet tmp;
        SendRaidBrowserJoinedPacket(player, tmp, ""); // the df "eye" can disappear in various case, resend if needed
        return;
    }

    // Do not allow to change dungeon in the middle of a current dungeon
    if (isContinue)
    {
        dungeons.clear();
        dungeons.insert(GetDungeon(gguid));
    }

    LfgState state = GetState(gguid);
    switch (state)
    {
        case LFG_STATE_ROLECHECK: // if joining again during rolecheck (eg. many players clicked continue inside instance)
            if (IS_GROUP_GUID(gguid))
                UpdateRoleCheck(gguid); // abort role check and remove from RoleChecksStore
            break;
        case LFG_STATE_QUEUED: // joining again while in a queue
            {
                LFGQueue& queue = GetQueue(gguid);
                queue.RemoveFromQueue(gguid);
            }
            break;
        case LFG_STATE_PROPOSAL: // if joining again during proposal
            joinData.result = LFG_JOIN_INTERNAL_ERROR;
            break;
        /*case LFG_STATE_FINISHED_DUNGEON:
            if (grp && grp->isLFGGroup())
                joinData.result = LFG_JOIN_PARTY_NOT_MEET_REQS;
            break;
        */
        default:
            break;
    }

    // Check if all dungeons are valid
    bool isRaid = false;
    if (joinData.result == LFG_JOIN_OK)
    {
        bool isDungeon = false;
        for (LfgDungeonSet::const_iterator it = dungeons.begin(); it != dungeons.end() && joinData.result == LFG_JOIN_OK; ++it)
        {
            LfgType type = GetDungeonType(*it);
            switch (type)
            {
                case LFG_TYPE_RANDOM:
                    if (dungeons.size() > 1)               // Only allow 1 random dungeon
                        joinData.result = LFG_JOIN_DUNGEON_INVALID;
                    else
                        rDungeonId = (*dungeons.begin());
                    // No break on purpose (Random can only be dungeon or heroic dungeon)
                case LFG_TYPE_HEROIC:
                case LFG_TYPE_DUNGEON:
                    if (isRaid)
                        joinData.result = LFG_JOIN_MIXED_RAID_DUNGEON;
                    isDungeon = true;
                    break;
                case LFG_TYPE_RAID:
                    if (isDungeon)
                        joinData.result = LFG_JOIN_MIXED_RAID_DUNGEON;
                    isRaid = true;
                    break;
                default:
                    sLog->outError("Wrong dungeon type %u for dungeon %u", type, *it);
                    joinData.result = LFG_JOIN_DUNGEON_INVALID;
                    break;
            }
        }
    }

    if (!isRaid && joinData.result == LFG_JOIN_OK)
    {
        // Check player or group member restrictions
        if (player->InBattleground() || player->InArena() || player->InBattlegroundQueue())
            joinData.result = LFG_JOIN_USING_BG_SYSTEM;
        else if (player->HasAura(LFG_SPELL_DUNGEON_DESERTER))
            joinData.result = LFG_JOIN_DESERTER;
        else if (dungeons.empty())
            joinData.result = LFG_JOIN_NOT_MEET_REQS;
        else if (grp)
        {
            if (grp->GetMembersCount() > MAXGROUPSIZE)
                joinData.result = LFG_JOIN_TOO_MUCH_MEMBERS;
            else
            {
                uint8 memberCount = 0;
                for (GroupReference* itr = grp->GetFirstMember(); itr != NULL && joinData.result == LFG_JOIN_OK; itr = itr->next())
                {
                    if (Player* plrg = itr->GetSource())
                    {
                        if (plrg->HasAura(LFG_SPELL_DUNGEON_DESERTER))
                            joinData.result = LFG_JOIN_PARTY_DESERTER;
                        else if (plrg->InBattleground() || plrg->InArena() || plrg->InBattlegroundQueue())
                            joinData.result = LFG_JOIN_USING_BG_SYSTEM;
                        ++memberCount;
                        players.insert(plrg->GetGUID());
                    }
                }

                if (joinData.result == LFG_JOIN_OK && memberCount != grp->GetMembersCount())
                    joinData.result = LFG_JOIN_DISCONNECTED;
            }
        }
        else
            players.insert(player->GetGUID());

        // Xinef: Check dungeon cooldown only for random dungeons
        // Xinef: Moreover check this only if dungeon is not started, afterwards its obvious that players will have the cooldown
        if (joinData.result == LFG_JOIN_OK && !isContinue && rDungeonId)
        {
            if (player->HasAura(LFG_SPELL_DUNGEON_COOLDOWN)) // xinef: added !isContinue
                joinData.result = LFG_JOIN_RANDOM_COOLDOWN;
            else if (grp)
            {
                for (GroupReference* itr = grp->GetFirstMember(); itr != NULL && joinData.result == LFG_JOIN_OK; itr = itr->next())
                    if (Player* plrg = itr->GetSource())
                        if (plrg->HasAura(LFG_SPELL_DUNGEON_COOLDOWN)) // xinef: added !isContinue
                            joinData.result = LFG_JOIN_PARTY_RANDOM_COOLDOWN;
            }
        }
    }

    if (isRaid)
        players.insert(player->GetGUID());

    if (joinData.result == LFG_JOIN_OK)
    {
        // Expand random dungeons and check restrictions
        if (rDungeonId)
            dungeons = GetDungeonsByRandom(rDungeonId);

        // if we have lockmap then there are no compatible dungeons
        // xinef: dont check compatibile dungeons for already running group (bind problems)
        if (!isContinue)
        {
            GetCompatibleDungeons(dungeons, players, joinData.lockmap);
            if (dungeons.empty())
                joinData.result = grp ? LFG_JOIN_PARTY_NOT_MEET_REQS : LFG_JOIN_NOT_MEET_REQS;
        }
    }

    // pussywizard:
    if (isRaid && grp && (grp->isLFGGroup() || guid != grp->GetLeaderGUID()))
        return;

    // Can't join. Send result
    if (joinData.result != LFG_JOIN_OK)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::Join: [" UI64FMTD "] joining with %u members. result: %u", guid, grp ? grp->GetMembersCount() : 1, joinData.result);
#endif
        if (!dungeons.empty())                             // Only should show lockmap when have no dungeons available
            joinData.lockmap.clear();
        player->GetSession()->SendLfgJoinResult(joinData);
        return;
    }

    SetComment(guid, comment);

    if (isRaid)
    {
        if (grp)
            roles = PLAYER_ROLE_LEADER;
        else 
            roles &= (PLAYER_ROLE_TANK | PLAYER_ROLE_HEALER | PLAYER_ROLE_DAMAGE);
        if (!roles)
            return;
        JoinRaidBrowser(player, roles, dungeons, comment);
        SetState(guid, LFG_STATE_RAIDBROWSER);
        SendRaidBrowserJoinedPacket(player, dungeons, comment);
        return;
    }

    std::string debugNames = "";
    if (grp)                                               // Begin rolecheck
    {
        // Create new rolecheck
        LfgRoleCheck& roleCheck = RoleChecksStore[gguid];
        roleCheck.roles.clear(); // pussywizard: NEW rolecheck, not old one with trash data >_>
        roleCheck.cancelTime = time_t(time(nullptr)) + LFG_TIME_ROLECHECK;
        roleCheck.state = LFG_ROLECHECK_INITIALITING;
        roleCheck.leader = guid;
        roleCheck.dungeons = dungeons;
        roleCheck.rDungeonId = rDungeonId;

        if (rDungeonId)
        {
            dungeons.clear();
            dungeons.insert(rDungeonId);
        }

        SetState(gguid, LFG_STATE_ROLECHECK);
        // Send update to player
        LfgUpdateData updateData = LfgUpdateData(LFG_UPDATETYPE_JOIN_QUEUE, dungeons, comment);
        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            if (Player* plrg = itr->GetSource())
            {
                uint64 pguid = plrg->GetGUID();
                plrg->GetSession()->SendLfgUpdateParty(updateData);
                SetState(pguid, LFG_STATE_ROLECHECK);
                if (!isContinue)
                    SetSelectedDungeons(pguid, dungeons);
                roleCheck.roles[pguid] = 0;
                if (!debugNames.empty())
                    debugNames.append(", ");
                debugNames.append(plrg->GetName());
            }
        }
        // Update leader role
        UpdateRoleCheck(gguid, guid, roles);
    }
    else                                                   // Add player to queue
    {
        LfgRolesMap rolesMap;
        rolesMap[guid] = roles;
        LFGQueue& queue = GetQueue(guid);
        queue.AddQueueData(guid, time(nullptr), dungeons, rolesMap);

        if (!isContinue)
        {
            if (rDungeonId)
            {
                dungeons.clear();
                dungeons.insert(rDungeonId);
            }
            SetSelectedDungeons(guid, dungeons);
        }
        // Send update to player
        player->GetSession()->SendLfgJoinResult(joinData);
        player->GetSession()->SendLfgUpdatePlayer(LfgUpdateData(LFG_UPDATETYPE_JOIN_QUEUE, dungeons, comment));
        SetState(guid, LFG_STATE_QUEUED);
        SetRoles(guid, roles);
        debugNames.append(player->GetName());
    }

    /*if (sLog->ShouldLog(LOG_FILTER_LFG, LOG_LEVEL_DEBUG))
    {
        std::ostringstream o;
        o << "LFGMgr::Join: [" << guid << "] joined (" << (grp ? "group" : "player") << ") Members: " << debugNames.c_str()
          << ". Dungeons (" << uint32(dungeons.size()) << "): " << ConcatenateDungeons(dungeons);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug((LOG_FILTER_LFG, "%s", o.str().c_str());
#endif
    }*/
}

/**
    Leaves Dungeon System. Player/Group is removed from queue, rolechecks, proposals
    or votekicks. Player or group needs to be not NULL and using Dungeon System

   @param[in]     guid Player or group guid
*/
void LFGMgr::LeaveLfg(uint64 guid)
{
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::Leave: [" UI64FMTD "]", guid);
    uint64 gguid = IS_GROUP_GUID(guid) ? guid : GetGroup(guid);
    LfgState state = GetState(guid);
    switch (state)
    {
        case LFG_STATE_QUEUED:
            if (gguid)
            {
                LFGQueue& queue = GetQueue(gguid);
                queue.RemoveFromQueue(gguid);
                SetState(gguid, LFG_STATE_NONE);
                const LfgGuidSet& players = GetPlayers(gguid);
                for (LfgGuidSet::const_iterator it = players.begin(); it != players.end(); ++it)
                {
                    SetState(*it, LFG_STATE_NONE);
                    SendLfgUpdateParty(*it, LfgUpdateData(LFG_UPDATETYPE_REMOVED_FROM_QUEUE));
                }
            }
            else
            {
                LFGQueue& queue = GetQueue(guid);
                queue.RemoveFromQueue(guid);
                SendLfgUpdatePlayer(guid, LfgUpdateData(LFG_UPDATETYPE_REMOVED_FROM_QUEUE));
                SetState(guid, LFG_STATE_NONE);
            }
            break;
        case LFG_STATE_ROLECHECK:
            if (gguid)
                UpdateRoleCheck(gguid);                    // No player to update role = LFG_ROLECHECK_ABORTED
            break;
        case LFG_STATE_PROPOSAL:
        {
            // Remove from Proposals
            LfgProposalContainer::iterator it = ProposalsStore.begin();
            uint64 pguid = gguid == guid ? GetLeader(gguid) : guid;
            while (it != ProposalsStore.end())
            {
                LfgProposalPlayerContainer::iterator itPlayer = it->second.players.find(pguid);
                if (itPlayer != it->second.players.end())
                {
                    // Mark the player/leader of group who left as didn't accept the proposal
                    itPlayer->second.accept = LFG_ANSWER_DENY;
                    break;
                }
                ++it;
            }

            // Remove from queue - if proposal is found, RemoveProposal will call RemoveFromQueue
            if (it != ProposalsStore.end())
                RemoveProposal(it, LFG_UPDATETYPE_PROPOSAL_DECLINED);
            break;
        }
        case LFG_STATE_NONE:
            break;
        case LFG_STATE_DUNGEON:
        case LFG_STATE_FINISHED_DUNGEON:
        case LFG_STATE_BOOT:
            if (guid != gguid) // Player
                SetState(guid, LFG_STATE_NONE);
            break;
        case LFG_STATE_RAIDBROWSER:
            LeaveRaidBrowser(guid);
            SetCanOverrideRBState(guid, true);
            SetState(guid, LFG_STATE_NONE);
            SetCanOverrideRBState(guid, false);
            SendLfgUpdatePlayer(guid, LfgUpdateData(LFG_UPDATETYPE_LEAVE_RAIDBROWSER));
            SendLfgUpdateParty(guid, LfgUpdateData(LFG_UPDATETYPE_LEAVE_RAIDBROWSER));
            break;
    }
}

void LFGMgr::JoinRaidBrowser(Player* player, uint8 roles, LfgDungeonSet& dungeons, std::string comment)
{
    // pussywizard: client limit for comment length is 64 @ 3.3.5a
    if (comment.size() > 64)
        comment = comment.substr(0, 64);

    RBEntryInfo entry(roles, comment);
    for (LfgDungeonSet::const_iterator itr = dungeons.begin(); itr != dungeons.end(); ++itr)
        if (GetLFGDungeon(*itr)) // ensure dungeon data exists for such dungeon id
        {
            RaidBrowserStore[player->GetTeamId()][*itr][player->GetGUIDLow()] = entry;
            RBUsedDungeonsStore[player->GetTeamId()].insert(*itr);
        }
}

void LFGMgr::LeaveRaidBrowser(uint64 guid)
{
    uint32 guidLow = GUID_LOPART(guid);
    for (uint8 team=0; team<2; ++team)
        for (RBStoreMap::iterator itr = RaidBrowserStore[team].begin(); itr != RaidBrowserStore[team].end(); ++itr)
            itr->second.erase(guidLow);
}

void LFGMgr::SendRaidBrowserJoinedPacket(Player* p, LfgDungeonSet& dungeons, std::string comment)
{
    if (dungeons.empty())
    {
        RBEntryInfoMap::iterator iter;
        uint8 team = p->GetTeamId();
        bool setComment = true;
        for (RBStoreMap::iterator itr = RaidBrowserStore[team].begin(); itr != RaidBrowserStore[team].end(); ++itr)
            if ((iter = itr->second.find(p->GetGUIDLow())) != itr->second.end())
            {
                dungeons.insert(itr->first);
                if (setComment)
                {
                    comment = iter->second.comment;
                    setComment = false;
                }
            }
    }
    LfgJoinResultData joinData;
    p->GetSession()->SendLfgJoinResult(joinData);
    LfgUpdateData updateData = LfgUpdateData(LFG_UPDATETYPE_JOIN_RAIDBROWSER, dungeons, comment);
    if (p->GetGroup())
        p->GetSession()->SendLfgUpdateParty(updateData);
    else
        p->GetSession()->SendLfgUpdatePlayer(updateData);
}

void LFGMgr::LfrSearchAdd(Player* p, uint32 dungeonId)
{
    RBSearchersStore[p->GetTeamId()][p->GetGUIDLow()] = dungeonId;
}

void LFGMgr::LfrSearchRemove(Player* p)
{
    RBSearchersStore[p->GetTeamId()].erase(p->GetGUIDLow());
}

void LFGMgr::SendRaidBrowserCachedList(Player* player, uint32 dungeonId)
{
    RBCacheMap::iterator itr = RBCacheStore[player->GetTeamId()].find(dungeonId);
    if (itr != RBCacheStore[player->GetTeamId()].end())
    {
        player->GetSession()->SendPacket(&(itr->second));
        return;
    }
    // send empty packet if cache not found
    WorldPacket data(SMSG_UPDATE_LFG_LIST, 1000);
    data << (uint32)LFG_TYPE_RAID;
    data << (uint32)dungeonId;
    data << (uint8)0;
    data << (uint32)0;
    data << (uint32)0;
    data << (uint32)0;
    data << (uint32)0;
    player->GetSession()->SendPacket(&data);
}

void LFGMgr::UpdateRaidBrowser(uint32 diff)
{
    for (uint8 team=0; team<2; ++team)
    {
        if (m_raidBrowserUpdateTimer[team] > diff)
            m_raidBrowserUpdateTimer[team] -= diff;
        else
            m_raidBrowserUpdateTimer[team] = 0;
    }

    if (getMSTimeDiff(World::GetGameTimeMS(), getMSTime()) > (70*7)/5) // prevent lagging
        return;

    uint64 guid, groupGuid, instanceGuid;
    uint8 level, Class, race, talents[3];
    float iLevel, mp5, mp5combat, baseAP, rangedAP;
    int32 spellDamage, spellHeal;
    uint32 dungeonId, encounterMask, maxPower;
    uint32 deletedCounter, groupCounter, playerCounter;
    ByteBuffer buffer_deleted, buffer_groups, buffer_players;
    std::string emptyComment;
    std::set<uint64> deletedGroups, deletedGroupsToErase;
    RBInternalInfoMap copy;

    for (uint8 team=0; team<2; ++team)
    {
        if (m_raidBrowserLastUpdatedDungeonId[team] == 0) // new loop
        {
            if (m_raidBrowserUpdateTimer[team] > 0) // allowed only with some time interval
                continue;
            else // reset timer
                m_raidBrowserUpdateTimer[team] = 5000;
        }

        RBUsedDungeonsSet::const_iterator neitr, titr;
        for (neitr = RBUsedDungeonsStore[team].begin(); neitr != RBUsedDungeonsStore[team].end(); )
        {
            titr = neitr++;
            dungeonId = (*titr);

            // go to next dungeon than previously (one dungeon updated in one LFGMgr::UpdateRaidBrowser)
            if (dungeonId <= m_raidBrowserLastUpdatedDungeonId[team])
                continue;
            m_raidBrowserLastUpdatedDungeonId[team] = dungeonId;

            RBEntryInfoMap& entryInfoMap = RaidBrowserStore[team][dungeonId];
            LFGDungeonData const* dungeonData = GetLFGDungeon(dungeonId); // checked if exists before inserting to the container
            RBInternalInfoMap& currInternalInfoMap = RBInternalInfoStoreCurr[team][dungeonId];
            for (RBEntryInfoMap::const_iterator sitr = entryInfoMap.begin(); sitr != entryInfoMap.end(); ++sitr)
            {
                guid = MAKE_NEW_GUID(sitr->first, 0, HIGHGUID_PLAYER);
                groupGuid = 0;
                Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
                ASSERT(p);
                if (sitr->second.roles == PLAYER_ROLE_LEADER)
                {
                    ASSERT(p->GetGroup());
                    groupGuid = p->GetGroup()->GetGUID();
                }
                encounterMask = 0;
                instanceGuid = 0;
                if (InstancePlayerBind* bind = sInstanceSaveMgr->PlayerGetBoundInstance(sitr->first, dungeonData->map, dungeonData->difficulty))
                    if (bind->perm)
                    {
                        instanceGuid = MAKE_NEW_GUID(bind->save->GetInstanceId(), 0, HIGHGUID_INSTANCE);
                        encounterMask = bind->save->GetCompletedEncounterMask();
                    }

                talents[0] = 0;
                talents[1] = 0;
                talents[2] = 0;
                p->GetTalentTreePoints(talents);
                spellDamage = p->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_ALL);
                spellHeal = p->SpellBaseHealingBonusDone(SPELL_SCHOOL_MASK_ALL);
                mp5 = p->GetFloatValue(UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER);
                mp5combat = p->GetFloatValue(UNIT_FIELD_POWER_REGEN_INTERRUPTED_FLAT_MODIFIER);
                baseAP = p->GetTotalAttackPowerValue(BASE_ATTACK);
                rangedAP = p->GetTotalAttackPowerValue(RANGED_ATTACK);
                maxPower = 0;
                if (p->getClass() == CLASS_DRUID)
                    maxPower = p->GetMaxPower(POWER_MANA);
                else
                    maxPower = (p->getPowerType() == POWER_RAGE || p->getPowerType() == POWER_RUNIC_POWER) ? p->GetMaxPower(p->getPowerType())/10 : p->GetMaxPower(p->getPowerType());

                currInternalInfoMap[sitr->first] = RBInternalInfo(guid, sitr->second.comment, groupGuid != 0, groupGuid, sitr->second.roles, encounterMask, instanceGuid,
                    1, p->getLevel(), p->getClass(), p->getRace(), p->GetAverageItemLevel(), 
                    talents, p->m_last_area_id, p->GetArmor(), (uint32)std::max<int32>(0, spellDamage), (uint32)std::max<int32>(0, spellHeal),
                    p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_CRIT_MELEE), p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_CRIT_RANGED), p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_CRIT_SPELL), std::max<float>(0.0f, mp5), std::max<float>(0.0f, mp5combat),
                    std::max<uint32>(baseAP, rangedAP), (uint32)p->GetStat(STAT_AGILITY), p->GetMaxHealth(), maxPower, p->GetDefenseSkillValue(),
                    p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_DODGE), p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_BLOCK), p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_PARRY), p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_HASTE_SPELL), p->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_EXPERTISE));

                if (!groupGuid)
                    continue;
                for (Group::member_citerator mitr = p->GetGroup()->GetMemberSlots().begin(); mitr != p->GetGroup()->GetMemberSlots().end(); ++mitr)
                {
                    if (mitr->guid == sitr->first) // leader already added
                        continue;
                    guid = MAKE_NEW_GUID(mitr->guid, 0, HIGHGUID_PLAYER);
                    level = 1;
                    Class = 0;
                    race = 0;
                    iLevel = 0.0f;
                    talents[0] = 0;
                    talents[1] = 0;
                    talents[2] = 0;
                    if (const GlobalPlayerData* gpd = sWorld->GetGlobalPlayerData(mitr->guid))
                    {
                        level = gpd->level;
                        Class = gpd->playerClass;
                        race = gpd->race;
                    }
                    Player* mplr = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
                    if (mplr)
                    {
                        iLevel = mplr->GetAverageItemLevel();
                        mplr->GetTalentTreePoints(talents);
                    }
                    currInternalInfoMap[mitr->guid] = RBInternalInfo(guid, emptyComment, false, groupGuid, 0, 0, 0,
                        (mplr ? 1 : 0), level, Class, race, iLevel, 
                        talents, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0);
                }
            }

            copy.clear();
            copy = currInternalInfoMap; // will be saved as prev at the end

            // compare prev with curr to build difference packet
            deletedCounter = 0; groupCounter = 0; playerCounter = 0;
            buffer_deleted.clear(); buffer_groups.clear(); buffer_players.clear();
            deletedGroups.clear(); deletedGroupsToErase.clear();

            RBInternalInfoMap& prevInternalInfoMap = RBInternalInfoStorePrev[team][dungeonId];
            RBInternalInfoMap::iterator iter, iterTmp;
            for (RBInternalInfoMap::const_iterator sitr = prevInternalInfoMap.begin(); sitr != prevInternalInfoMap.end(); ++sitr)
            {
                iter = currInternalInfoMap.find(sitr->first);
                if (iter == currInternalInfoMap.end()) // was -> isn't
                {
                    if (sitr->second.isGroupLeader)
                        deletedGroups.insert(sitr->second.groupGuid);
                    ++deletedCounter;
                    buffer_deleted << (uint64)sitr->second.guid;
                }
                else // was -> is
                {
                    if (sitr->second.isGroupLeader) // was a leader
                    {
                        if (!iter->second.isGroupLeader) // leader -> no longer a leader
                            deletedGroups.insert(sitr->second.groupGuid);
                        else if (sitr->second.groupGuid != iter->second.groupGuid) // leader -> leader of another group
                        {
                            deletedGroups.insert(sitr->second.groupGuid);
                            deletedGroupsToErase.insert(iter->second.groupGuid);
                            ++groupCounter;
                            RBPacketAppendGroup(iter->second, buffer_groups);
                        }
                        else if (sitr->second.comment != iter->second.comment || sitr->second.encounterMask != iter->second.encounterMask || sitr->second.instanceGuid != iter->second.instanceGuid) // leader -> nothing changed
                        {
                            ++groupCounter;
                            RBPacketAppendGroup(iter->second, buffer_groups);
                        }
                    }
                    else if (iter->second.isGroupLeader) // wasn't a leader -> is a leader
                    {
                        deletedGroupsToErase.insert(iter->second.groupGuid);
                        ++groupCounter;
                        RBPacketAppendGroup(iter->second, buffer_groups);
                    }

                    if (!iter->second._online) // if offline, copy previous stats (itemLevel, talents, area, etc.)
                    {
                        iterTmp = copy.find(sitr->first); // copied container is for building a full packet, so modify it there (currInternalInfoMap is erased)
                        iterTmp->second.CopyStats(sitr->second);
                        if (!sitr->second.PlayerSameAs(iterTmp->second)) // player info changed
                        {
                            ++playerCounter;
                            RBPacketAppendPlayer(iterTmp->second, buffer_players);
                        }
                    }
                    else if (!sitr->second.PlayerSameAs(iter->second)) // player info changed
                    {
                        ++playerCounter;
                        RBPacketAppendPlayer(iter->second, buffer_players);
                    }
                    currInternalInfoMap.erase(iter);
                }
            }
            // left entries (new)
            for (RBInternalInfoMap::const_iterator sitr = currInternalInfoMap.begin(); sitr != currInternalInfoMap.end(); ++sitr)
            {
                if (sitr->second.isGroupLeader)
                {
                    deletedGroupsToErase.insert(sitr->second.groupGuid);
                    ++groupCounter;
                    RBPacketAppendGroup(sitr->second, buffer_groups);
                }
                ++playerCounter;
                RBPacketAppendPlayer(sitr->second, buffer_players);
            }

            if (!deletedGroupsToErase.empty())
                for (std::set<uint64>::const_iterator sitr = deletedGroupsToErase.begin(); sitr != deletedGroupsToErase.end(); ++sitr)
                    deletedGroups.erase(*sitr);

            if (!deletedGroups.empty())
                for (std::set<uint64>::const_iterator sitr = deletedGroups.begin(); sitr != deletedGroups.end(); ++sitr)
                {
                    ++deletedCounter;
                    buffer_deleted << (*sitr);
                }

            WorldPacket differencePacket(SMSG_UPDATE_LFG_LIST, 1000);
            RBPacketBuildDifference(differencePacket, dungeonId, deletedCounter, buffer_deleted, groupCounter, buffer_groups, playerCounter, buffer_players);
            WorldPacket fullPacket(SMSG_UPDATE_LFG_LIST, 1000);
            RBPacketBuildFull(fullPacket, dungeonId, copy);

            RBCacheStore[team][dungeonId] = fullPacket;
            prevInternalInfoMap = copy;
            currInternalInfoMap.clear();

            if (entryInfoMap.empty())
                RBUsedDungeonsStore[team].erase(titr);

            // send difference packet to browsing players
            for (RBSearchersMap::const_iterator sitr = RBSearchersStore[team].begin(); sitr != RBSearchersStore[team].end(); ++sitr)
                if (sitr->second == dungeonId)
                    if (Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(MAKE_NEW_GUID(sitr->first, 0, HIGHGUID_PLAYER)))
                        p->GetSession()->SendPacket(&differencePacket);

            break; // one dungeon updated in one LFGMgr::UpdateRaidBrowser
        }

        // already updated all in this time interval
        if (neitr == RBUsedDungeonsStore[team].end())
            m_raidBrowserLastUpdatedDungeonId[team] = 0;
    }
}

void LFGMgr::RBPacketAppendGroup(const RBInternalInfo& info, ByteBuffer& buffer)
{
    buffer << (uint64)info.groupGuid;
    uint32 flags = LFG_UPDATE_FLAG_COMMENT | LFG_UPDATE_FLAG_ROLES | LFG_UPDATE_FLAG_BINDED;
    buffer << (uint32)flags;
    if (flags & LFG_UPDATE_FLAG_COMMENT)
        buffer << info.comment;
    if (flags & LFG_UPDATE_FLAG_ROLES)
        for (uint8 j=0; j<3; ++j)
            buffer << (uint8)0;
    if (!(flags & LFG_UPDATE_FLAG_BINDED))
        return;
    buffer << (uint64)info.instanceGuid;
    buffer << (uint32)info.encounterMask;
}

void LFGMgr::RBPacketAppendPlayer(const RBInternalInfo& info, ByteBuffer& buffer)
{
    buffer << (uint64)info.guid;
    uint32 flags = LFG_UPDATE_FLAG_CHARACTERINFO | LFG_UPDATE_FLAG_ROLES | LFG_UPDATE_FLAG_COMMENT | (info.groupGuid ? LFG_UPDATE_FLAG_GROUPGUID : LFG_UPDATE_FLAG_BINDED) | (info.isGroupLeader ? LFG_UPDATE_FLAG_GROUPLEADER : 0) | (!info.groupGuid || info.isGroupLeader ? LFG_UPDATE_FLAG_AREA : 0);
    buffer << (uint32)flags;

    if (flags & LFG_UPDATE_FLAG_CHARACTERINFO)
    {
        buffer << (uint8)info._level;
        buffer << (uint8)info._class;
        buffer << (uint8)info._race;
        buffer << (uint8)info._talents0;
        buffer << (uint8)info._talents1;
        buffer << (uint8)info._talents2;
        buffer << (uint32)info._armor;
        buffer << (uint32)info._spellDamage;
        buffer << (uint32)info._spellHeal;
        buffer << (uint32)info._critRatingMelee;
        buffer << (uint32)info._critRatingRanged;
        buffer << (uint32)info._critRatingSpell;
        buffer << (float)info._mp5;
        buffer << (float)info._mp5combat;
        buffer << (uint32)info._attackPower;
        buffer << (uint32)info._agility;
        buffer << (uint32)info._health;
        buffer << (uint32)info._mana;
        buffer << (uint32)info._online; // talentpoints, used as online/offline marker :D
        buffer << (float)info._avgItemLevel; // avgitemlevel
        buffer << (uint32)info._defenseSkill;
        buffer << (uint32)info._dodgeRating;
        buffer << (uint32)info._blockRating;
        buffer << (uint32)info._parryRating;
        buffer << (uint32)info._hasteRating;
        buffer << (uint32)info._expertiseRating;
    }

    if (flags & LFG_UPDATE_FLAG_COMMENT)
        buffer << (info.groupGuid ? std::string("") : info.comment);
    if (flags & LFG_UPDATE_FLAG_GROUPLEADER)
        buffer << (uint8)1; // isLFM
    if (flags & LFG_UPDATE_FLAG_GROUPGUID)
        buffer << (uint64)info.groupGuid;
    if (flags & LFG_UPDATE_FLAG_ROLES)
        buffer << (uint8)(info.groupGuid ? (info.isGroupLeader ? PLAYER_ROLE_LEADER : 0) : info.roles);
    if (flags & LFG_UPDATE_FLAG_AREA)
        buffer << (uint32)info._area;
    if (flags & LFG_UPDATE_FLAG_STATUS)
        buffer << (uint8)0;
    if (!(flags & LFG_UPDATE_FLAG_BINDED))
        return;
    buffer << (uint64)info.instanceGuid;
    buffer << (uint32)info.encounterMask;
}

void LFGMgr::RBPacketBuildDifference(WorldPacket& differencePacket, uint32 dungeonId, uint32 deletedCounter, ByteBuffer& buffer_deleted, uint32 groupCounter, ByteBuffer& buffer_groups, uint32 playerCounter, ByteBuffer& buffer_players)
{
    differencePacket << (uint32)LFG_TYPE_RAID;
    differencePacket << (uint32)dungeonId;
    differencePacket << (uint8)1;
    differencePacket << (uint32)deletedCounter;
    differencePacket.append(buffer_deleted);
    differencePacket << (uint32)groupCounter;
    differencePacket << (uint32)0;
    differencePacket.append(buffer_groups);
    differencePacket << (uint32)playerCounter;
    differencePacket << (uint32)0;
    differencePacket.append(buffer_players);
}

void LFGMgr::RBPacketBuildFull(WorldPacket& fullPacket, uint32 dungeonId, RBInternalInfoMap& infoMap)
{
    fullPacket << (uint32)LFG_TYPE_RAID;
    fullPacket << (uint32)dungeonId;
    fullPacket << (uint8)0;
    uint32 groupCounter = 0, playerCounter = 0;
    ByteBuffer buffer_groups, buffer_players;
    for (RBInternalInfoMap::const_iterator itr = infoMap.begin(); itr != infoMap.end(); ++itr)
    {
        if (itr->second.isGroupLeader)
        {
            ++groupCounter;
            RBPacketAppendGroup(itr->second, buffer_groups);
        }
        ++playerCounter;
        RBPacketAppendPlayer(itr->second, buffer_players);
    }
    fullPacket << (uint32)groupCounter;
    fullPacket << (uint32)0;
    fullPacket.append(buffer_groups);
    fullPacket << (uint32)playerCounter;
    fullPacket << (uint32)0;
    fullPacket.append(buffer_players);
}

// pussywizard:
void LFGMgr::LeaveAllLfgQueues(uint64 guid, bool allowgroup, uint64 groupguid)
{
    uint64 pguid = 0, gguid = 0;
    if (IS_GROUP_GUID(guid))
        gguid = guid;
    else if (groupguid && IS_GROUP_GUID(groupguid))
    {
        pguid = guid;
        gguid = groupguid;
    }
    else
    {
        pguid = guid;
        gguid = GetGroup(guid);
    }
    if (!allowgroup)
        gguid = 0;

    if (pguid)
        for (lfg::LfgQueueContainer::iterator itr = QueuesStore.begin(); itr != QueuesStore.end(); ++itr)
            itr->second.RemoveFromQueue(pguid);
    if (gguid)
        for (lfg::LfgQueueContainer::iterator itr = QueuesStore.begin(); itr != QueuesStore.end(); ++itr)
            itr->second.RemoveFromQueue(gguid);

    if (pguid && !gguid)
    {
        if (GetState(pguid) == LFG_STATE_QUEUED)
        {
            SendLfgUpdatePlayer(pguid, LfgUpdateData(LFG_UPDATETYPE_REMOVED_FROM_QUEUE));
            SetState(pguid, LFG_STATE_NONE);
        }
    }
    if (gguid)
    {
        if (GetState(gguid) == LFG_STATE_QUEUED)
        {
            SetState(gguid, LFG_STATE_NONE);
            const LfgGuidSet& players = GetPlayers(gguid);
            for (LfgGuidSet::const_iterator it = players.begin(); it != players.end(); ++it)
            {
                SetState(*it, LFG_STATE_NONE);
                SendLfgUpdateParty(*it, LfgUpdateData(LFG_UPDATETYPE_REMOVED_FROM_QUEUE));
            }
        }
    }
}

/**
   Update the Role check info with the player selected role.

   @param[in]     grp Group guid to update rolecheck
   @param[in]     guid Player guid (0 = rolecheck failed)
   @param[in]     roles Player selected roles
*/
void LFGMgr::UpdateRoleCheck(uint64 gguid, uint64 guid /* = 0 */, uint8 roles /* = PLAYER_ROLE_NONE */)
{
    if (!gguid)
        return;

    LfgRolesMap check_roles;
    LfgRoleCheckContainer::iterator itRoleCheck = RoleChecksStore.find(gguid);
    if (itRoleCheck == RoleChecksStore.end())
        return;

    LfgRoleCheck& roleCheck = itRoleCheck->second;
    bool sendRoleChosen = roleCheck.state != LFG_ROLECHECK_DEFAULT && guid;

    if (!guid)
        roleCheck.state = LFG_ROLECHECK_ABORTED;
    else if (roles < PLAYER_ROLE_TANK)                            // Player selected no role.
        roleCheck.state = LFG_ROLECHECK_NO_ROLE;
    else
    {
        roleCheck.roles[guid] = roles;

        // Check if all players have selected a role
        LfgRolesMap::const_iterator itRoles = roleCheck.roles.begin();
        while (itRoles != roleCheck.roles.end() && itRoles->second != PLAYER_ROLE_NONE)
            ++itRoles;

        if (itRoles == roleCheck.roles.end())
        {
            // use temporal var to check roles, CheckGroupRoles modifies the roles
            check_roles = roleCheck.roles;
            roleCheck.state = CheckGroupRoles(check_roles) ? LFG_ROLECHECK_FINISHED : LFG_ROLECHECK_WRONG_ROLES;
        }
    }

    LfgDungeonSet dungeons;
    if (roleCheck.rDungeonId)
        dungeons.insert(roleCheck.rDungeonId);
    else
        dungeons = roleCheck.dungeons;

    LfgJoinResultData joinData = LfgJoinResultData(LFG_JOIN_FAILED, roleCheck.state);
    for (LfgRolesMap::const_iterator it = roleCheck.roles.begin(); it != roleCheck.roles.end(); ++it)
    {
        uint64 pguid = it->first;

        if (sendRoleChosen)
            SendLfgRoleChosen(pguid, guid, roles);

        SendLfgRoleCheckUpdate(pguid, roleCheck);
        switch (roleCheck.state)
        {
            case LFG_ROLECHECK_INITIALITING:
                continue;
            case LFG_ROLECHECK_FINISHED:
                SetState(pguid, LFG_STATE_QUEUED);
                SetRoles(pguid, it->second);
                SendLfgUpdateParty(pguid, LfgUpdateData(LFG_UPDATETYPE_ADDED_TO_QUEUE, dungeons, GetComment(pguid)));
                break;
            default:
                if (roleCheck.leader == pguid)
                    SendLfgJoinResult(pguid, joinData);
                SendLfgUpdateParty(pguid, LfgUpdateData(LFG_UPDATETYPE_ROLECHECK_FAILED));
                RestoreState(pguid, "Rolecheck Failed");
                break;
        }
    }

    if (roleCheck.state == LFG_ROLECHECK_FINISHED)
    {
        SetState(gguid, LFG_STATE_QUEUED);
        LFGQueue& queue = GetQueue(gguid);
        queue.AddQueueData(gguid, time_t(time(nullptr)), roleCheck.dungeons, roleCheck.roles);
        RoleChecksStore.erase(itRoleCheck);
    }
    else if (roleCheck.state != LFG_ROLECHECK_INITIALITING)
    {
        RestoreState(gguid, "Rolecheck Failed");
        RoleChecksStore.erase(itRoleCheck);
    }
}

/**
   Given a list of dungeons remove the dungeons players have restrictions.

   @param[in, out] dungeons Dungeons to check restrictions
   @param[in]     players Set of players to check their dungeon restrictions
   @param[out]    lockMap Map of players Lock status info of given dungeons (Empty if dungeons is not empty)
*/
void LFGMgr::GetCompatibleDungeons(LfgDungeonSet& dungeons, LfgGuidSet const& players, LfgLockPartyMap& lockMap)
{
    lockMap.clear();
    for (LfgGuidSet::const_iterator it = players.begin(); it != players.end() && !dungeons.empty(); ++it)
    {
        uint64 guid = (*it);
        LfgLockMap const& cachedLockMap = GetLockedDungeons(guid);
        for (LfgLockMap::const_iterator it2 = cachedLockMap.begin(); it2 != cachedLockMap.end() && !dungeons.empty(); ++it2)
        {
            uint32 dungeonId = (it2->first & 0x00FFFFFF); // Compare dungeon ids
            LfgDungeonSet::iterator itDungeon = dungeons.find(dungeonId);
            if (itDungeon != dungeons.end())
            {
                dungeons.erase(itDungeon);
                lockMap[guid][dungeonId] = it2->second;
            }
        }
    }
    if (!dungeons.empty())
        lockMap.clear();
}

uint8 LFGMgr::CheckGroupRoles(LfgRolesMap& groles, bool removeLeaderFlag /*= true*/)
{
    if (groles.empty())
        return 0;

    uint8 damage = 0;
    uint8 tank = 0;
    uint8 healer = 0;

    if (removeLeaderFlag)
        for (LfgRolesMap::iterator it = groles.begin(); it != groles.end(); ++it)
            it->second &= ~PLAYER_ROLE_LEADER;

    for (LfgRolesMap::iterator it = groles.begin(); it != groles.end(); ++it)
    {
        if (it->second == PLAYER_ROLE_NONE)
            return 0;

        if (it->second & PLAYER_ROLE_DAMAGE)
        {
            if (it->second != PLAYER_ROLE_DAMAGE)
            {
                it->second -= PLAYER_ROLE_DAMAGE;
                if (uint8 x = CheckGroupRoles(groles, false))
                    return x;
                it->second += PLAYER_ROLE_DAMAGE;
            }
            else if (damage == LFG_DPS_NEEDED)
                return 0;
            else
                damage++;
        }

        if (it->second & PLAYER_ROLE_HEALER)
        {
            if (it->second != PLAYER_ROLE_HEALER)
            {
                it->second -= PLAYER_ROLE_HEALER;
                if (uint8 x = CheckGroupRoles(groles, false))
                    return x;
                it->second += PLAYER_ROLE_HEALER;
            }
            else if (healer == LFG_HEALERS_NEEDED)
                return 0;
            else
                healer++;
        }

        if (it->second & PLAYER_ROLE_TANK)
        {
            if (it->second != PLAYER_ROLE_TANK)
            {
                it->second -= PLAYER_ROLE_TANK;
                if (uint8 x = CheckGroupRoles(groles, false))
                    return x;
                it->second += PLAYER_ROLE_TANK;
            }
            else if (tank == LFG_TANKS_NEEDED)
                return 0;
            else
                tank++;
        }
    }
    if ((tank + healer + damage) == uint8(groles.size()))
        return (8*tank + 4*healer + damage);
    return 0;
}

/**
   Makes a new group given a proposal
   @param[in]     proposal Proposal to get info from
*/
void LFGMgr::MakeNewGroup(LfgProposal const& proposal)
{
    LfgGuidList players;
    LfgGuidList playersToTeleport;

    for (LfgProposalPlayerContainer::const_iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
    {
        uint64 guid = it->first;
        if (guid == proposal.leader)
            players.push_front(guid);
        else
            players.push_back(guid);

        if (proposal.isNew || GetGroup(guid) != proposal.group)
            playersToTeleport.push_back(guid);
    }

    // Set the dungeon difficulty
    LFGDungeonData const* dungeon = GetLFGDungeon(proposal.dungeonId);
    ASSERT(dungeon);

    Group* grp = proposal.group ? sGroupMgr->GetGroupByGUID(GUID_LOPART(proposal.group)) : nullptr;
    uint64 oldGroupGUID = 0;
    for (LfgGuidList::const_iterator it = players.begin(); it != players.end(); ++it)
    {
        uint64 pguid = (*it);
        Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(pguid);
        if (!player)
            continue;

        Group* group = player->GetGroup();

        // Xinef: Apply Random Buff
        if (grp && !grp->IsLfgWithBuff())
        {
            if (!group || group->GetGUID() != oldGroupGUID)
                grp->AddLfgBuffFlag();
            else
                oldGroupGUID = group->GetGUID();
        }

        // Xinef: Store amount of random players player grouped with
        if (group)
        {
            SetRandomPlayersCount(pguid, group->GetMembersCount() >= MAXGROUPSIZE ? 0 : MAXGROUPSIZE-group->GetMembersCount());
            oldGroupGUID = group->GetGUID();
            if (group != grp)
                group->RemoveMember(player->GetGUID());
        }
        else
            SetRandomPlayersCount(pguid, MAXGROUPSIZE-1);

        if (!grp)
        {
            grp = new Group();
            grp->ConvertToLFG();
            grp->Create(player);
            uint64 gguid = grp->GetGUID();
            SetState(gguid, LFG_STATE_PROPOSAL);
            sGroupMgr->AddGroup(grp);
        }
        else if (group != grp)
        {
            // pussywizard:
            if (!grp->IsFull())
                grp->AddMember(player);
            //else // some cleanup? LeaveLFG?
            //  ;
        }

        grp->SetLfgRoles(pguid, proposal.players.find(pguid)->second.role);
    }

    // pussywizard: crashfix, group wasn't created when iterating players (no player found by guid), proposal is deleted by the calling function
    if (!grp)
        return;

    grp->SetDungeonDifficulty(Difficulty(dungeon->difficulty));
    uint64 gguid = grp->GetGUID();
    SetDungeon(gguid, dungeon->Entry());
    SetState(gguid, LFG_STATE_DUNGEON);

    _SaveToDB(gguid);

    bool randomDungeon = false;
    // Teleport Player
    for (LfgGuidList::const_iterator it = playersToTeleport.begin(); it != playersToTeleport.end(); ++it)
        if (Player* player = ObjectAccessor::FindPlayer(*it))
        {
            if (player->GetGroup() != grp) // pussywizard: could not add because group was full (some shitness happened)
                continue;
            // Add the cooldown spell if queued for a random dungeon
            // xinef: add aura
            if ((randomDungeon || selectedRandomLfgDungeon(player->GetGUID())) && !player->HasAura(LFG_SPELL_DUNGEON_COOLDOWN))
            {
                randomDungeon = true;
                player->AddAura(LFG_SPELL_DUNGEON_COOLDOWN, player);
            }
            TeleportPlayer(player, false);
        }

    if (randomDungeon)
        grp->AddLfgRandomInstanceFlag();
    if (Difficulty(dungeon->difficulty) == DUNGEON_DIFFICULTY_HEROIC)
        grp->AddLfgHeroicFlag();

    // Update group info
    grp->SendUpdate();
}

uint32 LFGMgr::AddProposal(LfgProposal& proposal)
{
    proposal.id = ++m_lfgProposalId;
    ProposalsStore[m_lfgProposalId] = proposal;
    return m_lfgProposalId;
}

/**
   Update Proposal info with player answer

   @param[in]     proposalId Proposal id to be updated
   @param[in]     guid Player guid to update answer
   @param[in]     accept Player answer
*/
void LFGMgr::UpdateProposal(uint32 proposalId, uint64 guid, bool accept)
{
    // Check if the proposal exists
    LfgProposalContainer::iterator itProposal = ProposalsStore.find(proposalId);
    if (itProposal == ProposalsStore.end())
        return;

    LfgProposal& proposal = itProposal->second;

    // Check if proposal have the current player
    LfgProposalPlayerContainer::iterator itProposalPlayer = proposal.players.find(guid);
    if (itProposalPlayer == proposal.players.end())
        return;

    LfgProposalPlayer& player = itProposalPlayer->second;
    player.accept = LfgAnswer(accept);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::UpdateProposal: Player [" UI64FMTD "] of proposal %u selected: %u", guid, proposalId, accept);
#endif
    if (!accept)
    {
        RemoveProposal(itProposal, LFG_UPDATETYPE_PROPOSAL_DECLINED);
        return;
    }

    // check if all have answered and reorder players (leader first)
    bool allAnswered = true;
    for (LfgProposalPlayerContainer::const_iterator itPlayers = proposal.players.begin(); itPlayers != proposal.players.end(); ++itPlayers)
        if (itPlayers->second.accept != LFG_ANSWER_AGREE)   // No answer (-1) or not accepted (0)
            allAnswered = false;

    if (!allAnswered)
    {
        for (LfgProposalPlayerContainer::const_iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
            SendLfgUpdateProposal(it->first, proposal);

        return;
    }

    bool sendUpdate = proposal.state != LFG_PROPOSAL_SUCCESS;
    proposal.state = LFG_PROPOSAL_SUCCESS;
    time_t joinTime = time(nullptr);

    LFGQueue& queue = GetQueue(guid);
    LfgUpdateData updateData = LfgUpdateData(LFG_UPDATETYPE_GROUP_FOUND);
    for (LfgProposalPlayerContainer::const_iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
    {
        uint64 pguid = it->first;
        uint64 gguid = it->second.group;
        uint32 dungeonId = (*GetSelectedDungeons(pguid).begin());
        int32 waitTime = -1;
        if (sendUpdate)
           SendLfgUpdateProposal(pguid, proposal);

        if (gguid)
        {
            waitTime = int32((joinTime - queue.GetJoinTime(gguid)) / IN_MILLISECONDS);
            SendLfgUpdateParty(pguid, updateData);
        }
        else
        {
            waitTime = int32((joinTime - queue.GetJoinTime(pguid)) / IN_MILLISECONDS);
            SendLfgUpdatePlayer(pguid, updateData);
        }
        updateData.updateType = LFG_UPDATETYPE_REMOVED_FROM_QUEUE;
        SendLfgUpdatePlayer(pguid, updateData);
        SendLfgUpdateParty(pguid, updateData);

        // Update timers
        uint8 role = GetRoles(pguid);
        role &= ~PLAYER_ROLE_LEADER;
        switch (role)
        {
            case PLAYER_ROLE_DAMAGE:
                queue.UpdateWaitTimeDps(waitTime, dungeonId);
                break;
            case PLAYER_ROLE_HEALER:
                queue.UpdateWaitTimeHealer(waitTime, dungeonId);
                break;
            case PLAYER_ROLE_TANK:
                queue.UpdateWaitTimeTank(waitTime, dungeonId);
                break;
            default:
                queue.UpdateWaitTimeAvg(waitTime, dungeonId);
                break;
        }

        SetState(pguid, LFG_STATE_DUNGEON);
    }

    // Remove players/groups from Queue
    for (uint8 i=0; i<5 && proposal.queues.guid[i]; ++i)
        queue.RemoveQueueData(proposal.queues.guid[i]);

    MakeNewGroup(proposal);
    ProposalsStore.erase(itProposal);
}

/**
   Remove a proposal from the pool, remove the group that didn't accept (if needed) and readd the other members to the queue

   @param[in]     itProposal Iterator to the proposal to remove
   @param[in]     type Type of removal (LFG_UPDATETYPE_PROPOSAL_FAILED, LFG_UPDATETYPE_PROPOSAL_DECLINED)
*/
void LFGMgr::RemoveProposal(LfgProposalContainer::iterator itProposal, LfgUpdateType type)
{
    LfgProposal& proposal = itProposal->second;
    proposal.state = LFG_PROPOSAL_FAILED;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::RemoveProposal: Proposal %u, state FAILED, UpdateType %u", itProposal->first, type);
#endif
    // Mark all people that didn't answered as no accept
    if (type == LFG_UPDATETYPE_PROPOSAL_FAILED)
        for (LfgProposalPlayerContainer::iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
            if (it->second.accept == LFG_ANSWER_PENDING)
                it->second.accept = LFG_ANSWER_DENY;

    // pussywizard: add cooldown for not accepting (after 40 secs) or declining
    for (LfgProposalPlayerContainer::iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
        if (it->second.accept == LFG_ANSWER_DENY)
            if (Player* plr = sObjectAccessor->FindPlayer(it->first))
                if (Aura* aura = plr->AddAura(LFG_SPELL_DUNGEON_COOLDOWN, plr)) 
                    aura->SetDuration(150*IN_MILLISECONDS);

    // Mark players/groups to be removed
    LfgGuidSet toRemove;
    for (LfgProposalPlayerContainer::iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
    {
        if (it->second.accept == LFG_ANSWER_AGREE)
            continue;

        uint64 guid = it->second.group ? it->second.group : it->first;
        // Player didn't accept or still pending when no secs left
        if (it->second.accept == LFG_ANSWER_DENY || type == LFG_UPDATETYPE_PROPOSAL_FAILED)
        {
            it->second.accept = LFG_ANSWER_DENY;
            toRemove.insert(guid);
        }
    }

    // Notify players
    for (LfgProposalPlayerContainer::const_iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
    {
        uint64 guid = it->first;
        uint64 gguid = it->second.group ? it->second.group : guid;

        SendLfgUpdateProposal(guid, proposal);

        if (toRemove.find(gguid) != toRemove.end())         // Didn't accept or in same group that someone that didn't accept
        {
            LfgUpdateData updateData;
            if (it->second.accept == LFG_ANSWER_DENY)
            {
                updateData.updateType = type;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::RemoveProposal: [" UI64FMTD "] didn't accept. Removing from queue and compatible cache", guid);
#endif
            }
            else
            {
                updateData.updateType = LFG_UPDATETYPE_REMOVED_FROM_QUEUE;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::RemoveProposal: [" UI64FMTD "] in same group that someone that didn't accept. Removing from queue and compatible cache", guid);
#endif
            }

            RestoreState(guid, "Proposal Fail (didn't accepted or in group with someone that didn't accept");
            if (gguid != guid)
            {
                RestoreState(it->second.group, "Proposal Fail (someone in group didn't accepted)");
                SendLfgUpdateParty(guid, updateData);
            }
            else
                SendLfgUpdatePlayer(guid, updateData);
        }
        else
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::RemoveProposal: Readding [" UI64FMTD "] to queue.", guid);
#endif
            SetState(guid, LFG_STATE_QUEUED);
            if (gguid != guid)
            {
                SetState(gguid, LFG_STATE_QUEUED);
                SendLfgUpdateParty(guid, LfgUpdateData(LFG_UPDATETYPE_ADDED_TO_QUEUE, GetSelectedDungeons(guid), GetComment(guid)));
            }
            else
                SendLfgUpdatePlayer(guid, LfgUpdateData(LFG_UPDATETYPE_ADDED_TO_QUEUE, GetSelectedDungeons(guid), GetComment(guid)));
        }
    }

    LFGQueue& queue = GetQueue(proposal.players.begin()->first);
    // Remove players/groups from queue
    for (LfgGuidSet::const_iterator it = toRemove.begin(); it != toRemove.end(); ++it)
    {
        uint64 guid = *it;
        queue.RemoveFromQueue(guid);
        proposal.queues.remove(guid);
    }

    // Readd to queue
    for (uint8 i=0; i<5 && proposal.queues.guid[i]; ++i)
    {
        // xinef: this will work as data is not deleted, only references to this data are cleared
        // xinef: when new proposal is created
        // xinef: successful proposal is also taken into account is similar manner
        queue.AddToQueue(proposal.queues.guid[i], true);
    }

    ProposalsStore.erase(itProposal);
}

/**
   Initialize a boot kick vote

   @param[in]     gguid Group the vote kicks belongs to
   @param[in]     kicker Kicker guid
   @param[in]     victim Victim guid
   @param[in]     reason Kick reason
*/
void LFGMgr::InitBoot(uint64 gguid, uint64 kicker, uint64 victim, std::string const& reason)
{
    SetState(gguid, LFG_STATE_BOOT);

    LfgPlayerBoot& boot = BootsStore[gguid];
    boot.inProgress = true;
    boot.cancelTime = time_t(time(nullptr)) + LFG_TIME_BOOT;
    boot.reason = reason;
    boot.victim = victim;

    LfgGuidSet const& players = GetPlayers(gguid);

    // Set votes
    for (LfgGuidSet::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        uint64 guid = (*itr);
        SetState(guid, LFG_STATE_BOOT);
        boot.votes[guid] = LFG_ANSWER_PENDING;
    }

    boot.votes[victim] = LFG_ANSWER_DENY;                  // Victim auto vote NO
    boot.votes[kicker] = LFG_ANSWER_AGREE;                 // Kicker auto vote YES

    // Notify players
    for (LfgGuidSet::const_iterator it = players.begin(); it != players.end(); ++it)
        SendLfgBootProposalUpdate(*it, boot);
}

/**
   Update Boot info with player answer

   @param[in]     guid Player who has answered
   @param[in]     player answer
*/
void LFGMgr::UpdateBoot(uint64 guid, bool accept)
{
    uint64 gguid = GetGroup(guid);
    if (!gguid)
        return;

    LfgPlayerBootContainer::iterator itBoot = BootsStore.find(gguid);
    if (itBoot == BootsStore.end())
        return;

    LfgPlayerBoot& boot = itBoot->second;

    if (boot.votes[guid] != LFG_ANSWER_PENDING)    // Cheat check: Player can't vote twice
        return;

    boot.votes[guid] = LfgAnswer(accept);

    uint8 votesNum = 0;
    uint8 agreeNum = 0;
    for (LfgAnswerContainer::const_iterator itVotes = boot.votes.begin(); itVotes != boot.votes.end(); ++itVotes)
    {
        if (itVotes->second != LFG_ANSWER_PENDING)
        {
            ++votesNum;
            if (itVotes->second == LFG_ANSWER_AGREE)
                ++agreeNum;
        }
    }

    // if we don't have enough votes (agree or deny) do nothing
    if (agreeNum < LFG_GROUP_KICK_VOTES_NEEDED && (votesNum - agreeNum) < LFG_GROUP_KICK_VOTES_NEEDED)
        return;

    // Send update info to all players
    boot.inProgress = false;
    for (LfgAnswerContainer::const_iterator itVotes = boot.votes.begin(); itVotes != boot.votes.end(); ++itVotes)
    {
        uint64 pguid = itVotes->first;
        if (pguid != boot.victim)
        {
            SetState(pguid, LFG_STATE_DUNGEON);
            SendLfgBootProposalUpdate(pguid, boot);
        }
    }

    SetState(gguid, LFG_STATE_DUNGEON);
    if (agreeNum == LFG_GROUP_KICK_VOTES_NEEDED)           // Vote passed - Kick player
    {
        if (Group* group = sGroupMgr->GetGroupByGUID(GUID_LOPART(gguid)))
            Player::RemoveFromGroup(group, boot.victim, GROUP_REMOVEMETHOD_KICK_LFG);
        DecreaseKicksLeft(gguid);
    }
    BootsStore.erase(itBoot);
}

/**
   Teleports the player in or out the dungeon

   @param[in]     player Player to teleport
   @param[in]     out Teleport out (true) or in (false)
   @param[in]     fromOpcode Function called from opcode handlers? (Default false)
*/
void LFGMgr::TeleportPlayer(Player* player, bool out, bool fromOpcode /*= false*/)
{
    LFGDungeonData const* dungeon = nullptr;
    Group* group = player->GetGroup();

    if (group && group->isLFGGroup())
        dungeon = GetLFGDungeon(GetDungeon(group->GetGUID()));

    if (!dungeon)
    {
        player->GetSession()->SendLfgTeleportError(uint8(LFG_TELEPORTERROR_INVALID_LOCATION));
        return;
    }

    if (out)
    {
        if (player->GetMapId() == uint32(dungeon->map))
            player->TeleportToEntryPoint();

        return;
    }

    LfgTeleportError error = LFG_TELEPORTERROR_OK;

    if (!player->IsAlive())
        error = LFG_TELEPORTERROR_PLAYER_DEAD;
    else if (player->IsFalling() || player->HasUnitState(UNIT_STATE_JUMPING))
        error = LFG_TELEPORTERROR_FALLING;
    else if (player->IsMirrorTimerActive(FATIGUE_TIMER))
        error = LFG_TELEPORTERROR_FATIGUE;
    else if (player->GetVehicle())
        error = LFG_TELEPORTERROR_IN_VEHICLE;
    else if (player->GetCharmGUID())
        error = LFG_TELEPORTERROR_CHARMING;
    else if (player->GetMapId() != uint32(dungeon->map))  // Do not teleport players in dungeon to the entrance
    {
        uint32 mapid = dungeon->map;
        float x = dungeon->x;
        float y = dungeon->y;
        float z = dungeon->z;
        float orientation = dungeon->o;

        if (!fromOpcode)
        {
            // Select a player inside to be teleported to
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* plrg = itr->GetSource();
                if (plrg && plrg != player && plrg->GetMapId() == uint32(dungeon->map))
                {
                    mapid = plrg->GetMapId();
                    x = plrg->GetPositionX();
                    y = plrg->GetPositionY();
                    z = plrg->GetPositionZ();
                    orientation = plrg->GetOrientation();
                    break;
                }
            }
        }

        if (!player->GetMap()->IsDungeon())
            player->SetEntryPoint();

        if (!player->TeleportTo(mapid, x, y, z, orientation))
            error = LFG_TELEPORTERROR_INVALID_LOCATION;
    }
    else
        error = LFG_TELEPORTERROR_INVALID_LOCATION;

    if (error != LFG_TELEPORTERROR_OK)
        player->GetSession()->SendLfgTeleportError(uint8(error));

    //sLog->outDebug(LOG_FILTER_LFG, "TeleportPlayer: Player %s is being teleported in to map %u "
    //    "(x: %f, y: %f, z: %f) Result: %u", player->GetName().c_str(), dungeon->map,
    //    dungeon->x, dungeon->y, dungeon->z, error);
}

/**
   Finish a dungeon and give reward, if any.

   @param[in]     guid Group guid
   @param[in]     dungeonId Dungeonid
*/
void LFGMgr::FinishDungeon(uint64 gguid, const uint32 dungeonId, const Map* currMap)
{
    uint32 gDungeonId = GetDungeon(gguid);
    if (gDungeonId != dungeonId)
    {
        sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] Finished dungeon %u but group queued for %u. Ignoring", gguid, dungeonId, gDungeonId);
        return;
    }

    if (GetState(gguid) == LFG_STATE_FINISHED_DUNGEON) // Shouldn't happen. Do not reward multiple times
    {
        sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] Already rewarded group. Ignoring", gguid);
        return;
    }

    SetState(gguid, LFG_STATE_FINISHED_DUNGEON);
    _SaveToDB(gguid); // pussywizard

    const LfgGuidSet& players = GetPlayers(gguid);
    for (LfgGuidSet::const_iterator it = players.begin(); it != players.end(); ++it)
    {
        uint64 guid = (*it);
        if (GetState(guid) == LFG_STATE_FINISHED_DUNGEON)
        {
            sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] Already rewarded player. Ignoring", guid);
            continue;
        }

        uint32 rDungeonId = 0;
        const LfgDungeonSet& dungeons = GetSelectedDungeons(guid);
        if (!dungeons.empty())
            rDungeonId = (*dungeons.begin());

        SetState(guid, LFG_STATE_FINISHED_DUNGEON);

        // Give rewards only if its a random dungeon
        LFGDungeonData const* dungeon = GetLFGDungeon(rDungeonId);

        if (!dungeon || (dungeon->type != LFG_TYPE_RANDOM && !dungeon->seasonal))
        {
            sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] dungeon %u is not random or seasonal", guid, rDungeonId);
            continue;
        }

        Player* player = ObjectAccessor::FindPlayer(guid);
        if (!player || player->FindMap() != currMap) // pussywizard: currMap - multithreading crash if on other map (map id check is not enough, binding system is not reliable)
        {
            sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] not found in world", guid);
            continue;
        }

        LFGDungeonData const* dungeonDone = GetLFGDungeon(dungeonId);
        uint32 mapId = dungeonDone ? uint32(dungeonDone->map) : 0;

        if (player->GetMapId() != mapId)
        {
            sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] is in map %u and should be in %u to get reward", guid, player->GetMapId(), mapId);
            continue;
        }

        // Xinef: Update achievements, set correct amount of randomly grouped players
        if (dungeon->difficulty == DUNGEON_DIFFICULTY_HEROIC)
            if (uint8 count = GetRandomPlayersCount(player->GetGUID()))
                player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_USE_LFD_TO_GROUP_WITH_PLAYERS, count);

        LfgReward const* reward = GetRandomDungeonReward(rDungeonId, player->getLevel());
        if (!reward)
            continue;

        bool done = false;
        Quest const* quest = sObjectMgr->GetQuestTemplate(reward->firstQuest);
        if (!quest)
            continue;

        // if we can take the quest, means that we haven't done this kind of "run", IE: First Heroic Random of Day.
        if (player->CanRewardQuest(quest, false))
            player->RewardQuest(quest, 0, NULL, false);
        else
        {
            done = true;
            quest = sObjectMgr->GetQuestTemplate(reward->otherQuest);
            if (!quest)
                continue;
            // we give reward without informing client (retail does this)
            player->RewardQuest(quest, 0, NULL, false);
        }

        // Give rewards
        sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::FinishDungeon: [" UI64FMTD "] done dungeon %u, %s previously done.", player->GetGUID(), GetDungeon(gguid), done? " " : " not");
        LfgPlayerRewardData data = LfgPlayerRewardData(dungeon->Entry(), GetDungeon(gguid, false), done, quest);
        player->GetSession()->SendLfgPlayerReward(data);
    }
}

// --------------------------------------------------------------------------//
// Auxiliar Functions
// --------------------------------------------------------------------------//

/**
   Get the dungeon list that can be done given a random dungeon entry.

   @param[in]     randomdungeon Random dungeon id (if value = 0 will return all dungeons)
   @returns Set of dungeons that can be done.
*/
LfgDungeonSet const& LFGMgr::GetDungeonsByRandom(uint32 randomdungeon)
{
    LFGDungeonData const* dungeon = GetLFGDungeon(randomdungeon);
    uint32 group = dungeon ? dungeon->group : 0;
    return CachedDungeonMapStore[group];
}

/**
   Get the reward of a given random dungeon at a certain level

   @param[in]     dungeon dungeon id
   @param[in]     level Player level
   @returns Reward
*/
LfgReward const* LFGMgr::GetRandomDungeonReward(uint32 dungeon, uint8 level)
{
    LfgReward const* rew = nullptr;
    LfgRewardContainerBounds bounds = RewardMapStore.equal_range(dungeon & 0x00FFFFFF);
    for (LfgRewardContainer::const_iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        rew = itr->second;
        // ordered properly at loading
        if (itr->second->maxLevel >= level)
            break;
    }

    return rew;
}

/**
   Given a Dungeon id returns the dungeon Type

   @param[in]     dungeon dungeon id
   @returns Dungeon type
*/
LfgType LFGMgr::GetDungeonType(uint32 dungeonId)
{
    LFGDungeonData const* dungeon = GetLFGDungeon(dungeonId);
    if (!dungeon)
        return LFG_TYPE_NONE;

    return LfgType(dungeon->type);
}

LfgState LFGMgr::GetState(uint64 guid)
{
    LfgState state;
    if (IS_GROUP_GUID(guid))
        state = GroupsStore[guid].GetState();
    else
        state = PlayersStore[guid].GetState();

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetState: [" UI64FMTD "] = %u", guid, state);
#endif
    return state;
}

LfgState LFGMgr::GetOldState(uint64 guid)
{
    LfgState state;
    if (IS_GROUP_GUID(guid))
        state = GroupsStore[guid].GetOldState();
    else
        state = PlayersStore[guid].GetOldState();

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetOldState: [" UI64FMTD "] = %u", guid, state);
#endif
    return state;
}

uint32 LFGMgr::GetDungeon(uint64 guid, bool asId /*= true */)
{
    uint32 dungeon = GroupsStore[guid].GetDungeon(asId);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetDungeon: [" UI64FMTD "] asId: %u = %u", guid, asId, dungeon);
#endif
    return dungeon;
}

uint32 LFGMgr::GetDungeonMapId(uint64 guid)
{
    uint32 dungeonId = GroupsStore[guid].GetDungeon(true);
    uint32 mapId = 0;
    if (dungeonId)
        if (LFGDungeonData const* dungeon = GetLFGDungeon(dungeonId))
            mapId = dungeon->map;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetDungeonMapId: [" UI64FMTD "] = %u (DungeonId = %u)", guid, mapId, dungeonId);
#endif
    return mapId;
}

uint8 LFGMgr::GetRoles(uint64 guid)
{
    uint8 roles = PlayersStore[guid].GetRoles();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetRoles: [" UI64FMTD "] = %u", guid, roles);
#endif
    return roles;
}

const std::string& LFGMgr::GetComment(uint64 guid)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetComment: [" UI64FMTD "] = %s", guid, PlayersStore[guid].GetComment().c_str());
#endif
    return PlayersStore[guid].GetComment();
}

LfgDungeonSet const& LFGMgr::GetSelectedDungeons(uint64 guid)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetSelectedDungeons: [" UI64FMTD "]", guid);
#endif
    return PlayersStore[guid].GetSelectedDungeons();
}

LfgLockMap const& LFGMgr::GetLockedDungeons(uint64 guid)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetLockedDungeons: [" UI64FMTD "]", guid);
#endif
    return PlayersStore[guid].GetLockedDungeons();
}

uint8 LFGMgr::GetKicksLeft(uint64 guid)
{
    uint8 kicks = GroupsStore[guid].GetKicksLeft();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::GetKicksLeft: [" UI64FMTD "] = %u", guid, kicks);
#endif
    return kicks;
}

void LFGMgr::RestoreState(uint64 guid, char const*  /*debugMsg*/)
{
    if (IS_GROUP_GUID(guid))
    {
        LfgGroupData& data = GroupsStore[guid];
        /*if (sLog->ShouldLog(LOG_FILTER_LFG, LOG_LEVEL_DEBUG))
        {
            std::string const& ps = GetStateString(data.GetState());
            std::string const& os = GetStateString(data.GetOldState());
            sLog->outTrace(LOG_FILTER_LFG, "LFGMgr::RestoreState: Group: [" UI64FMTD "] (%s) State: %s, oldState: %s",
                guid, debugMsg, ps.c_str(), os.c_str());
        }*/

        data.RestoreState();
    }
    else
    {
        LfgPlayerData& data = PlayersStore[guid];
        /*if (sLog->ShouldLog(LOG_FILTER_LFG, LOG_LEVEL_DEBUG))
        {
            std::string const& ps = GetStateString(data.GetState());
            std::string const& os = GetStateString(data.GetOldState());
            sLog->outTrace(LOG_FILTER_LFG, "LFGMgr::RestoreState: Player: [" UI64FMTD "] (%s) State: %s, oldState: %s",
                guid, debugMsg, ps.c_str(), os.c_str());
        }*/
        data.RestoreState();
    }
}

void LFGMgr::SetState(uint64 guid, LfgState state)
{
    if (IS_GROUP_GUID(guid))
    {
        LfgGroupData& data = GroupsStore[guid];
        std::string ns = GetStateString(state);
        std::string ps = GetStateString(data.GetState());
        std::string os = GetStateString(data.GetOldState());
        sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetState: Group: [" UI64FMTD "] newState: %s, previous: %s, oldState: %s", guid, ns.c_str(), ps.c_str(), os.c_str());
        data.SetState(state);
    }
    else
    {
        LfgPlayerData& data = PlayersStore[guid];
        std::string ns = GetStateString(state);
        std::string ps = GetStateString(data.GetState());
        std::string os = GetStateString(data.GetOldState());
        sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetState: Player: [" UI64FMTD "] newState: %s, previous: %s, oldState: %s", guid, ns.c_str(), ps.c_str(), os.c_str());
        data.SetState(state);
    }
}

void LFGMgr::SetCanOverrideRBState(uint64 guid, bool val)
{
    PlayersStore[guid].SetCanOverrideRBState(val);
}

void LFGMgr::SetDungeon(uint64 guid, uint32 dungeon)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetDungeon: [" UI64FMTD "] dungeon %u", guid, dungeon);
#endif
    GroupsStore[guid].SetDungeon(dungeon);
}

void LFGMgr::SetRoles(uint64 guid, uint8 roles)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetRoles: [" UI64FMTD "] roles: %u", guid, roles);
#endif
    PlayersStore[guid].SetRoles(roles);
}

void LFGMgr::SetComment(uint64 guid, std::string const& comment)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetComment: [" UI64FMTD "] comment: %s", guid, comment.c_str());
#endif
    PlayersStore[guid].SetComment(comment);
}

void LFGMgr::LfrSetComment(Player* p, std::string comment)
{
    // pussywizard: client limit for comment length is 64 @ 3.3.5a
    if (comment.size() > 64)
        comment = comment.substr(0, 64);

    uint8 teamId = p->GetTeamId();
    RBEntryInfoMap::iterator iter;
    for (RBStoreMap::iterator itr = RaidBrowserStore[teamId].begin(); itr != RaidBrowserStore[teamId].end(); ++itr)
        if ((iter = itr->second.find(p->GetGUIDLow())) != itr->second.end())
            iter->second.comment = comment;
}

void LFGMgr::SetSelectedDungeons(uint64 guid, LfgDungeonSet const& dungeons)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetLockedDungeons: [" UI64FMTD "]", guid);
#endif
    PlayersStore[guid].SetSelectedDungeons(dungeons);
}

void LFGMgr::SetLockedDungeons(uint64 guid, LfgLockMap const& lock)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::SetLockedDungeons: [" UI64FMTD "]", guid);
#endif
    PlayersStore[guid].SetLockedDungeons(lock);
}

void LFGMgr::DecreaseKicksLeft(uint64 guid)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::DecreaseKicksLeft: [" UI64FMTD "]", guid);
#endif
    GroupsStore[guid].DecreaseKicksLeft();
}

void LFGMgr::RemoveGroupData(uint64 guid)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "LFGMgr::RemoveGroupData: [" UI64FMTD "]", guid);
#endif
    LfgGroupDataContainer::iterator it = GroupsStore.find(guid);
    if (it == GroupsStore.end())
        return;

    LfgState state = GetState(guid);
    // If group is being formed after proposal success do nothing more
    LfgGuidSet const& players = it->second.GetPlayers();
    for (LfgGuidSet::const_iterator it = players.begin(); it != players.end(); ++it)
    {
        uint64 guid = (*it);
        SetGroup(*it, 0);
        if (state != LFG_STATE_PROPOSAL)
        {
            SetState(*it, LFG_STATE_NONE);
            SendLfgUpdateParty(guid, LfgUpdateData(LFG_UPDATETYPE_REMOVED_FROM_QUEUE));
        }
    }
    GroupsStore.erase(it);
}

TeamId LFGMgr::GetTeam(uint64 guid)
{
    return PlayersStore[guid].GetTeam();
}

uint8 LFGMgr::RemovePlayerFromGroup(uint64 gguid, uint64 guid)
{
    return GroupsStore[gguid].RemovePlayer(guid);
}

void LFGMgr::AddPlayerToGroup(uint64 gguid, uint64 guid)
{
    GroupsStore[gguid].AddPlayer(guid);
}

void LFGMgr::SetLeader(uint64 gguid, uint64 leader)
{
    GroupsStore[gguid].SetLeader(leader);
}

void LFGMgr::SetTeam(uint64 guid, TeamId teamId)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP))
        teamId = TEAM_ALLIANCE; // @Not Sure About That TeamId is supposed to be uint8 Team = 0(@TrinityCore)

    PlayersStore[guid].SetTeam(teamId);
}

uint64 LFGMgr::GetGroup(uint64 guid)
{
    return PlayersStore[guid].GetGroup();
}

void LFGMgr::SetGroup(uint64 guid, uint64 group)
{
    PlayersStore[guid].SetGroup(group);
}

LfgGuidSet const& LFGMgr::GetPlayers(uint64 guid)
{
    return GroupsStore[guid].GetPlayers();
}

uint8 LFGMgr::GetPlayerCount(uint64 guid)
{
    return GroupsStore[guid].GetPlayerCount();
}

uint64 LFGMgr::GetLeader(uint64 guid)
{
    return GroupsStore[guid].GetLeader();
}

void LFGMgr::SetRandomPlayersCount(uint64 guid, uint8 count)
{
    PlayersStore[guid].SetRandomPlayersCount(count);
}

uint8 LFGMgr::GetRandomPlayersCount(uint64 guid)
{
    return PlayersStore[guid].GetRandomPlayersCount();
}

bool LFGMgr::HasIgnore(uint64 guid1, uint64 guid2)
{
    Player* plr1 = ObjectAccessor::FindPlayerInOrOutOfWorld(guid1);
    Player* plr2 = ObjectAccessor::FindPlayerInOrOutOfWorld(guid2);
    uint32 low1 = GUID_LOPART(guid1);
    uint32 low2 = GUID_LOPART(guid2);
    return plr1 && plr2 && (plr1->GetSocial()->HasIgnore(low2) || plr2->GetSocial()->HasIgnore(low1));
}

void LFGMgr::SendLfgRoleChosen(uint64 guid, uint64 pguid, uint8 roles)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgRoleChosen(pguid, roles);
}

void LFGMgr::SendLfgRoleCheckUpdate(uint64 guid, LfgRoleCheck const& roleCheck)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgRoleCheckUpdate(roleCheck);
}

void LFGMgr::SendLfgUpdatePlayer(uint64 guid, LfgUpdateData const& data)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgUpdatePlayer(data);
}

void LFGMgr::SendLfgUpdateParty(uint64 guid, LfgUpdateData const& data)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgUpdateParty(data);
}

void LFGMgr::SendLfgJoinResult(uint64 guid, LfgJoinResultData const& data)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgJoinResult(data);
}

void LFGMgr::SendLfgBootProposalUpdate(uint64 guid, LfgPlayerBoot const& boot)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgBootProposalUpdate(boot);
}

void LFGMgr::SendLfgUpdateProposal(uint64 guid, LfgProposal const& proposal)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgUpdateProposal(proposal);
}

void LFGMgr::SendLfgQueueStatus(uint64 guid, LfgQueueStatusData const& data)
{
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        player->GetSession()->SendLfgQueueStatus(data);
}

bool LFGMgr::IsLfgGroup(uint64 guid)
{
    return guid && IS_GROUP_GUID(guid) && GroupsStore[guid].IsLfgGroup();
}

LFGQueue& LFGMgr::GetQueue(uint64 guid)
{
    uint8 queueId = 0;
    if (IS_GROUP_GUID(guid))
    {
        LfgGuidSet const& players = GetPlayers(guid);
        uint64 pguid = players.empty() ? 0 : (*players.begin());
        if (pguid)
            queueId = GetTeam(pguid);
        else
            queueId = GetTeam(GetLeader(guid));
    }
    else
        queueId = GetTeam(guid);
    return QueuesStore[queueId];
}

bool LFGMgr::AllQueued(Lfg5Guids const& check)
{
    bool ok = true;

    if (check.empty())
        return false;

    for (uint8 i=0; i<5 && check.guid[i]; ++i)
    {
        uint64 guid = check.guid[i];
        if (GetState(guid) != LFG_STATE_QUEUED)
        {
            LFGQueue& queue = GetQueue(guid);
            queue.RemoveFromQueue(guid);
            ok = false;
        }
    }

    return ok;
}

// Only for debugging purposes
void LFGMgr::Clean()
{
    QueuesStore.clear();
}

bool LFGMgr::isOptionEnabled(uint32 option)
{
    return m_options & option;
}

uint32 LFGMgr::GetOptions()
{
    return m_options;
}

void LFGMgr::SetOptions(uint32 options)
{
    m_options = options;
}

LfgUpdateData LFGMgr::GetLfgStatus(uint64 guid)
{
    LfgPlayerData& playerData = PlayersStore[guid];
    return LfgUpdateData(LFG_UPDATETYPE_UPDATE_STATUS, playerData.GetState(), playerData.GetSelectedDungeons());
}

bool LFGMgr::IsSeasonActive(uint32 dungeonId)
{
    switch (dungeonId)
    {
        case 285: // The Headless Horseman
            return IsHolidayActive(HOLIDAY_HALLOWS_END);
        case 286: // The Frost Lord Ahune
            return IsHolidayActive(HOLIDAY_FIRE_FESTIVAL);
        case 287: // Coren Direbrew
            return IsHolidayActive(HOLIDAY_BREWFEST);
        case 288: // The Crown Chemical Co.
            return IsHolidayActive(HOLIDAY_LOVE_IS_IN_THE_AIR);
    }
    return false;
}

void LFGMgr::SetupGroupMember(uint64 guid, uint64 gguid)
{
    LfgDungeonSet dungeons;
    dungeons.insert(GetDungeon(gguid));
    SetSelectedDungeons(guid, dungeons);
    SetState(guid, GetState(gguid));
    SetGroup(guid, gguid);
    AddPlayerToGroup(gguid, guid);
}

bool LFGMgr::selectedRandomLfgDungeon(uint64 guid)
{
    if (GetState(guid) != LFG_STATE_NONE)
    {
        LfgDungeonSet const& dungeons = GetSelectedDungeons(guid);
        if (!dungeons.empty())
        {
             LFGDungeonData const* dungeon = GetLFGDungeon(*dungeons.begin());
             if (dungeon && (dungeon->type == LFG_TYPE_RANDOM || dungeon->seasonal))
                 return true;
        }
    }

    return false;
}

bool LFGMgr::inLfgDungeonMap(uint64 guid, uint32 map, Difficulty difficulty)
{
    if (!IS_GROUP_GUID(guid))
        guid = GetGroup(guid);

    if (uint32 dungeonId = GetDungeon(guid, true))
        if (LFGDungeonData const* dungeon = GetLFGDungeon(dungeonId))
            if (uint32(dungeon->map) == map && dungeon->difficulty == difficulty)
                return true;

    return false;
}

uint32 LFGMgr::GetLFGDungeonEntry(uint32 id)
{
    if (id)
        if (LFGDungeonData const* dungeon = GetLFGDungeon(id))
            return dungeon->Entry();

    return 0;
}

LfgDungeonSet LFGMgr::GetRandomAndSeasonalDungeons(uint8 level, uint8 expansion)
{
    LfgDungeonSet randomDungeons;
    for (lfg::LFGDungeonContainer::const_iterator itr = LfgDungeonStore.begin(); itr != LfgDungeonStore.end(); ++itr)
    {
        lfg::LFGDungeonData const& dungeon = itr->second;
        if ((dungeon.type == lfg::LFG_TYPE_RANDOM || (dungeon.seasonal && sLFGMgr->IsSeasonActive(dungeon.id)))
            && dungeon.expansion <= expansion && dungeon.minlevel <= level && level <= dungeon.maxlevel)
            randomDungeons.insert(dungeon.Entry());
    }
    return randomDungeons;
}

} // namespace lfg
