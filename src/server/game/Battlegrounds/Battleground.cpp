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

#include "Battleground.h"
#include "ArenaSpectator.h"
#include "ArenaTeam.h"
#include "BattlegroundBE.h"
#include "BattlegroundDS.h"
#include "BattlegroundMgr.h"
#include "BattlegroundNA.h"
#include "BattlegroundRL.h"
#include "BattlegroundRV.h"
#include "Chat.h"
#include "ChatTextBuilder.h"
#include "Creature.h"
#include "CreatureTextMgr.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GameGraveyard.h"
#include "GridNotifiersImpl.h"
#include "GroupMgr.h"
#include "MapMgr.h"
#include "MiscPackets.h"
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
#include "WorldStatePackets.h"

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

void BattlegroundScore::AppendToPacket(WorldPacket& data)
{
    data << PlayerGuid;

    data << uint32(KillingBlows);
    data << uint32(HonorableKills);
    data << uint32(Deaths);
    data << uint32(BonusHonor);
    data << uint32(DamageDone);
    data << uint32(HealingDone);

    BuildObjectivesBlock(data);
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
    m_WinnerId          = PVP_TEAM_NEUTRAL;
    m_StartTime         = 0;
    m_ResetStatTimer    = 0;
    m_ValidStartPositionTimer = 0;
    m_Events            = 0;
    m_StartDelayTime    = 0;
    m_IsRated           = false;
    m_BuffChange        = false;
    m_IsRandom          = false;
    m_LevelMin          = 0;
    m_LevelMax          = 0;
    m_SetDeleteThis     = false;

    m_MaxPlayersPerTeam = 0;
    m_MinPlayersPerTeam = 0;

    m_MapId             = 0;
    m_Map               = nullptr;
    m_StartMaxDist      = 0.0f;
    ScriptId            = 0;

    m_ArenaTeamIds[TEAM_ALLIANCE]   = 0;
    m_ArenaTeamIds[TEAM_HORDE]      = 0;

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

    StartMessageIds[BG_STARTING_EVENT_FIRST] = BG_TEXT_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = BG_TEXT_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD] = BG_TEXT_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = BG_TEXT_BATTLE_HAS_BEGUN;

    // pussywizard:
    m_UpdateTimer = 0;
}

Battleground::~Battleground()
{
    LOG_DEBUG("bg.battleground", "> Remove Battleground {} {} {}", GetName(), GetBgTypeID(), GetInstanceID());

    _reviveEvents.KillAllEvents(false);

    // remove objects and creatures
    // (this is done automatically in mapmanager update, when the instance is reset after the reset time)
    uint32 size = uint32(BgCreatures.size());
    for (uint32 i = 0; i < size; ++i)
        DelCreature(i);

    size = uint32(BgObjects.size());
    for (uint32 i = 0; i < size; ++i)
        DelObject(i);

    sScriptMgr->OnBattlegroundDestroy(this);

    sBattlegroundMgr->RemoveBattleground(GetBgTypeID(), GetInstanceID());
    // unload map
    if (m_Map)
    {
        m_Map->SetUnload();
        //unlink to prevent crash, always unlink all pointer reference before destruction
        m_Map->SetBG(nullptr);
        m_Map = nullptr;
    }

    // remove from bg free slot queue
    RemoveFromBGFreeSlotQueue();

    for (auto const& itr : PlayerScores)
        delete itr.second;
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
        //BG is empty
        // if there are no players invited, delete BG
        // this will delete arena or bg object, where any player entered
        // [[   but if you use battleground object again (more battles possible to be played on 1 instance)
        //      then this condition should be removed and code:
        //      if (!GetInvitedCount(TEAM_HORDE) && !GetInvitedCount(TEAM_ALLIANCE))
        //          AddToFreeBGObjectsQueue(); // not yet implemented
        //      should be used instead of current
        // ]]
        // Battleground Template instance cannot be updated, because it would be deleted
        if (!GetInvitedCount(TEAM_HORDE) && !GetInvitedCount(TEAM_ALLIANCE))
        {
            m_SetDeleteThis = true;
        }

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
                    EndBattleground(PVP_TEAM_NEUTRAL);
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

        for (auto const& [playerGuid, player] : GetPlayers())
        {
            Position pos = player->GetPosition();
            Position const* startPos = GetTeamStartPosition(player->GetBgTeamId());

            if (pos.GetExactDistSq(startPos) > maxDist)
            {
                LOG_DEBUG("bg.battleground", "BATTLEGROUND: Sending {} back to start location (map: {}) (possible exploit)", player->GetName(), GetMapId());
                player->TeleportTo(GetMapId(), startPos->GetPositionX(), startPos->GetPositionY(), startPos->GetPositionZ(), startPos->GetOrientation());
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

    _reviveEvents.Update(diff);

    m_LastResurrectTime += diff;
    if (m_LastResurrectTime >= RESURRECTION_INTERVAL)
    {
        if (GetReviveQueueSize())
        {
            for (std::map<ObjectGuid, GuidVector>::iterator itr = m_ReviveQueue.begin(); itr != m_ReviveQueue.end(); ++itr)
            {
                Creature* sh = nullptr;
                for (ObjectGuid const& guid : itr->second)
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
        for (ObjectGuid const& guid : m_ResurrectQueue)
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
                GetBgMap()->DoForAllPlayers([&](Player* player)
                    {
                        ChatHandler(player->GetSession()).PSendSysMessage(LANG_BATTLEGROUND_PREMATURE_FINISH_WARNING, (uint32)(m_PrematureCountDownTimer / (MINUTE * IN_MILLISECONDS)));
                    });
        }
        else
        {
            //announce every 15 seconds
            if (newtime / (15 * IN_MILLISECONDS) != m_PrematureCountDownTimer / (15 * IN_MILLISECONDS))
                GetBgMap()->DoForAllPlayers([&](Player* player)
                    {
                        ChatHandler(player->GetSession()).PSendSysMessage(LANG_BATTLEGROUND_PREMATURE_FINISH_WARNING_SECS, (uint32)(m_PrematureCountDownTimer / IN_MILLISECONDS));
                    });
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
            LOG_ERROR("bg.battleground", "Battleground::_ProcessJoin: map (map id: {}, instance id: {}) is not created!", m_MapId, m_InstanceID);
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
        if (StartMessageIds[BG_STARTING_EVENT_FIRST])
            SendBroadcastText(StartMessageIds[BG_STARTING_EVENT_FIRST], CHAT_MSG_BG_SYSTEM_NEUTRAL);
    }
    // After 1 minute or 30 seconds, warning is signaled
    else if (GetStartDelayTime() <= StartDelayTimes[BG_STARTING_EVENT_SECOND] && !(m_Events & BG_STARTING_EVENT_2))
    {
        m_Events |= BG_STARTING_EVENT_2;

        if (StartMessageIds[BG_STARTING_EVENT_SECOND])
            SendBroadcastText(StartMessageIds[BG_STARTING_EVENT_SECOND], CHAT_MSG_BG_SYSTEM_NEUTRAL);
    }
    // After 30 or 15 seconds, warning is signaled
    else if (GetStartDelayTime() <= StartDelayTimes[BG_STARTING_EVENT_THIRD] && !(m_Events & BG_STARTING_EVENT_3))
    {
        m_Events |= BG_STARTING_EVENT_3;

        if (StartMessageIds[BG_STARTING_EVENT_THIRD])
            SendBroadcastText(StartMessageIds[BG_STARTING_EVENT_THIRD], CHAT_MSG_BG_SYSTEM_NEUTRAL);

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

        if (StartMessageIds[BG_STARTING_EVENT_FOURTH])
            SendBroadcastText(StartMessageIds[BG_STARTING_EVENT_FOURTH], CHAT_MSG_BG_SYSTEM_NEUTRAL);

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
                                // && (!aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES)) Xinef: condition, ALL buffs should be removed
                                && (!aura->HasEffectType(SPELL_AURA_MOD_INVISIBILITY)))
                            player->RemoveAura(iter);
                        else
                            ++iter;
                    }

                    player->UpdateObjectVisibility(true);
                }

            for (SpectatorList::const_iterator itr = m_Spectators.begin(); itr != m_Spectators.end(); ++itr)
                ArenaSpectator::HandleResetCommand(*itr);

            CheckWinConditions();

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

            sScriptMgr->OnArenaStart(this);
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
                ChatHandler(nullptr).SendWorldText(LANG_BG_STARTED_ANNOUNCE_WORLD, GetName(), std::min(GetMinLevel(), (uint32)80), std::min(GetMaxLevel(), (uint32)80));

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

void Battleground::SetTeamStartPosition(TeamId teamId, Position const& pos)
{
    ASSERT(teamId < TEAM_NEUTRAL);
    _startPosition[teamId] = pos;
}

Position const* Battleground::GetTeamStartPosition(TeamId teamId) const
{
    ASSERT(teamId < TEAM_NEUTRAL);
    return &_startPosition[teamId];
}

void Battleground::SendPacketToAll(WorldPacket const* packet)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        itr->second->GetSession()->SendPacket(packet);
}

void Battleground::SendPacketToTeam(TeamId teamId, WorldPacket const* packet, Player* sender, bool self)
{
    for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        if (itr->second->GetBgTeamId() == teamId && (self || sender != itr->second))
            itr->second->GetSession()->SendPacket(packet);
}

void Battleground::SendChatMessage(Creature* source, uint8 textId, WorldObject* target /*= nullptr*/)
{
    sCreatureTextMgr->SendChat(source, textId, target);
}

void Battleground::SendBroadcastText(uint32 id, ChatMsg msgType, WorldObject const* target)
{
    if (!sObjectMgr->GetBroadcastText(id))
    {
        LOG_ERROR("bg.battleground", "Battleground::SendBroadcastText: `broadcast_text` (ID: {}) was not found", id);
        return;
    }

    Acore::BroadcastTextBuilder builder(nullptr, msgType, id, GENDER_MALE, target);
    Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder> localizer(builder);
    BroadcastWorker(localizer);
}

void Battleground::PlaySoundToAll(uint32 soundID)
{
    SendPacketToAll(WorldPackets::Misc::Playsound(soundID).Write());
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

            float repGain = static_cast<float>(reputation);
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

void Battleground::UpdateWorldState(uint32 variable, uint32 value)
{
    WorldPackets::WorldState::UpdateWorldState worldstate;
    worldstate.VariableID = variable;
    worldstate.Value = value;
    SendPacketToAll(worldstate.Write());
}

void Battleground::EndBattleground(PvPTeamId winnerTeamId)
{
    // xinef: if this is true, it means that endbattleground is called second time
    // skip to avoid double rating reduce / add
    // can bug out due to multithreading ?
    // set as fast as possible
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    RemoveFromBGFreeSlotQueue();
    SetStatus(STATUS_WAIT_LEAVE);
    SetWinner(winnerTeamId);

    if (winnerTeamId == PVP_TEAM_ALLIANCE)
    {
        if (isBattleground())
            SendBroadcastText(BG_TEXT_ALLIANCE_WINS, CHAT_MSG_BG_SYSTEM_NEUTRAL);

        PlaySoundToAll(SOUND_ALLIANCE_WINS); // alliance wins sound
    }
    else if (winnerTeamId == PVP_TEAM_HORDE)
    {
        if (isBattleground())
            SendBroadcastText(BG_TEXT_HORDE_WINS, CHAT_MSG_BG_SYSTEM_NEUTRAL);

        PlaySoundToAll(SOUND_HORDE_WINS); // horde wins sound
    }

    CharacterDatabasePreparedStatement* stmt = nullptr;
    uint64 battlegroundId = 1;
    if (isBattleground() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE))
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PVPSTATS_MAXID);
        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        if (result)
        {
            Field* fields = result->Fetch();
            battlegroundId = fields[0].Get<uint64>() + 1;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PVPSTATS_BATTLEGROUND);
        stmt->SetData(0, battlegroundId);
        stmt->SetData(1, GetWinner());
        stmt->SetData(2, GetUniqueBracketId());
        stmt->SetData(3, GetBgTypeID(true));
        CharacterDatabase.Execute(stmt);
    }

    //we must set it this way, because end time is sent in packet!
    m_EndTime = TIME_TO_AUTOREMOVE;

    WorldPacket pvpLogData;
    BuildPvPLogDataPacket(pvpLogData);

    for (auto const& [playerGuid, player] : m_Players)
    {
        TeamId bgTeamId = player->GetBgTeamId();

        // should remove spirit of redemption
        if (player->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
            player->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

        if (!player->IsAlive())
        {
            player->ResurrectPlayer(1.0f);
            player->SpawnCorpseBones();
        }
        else
        {
            //needed cause else in av some creatures will kill the players at the end
            player->CombatStop();
            player->getHostileRefMgr().deleteReferences();
        }

        uint32 winner_kills = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_HONOR_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_HONOR_FIRST);
        uint32 loser_kills = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_LOSER_HONOR_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_LOSER_HONOR_FIRST);
        uint32 winner_arena = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_ARENA_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_ARENA_FIRST);

        // Reward winner team
        if (bgTeamId == GetTeamId(winnerTeamId))
        {
            if (IsRandom() || BattlegroundMgr::IsBGWeekend(GetBgTypeID(true)))
            {
                UpdatePlayerScore(player, SCORE_BONUS_HONOR, GetBonusHonorFromKill(winner_kills));

                // Xinef: check player level and not bracket level if (CanAwardArenaPoints())
                if (player->GetLevel() >= sWorld->getIntConfig(CONFIG_DAILY_RBG_MIN_LEVEL_AP_REWARD))
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

        sScriptMgr->OnBattlegroundEndReward(this, player, GetTeamId(winnerTeamId));

        player->ResetAllPowers();
        player->CombatStopWithPets(true);

        BlockMovement(player);

        player->GetSession()->SendPacket(&pvpLogData);

        if (isBattleground() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE))
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PVPSTATS_PLAYER);
            auto const& score = PlayerScores.find(player->GetGUID().GetCounter());

            stmt->SetData(0, battlegroundId);
            stmt->SetData(1, player->GetGUID().GetCounter());
            stmt->SetData(2, bgTeamId == GetTeamId(winnerTeamId));
            stmt->SetData(3, score->second->GetKillingBlows());
            stmt->SetData(4, score->second->GetDeaths());
            stmt->SetData(5, score->second->GetHonorableKills());
            stmt->SetData(6, score->second->GetBonusHonor());
            stmt->SetData(7, score->second->GetDamageDone());
            stmt->SetData(8, score->second->GetHealingDone());
            stmt->SetData(9, score->second->GetAttr1());
            stmt->SetData(10, score->second->GetAttr2());
            stmt->SetData(11, score->second->GetAttr3());
            stmt->SetData(12, score->second->GetAttr4());
            stmt->SetData(13, score->second->GetAttr5());

            CharacterDatabase.Execute(stmt);
        }

        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, this, player->GetCurrentBattlegroundQueueSlot(), STATUS_IN_PROGRESS, TIME_TO_AUTOREMOVE, GetStartTime(), GetArenaType(), player->GetBgTeamId());
        player->GetSession()->SendPacket(&data);

        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND, player->GetMapId());
    }

    if (IsEventActive(EVENT_SPIRIT_OF_COMPETITION) && isBattleground())
        SpiritOfCompetitionEvent(winnerTeamId);

    sScriptMgr->OnBattlegroundEnd(this, GetTeamId(winnerTeamId));
}

void Battleground::SpiritOfCompetitionEvent(PvPTeamId winnerTeamId) const
{
    bool isDraw = winnerTeamId == PVP_TEAM_NEUTRAL;

    std::vector<Player*> filteredPlayers;
    GetBgMap()->DoForAllPlayers([&](Player* player)
        {
            // Reward all eligible players the participant reward
            if (player->GetQuestStatus(QUEST_FLAG_PARTICIPANT) != QUEST_STATUS_REWARDED)
                player->CastSpell(player, SPELL_SPIRIT_OF_COMPETITION_PARTICIPANT, true);

            // Collect players of the winning team who has yet to recieve the winner reward
            if (!isDraw && player->GetBgTeamId() == GetTeamId(winnerTeamId) &&
                player->GetQuestStatus(QUEST_FLAG_WINNER) != QUEST_STATUS_REWARDED)
                    filteredPlayers.push_back(player);
        });

    // Randomly select one player from winners team to recieve the reward, if any eligible
    if (!filteredPlayers.empty())
    {
        Player* wPlayer = filteredPlayers[rand() % filteredPlayers.size()];
        wPlayer->CastSpell(wPlayer, SPELL_SPIRIT_OF_COMPETITION_WINNER, true);
    }
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
    auto const& itr2 = PlayerScores.find(player->GetGUID().GetCounter());
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

    // GetStatus might be changed in RemovePlayer - define it here
    BattlegroundStatus status = GetStatus();

    // BG subclass specific code
    RemovePlayer(player);

    // if the player was a match participant
    if (participant)
    {
        player->ClearAfkReports();

        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, this, player->GetCurrentBattlegroundQueueSlot(), STATUS_NONE, 0, 0, 0, TEAM_NEUTRAL);
        player->GetSession()->SendPacket(&data);

        BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(GetBgTypeID(), GetArenaType());

        // this call is important, because player, when joins to battleground, this method is not called, so it must be called when leaving bg
        player->RemoveBattlegroundQueueId(bgQueueTypeId);

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
            if (status == STATUS_IN_PROGRESS || status == STATUS_WAIT_JOIN)
                player->ScheduleDelayedOperation(DELAYED_SPELL_CAST_DESERTER);

        DecreaseInvitedCount(teamId);

        //we should update battleground queue, but only if bg isn't ending
        if (isBattleground() && GetStatus() < STATUS_WAIT_LEAVE)
        {
            BattlegroundTypeId bgTypeId = GetBgTypeID();
            BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(GetBgTypeID(), GetArenaType());

            // a player has left the battleground, so there are free slots -> add to queue
            AddToBGFreeSlotQueue();
            sBattlegroundMgr->ScheduleQueueUpdate(0, 0, bgQueueTypeId, bgTypeId, GetBracketId());
        }
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
    SetWinner(PVP_TEAM_NEUTRAL);
    SetStatus(STATUS_WAIT_QUEUE);
    SetStartTime(0);
    SetEndTime(0);
    SetLastResurrectTime(0);

    m_Events = 0;

    if (m_BgInvitedPlayers[TEAM_ALLIANCE] > 0 || m_BgInvitedPlayers[TEAM_HORDE] > 0)
    {
        LOG_ERROR("bg.battleground", "Battleground::Reset: one of the counters is not 0 (alliance: {}, horde: {}) for BG (map: {}, instance id: {})!", m_BgInvitedPlayers[TEAM_ALLIANCE], m_BgInvitedPlayers[TEAM_HORDE], m_MapId, m_InstanceID);
        ABORT();
    }

    m_BgInvitedPlayers[TEAM_ALLIANCE] = 0;
    m_BgInvitedPlayers[TEAM_HORDE] = 0;
    _InBGFreeSlotQueue = false;

    m_Players.clear();

    for (auto const& itr : PlayerScores)
        delete itr.second;

    PlayerScores.clear();

    for (auto& itr : _arenaTeamScores)
        itr.Reset();

    ResetBGSubclass();
}

void Battleground::StartBattleground()
{
    SetStartTime(0);
    SetLastResurrectTime(0);

    // add BG to free slot queue
    AddToBGFreeSlotQueue();

    // add bg to update list
    // this must be done here, because we need to have already invited some players when first Battleground::Update() method is executed
    sBattlegroundMgr->AddBattleground(this);

    if (m_IsRated)
        LOG_DEBUG("bg.arena", "Arena match type: {} for Team1Id: {} - Team2Id: {} started.", m_ArenaType, m_ArenaTeamIds[TEAM_ALLIANCE], m_ArenaTeamIds[TEAM_HORDE]);
}

void Battleground::AddPlayer(Player* player)
{
    // remove afk from player
    if (player->HasPlayerFlag(PLAYER_FLAGS_AFK))
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
        // restore pets health before remove
        if (Pet* pet = player->GetPet())
            if (pet->IsAlive())
                pet->SetHealth(pet->GetMaxHealth());

        player->RemoveArenaEnchantments(TEMP_ENCHANTMENT_SLOT);
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
    LOG_DEBUG("bg.battleground", "BATTLEGROUND: Player {} joined the battle.", player->GetName());
}

// this method adds player to his team's bg group, or sets his correct group if player is already in bg group
void Battleground::AddOrSetPlayerToCorrectBgGroup(Player* player, TeamId teamId)
{
    if (player->GetGroup() && (player->GetGroup()->isBGGroup() || player->GetGroup()->isBFGroup()))
    {
        LOG_INFO("misc", "Battleground::AddOrSetPlayerToCorrectBgGroup - player is already in {} group!", (player->GetGroup()->isBGGroup() ? "BG" : "BF"));
        return;
    }

    ObjectGuid playerGuid = player->GetGUID();
    Group* group = GetBgRaid(teamId);
    if (!group)                                      // first player joined
    {
        group = new Group;
        SetBgRaid(teamId, group);
        group->Create(player);
        sGroupMgr->AddGroup(group);
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

// This method should be called only once ... it adds pointer to queue
void Battleground::AddToBGFreeSlotQueue()
{
    if (!_InBGFreeSlotQueue && isBattleground())
    {
        sBattlegroundMgr->AddToBGFreeSlotQueue(m_RealTypeID, this);
        _InBGFreeSlotQueue = true;
    }
}

// This method removes this battleground from free queue - it must be called when deleting battleground
void Battleground::RemoveFromBGFreeSlotQueue()
{
    if (_InBGFreeSlotQueue)
    {
        sBattlegroundMgr->RemoveFromBGFreeSlotQueue(m_RealTypeID, m_InstanceID);
        _InBGFreeSlotQueue = false;
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
    for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
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
    ChatHandler(p->GetSession()).SendNotification("You are marked as ready {}/{}", count, req);
    if (count == req)
    {
        m_Events |= BG_STARTING_EVENT_2;
        m_StartTime += GetStartDelayTime() - BG_START_DELAY_15S;
        SetStartDelayTime(BG_START_DELAY_15S);
    }
}

void Battleground::BuildPvPLogDataPacket(WorldPacket& data)
{
    uint8 type = (isArena() ? 1 : 0);

    data.Initialize(MSG_PVP_LOG_DATA, 1 + 1 + 4 + 40 * GetPlayerScores()->size());
    data << uint8(type); // type (battleground = 0 / arena = 1)

    if (type) // arena
    {
        for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
            _arenaTeamScores[i].BuildRatingInfoBlock(data);

        for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
            _arenaTeamScores[i].BuildTeamInfoBlock(data);
    }

    if (GetStatus() == STATUS_WAIT_LEAVE)
    {
        data << uint8(1);                      // bg ended
        data << uint8(GetWinner());            // who win
    }
    else
        data << uint8(0);                      // bg not ended

    data << uint32(GetPlayerScores()->size());

    for (auto const& score : PlayerScores)
        score.second->AppendToPacket(data);
}

bool Battleground::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    auto const& itr = PlayerScores.find(player->GetGUID().GetCounter());
    if (itr == PlayerScores.end()) // player not found...
        return false;

    if (type == SCORE_BONUS_HONOR && doAddHonor && isBattleground())
        player->RewardHonor(nullptr, 1, value); // RewardHonor calls UpdatePlayerScore with doAddHonor = false
    else
        itr->second->UpdateScore(type, value);

    return true;
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
        for (ObjectGuid const& guid : ghostList)
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
        LOG_ERROR("sql.sql", "Battleground::AddObject: cannot create gameobject (entry: {}) for BG (map: {}, instance id: {})!",
                         entry, m_MapId, m_InstanceID);
        LOG_ERROR("bg.battleground", "Battleground::AddObject: cannot create gameobject (entry: {}) for BG (map: {}, instance id: {})!",
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
        LOG_ERROR("bg.battleground", "Battleground::DoorClose: door gameobject (type: {}, {}) not found for BG (map: {}, instance id: {})!",
                       type, BgObjects[type].ToString(), m_MapId, m_InstanceID);
}

void Battleground::DoorOpen(uint32 type)
{
    if (GameObject* obj = GetBgMap()->GetGameObject(BgObjects[type]))
    {
        obj->SetLootState(GO_ACTIVATED);
        obj->SetGoState(GO_STATE_ACTIVE);
    }
    else
        LOG_ERROR("bg.battleground", "Battleground::DoorOpen: door gameobject (type: {}, {}) not found for BG (map: {}, instance id: {})!",
                       type, BgObjects[type].ToString(), m_MapId, m_InstanceID);
}

GameObject* Battleground::GetBGObject(uint32 type)
{
    GameObject* obj = GetBgMap()->GetGameObject(BgObjects[type]);
    if (!obj)
        LOG_ERROR("bg.battleground", "Battleground::GetBGObject: gameobject (type: {}, {}) not found for BG (map: {}, instance id: {})!",
                       type, BgObjects[type].ToString(), m_MapId, m_InstanceID);
    return obj;
}

Creature* Battleground::GetBGCreature(uint32 type)
{
    Creature* creature = GetBgMap()->GetCreature(BgCreatures[type]);
    if (!creature)
        LOG_ERROR("bg.battleground", "Battleground::GetBGCreature: creature (type: {}, {}) not found for BG (map: {}, instance id: {})!",
                       type, BgCreatures[type].ToString(), m_MapId, m_InstanceID);
    return creature;
}

void Battleground::SpawnBGObject(uint32 type, uint32 respawntime, uint32 forceRespawnDelay)
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

            if (forceRespawnDelay)
            {
                obj->SetRespawnDelay(forceRespawnDelay);
            }
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
        LOG_ERROR("bg.battleground", "Battleground::AddCreature: cannot create creature (entry: {}) for BG (map: {}, instance id: {})!",
                       entry, m_MapId, m_InstanceID);
        delete creature;
        return nullptr;
    }

    creature->SetHomePosition(x, y, z, o);

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(entry);
    if (!cinfo)
    {
        LOG_ERROR("bg.battleground", "Battleground::AddCreature: creature template (entry: {}) does not exist for BG (map: {}, instance id: {})!",
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

    return creature;
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

    LOG_ERROR("bg.battleground", "Battleground::DelCreature: creature (type: {}, {}) not found for BG (map: {}, instance id: {})!",
                   type, BgCreatures[type].ToString(), m_MapId, m_InstanceID);

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

    LOG_ERROR("bg.battleground", "Battleground::DelObject: gameobject (type: {}, {}) not found for BG (map: {}, instance id: {})!",
                   type, BgObjects[type].ToString(), m_MapId, m_InstanceID);

    BgObjects[type].Clear();
    return false;
}

bool Battleground::AddSpiritGuide(uint32 type, float x, float y, float z, float o, TeamId teamId)
{
    uint32 entry = (teamId == TEAM_ALLIANCE) ? BG_CREATURE_ENTRY_A_SPIRITGUIDE : BG_CREATURE_ENTRY_H_SPIRITGUIDE;

    if (Creature* creature = AddCreature(entry, type, x, y, z, o))
    {
        creature->setDeathState(DeathState::Dead);
        creature->SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT, creature->GetGUID());
        // aura
        /// @todo: Fix display here
        // creature->SetVisibleAura(0, SPELL_SPIRIT_HEAL_CHANNEL);
        // casting visual effect
        creature->SetUInt32Value(UNIT_CHANNEL_SPELL, SPELL_SPIRIT_HEAL_CHANNEL);
        // correct cast speed
        creature->SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);
        //creature->CastSpell(creature, SPELL_SPIRIT_HEAL_CHANNEL, true);
        return true;
    }
    LOG_ERROR("bg.battleground", "Battleground::AddSpiritGuide: cannot create spirit guide (type: {}, entry: {}) for BG (map: {}, instance id: {})!",
                   type, entry, m_MapId, m_InstanceID);
    EndNow();
    return false;
}

void Battleground::EndNow()
{
    RemoveFromBGFreeSlotQueue();
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
    {
        return;
    }

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

    uint32 respawnTime = SPEED_BUFF_RESPAWN_TIME;
    if (Map* map = FindBgMap())
    {
        if (GameObject* obj = map->GetGameObject(BgObjects[index]))
        {
            switch (obj->GetEntry())
            {
                case BG_OBJECTID_REGENBUFF_ENTRY:
                    respawnTime = RESTORATION_BUFF_RESPAWN_TIME;
                    break;
                case BG_OBJECTID_BERSERKERBUFF_ENTRY:
                    respawnTime = BERSERKING_BUFF_RESPAWN_TIME;
                    break;
                default:
                    break;
            }
        }
    }

    SpawnBGObject(index, respawnTime);
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
        victim->SetUnitFlag(UNIT_FLAG_SKINNABLE);
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

    BuildPvPLogDataPacket(data);
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

    LOG_ERROR("bg.battleground", "Battleground::GetObjectType: player used gameobject ({}) which is not in internal data for BG (map: {}, instance id: {}), cheating?",
                   guid.ToString(), m_MapId, m_InstanceID);

    return -1;
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
    return sGraveyard->GetClosestGraveyard(player, player->GetBgTeamId());
}

void Battleground::SetBracket(PvPDifficultyEntry const* bracketEntry)
{
    m_BracketId = bracketEntry->GetBracketId();
    SetLevelRange(bracketEntry->minLevel, bracketEntry->maxLevel);
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

    LOG_ERROR("bg.battleground", "GetTeamScore with wrong Team {} for BG {}", teamId, GetBgTypeID());
    return 0;
}

void Battleground::RewardXPAtKill(Player* killer, Player* victim)
{
    if (sWorld->getBoolConfig(CONFIG_BG_XP_FOR_KILL) && killer && victim)
        killer->RewardPlayerAndGroupAtKill(victim, true);
}

uint8 Battleground::GetUniqueBracketId() const
{
    return GetMaxLevel() / 10;
}
