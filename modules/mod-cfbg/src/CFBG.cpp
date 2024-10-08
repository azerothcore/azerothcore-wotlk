/*
 * Copyright (С) since 2019 Andrei Guluaev (Winfidonarleyan/Kargatum) https://github.com/Winfidonarleyan
 * Copyright (С) since 2019+ AzerothCore <www.azerothcore.org>
 * Licence MIT https://opensource.org/MIT
 */

#include "CFBG.h"
#include "BattlegroundMgr.h"
#include "BattlegroundUtils.h"
#include "Chat.h"
#include "Config.h"
#include "Containers.h"
#include "GroupMgr.h"
#include "Language.h"
#include "Log.h"
#include "Opcodes.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "GameTime.h"
#include "Player.h"

constexpr uint32 MapAlteracValley = 30;

CrossFactionGroupInfo::CrossFactionGroupInfo(GroupQueueInfo* groupInfo)
{
    uint32 sumLevels = 0;
    uint32 sumAverageItemLevels = 0;
    uint32 playersCount = 0;

    for (auto const& playerGuid : groupInfo->Players)
    {
        auto player = ObjectAccessor::FindConnectedPlayer(playerGuid);
        if (!player)
            continue;

        if (player->getClass() == CLASS_HUNTER && !IsHunterJoining)
            IsHunterJoining = true;

        sumLevels += player->GetLevel();
        sumAverageItemLevels += player->GetAverageItemLevel();
        playersCount++;

        SumAverageItemLevel += player->GetAverageItemLevel();
        SumPlayerLevel += player->GetLevel();
    }

    if (!playersCount)
        return;

    AveragePlayersLevel = sumLevels / playersCount;
    AveragePlayersItemLevel = sumAverageItemLevels / playersCount;
}

CrossFactionQueueInfo::CrossFactionQueueInfo(BattlegroundQueue* bgQueue)
{
    auto FillStats = [this, bgQueue](TeamId team)
    {
        for (auto const& groupInfo : bgQueue->m_SelectionPools[team].SelectedGroups)
        {
            for (auto const& playerGuid : groupInfo->Players)
            {
                auto player = ObjectAccessor::FindConnectedPlayer(playerGuid);
                if (!player)
                    continue;

                SumAverageItemLevel[team] += player->GetAverageItemLevel();
                SumPlayerLevel[team] += player->GetLevel();
                PlayersCount[team]++;
            }
        }
    };

    FillStats(TEAM_ALLIANCE);
    FillStats(TEAM_HORDE);
}

TeamId CrossFactionQueueInfo::GetLowerTeamIdInBG(GroupQueueInfo* groupInfo)
{
    int32 plCountA = PlayersCount.at(TEAM_ALLIANCE);
    int32 plCountH = PlayersCount.at(TEAM_HORDE);
    uint32 diff = std::abs(plCountA - plCountH);

    if (diff)
        return plCountA < plCountH ? TEAM_ALLIANCE : TEAM_HORDE;

    if (sCFBG->IsEnableBalancedTeams())
        return SelectBgTeam(groupInfo);

    if (sCFBG->IsEnableAvgIlvl() && SumAverageItemLevel.at(TEAM_ALLIANCE) != SumAverageItemLevel.at(TEAM_HORDE))
        return GetLowerAverageItemLevelTeam();

    return groupInfo->teamId;
}

TeamId CrossFactionQueueInfo::SelectBgTeam(GroupQueueInfo* groupInfo)
{
    uint32 allianceLevels = SumPlayerLevel.at(TeamId::TEAM_ALLIANCE);
    uint32 hordeLevels = SumPlayerLevel.at(TeamId::TEAM_HORDE);
    TeamId team = groupInfo->teamId;

    // First select team - where the sum of the levels is less
    if (allianceLevels != hordeLevels)
        team = allianceLevels < hordeLevels ? TEAM_ALLIANCE : TEAM_HORDE;

    // Config option `CFBG.EvenTeams.Enabled = 1`
    // if players in queue is equal to an even number
    //if (sCFBG->IsEnableEvenTeams() && groupInfo->Players.size() % 2 == 0)
    //{
    //    auto cfGroupInfo = CrossFactionGroupInfo(groupInfo);
    //    auto playerLevel = cfGroupInfo.AveragePlayersLevel;

    //    auto playerCountH = PlayersCount.at(TEAM_HORDE);
    //    auto playerCountA = PlayersCount.at(TEAM_ALLIANCE);

    //    // We need to have a diff of 0.5f
    //    // Range of calculation: [minBgLevel, maxBgLevel], i.e: [10,20)
    //    float avgLvlAlliance = SumPlayerLevel.at(TEAM_ALLIANCE) / (float)playerCountA;
    //    float avgLvlHorde = SumPlayerLevel.at(TEAM_HORDE) / (float)playerCountH;

    //    if (std::abs(avgLvlAlliance - avgLvlHorde) >= 0.5f)
    //    {
    //        team = avgLvlAlliance < avgLvlHorde ? TEAM_ALLIANCE : TEAM_HORDE;
    //    }
    //    else // it's balanced, so we should only check the ilvl
    //        team = GetLowerAverageItemLevelTeam();
    //}
    //else if (allianceLevels == hordeLevels)
    if (allianceLevels == hordeLevels && SumAverageItemLevel.at(TEAM_ALLIANCE) != SumAverageItemLevel.at(TEAM_HORDE))
        team = GetLowerAverageItemLevelTeam();

    return team;
}

TeamId CrossFactionQueueInfo::GetLowerAverageItemLevelTeam()
{
    return SumAverageItemLevel.at(TEAM_ALLIANCE) < SumAverageItemLevel.at(TEAM_HORDE) ? TEAM_ALLIANCE : TEAM_HORDE;
}

CFBG::CFBG()
{
    _raceData =
    {
        RaceData{ CLASS_NONE,           { 0 }, { 0 } },
        RaceData{ CLASS_WARRIOR,        { RACE_HUMAN, RACE_DWARF, RACE_GNOME, RACE_DRAENEI  }, { RACE_ORC, RACE_TAUREN, RACE_TROLL } },
        RaceData{ CLASS_PALADIN,        { RACE_HUMAN, RACE_DWARF, RACE_DRAENEI }, { RACE_BLOODELF } },
        RaceData{ CLASS_HUNTER,         { RACE_DWARF, RACE_DRAENEI }, { RACE_ORC, RACE_TAUREN, RACE_TROLL, RACE_BLOODELF } },
        RaceData{ CLASS_ROGUE,          { RACE_HUMAN, RACE_DWARF, RACE_GNOME }, { RACE_ORC, RACE_TROLL, RACE_BLOODELF } },
        RaceData{ CLASS_PRIEST,         { RACE_HUMAN, RACE_DWARF, RACE_DRAENEI  }, { RACE_TROLL, RACE_BLOODELF } },
        RaceData{ CLASS_DEATH_KNIGHT,   { RACE_HUMAN, RACE_DWARF, RACE_GNOME, RACE_DRAENEI }, { RACE_ORC, RACE_TAUREN, RACE_TROLL, RACE_BLOODELF } },
        RaceData{ CLASS_SHAMAN,         { RACE_DRAENEI }, { RACE_ORC, RACE_TAUREN, RACE_TROLL  } },
        RaceData{ CLASS_MAGE,           { RACE_HUMAN, RACE_GNOME }, { RACE_BLOODELF, RACE_TROLL } },
        RaceData{ CLASS_WARLOCK,        { RACE_HUMAN, RACE_GNOME }, { RACE_ORC, RACE_BLOODELF } },
        RaceData{ CLASS_NONE,           { 0 }, { 0 } },
        RaceData{ CLASS_DRUID,          { RACE_HUMAN }, { RACE_TAUREN } }
    };

    _raceInfo =
    {
        CFBGRaceInfo{ RACE_HUMAN,    "human",    TEAM_HORDE    },
        CFBGRaceInfo{ RACE_NIGHTELF, "nightelf", TEAM_HORDE    },
        CFBGRaceInfo{ RACE_DWARF,    "dwarf",    TEAM_HORDE    },
        CFBGRaceInfo{ RACE_GNOME,    "gnome",    TEAM_HORDE    },
        CFBGRaceInfo{ RACE_DRAENEI,  "draenei",  TEAM_HORDE    },
        CFBGRaceInfo{ RACE_ORC,      "orc",      TEAM_ALLIANCE },
        CFBGRaceInfo{ RACE_BLOODELF, "bloodelf", TEAM_ALLIANCE },
        CFBGRaceInfo{ RACE_TROLL,    "troll",    TEAM_ALLIANCE },
        CFBGRaceInfo{ RACE_TAUREN,   "tauren",   TEAM_ALLIANCE }
    };
}

CFBG* CFBG::instance()
{
    static CFBG instance;
    return &instance;
}

void CFBG::LoadConfig()
{
    _IsEnableSystem = sConfigMgr->GetOption<bool>("CFBG.Enable", false);
    if (!_IsEnableSystem)
        return;

    _IsEnableAvgIlvl = sConfigMgr->GetOption<bool>("CFBG.Include.Avg.Ilvl.Enable", false);
    _IsEnableBalancedTeams = sConfigMgr->GetOption<bool>("CFBG.BalancedTeams", false);
    _IsEnableEvenTeams = sConfigMgr->GetOption<bool>("CFBG.EvenTeams.Enabled", false);
    _IsEnableBalanceClassLowLevel = sConfigMgr->GetOption<bool>("CFBG.BalancedTeams.Class.LowLevel", true);
    _IsEnableResetCooldowns = sConfigMgr->GetOption<bool>("CFBG.ResetCooldowns", false);
    _showPlayerName = sConfigMgr->GetOption<bool>("CFBG.Show.PlayerName", false);
    _EvenTeamsMaxPlayersThreshold = sConfigMgr->GetOption<uint32>("CFBG.EvenTeams.MaxPlayersThreshold", 5);
    _MaxPlayersCountInGroup = sConfigMgr->GetOption<uint32>("CFBG.Players.Count.In.Group", 3);
    _balanceClassMinLevel = sConfigMgr->GetOption<uint8>("CFBG.BalancedTeams.Class.MinLevel", 10);
    _balanceClassMaxLevel = sConfigMgr->GetOption<uint8>("CFBG.BalancedTeams.Class.MaxLevel", 19);
    _balanceClassLevelDiff = sConfigMgr->GetOption<uint8>("CFBG.BalancedTeams.Class.LevelDiff", 2);
    _randomizeRaces = sConfigMgr->GetOption<bool>("CFBG.RandomRaceSelection", true);
}

uint32 CFBG::GetBGTeamAverageItemLevel(Battleground* bg, TeamId team)
{
    if (!bg)
    {
        return 0;
    }

    uint32 sum = 0;
    uint32 count = 0;

    for (auto const& [playerGuid, player] : bg->GetPlayers())
    {
        if (player && player->GetTeamId() == team)
        {
            sum += player->GetAverageItemLevel();
            count++;
        }
    }

    if (!count || !sum)
    {
        return 0;
    }

    return sum / count;
}

uint32 CFBG::GetBGTeamSumPlayerLevel(Battleground* bg, TeamId team)
{
    if (!bg)
    {
        return 0;
    }

    uint32 sum = 0;

    for (auto const& [playerGuid, player] : bg->GetPlayers())
    {
        if (player && player->GetTeamId() == team)
        {
            sum += player->GetLevel();
        }
    }

    return sum;
}

TeamId CFBG::GetLowerTeamIdInBG(Battleground* bg, BattlegroundQueue* bgQueue, GroupQueueInfo* groupInfo)
{
    auto queueInfo = CrossFactionQueueInfo{ bgQueue };

    int32 plCountA = bg->GetPlayersCountByTeam(TEAM_ALLIANCE) + queueInfo.PlayersCount.at(TEAM_ALLIANCE);
    int32 plCountH = bg->GetPlayersCountByTeam(TEAM_HORDE) + queueInfo.PlayersCount.at(TEAM_HORDE);

    if (uint32 diff = std::abs(plCountA - plCountH))
        return plCountA < plCountH ? TEAM_ALLIANCE : TEAM_HORDE;

    if (IsEnableBalancedTeams())
        return SelectBgTeam(bg, groupInfo, &queueInfo);

    if (IsEnableAvgIlvl() && !IsAvgIlvlTeamsInBgEqual(bg))
        return GetLowerAvgIlvlTeamInBg(bg);

    return groupInfo->teamId;
}

TeamId CFBG::SelectBgTeam(Battleground* bg, GroupQueueInfo* groupInfo, CrossFactionQueueInfo* cfQueueInfo)
{
    auto cfGroupInfo = CrossFactionGroupInfo(groupInfo);

    uint32 allianceLevels = GetBGTeamSumPlayerLevel(bg, TEAM_ALLIANCE) + cfQueueInfo->SumPlayerLevel.at(TEAM_ALLIANCE);
    uint32 hordeLevels = GetBGTeamSumPlayerLevel(bg, TEAM_HORDE) + cfQueueInfo->SumPlayerLevel.at(TEAM_HORDE);

    if (groupInfo->teamId == TeamId::TEAM_ALLIANCE)
        allianceLevels += cfGroupInfo.SumPlayerLevel;
    else
        hordeLevels += cfGroupInfo.SumPlayerLevel;

    TeamId team = groupInfo->teamId;

    // First select team - where the sum of the levels is less
    if (allianceLevels != hordeLevels)
        team = (allianceLevels < hordeLevels) ? TEAM_ALLIANCE : TEAM_HORDE;

    // Config option `CFBG.EvenTeams.Enabled = 1`
    // if players in queue is equal to an even number
    if (IsEnableEvenTeams() /*&& groupInfo->Players.size() % 2 == 0*/)
    {
        auto cfGroupInfo = CrossFactionGroupInfo(groupInfo);
        auto playerLevel = cfGroupInfo.AveragePlayersLevel;

        // if CFBG.BalancedTeams.LowLevelClass is enabled, check the quantity of hunter per team if the player is an hunter
        if (IsEnableBalanceClassLowLevel() &&
            (playerLevel >= _balanceClassMinLevel && playerLevel <= _balanceClassMaxLevel) &&
            (playerLevel >= getBalanceClassMinLevel(bg)) &&
            (cfGroupInfo.IsHunterJoining)) // if the current player is hunter OR there is a hunter in the joining queue while a non-hunter player is joining
        {
            team = getTeamWithLowerClass(bg, CLASS_HUNTER);
        }
        else
        {
            auto playerCountH = bg->GetPlayersCountByTeam(TEAM_HORDE) + cfQueueInfo->PlayersCount.at(TEAM_HORDE);
            auto playerCountA = bg->GetPlayersCountByTeam(TEAM_ALLIANCE) + cfQueueInfo->PlayersCount.at(TEAM_ALLIANCE);

            // We need to have a diff of 0.5f
            // Range of calculation: [minBgLevel, maxBgLevel], i.e: [10,20)
            float avgLvlAlliance = allianceLevels / (float)playerCountA;
            float avgLvlHorde = hordeLevels / (float)playerCountH;

            if (std::abs(avgLvlAlliance - avgLvlHorde) >= 0.5f)
            {
                team = avgLvlAlliance < avgLvlHorde ? TEAM_ALLIANCE : TEAM_HORDE;
            }
            else // it's balanced, so we should only check the ilvl
                team = GetLowerAvgIlvlTeamInBg(bg);
        }
    }
    else if (allianceLevels == hordeLevels)
    {
        team = GetLowerAvgIlvlTeamInBg(bg);
    }

    return team;
}

uint8 CFBG::getBalanceClassMinLevel(const Battleground* bg) const
{
    return static_cast<uint8>(bg->GetMaxLevel()) - _balanceClassLevelDiff;
}

TeamId CFBG::getTeamWithLowerClass(Battleground *bg, Classes c)
{
    uint16 hordeClassQty = 0;
    uint16 allianceClassQty = 0;

    for (auto const& [playerGuid, player] : bg->GetPlayers())
    {
        if (player && player->getClass() == c)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                allianceClassQty++;
            }
            else
            {
                hordeClassQty++;
            }
        }
    }

    return hordeClassQty > allianceClassQty ? TEAM_ALLIANCE : TEAM_HORDE;
}

TeamId CFBG::GetLowerAvgIlvlTeamInBg(Battleground* bg)
{
    return (GetBGTeamAverageItemLevel(bg, TeamId::TEAM_ALLIANCE) < GetBGTeamAverageItemLevel(bg, TeamId::TEAM_HORDE)) ? TEAM_ALLIANCE : TEAM_HORDE;
}

bool CFBG::IsAvgIlvlTeamsInBgEqual(Battleground* bg)
{
    return GetBGTeamAverageItemLevel(bg, TeamId::TEAM_ALLIANCE) == GetBGTeamAverageItemLevel(bg, TeamId::TEAM_HORDE);
}

void CFBG::ValidatePlayerForBG(Battleground* bg, Player* player)
{
    if (!_IsEnableSystem || !bg || bg->isArena() || !player)
        return;

    TeamId teamId{ player->GetBgTeamId() };

    if (player->GetTeamId(true) == teamId)
        return;

    BGData& bgdata = player->GetBGData();

    if (bgdata.bgTeamId != teamId)
        bgdata.bgTeamId = teamId;

    SetFakeRaceAndMorph(player);

    if (bg->GetMapId() == MapAlteracValley)
    {
        if (teamId == TEAM_HORDE)
        {
            player->GetReputationMgr().ApplyForceReaction(FACTION_FROSTWOLF_CLAN, REP_FRIENDLY, true);
            player->GetReputationMgr().ApplyForceReaction(FACTION_STORMPIKE_GUARD, REP_HOSTILE, true);
        }
        else
        {
            player->GetReputationMgr().ApplyForceReaction(FACTION_FROSTWOLF_CLAN, REP_HOSTILE, true);
            player->GetReputationMgr().ApplyForceReaction(FACTION_STORMPIKE_GUARD, REP_FRIENDLY, true);
        }

        player->GetReputationMgr().SendForceReactions();
    }
}

uint32 CFBG::GetAllPlayersCountInBG(Battleground* bg)
{
    return bg->GetPlayersSize();
}

uint32 CFBG::GetMorphFromRace(uint8 race, uint8 gender)
{
    switch (race)
    {
        case RACE_BLOODELF:
            return gender == GENDER_MALE ? FAKE_M_BLOOD_ELF : FAKE_F_BLOOD_ELF;
        case RACE_ORC:
            return gender == GENDER_MALE ? FAKE_M_FEL_ORC : FAKE_F_ORC;
        case RACE_TROLL:
            return gender == GENDER_MALE ? FAKE_M_TROLL : FAKE_F_BLOOD_ELF;
        case RACE_TAUREN:
            return gender == GENDER_MALE ? FAKE_M_TAUREN : FAKE_F_TAUREN;
        case RACE_DRAENEI:
            return gender == GENDER_MALE ? FAKE_M_BROKEN_DRAENEI : FAKE_F_DRAENEI;
        case RACE_DWARF:
            return gender == GENDER_MALE ? FAKE_M_DWARF : FAKE_F_HUMAN;
        case RACE_GNOME:
            return gender == GENDER_MALE ? FAKE_M_GNOME : FAKE_F_GNOME;
        case RACE_NIGHTELF: // female is missing and male causes client crashes...
        case RACE_HUMAN:
            return gender == GENDER_MALE ? FAKE_M_HUMAN : FAKE_F_HUMAN;
        default:
            // Default: Blood elf.
            return gender == GENDER_MALE ? FAKE_M_BLOOD_ELF : FAKE_F_BLOOD_ELF;
    }
}

CFBG::RandomSkinInfo CFBG::GetRandomRaceMorph(TeamId team, uint8 playerClass, uint8 gender)
{
    uint8 playerRace = Acore::Containers::SelectRandomContainerElement(team == TEAM_ALLIANCE ? _raceData[playerClass].availableRacesH : _raceData[playerClass].availableRacesA);
    uint32 playerMorph = GetMorphFromRace(playerRace, gender);

    return { playerRace, playerMorph };
}

void CFBG::SetFakeRaceAndMorph(Player* player)
{
    if (!player->InBattleground() || player->GetTeamId(true) == player->GetBgTeamId() || IsPlayerFake(player))
        return;

    // generate random race and morph
    RandomSkinInfo skinInfo{ GetRandomRaceMorph(player->GetTeamId(true), player->getClass(), player->getGender()) };

    uint8 selectedRace = player->GetPlayerSetting("mod-cfbg", SETTING_CFBG_RACE).value;

    if (!RandomizeRaces() && selectedRace && IsRaceValidForFaction(player->GetTeamId(true), selectedRace))
    {
        skinInfo.first = selectedRace;
        skinInfo.second = GetMorphFromRace(skinInfo.first, player->getGender());
    }

    FakePlayer fakePlayerInfo
    {
        skinInfo.first,
        skinInfo.second,
        player->TeamIdForRace(skinInfo.first),
        player->getRace(true),
        player->GetDisplayId(),
        player->GetNativeDisplayId(),
        player->GetTeamId(true)
    };

    player->setRace(fakePlayerInfo.FakeRace);
    SetFactionForRace(player, fakePlayerInfo.FakeRace);
    player->SetDisplayId(fakePlayerInfo.FakeMorph);
    player->SetNativeDisplayId(fakePlayerInfo.FakeMorph);

    _fakePlayerStore.emplace(player, std::move(fakePlayerInfo));
}

void CFBG::SetFactionForRace(Player* player, uint8 Race)
{
    player->setTeamId(player->TeamIdForRace(Race));

    ChrRacesEntry const* DBCRace = sChrRacesStore.LookupEntry(Race);
    player->SetFaction(DBCRace ? DBCRace->FactionID : 0);
}

void CFBG::ClearFakePlayer(Player* player)
{
    if (!IsPlayerFake(player))
        return;

    player->setRace(_fakePlayerStore[player].RealRace);
    player->SetDisplayId(_fakePlayerStore[player].RealMorph);
    player->SetNativeDisplayId(_fakePlayerStore[player].RealNativeMorph);
    SetFactionForRace(player, _fakePlayerStore[player].RealRace);

    // Clear forced faction reactions. Rank doesn't matter here, not used when they are removed.
    player->GetReputationMgr().ApplyForceReaction(FACTION_FROSTWOLF_CLAN, REP_FRIENDLY, false);
    player->GetReputationMgr().ApplyForceReaction(FACTION_STORMPIKE_GUARD, REP_FRIENDLY, false);

    _fakePlayerStore.erase(player);
}

bool CFBG::IsPlayerFake(Player* player)
{
    return _fakePlayerStore.contains(player);
}

FakePlayer const* CFBG::GetFakePlayer(Player* player) const
{
    return Acore::Containers::MapGetValuePtr(_fakePlayerStore, player);
}

void CFBG::DoForgetPlayersInList(Player* player)
{
    // m_FakePlayers is filled from a vector within the battleground
    // they were in previously so all players that have been in that BG will be invalidated.
    for (auto const& itr : _fakeNamePlayersStore)
    {
        WorldPacket data(SMSG_INVALIDATE_PLAYER, 8);
        data << itr.second;
        player->GetSession()->SendPacket(&data);

        if (Player* _player = ObjectAccessor::FindPlayer(itr.second))
            player->GetSession()->SendNameQueryOpcode(_player->GetGUID());
    }

    _fakeNamePlayersStore.erase(player);
}

void CFBG::FitPlayerInTeam(Player* player, bool action, Battleground* bg)
{
    if (!_IsEnableSystem)
        return;

    if (!bg)
        bg = player->GetBattleground();

    if ((!bg || bg->isArena()) && action)
        return;

    if (action)
        SetForgetBGPlayers(player, true);
    else
        SetForgetInListPlayers(player, true);
}

void CFBG::SetForgetBGPlayers(Player* player, bool value)
{
    _forgetBGPlayersStore[player] = value;
}

bool CFBG::ShouldForgetBGPlayers(Player* player)
{
    return _forgetBGPlayersStore[player];
}

void CFBG::SetForgetInListPlayers(Player* player, bool value)
{
    _forgetInListPlayersStore[player] = value;
}

bool CFBG::ShouldForgetInListPlayers(Player* player)
{
    return _forgetInListPlayersStore.find(player) != _forgetInListPlayersStore.end() && _forgetInListPlayersStore[player];
}

void CFBG::DoForgetPlayersInBG(Player* player, Battleground* bg)
{
    for (auto const& itr : bg->GetPlayers())
    {
        // Here we invalidate players in the bg to the added player
        WorldPacket data1(SMSG_INVALIDATE_PLAYER, 8);
        data1 << itr.first;
        player->GetSession()->SendPacket(&data1);

        if (Player* _player = ObjectAccessor::FindPlayer(itr.first))
        {
            player->GetSession()->SendNameQueryOpcode(_player->GetGUID()); // Send namequery answer instantly if player is available

            // Here we invalidate the player added to players in the bg
            WorldPacket data2(SMSG_INVALIDATE_PLAYER, 8);
            data2 << player->GetGUID();
            _player->GetSession()->SendPacket(&data2);
            _player->GetSession()->SendNameQueryOpcode(player->GetGUID());
        }
    }
}

bool CFBG::SendRealNameQuery(Player* player)
{
    if (IsPlayingNative(player))
        return false;

    WorldPacket data(SMSG_NAME_QUERY_RESPONSE, (8 + 1 + 1 + 1 + 1 + 1 + 10));
    data << player->GetGUID().WriteAsPacked();                  // player guid
    data << uint8(0);                                           // added in 3.1; if > 1, then end of packet
    data << player->GetName();                                  // played name
    data << uint8(0);                                           // realm name for cross realm BG usage
    data << uint8(player->getRace(true));
    data << uint8(player->getGender());
    data << uint8(player->getClass());
    data << uint8(0);                                           // is not declined
    player->GetSession()->SendPacket(&data);

    return true;
}

bool CFBG::IsPlayingNative(Player* player)
{
    return player->GetTeamId(true) == player->GetBGData().bgTeamId;
}

bool CFBG::CheckCrossFactionMatch(BattlegroundQueue* queue, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers)
{
    if (!IsEnableSystem())
        return false;

    queue->m_SelectionPools[TEAM_ALLIANCE].Init();
    queue->m_SelectionPools[TEAM_HORDE].Init();

    GroupsList groups{ queue->m_QueuedGroups[bracket_id][BG_QUEUE_CFBG].begin(), queue->m_QueuedGroups[bracket_id][BG_QUEUE_CFBG].end() };

    if (IsEnableEvenTeams())
    {
        // Sort for check same count groups
        std::sort(groups.begin(), groups.end(), [](GroupQueueInfo const* a, GroupQueueInfo const* b) { return a->Players.size() > b->Players.size(); });

        InviteSameCountGroups(groups, queue, maxPlayers, maxPlayers);
    }
    else
    {
        // Default sort
        std::sort(groups.begin(), groups.end(), [](GroupQueueInfo const* a, GroupQueueInfo const* b) { return a->JoinTime > b->JoinTime; });

        for (auto const& gInfo : groups)
        {
            if (gInfo->IsInvitedToBGInstanceGUID)
                continue;

            auto queueInfo = CrossFactionQueueInfo{ queue };
            auto targetTeam = queueInfo.GetLowerTeamIdInBG(gInfo);
            gInfo->teamId = targetTeam;

            if (!queue->m_SelectionPools[targetTeam].AddGroup(gInfo, maxPlayers))
                break;
        }
    }

    // Return when we're ready to start a BG, if we're in startup process
    if (queue->m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= minPlayers &&
        queue->m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= minPlayers)
        return true;

    // Return false when we didn't manage to fill the BattleGround in Filling "mode".
    // reset selectionpool for further attempts
    queue->m_SelectionPools[TEAM_ALLIANCE].Init();
    queue->m_SelectionPools[TEAM_HORDE].Init();
    return true;
}

bool CFBG::FillPlayersToCFBG(BattlegroundQueue* bgqueue, Battleground* bg, BattlegroundBracketId bracket_id)
{
    if (!IsEnableSystem() || bg->isArena() || bg->isRated())
        return false;

    uint32 maxAli{ bg->GetFreeSlotsForTeam(TEAM_ALLIANCE) };
    uint32 maxHorde{ bg->GetFreeSlotsForTeam(TEAM_HORDE) };

    GroupsList groups{ bgqueue->m_QueuedGroups[bracket_id][BG_QUEUE_CFBG].begin(), bgqueue->m_QueuedGroups[bracket_id][BG_QUEUE_CFBG].end() };

    // Sort for check same groups
    std::sort(groups.begin(), groups.end(), [](GroupQueueInfo const* a, GroupQueueInfo const* b) { return a->Players.size() < b->Players.size(); });

    std::array<std::size_t, 2> playersInvitedToBGCount{};

    if (IsEnableEvenTeams())
    {
        std::vector<std::pair<GroupQueueInfo*, GroupQueueInfo*>> sameGroups;

        // Check groups with equal players
        for (auto itr = groups.begin(); itr != groups.end();)
        {
            if ((*itr)->IsInvitedToBGInstanceGUID)
            {
                itr++;
                continue;
            }

            auto nextItr{ itr + 1 };
            if (nextItr != groups.end())
            {
                if ((*nextItr)->IsInvitedToBGInstanceGUID || (*itr)->Players.size() != (*nextItr)->Players.size())
                {
                    itr++;
                    continue;
                }

                sameGroups.emplace_back(*itr, *nextItr);
                itr = itr + 2;

                if (itr == groups.end())
                    break;
                else
                    continue;
            }

            itr++;
        }

        if (!sameGroups.empty())
        {
            auto InviteGroupToBG = [this, bg, bgqueue, maxAli, maxHorde](GroupQueueInfo* gInfo)
            {
                TeamId targetTeam = GetLowerTeamIdInBG(bg, bgqueue, gInfo);
                gInfo->teamId = targetTeam;

                if (bgqueue->m_SelectionPools[targetTeam].AddGroup(gInfo, targetTeam == TEAM_ALLIANCE ? maxAli : maxHorde))
                    return targetTeam;

                return TEAM_NEUTRAL;
            };

            for (auto& [group1, group2] : sameGroups)
            {
                auto team1{ InviteGroupToBG(group1) };
                auto team2{ InviteGroupToBG(group2) };

                if (team1 != TEAM_NEUTRAL && team2 != TEAM_NEUTRAL)
                {
                    std::erase(groups, group1);
                    std::erase(groups, group2);
                    playersInvitedToBGCount.at(team1) += group1->Players.size();
                    playersInvitedToBGCount.at(team2) += group2->Players.size();
                }
            }
        }

        if (groups.empty())
            return true; // we invited all players, done
    }

    // Sort with join time (default)
    std::sort(groups.begin(), groups.end(), [](GroupQueueInfo const* a, GroupQueueInfo const* b) { return a->JoinTime < b->JoinTime; });

    if (IsEnableEvenTeams())
    {
        InviteSameCountGroups(groups, bgqueue, maxAli, maxHorde, bg);

        if (groups.empty())
            return true; // we invited all players, done
    }

    // Check invited players to bg
    for (auto const& gInfo : bgqueue->m_QueuedGroups[bracket_id][BG_QUEUE_CFBG])
    {
        if (gInfo->IsInvitedToBGInstanceGUID)
            playersInvitedToBGCount.at(gInfo->teamId) += gInfo->Players.size();
    }

    auto DefaultInvitePlayersToBG = [this, bg, bgqueue, &groups, maxAli, maxHorde]()
    {
        GroupsList toDeleteGroups;

        for (auto const& gInfo : groups)
        {
            if (gInfo->IsInvitedToBGInstanceGUID)
                continue;

            TeamId targetTeam = GetLowerTeamIdInBG(bg, bgqueue, gInfo);
            gInfo->teamId = targetTeam;

            if (bgqueue->m_SelectionPools[targetTeam].AddGroup(gInfo, targetTeam == TEAM_ALLIANCE ? maxAli : maxHorde))
                toDeleteGroups.emplace_back(gInfo);
        }

        for (auto const& itr : toDeleteGroups)
            std::erase(groups, itr);
    };

    auto playersInBGAli{ bg->GetPlayersCountByTeam(TEAM_ALLIANCE) + playersInvitedToBGCount.at(TEAM_ALLIANCE) };
    auto playersInBGHorde{ bg->GetPlayersCountByTeam(TEAM_HORDE) + playersInvitedToBGCount.at(TEAM_HORDE) };
    auto playersInBG{ static_cast<std::size_t>(playersInBGAli + playersInBGHorde) };
    auto evenTeamsCount{ EvenTeamsMaxPlayersThreshold() };

    if (IsEnableEvenTeams() && evenTeamsCount && playersInBG < evenTeamsCount * 2)
    {
        int32 aliNeed = evenTeamsCount - playersInBGAli;
        int32 hordeNeed = evenTeamsCount - playersInBGHorde;

        if (aliNeed < 0)
            aliNeed = 0;

        if (hordeNeed < 0)
            hordeNeed = 0;

        if ((aliNeed || hordeNeed) && (aliNeed != hordeNeed))
        {
            uint32 playersNeed{ 0 };
            TeamId targetTeam = TEAM_NEUTRAL;

            if (aliNeed && aliNeed > hordeNeed)
            {
                playersNeed = aliNeed - hordeNeed;
                targetTeam = TEAM_ALLIANCE;
            }
            else if (hordeNeed && hordeNeed > aliNeed)
            {
                playersNeed = hordeNeed - aliNeed;
                targetTeam = TEAM_HORDE;
            }

            if (playersNeed > 0 && targetTeam != TEAM_NEUTRAL)
            {
                GroupsList toDeleteGroups;

                // #1. Try fill players to even team
                for (auto const& gInfo : groups)
                {
                    // We can add only single players
                    if (gInfo->IsInvitedToBGInstanceGUID)
                        continue;

                    gInfo->teamId = targetTeam;

                    if (bgqueue->m_SelectionPools[targetTeam].AddGroup(gInfo, playersNeed))
                    {
                        auto groupPlayerSize{ gInfo->Players.size() };
                        playersNeed -= groupPlayerSize;
                        toDeleteGroups.emplace_back(gInfo);
                        targetTeam == TEAM_ALLIANCE ? aliNeed -= groupPlayerSize : hordeNeed -= groupPlayerSize;
                    }

                    // Stop invited if found players for even teams
                    if (!playersNeed)
                        break;
                }

                // Delete invited groups
                for (auto const& gInfo : toDeleteGroups)
                    std::erase(groups, gInfo);
            }
            else
                LOG_FATAL("module", "> CFBG: Incorrect conditions for check even teams. Players need: {}. Target team: {}", playersNeed, targetTeam);
        }

        // #2 if all teams even and `MaxPlayersThreshold` complete
        if (!aliNeed && !hordeNeed)
            DefaultInvitePlayersToBG();
    }
    else
        DefaultInvitePlayersToBG();

    return true;
}

bool CFBG::isClassJoining(uint8 _class, Player* player, uint32 minLevel)
{
    if (!player)
    {
        return false;
    }

    return player->getClass() == _class && (player->GetLevel() >= minLevel);
}

void CFBG::UpdateForget(Player* player)
{
    Battleground* bg = player->GetBattleground();
    if (bg)
    {
        if (ShouldForgetBGPlayers(player) && bg)
        {
            DoForgetPlayersInBG(player, bg);
            SetForgetBGPlayers(player, false);
        }
    }
    else if (ShouldForgetInListPlayers(player))
    {
        DoForgetPlayersInList(player);
        SetForgetInListPlayers(player, false);
    }
}

std::unordered_map<ObjectGuid, Seconds> BGSpamProtectionCFBG;
void CFBG::SendMessageQueue(BattlegroundQueue* bgQueue, Battleground* bg, PvPDifficultyEntry const* bracketEntry, Player* leader)
{
    BattlegroundBracketId bracketId = bracketEntry->GetBracketId();

    auto bgName = bg->GetName();
    uint32 q_min_level = std::min(bracketEntry->minLevel, (uint32)80);
    uint32 q_max_level = std::min(bracketEntry->maxLevel, (uint32)80);
    uint32 MinPlayers = GetMinPlayersPerTeam(bg, bracketEntry) * 2;
    uint32 qTotal = bgQueue->GetPlayersCountInGroupsQueue(bracketId, (BattlegroundQueueGroupTypes)BG_QUEUE_CFBG);

    if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_PLAYERONLY))
    {
        ChatHandler(leader->GetSession()).PSendSysMessage("CFBG {} (Levels: {} - {}). Registered: {}/{}", bgName.c_str(), q_min_level, q_max_level, qTotal, MinPlayers);
    }
    else
    {
        if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMED))
        {
            if (bgQueue->GetQueueAnnouncementTimer(bracketEntry->bracketId) < 0)
            {
                bgQueue->SetQueueAnnouncementTimer(bracketEntry->bracketId, sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMER));
            }
        }
        else
        {
            auto searchGUID = BGSpamProtectionCFBG.find(leader->GetGUID());

            if (searchGUID == BGSpamProtectionCFBG.end())
                BGSpamProtectionCFBG[leader->GetGUID()] = 0s;

            // Skip if spam time < 30 secs (default)
            if (GameTime::GetGameTime() - BGSpamProtectionCFBG[leader->GetGUID()] < Seconds(sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_SPAM_DELAY)))
            {
                return;
            }

            // When limited, it announces only if there are at least CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_PLAYERS in queue
            auto limitQueueMinLevel = sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_LEVEL);
            if (limitQueueMinLevel != 0 && q_min_level >= limitQueueMinLevel)
            {
                // limit only RBG for 80, WSG for lower levels
                auto bgTypeToLimit = q_min_level == 80 ? BATTLEGROUND_RB : BATTLEGROUND_WS;

                if (bg->GetBgTypeID() == bgTypeToLimit && qTotal < sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_PLAYERS))
                {
                    return;
                }
            }

            BGSpamProtectionCFBG[leader->GetGUID()] = GameTime::GetGameTime();

            if (_showPlayerName)
            {
                std::string msg = Acore::StringFormat("{} |cffffffffHas Joined|r |cffff0000{}|r|cffffffff(|r|cff00ffff{}|r|cffffffff/|r|cff00ffff{}|r|cffffffff)|r",
                    leader->GetPlayerName(), bg->GetName(), qTotal, MinPlayers);

                for (auto const& session : sWorld->GetAllSessions())
                {
                    if (Player* player = session.second->GetPlayer())
                    {
                        if (player->GetPlayerSetting(AzerothcorePSSource, SETTING_ANNOUNCER_FLAGS).HasFlag(ANNOUNCER_FLAG_DISABLE_BG_QUEUE))
                        {
                            continue;
                        }

                        WorldPacket data(SMSG_CHAT_SERVER_MESSAGE, (msg.size() + 1));
                        data << uint32(3);
                        data << msg;
                        player->GetSession()->SendPacket(&data);
                    }
                }
            }
            else
            {
                ChatHandler(nullptr).SendWorldTextOptional(LANG_BG_QUEUE_ANNOUNCE_WORLD, ANNOUNCER_FLAG_DISABLE_BG_QUEUE, bgName, q_min_level, q_max_level, qTotal, MinPlayers);
            }
        }
    }
}

bool CFBG::IsRaceValidForFaction(uint8 teamId, uint8 race)
{
    for (auto const& raceVariable : _raceInfo)
    {
        if (race == raceVariable.RaceId && teamId == raceVariable.TeamId)
        {
            return true;
        }
    }

    return false;
}

void CFBG::InviteSameCountGroups(GroupsList& groups, BattlegroundQueue* bgQueue, uint32 maxAli, uint32 maxHorde, Battleground* bg /*= nullptr*/)
{
    if (groups.size() < 2 || !bgQueue)
        return;

    GroupsList groupList;
    GroupsList addedGroups;
    SameCountGroupsList container;

    for (auto const& targetGroup : groups)
    {
        if (targetGroup->IsInvitedToBGInstanceGUID)
            continue;

        if (std::find(addedGroups.begin(), addedGroups.end(), targetGroup) != addedGroups.end())
            continue;

        groupList.clear();
        auto groupSizeNeed{ targetGroup->Players.size() };

        for (auto const& itrGroup : groups)
        {
            if (itrGroup == targetGroup)
                continue;

            if (itrGroup->IsInvitedToBGInstanceGUID)
                continue;

            if (std::find(addedGroups.begin(), addedGroups.end(), itrGroup) != addedGroups.end())
                continue;

            auto groupSizeItr{ itrGroup->Players.size() };
            if (groupSizeItr <= groupSizeNeed)
            {
                groupList.emplace_back(itrGroup);
                groupSizeNeed -= groupSizeItr;
            }

            if (!groupSizeNeed)
            {
                container.emplace_back(targetGroup, groupList);
                addedGroups.emplace_back(targetGroup);

                for (auto const& itr : groupList)
                    addedGroups.emplace_back(itr);

                groupList.clear();
                break;
            }
        }
    }

    if (container.empty())
        return;

    auto DeleteGroup = [bgQueue](GroupQueueInfo* gInfo)
    {
        std::erase(bgQueue->m_SelectionPools[TEAM_ALLIANCE].SelectedGroups, gInfo);
        std::erase(bgQueue->m_SelectionPools[TEAM_HORDE].SelectedGroups, gInfo);
    };

    for (auto& [groupTarget, groupListForTarger] : container)
    {
        auto teamTarget{ InviteGroupToBG(groupTarget, bgQueue, maxAli, maxHorde, bg) };
        if (teamTarget == TEAM_NEUTRAL)
            continue;

        bool IsAllInvited{ true };

        for (auto const& groupItr : groupListForTarger)
        {
            auto teamItr{ InviteGroupToBG(groupItr, bgQueue, maxAli, maxHorde, bg) };
            if (teamItr == TEAM_NEUTRAL)
            {
                IsAllInvited = false;
                break;
            }
        }

        if (!IsAllInvited)
        {
            for (auto const& groupItr : groupListForTarger)
                DeleteGroup(groupItr);

            DeleteGroup(groupTarget);
            continue;
        }

        for (auto const& groupItr : groupListForTarger)
            std::erase(groups, groupItr);

        std::erase(groups, groupTarget);
    }
}

TeamId CFBG::InviteGroupToBG(GroupQueueInfo* gInfo, BattlegroundQueue* bgQueue, uint32 maxAli, uint32 maxHorde, Battleground* bg /*= nullptr*/)
{
    if (bg)
    {
        auto targetTeam = GetLowerTeamIdInBG(bg, bgQueue, gInfo);
        gInfo->teamId = targetTeam;
    }
    else
    {
        auto queueInfo = CrossFactionQueueInfo{ bgQueue };
        auto targetTeam = queueInfo.GetLowerTeamIdInBG(gInfo);
        gInfo->teamId = targetTeam;
    }

    if (bgQueue->m_SelectionPools[gInfo->teamId].AddGroup(gInfo, gInfo->teamId == TEAM_ALLIANCE ? maxAli : maxHorde))
        return gInfo->teamId;

    return TEAM_NEUTRAL;
}
