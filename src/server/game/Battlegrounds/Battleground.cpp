/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ArenaSpectator.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battleground.h"
#include "BattlegroundBE.h"
#include "BattlegroundDS.h"
#include "BattlegroundMgr.h"
#include "BattlegroundNA.h"
#include "BattlegroundRL.h"
#include "BattlegroundRV.h"
#include "Chat.h"
#include "Creature.h"
#include "Formulas.h"
#include "GameGraveyard.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "MapManager.h"
#include "Object.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "Transport.h"
#include "Util.h"
#include "World.h"
#include "WorldPacket.h"

#ifdef ELUNA
#include "LuaEngine.h"
#endif
namespace Acore
{
    class BattlegroundChatBuilder
    {
    public:
        BattlegroundChatBuilder(ChatMsg msgtype, uint32 textId, Player const* source, va_list* args = nullptr)
            : _msgtype(msgtype), _textId(textId), _source(source), _args(args) { }

        void operator()(WorldPacket& data, LocaleConstant loc_idx)
        {
            char const* text = sObjectMgr->GetAcoreString(_textId, loc_idx);
            if (_args)
            {
                // we need copy va_list before use or original va_list will corrupted
                va_list ap;
                va_copy(ap, *_args);

                char str[2048];
                vsnprintf(str, 2048, text, ap);
                va_end(ap);

                do_helper(data, &str[0]);
            }
            else
                do_helper(data, text);
        }

    private:
        void do_helper(WorldPacket& data, char const* text)
        {
            ChatHandler::BuildChatPacket(data, _msgtype, LANG_UNIVERSAL, _source, _source, text);
        }

        ChatMsg _msgtype;
        uint32 _textId;
        Player const* _source;
        va_list* _args;
    };

    class Battleground2ChatBuilder
    {
    public:
        Battleground2ChatBuilder(ChatMsg msgtype, uint32 textId, Player const* source, int32 arg1, int32 arg2)
            : _msgtype(msgtype), _textId(textId), _source(source), _arg1(arg1), _arg2(arg2) {}

        void operator()(WorldPacket& data, LocaleConstant loc_idx)
        {
            char const* text = sObjectMgr->GetAcoreString(_textId, loc_idx);
            char const* arg1str = _arg1 ? sObjectMgr->GetAcoreString(_arg1, loc_idx) : "";
            char const* arg2str = _arg2 ? sObjectMgr->GetAcoreString(_arg2, loc_idx) : "";

            char str[2048];
            snprintf(str, 2048, text, arg1str, arg2str);

            ChatHandler::BuildChatPacket(data, _msgtype, LANG_UNIVERSAL, _source, _source, str);
        }

    private:
        ChatMsg _msgtype;
        uint32 _textId;
        Player const* _source;
        uint32 _arg1;
        uint32 _arg2;
    };
}                                                           // namespace Acore

template<class Do>
void Battleground::BroadcastWorker(Do& _do)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        _do(itr->second);
}

Battleground::Battleground()
{
    m_RealTypeID        = BATTLEGROUND_TYPE_NONE;
    m_RandomTypeID      = BATTLEGROUND_TYPE_NONE;
    m_InstanceID        = 0;
    m_Status            = STATUS_NONE;
    m_ClientInstanceID  = 0;
    m_EndTime           = 0;
    m_LastResurrectTime = 0;
    m_ArenaType         = 0;
    m_IsArena           = false;
    m_WinnerId          = TEAM_NEUTRAL;
    m_StartTime         = 0;
    m_ResetStatTimer    = 0;
    m_ValidStartPositionTimer = 0;
    m_Events            = 0;
    m_StartDelayTime    = 0;
    m_IsRated           = false;
    m_BuffChange        = false;
    m_IsRandom          = false;
    m_Name              = "";
    m_LevelMin          = 0;
    m_LevelMax          = 0;
    m_SetDeleteThis     = false;

    m_MaxPlayersPerTeam = 0;
    m_MinPlayersPerTeam = 0;

    m_MapId             = 0;
    m_Map               = nullptr;
    m_StartMaxDist      = 0.0f;
    ScriptId            = 0;

    m_TeamStartLocX[TEAM_ALLIANCE]   = 0;
    m_TeamStartLocX[TEAM_HORDE]      = 0;

    m_TeamStartLocY[TEAM_ALLIANCE]   = 0;
    m_TeamStartLocY[TEAM_HORDE]      = 0;

    m_TeamStartLocZ[TEAM_ALLIANCE]   = 0;
    m_TeamStartLocZ[TEAM_HORDE]      = 0;

    m_TeamStartLocO[TEAM_ALLIANCE]   = 0;
    m_TeamStartLocO[TEAM_HORDE]      = 0;

    m_ArenaTeamIds[TEAM_ALLIANCE]   = 0;
    m_ArenaTeamIds[TEAM_HORDE]      = 0;

    m_ArenaTeamRatingChanges[TEAM_ALLIANCE]   = 0;
    m_ArenaTeamRatingChanges[TEAM_HORDE]      = 0;

    m_ArenaTeamMMR[TEAM_ALLIANCE]   = 0;
    m_ArenaTeamMMR[TEAM_HORDE]      = 0;

    m_BgRaids[TEAM_ALLIANCE]         = nullptr;
    m_BgRaids[TEAM_HORDE]            = nullptr;

    m_PlayersCount[TEAM_ALLIANCE]    = 0;
    m_PlayersCount[TEAM_HORDE]       = 0;

    m_BgInvitedPlayers[TEAM_ALLIANCE] = 0;
    m_BgInvitedPlayers[TEAM_HORDE]   = 0;

    m_TeamScores[TEAM_ALLIANCE]      = 0;
    m_TeamScores[TEAM_HORDE]         = 0;

    m_PrematureCountDown = false;
    m_PrematureCountDownTimer = 0;

    m_HonorMode = BG_NORMAL;

    StartDelayTimes[BG_STARTING_EVENT_FIRST]  = BG_START_DELAY_2M;
    StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_1M;
    StartDelayTimes[BG_STARTING_EVENT_THIRD]  = BG_START_DELAY_30S;
    StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;
    //we must set to some default existing values
    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_BG_WS_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_BG_WS_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_BG_WS_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_BG_WS_HAS_BEGUN;

    // pussywizard:
    m_UpdateTimer = 0;
}

Battleground::~Battleground()
{
    // remove objects and creatures
    // (this is done automatically in mapmanager update, when the instance is reset after the reset time)
    uint32 size = uint32(BgCreatures.size());
    for (uint32 i = 0; i < size; ++i)
        DelCreature(i);

    size = uint32(BgObjects.size());
    for (uint32 i = 0; i < size; ++i)
        DelObject(i);

#ifdef ELUNA
    sEluna->OnBGDestroy(this, GetBgTypeID(), GetInstanceID());
#endif

    sBattlegroundMgr->RemoveBattleground(GetBgTypeID(), GetInstanceID());
    // unload map
    if (m_Map)
    {
        m_Map->SetUnload();
        //unlink to prevent crash, always unlink all pointer reference before destruction
        m_Map->SetBG(nullptr);
        m_Map = nullptr;
    }

    for (BattlegroundScoreMap::const_iterator itr = PlayerScores.begin(); itr != PlayerScores.end(); ++itr)
        delete itr->second;
}

void Battleground::Update(uint32 diff)
{
    // pussywizard:
    m_UpdateTimer += diff;
    if (m_UpdateTimer < BATTLEGROUND_UPDATE_INTERVAL)
        return;

    diff = BATTLEGROUND_UPDATE_INTERVAL; // just change diff value, no need to replace variable name in many places
    m_UpdateTimer -= BATTLEGROUND_UPDATE_INTERVAL;

    if (!PreUpdateImpl(diff))
        return;

    if (!GetPlayersSize())
    {
        if (!GetInvitedCount(TEAM_HORDE) && !GetInvitedCount(TEAM_ALLIANCE))
            m_SetDeleteThis = true;
        return;
    }

    switch (GetStatus())
    {
        case STATUS_WAIT_JOIN:
            if (GetPlayersSize())
            {
                _ProcessJoin(diff);
                _CheckSafePositions(diff);
            }
            break;
        case STATUS_IN_PROGRESS:
            if (isArena())
            {
                if (GetStartTime() >= 46 * MINUTE * IN_MILLISECONDS) // pussywizard: 1min startup + 45min allowed duration
                {
                    UpdateArenaWorldState();
                    CheckArenaAfterTimerConditions();
                    return;
                }
            }
            else
            {
                _ProcessResurrect(diff);
                if (sBattlegroundMgr->GetPrematureFinishTime() && (GetPlayersCountByTeam(TEAM_ALLIANCE) < GetMinPlayersPerTeam() || GetPlayersCountByTeam(TEAM_HORDE) < GetMinPlayersPerTeam()))
                    _ProcessProgress(diff);
                else if (m_PrematureCountDown)
                    m_PrematureCountDown = false;
            }
            break;
        case STATUS_WAIT_LEAVE:
            _ProcessLeave(diff);
            break;
        default:
            break;
    }

    // Update start time and reset stats timer
    m_StartTime += diff;
    m_ResetStatTimer += diff;

    PostUpdateImpl(diff);

    sScriptMgr->OnBattlegroundUpdate(this, diff);
}

inline void Battleground::_CheckSafePositions(uint32 diff)
{
    float maxDist = GetStartMaxDist();
    if (!maxDist)
        return;

    m_ValidStartPositionTimer += diff;
    if (m_ValidStartPositionTimer >= CHECK_PLAYER_POSITION_INVERVAL)
    {
        m_ValidStartPositionTimer = 0;

        Position pos;
        float x, y, z, o;
        for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
        {
            itr->second->GetPosition(&pos);
            GetTeamStartLoc(itr->second->GetBgTeamId(), x, y, z, o);
            if (pos.GetExactDistSq(x, y, z) > maxDist)
            {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("bg.battleground", "BATTLEGROUND: Sending %s back to start location (map: %u) (possible exploit)", itr->second->GetName().c_str(), GetMapId());
#endif
                itr->second->TeleportTo(GetMapId(), x, y, z, o);
            }
        }
    }
}

inline void Battleground::_ProcessResurrect(uint32 diff)
{
    // *********************************************************
    // ***        BATTLEGROUND RESURRECTION SYSTEM           ***
    // *********************************************************
    // this should be handled by spell system
    m_LastResurrectTime += diff;
    if (m_LastResurrectTime >= RESURRECTION_INTERVAL)
    {
        if (GetReviveQueueSize())
        {
            for (std::map<ObjectGuid, GuidVector>::iterator itr = m_ReviveQueue.begin(); itr != m_ReviveQueue.end(); ++itr)
            {
                Creature* sh = nullptr;
                for (ObjectGuid const guid : itr->second)
                {
                    Player* player = ObjectAccessor::FindPlayer(guid);
                    if (!player)
                        continue;

                    if (!sh && player->IsInWorld())
                    {
                        sh = player->GetMap()->GetCreature(itr->first);
                        // only for visual effect
                        if (sh)
                            // Spirit Heal, effect 117
                            sh->CastSpell(sh, SPELL_SPIRIT_HEAL, true);
                    }

                    // Resurrection visual
                    player->CastSpell(player, SPELL_RESURRECTION_VISUAL, true);
                    m_ResurrectQueue.push_back(guid);
                }

                itr->second.clear();
            }

            m_ReviveQueue.clear();
            m_LastResurrectTime = 0;
        }
        else
            // queue is clear and time passed, just update last resurrection time
            m_LastResurrectTime = 0;
    }
    else if (m_LastResurrectTime > 500)    // Resurrect players only half a second later, to see spirit heal effect on NPC
    {
        for (ObjectGuid const guid : m_ResurrectQueue)
        {
            Player* player = ObjectAccessor::FindPlayer(guid);
            if (!player)
                continue;
            player->ResurrectPlayer(1.0f);
            player->CastSpell(player, 6962, true);
            player->CastSpell(player, SPELL_SPIRIT_HEAL_MANA, true);
            player->SpawnCorpseBones(false);
        }
        m_ResurrectQueue.clear();
    }
}

TeamId Battleground::GetPrematureWinner()
{
    if (GetPlayersCountByTeam(TEAM_ALLIANCE) >= GetMinPlayersPerTeam())
        return TEAM_ALLIANCE;
    else if (GetPlayersCountByTeam(TEAM_HORDE) >= GetMinPlayersPerTeam())
        return TEAM_HORDE;

    return TEAM_NEUTRAL;
}

inline void Battleground::_ProcessProgress(uint32 diff)
{
    // *********************************************************
    // ***           BATTLEGROUND BALLANCE SYSTEM            ***
    // *********************************************************
    // if less then minimum players are in on one side, then start premature finish timer
    if (!m_PrematureCountDown)
    {
        m_PrematureCountDown = true;
        m_PrematureCountDownTimer = sBattlegroundMgr->GetPrematureFinishTime();
    }
    else if (m_PrematureCountDownTimer < diff)
    {
        // time's up!
        EndBattleground(GetPrematureWinner());
        m_PrematureCountDown = false;
    }
    else if (!sBattlegroundMgr->isTesting())
    {
        uint32 newtime = m_PrematureCountDownTimer - diff;
        // announce every minute
        if (newtime > (MINUTE * IN_MILLISECONDS))
        {
            if (newtime / (MINUTE * IN_MILLISECONDS) != m_PrematureCountDownTimer / (MINUTE * IN_MILLISECONDS))
                PSendMessageToAll(LANG_BATTLEGROUND_PREMATURE_FINISH_WARNING, CHAT_MSG_SYSTEM, nullptr, (uint32)(m_PrematureCountDownTimer / (MINUTE * IN_MILLISECONDS)));
        }
        else
        {
            //announce every 15 seconds
            if (newtime / (15 * IN_MILLISECONDS) != m_PrematureCountDownTimer / (15 * IN_MILLISECONDS))
                PSendMessageToAll(LANG_BATTLEGROUND_PREMATURE_FINISH_WARNING_SECS, CHAT_MSG_SYSTEM, nullptr, (uint32)(m_PrematureCountDownTimer / IN_MILLISECONDS));
        }
        m_PrematureCountDownTimer = newtime;
    }
}

inline void Battleground::_ProcessJoin(uint32 diff)
{
    // *********************************************************
    // ***           BATTLEGROUND STARTING SYSTEM            ***
    // *********************************************************
    ModifyStartDelayTime(diff);

    if (m_ResetStatTimer > 5000)
    {
        m_ResetStatTimer = 0;
        for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
            itr->second->ResetAllPowers();
    }

    if (!(m_Events & BG_STARTING_EVENT_1))
    {
        m_Events |= BG_STARTING_EVENT_1;

        if (!FindBgMap())
        {
            LOG_ERROR("server", "Battleground::_ProcessJoin: map (map id: %u, instance id: %u) is not created!", m_MapId, m_InstanceID);
            EndNow();
            return;
        }

        // Setup here, only when at least one player has ported to the map
        if (!SetupBattleground())
        {
            EndNow();
            return;
        }

        StartingEventCloseDoors();
        SetStartDelayTime(StartDelayTimes[BG_STARTING_EVENT_FIRST]);
        // First start warning - 2 or 1 minute
        SendMessageToAll(StartMessageIds[BG_STARTING_EVENT_FIRST], CHAT_MSG_BG_SYSTEM_NEUTRAL);
    }
    // After 1 minute or 30 seconds, warning is signaled
    else if (GetStartDelayTime() <= StartDelayTimes[BG_STARTING_EVENT_SECOND] && !(m_Events & BG_STARTING_EVENT_2))
    {
        m_Events |= BG_STARTING_EVENT_2;
        SendMessageToAll(StartMessageIds[BG_STARTING_EVENT_SECOND], CHAT_MSG_BG_SYSTEM_NEUTRAL);
    }
    // After 30 or 15 seconds, warning is signaled
    else if (GetStartDelayTime() <= StartDelayTimes[BG_STARTING_EVENT_THIRD] && !(m_Events & BG_STARTING_EVENT_3))
    {
        m_Events |= BG_STARTING_EVENT_3;
        SendMessageToAll(StartMessageIds[BG_STARTING_EVENT_THIRD], CHAT_MSG_BG_SYSTEM_NEUTRAL);

        if (isArena())
            switch (GetBgTypeID())
            {
                case BATTLEGROUND_NA:
                    DelObject(BG_NA_OBJECT_READY_MARKER_1);
                    DelObject(BG_NA_OBJECT_READY_MARKER_2);
                    break;
                case BATTLEGROUND_BE:
                    DelObject(BG_BE_OBJECT_READY_MARKER_1);
                    DelObject(BG_BE_OBJECT_READY_MARKER_2);
                    break;
                case BATTLEGROUND_RL:
                    DelObject(BG_RL_OBJECT_READY_MARKER_1);
                    DelObject(BG_RL_OBJECT_READY_MARKER_2);
                    break;
                case BATTLEGROUND_DS:
                    DelObject(BG_DS_OBJECT_READY_MARKER_1);
                    DelObject(BG_DS_OBJECT_READY_MARKER_2);
                    break;
                case BATTLEGROUND_RV:
                    DelObject(BG_RV_OBJECT_READY_MARKER_1);
                    DelObject(BG_RV_OBJECT_READY_MARKER_2);
                    break;
                default:
                    break;
            }
    }
    // Delay expired (after 2 or 1 minute)
    else if (GetStartDelayTime() <= 0 && !(m_Events & BG_STARTING_EVENT_4))
    {
        m_Events |= BG_STARTING_EVENT_4;

        StartingEventOpenDoors();

#ifdef ELUNA
        sEluna->OnBGStart(this, GetBgTypeID(), GetInstanceID());
#endif

        SendWarningToAll(StartMessageIds[BG_STARTING_EVENT_FOURTH]);
        SetStatus(STATUS_IN_PROGRESS);
        SetStartDelayTime(StartDelayTimes[BG_STARTING_EVENT_FOURTH]);

        // Remove preparation
        if (isArena())
        {
            // pussywizard: initial visibility range is 30yd, set it to a proper value now:
            if (BattlegroundMap* map = GetBgMap())
                map->SetVisibilityRange(World::GetMaxVisibleDistanceInBGArenas());

            for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                if (Player* player = itr->second)
                {
                    WorldPacket status;
                    sBattlegroundMgr->BuildBattlegroundStatusPacket(&status, this, player->GetCurrentBattlegroundQueueSlot(), STATUS_IN_PROGRESS, 0, GetStartTime(), GetArenaType(), player->GetBgTeamId());
                    player->GetSession()->SendPacket(&status);

                    player->RemoveAurasDueToSpell(SPELL_ARENA_PREPARATION);
                    player->ResetAllPowers();
                    // remove auras with duration lower than 30s
                    Unit::AuraApplicationMap& auraMap = player->GetAppliedAuras();
                    for (Unit::AuraApplicationMap::iterator iter = auraMap.begin(); iter != auraMap.end();)
                    {
                        AuraApplication* aurApp = iter->second;
                        Aura* aura = aurApp->GetBase();
                        if (!aura->IsPermanent()
                                && aura->GetDuration() <= 30 * IN_MILLISECONDS
                                && aurApp->IsPositive()
                                // && (!aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES)) Xinef: bullshit condition, ALL buffs should be removed
                                && (!aura->HasEffectType(SPELL_AURA_MOD_INVISIBILITY)))
                            player->RemoveAura(iter);
                        else
                            ++iter;
                    }

                    player->UpdateObjectVisibility(true);
                }

            for (SpectatorList::const_iterator itr = m_Spectators.begin(); itr != m_Spectators.end(); ++itr)
                ArenaSpectator::HandleResetCommand(*itr);

            CheckArenaWinConditions();

            // pussywizard: arena spectator stuff
            if (GetStatus() == STATUS_IN_PROGRESS)
            {
                for (ToBeTeleportedMap::const_iterator itr = m_ToBeTeleported.begin(); itr != m_ToBeTeleported.end(); ++itr)
                    if (Player* p = ObjectAccessor::FindConnectedPlayer(itr->first))
                        if (Player* t = ObjectAccessor::FindPlayer(itr->second))
                        {
                            if (!t->FindMap() || t->FindMap() != GetBgMap())
                                continue;

                            p->SetSummonPoint(t->GetMapId(), t->GetPositionX(), t->GetPositionY(), t->GetPositionZ(), 15, true);

                            WorldPacket data(SMSG_SUMMON_REQUEST, 8 + 4 + 4);
                            data << t->GetGUID();
                            data << uint32(t->GetZoneId());
                            data << uint32(15 * IN_MILLISECONDS);
                            p->GetSession()->SendPacket(&data);
                        }
                m_ToBeTeleported.clear();
            }
        }
        else
        {
            PlaySoundToAll(SOUND_BG_START);

            for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
            {
                itr->second->RemoveAurasDueToSpell(SPELL_PREPARATION);
                itr->second->ResetAllPowers();
            }

            // Announce BG starting
            if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE))
                sWorld->SendWorldText(LANG_BG_STARTED_ANNOUNCE_WORLD, GetName(), std::min(GetMinLevel(), (uint32)80), std::min(GetMaxLevel(), (uint32)80));

            sScriptMgr->OnBattlegroundStart(this);
        }
    }
}

inline void Battleground::_ProcessLeave(uint32 diff)
{
    // *********************************************************
    // ***           BATTLEGROUND ENDING SYSTEM              ***
    // *********************************************************
    // remove all players from battleground after 2 minutes
    m_EndTime -= diff;
    if (m_EndTime <= 0)
    {
        m_EndTime = TIME_TO_AUTOREMOVE; // pussywizard: 0 -> TIME_TO_AUTOREMOVE
        BattlegroundPlayerMap::iterator itr, next;
        for (itr = m_Players.begin(); itr != m_Players.end(); itr = next)
        {
            next = itr;
            ++next;
            itr->second->LeaveBattleground(this); //itr is erased here!
        }
    }
}

void Battleground::SetTeamStartLoc(TeamId teamId, float X, float Y, float Z, float O)
{
    m_TeamStartLocX[teamId] = X;
    m_TeamStartLocY[teamId] = Y;
    m_TeamStartLocZ[teamId] = Z;
    m_TeamStartLocO[teamId] = O;
}

void Battleground::SendPacketToAll(WorldPacket* packet)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        itr->second->GetSession()->SendPacket(packet);
}

void Battleground::SendPacketToTeam(TeamId teamId, WorldPacket* packet, Player* sender, bool self)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->GetBgTeamId() == teamId && (self || sender != itr->second))
            itr->second->GetSession()->SendPacket(packet);
}

void Battleground::PlaySoundToAll(uint32 soundID)
{
    WorldPacket data;
    sBattlegroundMgr->BuildPlaySoundPacket(&data, soundID);
    SendPacketToAll(&data);
}

void Battleground::CastSpellOnTeam(uint32 spellId, TeamId teamId)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->GetBgTeamId() == teamId)
            itr->second->CastSpell(itr->second, spellId, true);
}

void Battleground::RemoveAuraOnTeam(uint32 spellId, TeamId teamId)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->GetBgTeamId() == teamId)
            itr->second->RemoveAura(spellId);
}

void Battleground::YellToAll(Creature* creature, char const* text, uint32 language)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
    {
        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_YELL, Language(language), creature, itr->second, text);
        itr->second->SendDirectMessage(&data);
    }
}

void Battleground::RewardHonorToTeam(uint32 honor, TeamId teamId)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->GetBgTeamId() == teamId)
            UpdatePlayerScore(itr->second, SCORE_BONUS_HONOR, honor);
}

void Battleground::RewardReputationToTeam(uint32 factionId, uint32 reputation, TeamId teamId)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->GetBgTeamId() == teamId)
        {
            uint32 realFactionId = GetRealRepFactionForPlayer(factionId, itr->second);

            uint32 repGain = reputation;
            AddPct(repGain, itr->second->GetTotalAuraModifier(SPELL_AURA_MOD_REPUTATION_GAIN));
            AddPct(repGain, itr->second->GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_FACTION_REPUTATION_GAIN, realFactionId));
            if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(realFactionId))
                itr->second->GetReputationMgr().ModifyReputation(factionEntry, repGain);
        }
}

uint32 Battleground::GetRealRepFactionForPlayer(uint32 factionId, Player* player)
{
    if (player)
    {
        // if the bg team is not the original team, reverse reputation
        if (player->GetBgTeamId() != player->GetTeamId(true))
        {
            switch (factionId)
            {
                case BG_REP_AB_ALLIANCE:
                    return BG_REP_AB_HORDE;
                case BG_REP_AB_HORDE:
                    return BG_REP_AB_ALLIANCE;
                case BG_REP_AV_ALLIANCE:
                    return BG_REP_AV_HORDE;
                case BG_REP_AV_HORDE:
                    return BG_REP_AV_ALLIANCE;
                case BG_REP_WS_ALLIANCE:
                    return BG_REP_WS_HORDE;
                case BG_REP_WS_HORDE:
                    return BG_REP_WS_ALLIANCE;
            }
        }
    }

    return factionId;
}

void Battleground::UpdateWorldState(uint32 Field, uint32 Value)
{
    WorldPacket data;
    sBattlegroundMgr->BuildUpdateWorldStatePacket(&data, Field, Value);
    SendPacketToAll(&data);
}

void Battleground::UpdateWorldStateForPlayer(uint32 Field, uint32 Value, Player* player)
{
    WorldPacket data;
    sBattlegroundMgr->BuildUpdateWorldStatePacket(&data, Field, Value);
    player->GetSession()->SendPacket(&data);
}

void Battleground::EndBattleground(TeamId winnerTeamId)
{
    // xinef: if this is true, it means that endbattleground is called second time
    // skip to avoid double rating reduce / add
    // can bug out due to multithreading ?
    // set as fast as possible
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;
    uint32 startDelay = GetStartDelayTime();
    bool bValidArena = isArena() && isRated() && GetStatus() == STATUS_IN_PROGRESS && GetStartTime() >= startDelay + 15000; // pussywizard: only if arena lasted at least 15 secs
    SetStatus(STATUS_WAIT_LEAVE);

    ArenaTeam* winnerArenaTeam = nullptr;
    ArenaTeam* loserArenaTeam = nullptr;

    uint32 loserTeamRating = 0;
    uint32 loserMatchmakerRating = 0;
    int32  loserChange = 0;
    int32  loserMatchmakerChange = 0;
    uint32 winnerTeamRating = 0;
    uint32 winnerMatchmakerRating = 0;
    int32  winnerChange = 0;
    int32  winnerMatchmakerChange = 0;

    int32 winmsg_id = 0;

    if (winnerTeamId == TEAM_ALLIANCE)
    {
        SetWinner(TEAM_HORDE); // reversed in packet
        winmsg_id = isBattleground() ? LANG_BG_A_WINS : LANG_ARENA_GOLD_WINS;
        PlaySoundToAll(SOUND_ALLIANCE_WINS);                // alliance wins sound
    }
    else if (winnerTeamId == TEAM_HORDE)
    {
        SetWinner(TEAM_ALLIANCE); // reversed in packet
        winmsg_id = isBattleground() ? LANG_BG_H_WINS : LANG_ARENA_GREEN_WINS;
        PlaySoundToAll(SOUND_HORDE_WINS);                   // horde wins sound
    }
    else
        SetWinner(TEAM_NEUTRAL);

    PreparedStatement* stmt = nullptr;
    uint64 battlegroundId = 1;
    if (isBattleground() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PVPSTATS_MAXID);
        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        if (result)
        {
            Field* fields = result->Fetch();
            battlegroundId = fields[0].GetUInt64() + 1;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PVPSTATS_BATTLEGROUND);
        stmt->setUInt64(0, battlegroundId);
        stmt->setUInt8(1, GetWinner());
        stmt->setUInt8(2, GetUniqueBracketId());
        stmt->setUInt8(3, GetBgTypeID(true));
        CharacterDatabase.Execute(stmt);
    }

    //we must set it this way, because end time is sent in packet!
    m_EndTime = TIME_TO_AUTOREMOVE;

    // arena rating calculation
    if (isArena() && isRated())
    {
        winnerArenaTeam = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(winnerTeamId == TEAM_NEUTRAL ? TEAM_HORDE : winnerTeamId));
        loserArenaTeam  = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(winnerTeamId == TEAM_NEUTRAL ? TEAM_ALLIANCE : GetOtherTeamId(winnerTeamId)));
        if (winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
        {
            if (winnerTeamId != TEAM_NEUTRAL)
            {
                loserTeamRating = loserArenaTeam->GetRating();
                loserMatchmakerRating = GetArenaMatchmakerRating(GetOtherTeamId(winnerTeamId));
                winnerTeamRating = winnerArenaTeam->GetRating();
                winnerMatchmakerRating = GetArenaMatchmakerRating(winnerTeamId);
                winnerMatchmakerChange = bValidArena ? winnerArenaTeam->WonAgainst(winnerMatchmakerRating, loserMatchmakerRating, winnerChange, GetBgMap()) : 0;
                loserMatchmakerChange = loserArenaTeam->LostAgainst(loserMatchmakerRating, winnerMatchmakerRating, loserChange, GetBgMap());

                sScriptMgr->OnAfterArenaRatingCalculation(this, winnerMatchmakerChange, loserMatchmakerChange, winnerChange, loserChange);

                SetArenaMatchmakerRating(winnerTeamId, winnerMatchmakerRating + winnerMatchmakerChange);
                SetArenaMatchmakerRating(GetOtherTeamId(winnerTeamId), loserMatchmakerRating + loserMatchmakerChange);
                SetArenaTeamRatingChangeForTeam(winnerTeamId, winnerChange);
                SetArenaTeamRatingChangeForTeam(GetOtherTeamId(winnerTeamId), loserChange);

                // pussywizard: arena logs in database
                uint32 fightId = sArenaTeamMgr->GetNextArenaLogId();
                uint32 currOnline = (uint32)(sWorld->GetActiveSessionCount());

                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                PreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_INS_ARENA_LOG_FIGHT);
                stmt2->setUInt32(0, fightId);
                stmt2->setUInt8(1, m_ArenaType);
                stmt2->setUInt32(2, ((GetStartTime() <= startDelay ? 0 : GetStartTime() - startDelay) / 1000));
                stmt2->setUInt32(3, winnerArenaTeam->GetId());
                stmt2->setUInt32(4, loserArenaTeam->GetId());
                stmt2->setUInt16(5, (uint16)winnerTeamRating);
                stmt2->setUInt16(6, (uint16)winnerMatchmakerRating);
                stmt2->setInt16(7, (int16)winnerChange);
                stmt2->setUInt16(8, (uint16)loserTeamRating);
                stmt2->setUInt16(9, (uint16)loserMatchmakerRating);
                stmt2->setInt16(10, (int16)loserChange);
                stmt2->setUInt32(11, currOnline);
                trans->Append(stmt2);

                uint8 memberId = 0;
                for (Battleground::ArenaLogEntryDataMap::const_iterator itr = ArenaLogEntries.begin(); itr != ArenaLogEntries.end(); ++itr)
                {
                    stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_INS_ARENA_LOG_MEMBERSTATS);
                    stmt2->setUInt32(0, fightId);
                    stmt2->setUInt8(1, ++memberId);
                    stmt2->setString(2, itr->second.Name);
                    stmt2->setUInt32(3, itr->second.Guid);
                    stmt2->setUInt32(4, itr->second.ArenaTeamId);
                    stmt2->setUInt32(5, itr->second.Acc);
                    stmt2->setString(6, itr->second.IP);
                    stmt2->setUInt32(7, itr->second.DamageDone);
                    stmt2->setUInt32(8, itr->second.HealingDone);
                    stmt2->setUInt32(9, itr->second.KillingBlows);
                    trans->Append(stmt2);
                }

                CharacterDatabase.CommitTransaction(trans);
            }
            // Deduct 16 points from each teams arena-rating if there are no winners after 45+2 minutes
            else
            {
                // pussywizard: in case of a draw, the following is always true:
                // winnerArenaTeam => TEAM_HORDE, loserArenaTeam => TEAM_ALLIANCE

                winnerTeamRating = winnerArenaTeam->GetRating();
                winnerMatchmakerRating = GetArenaMatchmakerRating(TEAM_HORDE);
                loserTeamRating = loserArenaTeam->GetRating();
                loserMatchmakerRating = GetArenaMatchmakerRating(TEAM_ALLIANCE);
                winnerMatchmakerChange = 0;
                loserMatchmakerChange = 0;
                winnerChange = ARENA_TIMELIMIT_POINTS_LOSS;
                loserChange = ARENA_TIMELIMIT_POINTS_LOSS;

                SetArenaTeamRatingChangeForTeam(TEAM_ALLIANCE, ARENA_TIMELIMIT_POINTS_LOSS);
                SetArenaTeamRatingChangeForTeam(TEAM_HORDE, ARENA_TIMELIMIT_POINTS_LOSS);
                winnerArenaTeam->FinishGame(ARENA_TIMELIMIT_POINTS_LOSS, GetBgMap());
                loserArenaTeam->FinishGame(ARENA_TIMELIMIT_POINTS_LOSS, GetBgMap());

                // pussywizard: arena logs in database
                uint32 fightId = sArenaTeamMgr->GetNextArenaLogId();
                uint32 currOnline = (uint32)(sWorld->GetActiveSessionCount());

                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                PreparedStatement* stmt3 = CharacterDatabase.GetPreparedStatement(CHAR_INS_ARENA_LOG_FIGHT);
                stmt3->setUInt32(0, fightId);
                stmt3->setUInt8(1, m_ArenaType);
                stmt3->setUInt32(2, ((GetStartTime() <= startDelay ? 0 : GetStartTime() - startDelay) / 1000));
                stmt3->setUInt32(3, winnerArenaTeam->GetId());
                stmt3->setUInt32(4, loserArenaTeam->GetId());
                stmt3->setUInt16(5, (uint16)winnerTeamRating);
                stmt3->setUInt16(6, (uint16)winnerMatchmakerRating);
                stmt3->setInt16(7, (int16)winnerChange);
                stmt3->setUInt16(8, (uint16)loserTeamRating);
                stmt3->setUInt16(9, (uint16)loserMatchmakerRating);
                stmt3->setInt16(10, (int16)loserChange);
                stmt3->setUInt32(11, currOnline);
                trans->Append(stmt3);

                uint8 memberId = 0;
                for (Battleground::ArenaLogEntryDataMap::const_iterator itr = ArenaLogEntries.begin(); itr != ArenaLogEntries.end(); ++itr)
                {
                    stmt3 = CharacterDatabase.GetPreparedStatement(CHAR_INS_ARENA_LOG_MEMBERSTATS);
                    stmt3->setUInt32(0, fightId);
                    stmt3->setUInt8(1, ++memberId);
                    stmt3->setString(2, itr->second.Name);
                    stmt3->setUInt32(3, itr->second.Guid);
                    stmt3->setUInt32(4, itr->second.ArenaTeamId);
                    stmt3->setUInt32(5, itr->second.Acc);
                    stmt3->setString(6, itr->second.IP);
                    stmt3->setUInt32(7, itr->second.DamageDone);
                    stmt3->setUInt32(8, itr->second.HealingDone);
                    stmt3->setUInt32(9, itr->second.KillingBlows);
                    trans->Append(stmt3);
                }

                CharacterDatabase.CommitTransaction(trans);
            }
        }
        else
        {
            SetArenaTeamRatingChangeForTeam(TEAM_ALLIANCE, 0);
            SetArenaTeamRatingChangeForTeam(TEAM_HORDE, 0);
        }
    }

    WorldPacket pvpLogData;
    sBattlegroundMgr->BuildPvpLogDataPacket(&pvpLogData, this);

    uint8 aliveWinners = GetAlivePlayersCountByTeam(winnerTeamId);
    for (BattlegroundPlayerMap::iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
    {
        Player* player = itr->second;
        TeamId bgTeamId = player->GetBgTeamId();
        // should remove spirit of redemption
        if (player->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
            player->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

        // Last standing - Rated 5v5 arena & be solely alive player
        if (bgTeamId == winnerTeamId && isArena() && isRated() && GetArenaType() == ARENA_TYPE_5v5 && aliveWinners == 1 && player->IsAlive() && bValidArena)
            player->CastSpell(player, SPELL_THE_LAST_STANDING, true);

        if (!player->IsAlive())
        {
            player->ResurrectPlayer(1.0f);
            player->SpawnCorpseBones();
        }
        else
        {
            //needed cause else in av some creatures will kill the players at the end
            player->CombatStop();
            player->getHostileRefManager().deleteReferences();
        }

        // per player calculation
        if (isArena() && isRated() && winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
        {
            if (bgTeamId == winnerTeamId)
            {
                if (bValidArena)
                {
                    // update achievement BEFORE personal rating update
                    uint32 rating = player->GetArenaPersonalRating(winnerArenaTeam->GetSlot());
                    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA, rating ? rating : 1);
                    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_ARENA, GetMapId());

                    winnerArenaTeam->MemberWon(player, loserMatchmakerRating, winnerMatchmakerChange);
                }
            }
            else
            {
                loserArenaTeam->MemberLost(player, winnerMatchmakerRating, loserMatchmakerChange);

                // Arena lost => reset the win_rated_arena having the "no_lose" condition
                player->ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_NO_LOSE, 0);
            }

            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_PLAY_ARENA, GetMapId());
        }

        uint32 winner_kills = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_HONOR_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_HONOR_FIRST);
        uint32 loser_kills = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_LOSER_HONOR_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_LOSER_HONOR_FIRST);
        uint32 winner_arena = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_ARENA_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_ARENA_FIRST);

        sScriptMgr->OnBattlegroundEndReward(this, player, winnerTeamId);

        // Reward winner team
        if (bgTeamId == winnerTeamId)
        {
            if (IsRandom() || BattlegroundMgr::IsBGWeekend(GetBgTypeID(true)))
            {
                UpdatePlayerScore(player, SCORE_BONUS_HONOR, GetBonusHonorFromKill(winner_kills));

                // Xinef: check player level and not bracket level if (CanAwardArenaPoints())
                if (player->getLevel() >= BG_AWARD_ARENA_POINTS_MIN_LEVEL)
                    player->ModifyArenaPoints(winner_arena);

                if (!player->GetRandomWinner())
                    player->SetRandomWinner(true);
            }

            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_BG, player->GetMapId());
        }
        else
        {
            if (IsRandom() || BattlegroundMgr::IsBGWeekend(GetBgTypeID(true)))
                UpdatePlayerScore(player, SCORE_BONUS_HONOR, GetBonusHonorFromKill(loser_kills));
        }

        player->ResetAllPowers();
        player->CombatStopWithPets(true);

        BlockMovement(player);

        player->GetSession()->SendPacket(&pvpLogData);

        if (isBattleground() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE))
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PVPSTATS_PLAYER);
            BattlegroundScoreMap::const_iterator score = PlayerScores.find(player->GetGUID());

            stmt->setUInt32(0, battlegroundId);
            stmt->setUInt32(1, player->GetGUID().GetCounter());
            stmt->setBool(2, bgTeamId == winnerTeamId);
            stmt->setUInt32(3, score->second->GetKillingBlows());
            stmt->setUInt32(4, score->second->GetDeaths());
            stmt->setUInt32(5, score->second->GetHonorableKills());
            stmt->setUInt32(6, score->second->GetBonusHonor());
            stmt->setUInt32(7, score->second->GetDamageDone());
            stmt->setUInt32(8, score->second->GetHealingDone());
            stmt->setUInt32(9, score->second->GetAttr1());
            stmt->setUInt32(10, score->second->GetAttr2());
            stmt->setUInt32(11, score->second->GetAttr3());
            stmt->setUInt32(12, score->second->GetAttr4());
            stmt->setUInt32(13, score->second->GetAttr5());

            CharacterDatabase.Execute(stmt);
        }

        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, this, player->GetCurrentBattlegroundQueueSlot(), STATUS_IN_PROGRESS, TIME_TO_AUTOREMOVE, GetStartTime(), GetArenaType(), player->GetBgTeamId());
        player->GetSession()->SendPacket(&data);

        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND, player->GetMapId());
    }

    if (isArena() && isRated() && winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
    {
        // save the stat changes
        if (bValidArena) winnerArenaTeam->SaveToDB();
        loserArenaTeam->SaveToDB();
        // send updated arena team stats to players
        // this way all arena team members will get notified, not only the ones who participated in this match
        if (bValidArena) winnerArenaTeam->NotifyStatsChanged();
        loserArenaTeam->NotifyStatsChanged();
    }

    if (winmsg_id)
        SendMessageToAll(winmsg_id, CHAT_MSG_BG_SYSTEM_NEUTRAL);

#ifdef ELUNA
    sEluna->OnBGEnd(this, GetBgTypeID(), GetInstanceID(), winnerTeamId);
#endif
}

uint32 Battleground::GetBonusHonorFromKill(uint32 kills) const
{
    //variable kills means how many honorable kills you scored (so we need kills * honor_for_one_kill)
    uint32 maxLevel = std::min<uint32>(GetMaxLevel(), 80U);
    return Acore::Honor::hk_honor_at_level(maxLevel, float(kills));
}

void Battleground::BlockMovement(Player* player)
{
    player->SetClientControl(player, 0);                          // movement disabled NOTE: the effect will be automatically removed by client when the player is teleported from the battleground, so no need to send with uint8(1) in RemovePlayerAtLeave()
}

void Battleground::RemovePlayerAtLeave(Player* player)
{
    TeamId teamId = player->GetBgTeamId();

    // check if the player was a participant of the match, or only entered through gm command
    bool participant = false;
    BattlegroundPlayerMap::iterator itr = m_Players.find(player->GetGUID());
    if (itr != m_Players.end())
    {
        UpdatePlayersCountByTeam(teamId, true); // -1 player
        m_Players.erase(itr);
        participant = true;
    }

    // delete player score if exists
    BattlegroundScoreMap::iterator itr2 = PlayerScores.find(player->GetGUID());
    if (itr2 != PlayerScores.end())
    {
        delete itr2->second;
        PlayerScores.erase(itr2);
    }

    RemovePlayerFromResurrectQueue(player);

    // resurrect on exit
    if (!player->IsAlive())
    {
        player->ResurrectPlayer(1.0f);
        player->SpawnCorpseBones();
    }

    player->RemoveAurasByType(SPELL_AURA_MOUNTED);

    // BG subclass specific code
    RemovePlayer(player);

    // if the player was a match participant
    if (participant)
    {
        WorldPacket data;

        player->ClearAfkReports();

        //left a rated match in progress, consider as loser
        if (isArena() && isRated() && GetStatus() == STATUS_IN_PROGRESS && teamId != TEAM_NEUTRAL)
        {
            ArenaTeam* winnerArenaTeam = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(GetOtherTeamId(teamId)));
            ArenaTeam* loserArenaTeam = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(teamId));
            if (winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
                loserArenaTeam->MemberLost(player, GetArenaMatchmakerRating(GetOtherTeamId(teamId)));
        }

        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, this, player->GetCurrentBattlegroundQueueSlot(), STATUS_NONE, 0, 0, 0, TEAM_NEUTRAL);
        player->GetSession()->SendPacket(&data);

        // remove from raid group if player is member
        if (Group* group = GetBgRaid(teamId))
            if (group->IsMember(player->GetGUID()))
                if (!group->RemoveMember(player->GetGUID())) // group was disbanded
                    SetBgRaid(teamId, nullptr);

        // let others know
        sBattlegroundMgr->BuildPlayerLeftBattlegroundPacket(&data, player->GetGUID());
        SendPacketToTeam(teamId, &data, player, false);

        // cast deserter
        if (isBattleground() && !player->IsGameMaster() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_CAST_DESERTER))
            if (GetStatus() == STATUS_IN_PROGRESS || GetStatus() == STATUS_WAIT_JOIN)
                player->ScheduleDelayedOperation(DELAYED_SPELL_CAST_DESERTER);
    }

    // Remove shapeshift auras
    player->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

    player->SetBattlegroundId(0, BATTLEGROUND_TYPE_NONE, PLAYER_MAX_BATTLEGROUND_QUEUES, false, false, TEAM_NEUTRAL);

    // Xinef: remove all criterias on bg leave
    player->ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_BG_MAP, GetMapId(), true);

    sScriptMgr->OnBattlegroundRemovePlayerAtLeave(this, player);
}

// this method is called when creating bg
void Battleground::Init()
{
    SetWinner(TEAM_NEUTRAL);
    SetStatus(STATUS_WAIT_QUEUE);
    SetStartTime(0);
    SetEndTime(0);
    SetLastResurrectTime(0);

    m_Events = 0;

    if (m_BgInvitedPlayers[TEAM_ALLIANCE] > 0 || m_BgInvitedPlayers[TEAM_HORDE] > 0)
    {
        LOG_ERROR("server", "Battleground::Reset: one of the counters is not 0 (alliance: %u, horde: %u) for BG (map: %u, instance id: %u)!", m_BgInvitedPlayers[TEAM_ALLIANCE], m_BgInvitedPlayers[TEAM_HORDE], m_MapId, m_InstanceID);
        ABORT();
    }

    m_BgInvitedPlayers[TEAM_ALLIANCE] = 0;
    m_BgInvitedPlayers[TEAM_HORDE] = 0;

    m_Players.clear();

    for (BattlegroundScoreMap::const_iterator itr = PlayerScores.begin(); itr != PlayerScores.end(); ++itr)
        delete itr->second;
    PlayerScores.clear();

    ResetBGSubclass();
}

void Battleground::StartBattleground()
{
    SetStartTime(0);
    SetLastResurrectTime(0);

    // add bg to update list
    // this must be done here, because we need to have already invited some players when first Battleground::Update() method is executed
    sBattlegroundMgr->AddBattleground(this);
}

void Battleground::AddPlayer(Player* player)
{
    // remove afk from player
    if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK))
        player->ToggleAFK();

    sScriptMgr->OnBattlegroundBeforeAddPlayer(this, player);

    // score struct must be created in inherited class

    ObjectGuid guid = player->GetGUID();
    TeamId teamId = player->GetBgTeamId();

    // Add to list/maps
    m_Players[guid] = player;

    UpdatePlayersCountByTeam(teamId, false);                  // +1 player

    WorldPacket data;
    sBattlegroundMgr->BuildPlayerJoinedBattlegroundPacket(&data, player);
    SendPacketToTeam(teamId, &data, player, false);

    player->RemoveAurasByType(SPELL_AURA_MOUNTED);

    // add arena specific auras
    if (isArena())
    {
        player->RemoveArenaEnchantments(TEMP_ENCHANTMENT_SLOT);
        if (teamId == TEAM_ALLIANCE)                                // gold
        {
            if (player->GetTeamId() == TEAM_HORDE)
                player->CastSpell(player, SPELL_HORDE_GOLD_FLAG, true);
            else
                player->CastSpell(player, SPELL_ALLIANCE_GOLD_FLAG, true);
        }
        else                                                // green
        {
            if (player->GetTeamId() == TEAM_HORDE)
                player->CastSpell(player, SPELL_HORDE_GREEN_FLAG, true);
            else
                player->CastSpell(player, SPELL_ALLIANCE_GREEN_FLAG, true);
        }

        // restore pets health before remove
        if (Pet* pet = player->GetPet())
            if (pet->IsAlive())
                pet->SetHealth(pet->GetMaxHealth());

        player->DestroyConjuredItems(true);
        player->UnsummonPetTemporaryIfAny();

        if (GetStatus() == STATUS_WAIT_JOIN)                 // not started yet
        {
            player->CastSpell(player, SPELL_ARENA_PREPARATION, true);
            player->ResetAllPowers();
        }
    }
    else
    {
        if (GetStatus() == STATUS_WAIT_JOIN)                 // not started yet
            player->CastSpell(player, SPELL_PREPARATION, true);   // reduces all mana cost of spells.
    }

    // Xinef: reset all map criterias on map enter
    player->ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_BG_MAP, GetMapId(), true);

    // setup BG group membership
    PlayerAddedToBGCheckIfBGIsRunning(player);
    AddOrSetPlayerToCorrectBgGroup(player, teamId);

    sScriptMgr->OnBattlegroundAddPlayer(this, player);

    // Log
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("server", "BATTLEGROUND: Player %s joined the battle.", player->GetName().c_str());
#endif
}

// this method adds player to his team's bg group, or sets his correct group if player is already in bg group
void Battleground::AddOrSetPlayerToCorrectBgGroup(Player* player, TeamId teamId)
{
    if (player->GetGroup() && (player->GetGroup()->isBGGroup() || player->GetGroup()->isBFGroup()))
    {
        LOG_INFO("misc", "Battleground::AddOrSetPlayerToCorrectBgGroup - player is already in %s group!", (player->GetGroup()->isBGGroup() ? "BG" : "BF"));
        return;
    }

    ObjectGuid playerGuid = player->GetGUID();
    Group* group = GetBgRaid(teamId);
    if (!group)                                      // first player joined
    {
        group = new Group;
        SetBgRaid(teamId, group);
        group->Create(player);
    }
    else if (group->IsMember(playerGuid))
    {
        uint8 subgroup = group->GetMemberGroup(playerGuid);
        player->SetBattlegroundOrBattlefieldRaid(group, subgroup);
    }
    else
    {
        group->AddMember(player);

        if (Group* originalGroup = player->GetOriginalGroup())
            if (originalGroup->IsLeader(playerGuid))
            {
                group->ChangeLeader(playerGuid);
                group->SendUpdate();
            }
    }
}

uint32 Battleground::GetFreeSlotsForTeam(TeamId teamId) const
{
    if (!(GetStatus() == STATUS_IN_PROGRESS || GetStatus() == STATUS_WAIT_JOIN))
        return 0;

    // if CONFIG_BATTLEGROUND_INVITATION_TYPE == BG_QUEUE_INVITATION_TYPE_NO_BALANCE, invite everyone unless the BG is full
    if (sWorld->getIntConfig(CONFIG_BATTLEGROUND_INVITATION_TYPE) == BG_QUEUE_INVITATION_TYPE_NO_BALANCE)
        return (GetInvitedCount(teamId) < GetMaxPlayersPerTeam()) ? GetMaxPlayersPerTeam() - GetInvitedCount(teamId) : 0;

    // if BG is already started or CONFIG_BATTLEGROUND_INVITATION_TYPE != BG_QUEUE_INVITATION_TYPE_NO_BALANCE, do not allow to join too many players of one faction
    uint32 thisTeamInvitedCount = teamId == TEAM_ALLIANCE ? GetInvitedCount(TEAM_ALLIANCE) : GetInvitedCount(TEAM_HORDE);
    uint32 thisTeamPlayersCount = teamId == TEAM_ALLIANCE ? GetPlayersCountByTeam(TEAM_ALLIANCE) : GetPlayersCountByTeam(TEAM_HORDE);
    uint32 otherTeamInvitedCount = teamId == TEAM_ALLIANCE ? GetInvitedCount(TEAM_HORDE) : GetInvitedCount(TEAM_ALLIANCE);
    uint32 otherTeamPlayersCount = teamId == TEAM_ALLIANCE ? GetPlayersCountByTeam(TEAM_HORDE) : GetPlayersCountByTeam(TEAM_ALLIANCE);

    // difference based on ppl invited (not necessarily entered battle)
    // default: allow 0
    uint32 diff = 0;
    uint32 maxPlayersPerTeam = GetMaxPlayersPerTeam();
    uint32 minPlayersPerTeam = GetMinPlayersPerTeam();

    // allow join one person if the sides are equal (to fill up bg to minPlayerPerTeam)
    if (otherTeamInvitedCount == thisTeamInvitedCount)
        diff = 1;
    else if (otherTeamInvitedCount > thisTeamInvitedCount) // allow join more ppl if the other side has more players
        diff = otherTeamInvitedCount - thisTeamInvitedCount;

    // difference based on max players per team (don't allow inviting more)
    uint32 diff2 = (thisTeamInvitedCount < maxPlayersPerTeam) ? maxPlayersPerTeam - thisTeamInvitedCount : 0;

    // difference based on players who already entered
    // default: allow 0
    uint32 diff3 = 0;

    // allow join one person if the sides are equal (to fill up bg minPlayerPerTeam)
    if (otherTeamPlayersCount == thisTeamPlayersCount)
        diff3 = 1;
    else if (otherTeamPlayersCount > thisTeamPlayersCount) // allow join more ppl if the other side has more players
        diff3 = otherTeamPlayersCount - thisTeamPlayersCount;
    else if (thisTeamInvitedCount <= minPlayersPerTeam) // or other side has less than minPlayersPerTeam
        diff3 = minPlayersPerTeam - thisTeamInvitedCount + 1;

    // return the minimum of the 3 differences
    // min of diff, diff2 and diff3
    return std::min({ diff, diff2, diff3 });
}

uint32 Battleground::GetMaxFreeSlots() const
{
    return std::max<uint32>(GetFreeSlotsForTeam(TEAM_ALLIANCE), GetFreeSlotsForTeam(TEAM_HORDE));
}

bool Battleground::HasFreeSlots() const
{
    if (GetStatus() != STATUS_WAIT_JOIN && GetStatus() != STATUS_IN_PROGRESS)
        return false;
    for (uint8 i = 0; i < BG_TEAMS_COUNT; ++i)
        if (GetFreeSlotsForTeam((TeamId)i) > 0)
            return true;
    return false;
}

void Battleground::SpectatorsSendPacket(WorldPacket& data)
{
    for (SpectatorList::const_iterator itr = m_Spectators.begin(); itr != m_Spectators.end(); ++itr)
        (*itr)->GetSession()->SendPacket(&data);
}

void Battleground::ReadyMarkerClicked(Player* p)
{
    if (!isArena() || GetStatus() >= STATUS_IN_PROGRESS || GetStartDelayTime() <= BG_START_DELAY_15S || (m_Events & BG_STARTING_EVENT_3) || p->IsSpectator())
        return;
    readyMarkerClickedSet.insert(p->GetGUID());
    uint32 count = readyMarkerClickedSet.size();
    uint32 req = ArenaTeam::GetReqPlayersForType(GetArenaType());
    p->GetSession()->SendNotification("You are marked as ready %u/%u", count, req);
    if (count == req)
    {
        m_Events |= BG_STARTING_EVENT_2;
        m_StartTime += GetStartDelayTime() - BG_START_DELAY_15S;
        SetStartDelayTime(BG_START_DELAY_15S);
    }
}

void Battleground::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    //this procedure is called from virtual function implemented in bg subclass
    BattlegroundScoreMap::const_iterator itr = PlayerScores.find(player->GetGUID());
    if (itr == PlayerScores.end())                         // player not found...
        return;

    switch (type)
    {
        case SCORE_KILLING_BLOWS:                           // Killing blows
            itr->second->KillingBlows += value;
            if (isArena() && isRated())
            {
                ArenaLogEntryDataMap::iterator itr2 = ArenaLogEntries.find(player->GetGUID());
                if (itr2 != ArenaLogEntries.end())
                    itr2->second.KillingBlows += value;
            }
            break;
        case SCORE_DEATHS:                                  // Deaths
            itr->second->Deaths += value;
            break;
        case SCORE_HONORABLE_KILLS:                         // Honorable kills
            itr->second->HonorableKills += value;
            break;
        case SCORE_BONUS_HONOR:                             // Honor bonus
            // do not add honor in arenas
            if (isBattleground())
            {
                // reward honor instantly
                if (doAddHonor)
                    player->RewardHonor(nullptr, 1, value);    // RewardHonor calls UpdatePlayerScore with doAddHonor = false
                else
                    itr->second->BonusHonor += value;
            }
            break;
        // used only in EY, but in MSG_PVP_LOG_DATA opcode
        case SCORE_DAMAGE_DONE:                             // Damage Done
            itr->second->DamageDone += value;
            if (isArena() && isRated() && GetStatus() == STATUS_IN_PROGRESS)
            {
                ArenaLogEntryDataMap::iterator itr2 = ArenaLogEntries.find(player->GetGUID());
                if (itr2 != ArenaLogEntries.end())
                    itr2->second.DamageDone += value;
            }
            break;
        case SCORE_HEALING_DONE:                            // Healing Done
            itr->second->HealingDone += value;
            if (isArena() && isRated() && GetStatus() == STATUS_IN_PROGRESS)
            {
                ArenaLogEntryDataMap::iterator itr2 = ArenaLogEntries.find(player->GetGUID());
                if (itr2 != ArenaLogEntries.end())
                    itr2->second.HealingDone += value;
            }
            break;
        default:
            LOG_ERROR("server", "Battleground::UpdatePlayerScore: unknown score type (%u) for BG (map: %u, instance id: %u)!",
                           type, m_MapId, m_InstanceID);
            break;
    }
}

void Battleground::AddPlayerToResurrectQueue(ObjectGuid npc_guid, ObjectGuid player_guid)
{
    m_ReviveQueue[npc_guid].push_back(player_guid);

    Player* player = ObjectAccessor::FindPlayer(player_guid);
    if (!player)
        return;

    player->CastSpell(player, SPELL_WAITING_FOR_RESURRECT, true);
}

void Battleground::RemovePlayerFromResurrectQueue(Player* player)
{
    for (std::map<ObjectGuid, GuidVector>::iterator itr = m_ReviveQueue.begin(); itr != m_ReviveQueue.end(); ++itr)
        for (GuidVector::iterator itr2 = itr->second.begin(); itr2 != itr->second.end(); ++itr2)
            if (*itr2 == player->GetGUID())
            {
                itr->second.erase(itr2);
                player->RemoveAurasDueToSpell(SPELL_WAITING_FOR_RESURRECT);
                return;
            }
}

void Battleground::RelocateDeadPlayers(ObjectGuid queueIndex)
{
    // Those who are waiting to resurrect at this node are taken to the closest own node's graveyard
    GuidVector& ghostList = m_ReviveQueue[queueIndex];
    if (!ghostList.empty())
    {
        GraveyardStruct const* closestGrave = nullptr;
        for (ObjectGuid const guid : ghostList)
        {
            Player* player = ObjectAccessor::FindPlayer(guid);
            if (!player)
                continue;

            if (!closestGrave)
                closestGrave = GetClosestGraveyard(player);

            if (closestGrave)
                player->TeleportTo(GetMapId(), closestGrave->x, closestGrave->y, closestGrave->z, player->GetOrientation());
        }

        ghostList.clear();
    }
}

bool Battleground::AddObject(uint32 type, uint32 entry, float x, float y, float z, float o, float rotation0, float rotation1, float rotation2, float rotation3, uint32 /*respawnTime*/, GOState goState)
{
    // If the assert is called, means that BgObjects must be resized!
    ASSERT(type < BgObjects.size());

    Map* map = FindBgMap();
    if (!map)
        return false;
    // Must be created this way, adding to godatamap would add it to the base map of the instance
    // and when loading it (in go::LoadFromDB()), a new guid would be assigned to the object, and a new object would be created
    // So we must create it specific for this instance
    GameObject* go = sObjectMgr->IsGameObjectStaticTransport(entry) ? new StaticTransport() : new GameObject();
    if (!go->Create(map->GenerateLowGuid<HighGuid::GameObject>(), entry, GetBgMap(),
                    PHASEMASK_NORMAL, x, y, z, o, G3D::Quat(rotation0, rotation1, rotation2, rotation3), 100, goState))
    {
        LOG_ERROR("sql.sql", "Battleground::AddObject: cannot create gameobject (entry: %u) for BG (map: %u, instance id: %u)!",
                         entry, m_MapId, m_InstanceID);
        LOG_ERROR("server", "Battleground::AddObject: cannot create gameobject (entry: %u) for BG (map: %u, instance id: %u)!",
                       entry, m_MapId, m_InstanceID);
        delete go;
        return false;
    }
    /*
        ObjectGuid::LowType spawnId = go->GetSpawnId();

        // without this, UseButtonOrDoor caused the crash, since it tried to get go info from godata
        // iirc that was changed, so adding to go data map is no longer required if that was the only function using godata from GameObject without checking if it existed
        GameObjectData& data = sObjectMgr->NewGOData(spawnId);

        data.id             = entry;
        data.mapid          = GetMapId();
        data.posX           = x;
        data.posY           = y;
        data.posZ           = z;
        data.orientation    = o;
        data.rotation0      = rotation0;
        data.rotation1      = rotation1;
        data.rotation2      = rotation2;
        data.rotation3      = rotation3;
        data.spawntimesecs  = respawnTime;
        data.spawnMask      = 1;
        data.animprogress   = 100;
        data.go_state       = 1;
    */
    // Add to world, so it can be later looked up from HashMapHolder
    if (!map->AddToMap(go))
    {
        delete go;
        return false;
    }
    BgObjects[type] = go->GetGUID();
    return true;
}

// Some doors aren't despawned so we cannot handle their closing in gameobject::update()
// It would be nice to correctly implement GO_ACTIVATED state and open/close doors in gameobject code
void Battleground::DoorClose(uint32 type)
{
    if (GameObject* obj = GetBgMap()->GetGameObject(BgObjects[type]))
    {
        // If doors are open, close it
        if (obj->getLootState() == GO_ACTIVATED && obj->GetGoState() != GO_STATE_READY)
        {
            obj->SetLootState(GO_READY);
            obj->SetGoState(GO_STATE_READY);
        }
    }
    else
        LOG_ERROR("server", "Battleground::DoorClose: door gameobject (type: %u, %s) not found for BG (map: %u, instance id: %u)!",
                       type, BgObjects[type].ToString().c_str(), m_MapId, m_InstanceID);
}

void Battleground::DoorOpen(uint32 type)
{
    if (GameObject* obj = GetBgMap()->GetGameObject(BgObjects[type]))
    {
        obj->SetLootState(GO_ACTIVATED);
        obj->SetGoState(GO_STATE_ACTIVE);
    }
    else
        LOG_ERROR("server", "Battleground::DoorOpen: door gameobject (type: %u, %s) not found for BG (map: %u, instance id: %u)!",
                       type, BgObjects[type].ToString().c_str(), m_MapId, m_InstanceID);
}

GameObject* Battleground::GetBGObject(uint32 type)
{
    GameObject* obj = GetBgMap()->GetGameObject(BgObjects[type]);
    if (!obj)
        LOG_ERROR("server", "Battleground::GetBGObject: gameobject (type: %u, %s) not found for BG (map: %u, instance id: %u)!",
                       type, BgObjects[type].ToString().c_str(), m_MapId, m_InstanceID);
    return obj;
}

Creature* Battleground::GetBGCreature(uint32 type)
{
    Creature* creature = GetBgMap()->GetCreature(BgCreatures[type]);
    if (!creature)
        LOG_ERROR("server", "Battleground::GetBGCreature: creature (type: %u, %s) not found for BG (map: %u, instance id: %u)!",
                       type, BgCreatures[type].ToString().c_str(), m_MapId, m_InstanceID);
    return creature;
}

void Battleground::SpawnBGObject(uint32 type, uint32 respawntime)
{
    if (Map* map = FindBgMap())
        if (GameObject* obj = map->GetGameObject(BgObjects[type]))
        {
            if (respawntime)
                obj->SetLootState(GO_JUST_DEACTIVATED);
            else if (obj->getLootState() == GO_JUST_DEACTIVATED)
                // Change state from GO_JUST_DEACTIVATED to GO_READY in case battleground is starting again
                obj->SetLootState(GO_READY);
            obj->SetRespawnTime(respawntime);
            map->AddToMap(obj);
        }
}

Creature* Battleground::AddCreature(uint32 entry, uint32 type, float x, float y, float z, float o, uint32 respawntime, MotionTransport* transport)
{
    // If the assert is called, means that BgCreatures must be resized!
    ASSERT(type < BgCreatures.size());

    Map* map = FindBgMap();
    if (!map)
        return nullptr;

    if (transport)
    {
        transport->CalculatePassengerPosition(x, y, z, &o);
        if (Creature* creature = transport->SummonCreature(entry, x, y, z, o, TEMPSUMMON_MANUAL_DESPAWN))
        {
            transport->AddPassenger(creature, true);
            BgCreatures[type] = creature->GetGUID();
            return creature;
        }

        return nullptr;
    }

    Creature* creature = new Creature();
    if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, PHASEMASK_NORMAL, entry, 0, x, y, z, o))
    {
        LOG_ERROR("server", "Battleground::AddCreature: cannot create creature (entry: %u) for BG (map: %u, instance id: %u)!",
                       entry, m_MapId, m_InstanceID);
        delete creature;
        return nullptr;
    }

    creature->SetHomePosition(x, y, z, o);

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(entry);
    if (!cinfo)
    {
        LOG_ERROR("server", "Battleground::AddCreature: creature template (entry: %u) does not exist for BG (map: %u, instance id: %u)!",
                       entry, m_MapId, m_InstanceID);
        delete creature;
        return nullptr;
    }
    // Force using DB speeds
    creature->SetSpeed(MOVE_WALK,  cinfo->speed_walk);
    creature->SetSpeed(MOVE_RUN,   cinfo->speed_run);

    if (!map->AddToMap(creature))
    {
        delete creature;
        return nullptr;
    }

    BgCreatures[type] = creature->GetGUID();

    if (respawntime)
        creature->SetRespawnDelay(respawntime);

    // Xinef: Set PVP state for vehicles, should be for all creatures in bg?
    if (creature->IsVehicle())
        creature->SetPvP(true);

    return  creature;
}

bool Battleground::DelCreature(uint32 type)
{
    if (!BgCreatures[type])
        return true;

    if (Creature* creature = GetBgMap()->GetCreature(BgCreatures[type]))
    {
        creature->AddObjectToRemoveList();
        BgCreatures[type].Clear();
        return true;
    }

    LOG_ERROR("server", "Battleground::DelCreature: creature (type: %u, %s) not found for BG (map: %u, instance id: %u)!",
                   type, BgCreatures[type].ToString().c_str(), m_MapId, m_InstanceID);

    BgCreatures[type].Clear();
    return false;
}

bool Battleground::DelObject(uint32 type)
{
    if (!BgObjects[type])
        return true;

    if (GameObject* obj = GetBgMap()->GetGameObject(BgObjects[type]))
    {
        obj->SetRespawnTime(0);                                 // not save respawn time
        obj->Delete();
        BgObjects[type].Clear();
        return true;
    }

    LOG_ERROR("server", "Battleground::DelObject: gameobject (type: %u, %s) not found for BG (map: %u, instance id: %u)!",
                   type, BgObjects[type].ToString().c_str(), m_MapId, m_InstanceID);

    BgObjects[type].Clear();
    return false;
}

bool Battleground::AddSpiritGuide(uint32 type, float x, float y, float z, float o, TeamId teamId)
{
    uint32 entry = (teamId == TEAM_ALLIANCE) ? BG_CREATURE_ENTRY_A_SPIRITGUIDE : BG_CREATURE_ENTRY_H_SPIRITGUIDE;

    if (Creature* creature = AddCreature(entry, type, x, y, z, o))
    {
        creature->setDeathState(DEAD);
        creature->SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT, creature->GetGUID());
        // aura
        // TODO: Fix display here
        // creature->SetVisibleAura(0, SPELL_SPIRIT_HEAL_CHANNEL);
        // casting visual effect
        creature->SetUInt32Value(UNIT_CHANNEL_SPELL, SPELL_SPIRIT_HEAL_CHANNEL);
        // correct cast speed
        creature->SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);
        //creature->CastSpell(creature, SPELL_SPIRIT_HEAL_CHANNEL, true);
        return true;
    }
    LOG_ERROR("server", "Battleground::AddSpiritGuide: cannot create spirit guide (type: %u, entry: %u) for BG (map: %u, instance id: %u)!",
                   type, entry, m_MapId, m_InstanceID);
    EndNow();
    return false;
}

void Battleground::SendMessageToAll(uint32 entry, ChatMsg type, Player const* source)
{
    if (!entry)
        return;

    Acore::BattlegroundChatBuilder bg_builder(type, entry, source);
    Acore::LocalizedPacketDo<Acore::BattlegroundChatBuilder> bg_do(bg_builder);
    BroadcastWorker(bg_do);
}

void Battleground::PSendMessageToAll(uint32 entry, ChatMsg type, Player const* source, ...)
{
    if (!entry)
        return;

    va_list ap;
    va_start(ap, source);

    Acore::BattlegroundChatBuilder bg_builder(type, entry, source, &ap);
    Acore::LocalizedPacketDo<Acore::BattlegroundChatBuilder> bg_do(bg_builder);
    BroadcastWorker(bg_do);

    va_end(ap);
}

void Battleground::SendWarningToAll(uint32 entry, ...)
{
    if (!entry)
        return;

    std::map<uint32, WorldPacket> localizedPackets;
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
    {
        if (localizedPackets.find(itr->second->GetSession()->GetSessionDbLocaleIndex()) == localizedPackets.end())
        {
            char const* format = sObjectMgr->GetAcoreString(entry, itr->second->GetSession()->GetSessionDbLocaleIndex());

            char str[1024];
            va_list ap;
            va_start(ap, entry);
            vsnprintf(str, 1024, format, ap);
            va_end(ap);

            ChatHandler::BuildChatPacket(localizedPackets[itr->second->GetSession()->GetSessionDbLocaleIndex()], CHAT_MSG_RAID_BOSS_EMOTE, LANG_UNIVERSAL, nullptr, nullptr, str);
        }

        itr->second->SendDirectMessage(&localizedPackets[itr->second->GetSession()->GetSessionDbLocaleIndex()]);
    }
}

void Battleground::SendMessage2ToAll(uint32 entry, ChatMsg type, Player const* source, uint32 arg1, uint32 arg2)
{
    Acore::Battleground2ChatBuilder bg_builder(type, entry, source, arg1, arg2);
    Acore::LocalizedPacketDo<Acore::Battleground2ChatBuilder> bg_do(bg_builder);
    BroadcastWorker(bg_do);
}

void Battleground::EndNow()
{
    SetStatus(STATUS_WAIT_LEAVE);
    SetEndTime(0);
}

// To be removed
char const* Battleground::GetAcoreString(int32 entry)
{
    // FIXME: now we have different DBC locales and need localized message for each target client
    return sObjectMgr->GetAcoreStringForDBCLocale(entry);
}

void Battleground::HandleTriggerBuff(GameObject* gameObject)
{
    // Xinef: crash fix?
    if (GetStatus() != STATUS_IN_PROGRESS || !GetPlayersSize() || BgObjects.empty())
        return;

    uint32 index = 0;
    for (; index < BgObjects.size() && BgObjects[index] != gameObject->GetGUID(); ++index);
    if (BgObjects[index] != gameObject->GetGUID())
        return;

    if (m_BuffChange)
    {
        uint8 buff = urand(0, 2);
        if (gameObject->GetEntry() != Buff_Entries[buff])
        {
            SpawnBGObject(index, RESPAWN_ONE_DAY);
            for (uint8 currBuffTypeIndex = 0; currBuffTypeIndex < 3; ++currBuffTypeIndex)
                if (gameObject->GetEntry() == Buff_Entries[currBuffTypeIndex])
                {
                    index -= currBuffTypeIndex;
                    index += buff;
                }
        }
    }

    SpawnBGObject(index, BUFF_RESPAWN_TIME);
}

void Battleground::HandleKillPlayer(Player* victim, Player* killer)
{
    // Keep in mind that for arena this will have to be changed a bit

    // Add +1 deaths
    UpdatePlayerScore(victim, SCORE_DEATHS, 1);
    // Add +1 kills to group and +1 killing_blows to killer
    if (killer)
    {
        // Don't reward credit for killing ourselves, like fall damage of hellfire (warlock)
        if (killer == victim)
            return;

        UpdatePlayerScore(killer, SCORE_HONORABLE_KILLS, 1);
        UpdatePlayerScore(killer, SCORE_KILLING_BLOWS, 1);

        for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        {
            Player* creditedPlayer = itr->second;
            if (creditedPlayer == killer)
                continue;

            if (creditedPlayer->GetBgTeamId() == killer->GetBgTeamId() && (creditedPlayer == killer || creditedPlayer->IsAtGroupRewardDistance(victim)))
                UpdatePlayerScore(creditedPlayer, SCORE_HONORABLE_KILLS, 1);
        }
    }

    if (!isArena())
    {
        // To be able to remove insignia -- ONLY IN Battlegrounds
        victim->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);
        RewardXPAtKill(killer, victim);
    }
}

TeamId Battleground::GetOtherTeamId(TeamId teamId)
{
    return teamId != TEAM_NEUTRAL ? (teamId == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE) : TEAM_NEUTRAL;
}

bool Battleground::IsPlayerInBattleground(ObjectGuid guid) const
{
    BattlegroundPlayerMap::const_iterator itr = m_Players.find(guid);
    if (itr != m_Players.end())
        return true;
    return false;
}

void Battleground::PlayerAddedToBGCheckIfBGIsRunning(Player* player)
{
    if (GetStatus() != STATUS_WAIT_LEAVE)
        return;

    WorldPacket data;
    BlockMovement(player);

    sBattlegroundMgr->BuildPvpLogDataPacket(&data, this);
    player->GetSession()->SendPacket(&data);

    sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, this, player->GetCurrentBattlegroundQueueSlot(), STATUS_IN_PROGRESS, GetEndTime(), GetStartTime(), GetArenaType(), player->GetBgTeamId());
    player->GetSession()->SendPacket(&data);
}

uint32 Battleground::GetAlivePlayersCountByTeam(TeamId teamId) const
{
    uint32 count = 0;
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->IsAlive() && !itr->second->HasByteFlag(UNIT_FIELD_BYTES_2, 3, FORM_SPIRITOFREDEMPTION) && itr->second->GetBgTeamId() == teamId)
            ++count;

    return count;
}

void Battleground::SetHoliday(bool is_holiday)
{
    m_HonorMode = is_holiday ? BG_HOLIDAY : BG_NORMAL;
}

int32 Battleground::GetObjectType(ObjectGuid guid)
{
    for (uint32 i = 0; i < BgObjects.size(); ++i)
        if (BgObjects[i] == guid)
            return i;

    LOG_ERROR("server", "Battleground::GetObjectType: player used gameobject (%s) which is not in internal data for BG (map: %u, instance id: %u), cheating?",
                   guid.ToString().c_str(), m_MapId, m_InstanceID);

    return -1;
}

void Battleground::HandleKillUnit(Creature* /*victim*/, Player* /*killer*/)
{
}

void Battleground::CheckArenaAfterTimerConditions()
{
    EndBattleground(TEAM_NEUTRAL);
}

void Battleground::CheckArenaWinConditions()
{
    if (isArena() && GetStatus() <= STATUS_WAIT_JOIN) // pussywizard
        return;
    if (!GetAlivePlayersCountByTeam(TEAM_ALLIANCE) && GetPlayersCountByTeam(TEAM_HORDE))
        EndBattleground(TEAM_HORDE);
    else if (GetPlayersCountByTeam(TEAM_ALLIANCE) && !GetAlivePlayersCountByTeam(TEAM_HORDE))
        EndBattleground(TEAM_ALLIANCE);
}

void Battleground::UpdateArenaWorldState()
{
    UpdateWorldState(0xe10, GetAlivePlayersCountByTeam(TEAM_HORDE));
    UpdateWorldState(0xe11, GetAlivePlayersCountByTeam(TEAM_ALLIANCE));
}

void Battleground::SetBgRaid(TeamId teamId, Group* bg_raid)
{
    Group*& old_raid = m_BgRaids[teamId];
    if (old_raid)
        old_raid->SetBattlegroundGroup(nullptr);
    if (bg_raid)
        bg_raid->SetBattlegroundGroup(this);
    old_raid = bg_raid;
}

GraveyardStruct const* Battleground::GetClosestGraveyard(Player* player)
{
    return sGraveyard->GetClosestGraveyard(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), player->GetBgTeamId());
}

void Battleground::StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
        itr->second->StartTimedAchievement(type, entry);
}

uint32 Battleground::GetTeamScore(TeamId teamId) const
{
    if (teamId == TEAM_ALLIANCE || teamId == TEAM_HORDE)
        return m_TeamScores[teamId];

    LOG_ERROR("server", "GetTeamScore with wrong Team %u for BG %u", teamId, GetBgTypeID());
    return 0;
}

void Battleground::RewardXPAtKill(Player* killer, Player* victim)
{
    if (sWorld->getBoolConfig(CONFIG_BG_XP_FOR_KILL) && killer && victim)
        killer->RewardPlayerAndGroupAtKill(victim, true);
}

uint8 Battleground::GetUniqueBracketId() const
{
    return GetMinLevel() / 10;
}
