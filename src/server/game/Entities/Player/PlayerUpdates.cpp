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

#include "AchievementMgr.h"
#include "BattlefieldMgr.h"
#include "CellImpl.h"
#include "Channel.h"
#include "ChannelMgr.h"
#include "Formulas.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "Guild.h"
#include "InstanceScript.h"
#include "Language.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SkillDiscovery.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "UpdateFieldFlags.h"
#include "Vehicle.h"
#include "Weather.h"
#include "WeatherMgr.h"
#include "WorldStatePackets.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

//npcbot
#include "botmgr.h"
//end npcbot

// Zone Interval should be 1 second
constexpr auto ZONE_UPDATE_INTERVAL = 1000;

void Player::Update(uint32 p_time)
{
    if (!IsInWorld())
        return;

    sScriptMgr->OnBeforePlayerUpdate(this, p_time);

    // undelivered mail
    if (m_nextMailDelivereTime && m_nextMailDelivereTime <= GameTime::GetGameTime().count())
    {
        SendNewMail();
        ++unReadMails;

        // It will be recalculate at mailbox open (for unReadMails important
        // non-0 until mailbox open, it also will be recalculated)
        m_nextMailDelivereTime = time_t(0);
    }

    // Update cinematic location, if 500ms have passed and we're doing a
    // cinematic now.
    _cinematicMgr->m_cinematicDiff += p_time;
    if (_cinematicMgr->m_cinematicCamera && _cinematicMgr->m_activeCinematicCameraId && GetMSTimeDiffToNow(_cinematicMgr->m_lastCinematicCheck) > CINEMATIC_UPDATEDIFF)
    {
        _cinematicMgr->m_lastCinematicCheck = getMSTime();
        _cinematicMgr->UpdateCinematicLocation(p_time);
    }

    // used to implement delayed far teleports
    SetMustDelayTeleport(true);
    Unit::Update(p_time);
    SetMustDelayTeleport(false);

    time_t now = GameTime::GetGameTime().count();

    UpdatePvPFlag(now);
    UpdateFFAPvPFlag(now);

    UpdateContestedPvP(p_time);

    UpdateDuelFlag(now);

    CheckDuelDistance(now);

    UpdateAfkReport(now);

    // Xinef: update charm AI only if we are controlled by creature or
    // non-posses player charm
    if (IsCharmed() && !HasUnitFlag(UNIT_FLAG_POSSESSED))
    {
        m_charmUpdateTimer += p_time;
        if (m_charmUpdateTimer >= 1000)
        {
            m_charmUpdateTimer = 0;
            if (Unit* charmer = GetCharmer())
                if (charmer->IsAlive())
                    UpdateCharmedAI();
        }
    }

    time_t lastTick = m_Last_tick;
    if (now > m_Last_tick)
    {
        // Update items that have just a limited lifetime
        UpdateItemDuration(uint32(now - m_Last_tick));

        // check every minute, less chance to crash and wont break anything.
        UpdateSoulboundTradeItems();

        // Played time
        uint32 elapsed = uint32(now - m_Last_tick);
        m_Played_time[PLAYED_TIME_TOTAL] += elapsed; // Total played time
        m_Played_time[PLAYED_TIME_LEVEL] += elapsed; // Level played time
        GetSession()->SetTotalTime(GetSession()->GetTotalTime() + elapsed);
        m_Last_tick = now;
    }

    // If mute expired, remove it from the DB
    if (GetSession()->m_muteTime && GetSession()->m_muteTime < now)
    {
        GetSession()->m_muteTime = 0;
        LoginDatabasePreparedStatement* stmt =
            LoginDatabase.GetPreparedStatement(LOGIN_UPD_MUTE_TIME);
        stmt->SetData(0, 0); // Set the mute time to 0
        stmt->SetData(1, "");
        stmt->SetData(2, "");
        stmt->SetData(3, GetSession()->GetAccountId());
        LoginDatabase.Execute(stmt);
    }

    if (!m_timedquests.empty())
    {
        QuestSet::iterator iter = m_timedquests.begin();
        while (iter != m_timedquests.end())
        {
            QuestStatusData& q_status = m_QuestStatus[*iter];
            if (q_status.Timer <= p_time)
            {
                uint32 quest_id = *iter;
                ++iter; // current iter will be removed in FailQuest
                FailQuest(quest_id);
            }
            else
            {
                q_status.Timer -= p_time;
                m_QuestStatusSave[*iter] = true;
                ++iter;
            }
        }
    }

    m_achievementMgr->UpdateTimedAchievements(p_time);

    if (HasUnitState(UNIT_STATE_MELEE_ATTACKING) && !HasUnitState(UNIT_STATE_CASTING) && !HasUnitState(UNIT_STATE_CHARGING))
    {
        if (Unit* victim = GetVictim())
        {
            // default combat reach 10
            /// @todo add weapon, skill check

            if (isAttackReady(BASE_ATTACK))
            {
                if (!IsWithinMeleeRange(victim))
                {
                    setAttackTimer(BASE_ATTACK, 100);
                    if (m_swingErrorMsg != 1) // send single time (client auto repeat)
                    {
                        SendAttackSwingNotInRange();
                        m_swingErrorMsg = 1;
                    }
                }
                // 120 degrees of radiant range
                else if (!HasInArc(2 * M_PI / 3, victim))
                {
                    setAttackTimer(BASE_ATTACK, 100);
                    if (m_swingErrorMsg != 2) // send single time (client auto repeat)
                    {
                        SendAttackSwingBadFacingAttack();
                        m_swingErrorMsg = 2;
                    }
                }
                else
                {
                    m_swingErrorMsg = 0; // reset swing error state

                    // prevent base and off attack in same time, delay attack at
                    // 0.2 sec
                    if (haveOffhandWeapon())
                        if (getAttackTimer(OFF_ATTACK) < ATTACK_DISPLAY_DELAY)
                            setAttackTimer(OFF_ATTACK, ATTACK_DISPLAY_DELAY);

                    // do attack
                    AttackerStateUpdate(victim, BASE_ATTACK);
                    resetAttackTimer(BASE_ATTACK);
                }
            }

            if (haveOffhandWeapon() && isAttackReady(OFF_ATTACK))
            {
                if (!IsWithinMeleeRange(victim))
                    setAttackTimer(OFF_ATTACK, 100);
                else if (!HasInArc(2 * M_PI / 3, victim))
                    setAttackTimer(OFF_ATTACK, 100);
                else
                {
                    // prevent base and off attack in same time, delay attack at
                    // 0.2 sec
                    if (getAttackTimer(BASE_ATTACK) < ATTACK_DISPLAY_DELAY)
                        setAttackTimer(BASE_ATTACK, ATTACK_DISPLAY_DELAY);

                    // do attack
                    AttackerStateUpdate(victim, OFF_ATTACK);
                    resetAttackTimer(OFF_ATTACK);
                }
            }

            /*Unit* owner = victim->GetOwner();
            Unit* u = owner ? owner : victim;
            if (u->IsPvP() && (!duel || duel->opponent != u))
            {
                UpdatePvP(true);
                RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
            }*/
        }
    }

    if (HasPlayerFlag(PLAYER_FLAGS_RESTING))
    {
        if (now > lastTick && _restTime > 0) // freeze update
        {
            time_t currTime = GameTime::GetGameTime().count();
            time_t timeDiff = currTime - _restTime;
            if (timeDiff >= 10) // freeze update
            {
                _restTime = currTime;

                float bubble = 0.125f * sWorld->getRate(RATE_REST_INGAME);
                float extraPerSec =
                    ((float) GetUInt32Value(PLAYER_NEXT_LEVEL_XP) / 72000.0f) *
                    bubble;

                // speed collect rest bonus (section/in hour)
                SetRestBonus(GetRestBonus() + timeDiff * extraPerSec);
            }
        }
    }

    if (m_weaponChangeTimer > 0)
    {
        if (p_time >= m_weaponChangeTimer)
            m_weaponChangeTimer = 0;
        else
            m_weaponChangeTimer -= p_time;
    }

    if (!IsPositionValid()) // pussywizard: will crash below at eg. GetZoneAndAreaId
    {
        LOG_INFO("misc", "Player::Update - invalid position ({0:.1f}, {0:.1f}, {0:.1f})! Map: {}, MapId: {}, {}",
            GetPositionX(), GetPositionY(), GetPositionZ(), (FindMap() ? FindMap()->GetId() : 0), GetMapId(), GetGUID().ToString());
        GetSession()->KickPlayer("Invalid position");
        return;
    }

    if (m_zoneUpdateTimer > 0)
    {
        if (p_time >= m_zoneUpdateTimer)
        {
            // On zone update tick check if we are still in an inn if we are
            // supposed to be in one
            if (HasRestFlag(REST_FLAG_IN_TAVERN))
            {
                AreaTrigger const* atEntry = sObjectMgr->GetAreaTrigger(GetInnTriggerId());
                if (!atEntry || !IsInAreaTriggerRadius(atEntry, 5.f))
                {
                    RemoveRestFlag(REST_FLAG_IN_TAVERN);
                }
            }

            uint32 newzone, newarea;
            GetZoneAndAreaId(newzone, newarea);

            if (m_zoneUpdateId != newzone)
                UpdateZone(newzone, newarea); // also update area
            else
            {
                // use area updates as well
                // needed for free far all arenas for example
                if (m_areaUpdateId != newarea)
                    UpdateArea(newarea);
            }

            m_zoneUpdateTimer = ZONE_UPDATE_INTERVAL;
        }
        else
            m_zoneUpdateTimer -= p_time;
    }

    sScriptMgr->OnPlayerUpdate(this, p_time);

    if (IsAlive())
    {
        m_regenTimer += p_time;
        RegenerateAll();
    }

    if (m_deathState == DeathState::JustDied)
        KillPlayer();

    if (m_nextSave)
    {
        if (p_time >= m_nextSave)
        {
            // m_nextSave reset in SaveToDB call
            SaveToDB(false, false);
            LOG_DEBUG("entities.player", "Player::Update: Player '{}' ({}) saved", GetName(), GetGUID().ToString());
        }
        else
        {
            m_nextSave -= p_time;
        }
    }

    // Handle Water/drowning
    HandleDrowning(p_time);

    if (GetDrunkValue())
    {
        m_drunkTimer += p_time;
        if (m_drunkTimer > 9 * IN_MILLISECONDS)
            HandleSobering();
    }

    if (HasPendingBind())
    {
        if (_pendingBindTimer <= p_time)
        {
            // Player left the instance
            if (_pendingBindId == GetInstanceId())
                BindToInstance();
            SetPendingBind(0, 0);
        }
        else
            _pendingBindTimer -= p_time;
    }

    // not auto-free ghost from body in instances
    if (m_deathTimer > 0 && !GetMap()->Instanceable() &&
        !HasAuraType(SPELL_AURA_PREVENT_RESURRECTION))
    {
        if (p_time >= m_deathTimer)
        {
            m_deathTimer = 0;
            BuildPlayerRepop();
            RepopAtGraveyard();
        }
        else
            m_deathTimer -= p_time;
    }

    UpdateEnchantTime(p_time);
    UpdateHomebindTime(p_time);

    if (!_instanceResetTimes.empty())
    {
        for (InstanceTimeMap::iterator itr = _instanceResetTimes.begin();
             itr != _instanceResetTimes.end();)
        {
            if (itr->second < now)
                _instanceResetTimes.erase(itr++);
            else
                ++itr;
        }
    }

    // group update
    SendUpdateToOutOfRangeGroupMembers();

    Pet* pet = GetPet();
    if (pet && !pet->IsWithinDistInMap(this, GetMap()->GetVisibilityRange()) &&
        !pet->isPossessed())
        // if (pet && !pet->IsWithinDistInMap(this,
        // GetMap()->GetVisibilityDistance()) && (GetCharmGUID() &&
        // (pet->GetGUID()
        // != GetCharmGUID())))
        RemovePet(pet, PET_SAVE_NOT_IN_SLOT, true);

    // pussywizard:
    if (m_hostileReferenceCheckTimer <= p_time)
    {
        m_hostileReferenceCheckTimer = 15000;
        if (!GetMap()->IsDungeon())
            getHostileRefMgr().deleteReferencesOutOfRange(
                GetVisibilityRange());
    }
    else
        m_hostileReferenceCheckTimer -= p_time;

    // we should execute delayed teleports only for alive(!) players
    // because we don't want player's ghost teleported from graveyard
    // xinef: so we store it to the end of the world and teleport out of the ass
    // after resurrection?
    if (HasDelayedTeleport() /* && IsAlive()*/)
    {
        SetHasDelayedTeleport(false);
        TeleportTo(teleportStore_dest, teleportStore_options);
    }

    if (!IsBeingTeleported() && bRequestForcedVisibilityUpdate)
    {
        bRequestForcedVisibilityUpdate = false;
        UpdateObjectVisibility(true, true);
        m_delayed_unit_relocation_timer = 0;
        RemoveFromNotify(NOTIFY_VISIBILITY_CHANGED);
    }

    //NpcBot mod: Update
    _botMgr->Update(p_time);
    //end Npcbot
}

void Player::UpdateMirrorTimers()
{
    // Desync flags for update on next HandleDrowning
    if (m_MirrorTimerFlags)
        m_MirrorTimerFlagsLast = ~m_MirrorTimerFlags;
}

void Player::UpdateNextMailTimeAndUnreads()
{
    // Update the next delivery time and unread mails
    time_t cTime = GameTime::GetGameTime().count();
    // Get the next delivery time
    CharacterDatabasePreparedStatement* stmtNextDeliveryTime =
        CharacterDatabase.GetPreparedStatement(CHAR_SEL_NEXT_MAIL_DELIVERYTIME);
    stmtNextDeliveryTime->SetData(0, GetGUID().GetCounter());
    stmtNextDeliveryTime->SetData(1, uint32(cTime));
    PreparedQueryResult resultNextDeliveryTime =
        CharacterDatabase.Query(stmtNextDeliveryTime);
    if (resultNextDeliveryTime)
    {
        Field* fields          = resultNextDeliveryTime->Fetch();
        m_nextMailDelivereTime = time_t(fields[0].Get<uint32>());
    }

    // Get unread mails count
    CharacterDatabasePreparedStatement* stmtUnreadAmount =
        CharacterDatabase.GetPreparedStatement(
            CHAR_SEL_CHARACTER_MAILCOUNT_UNREAD_SYNCH);
    stmtUnreadAmount->SetData(0, GetGUID().GetCounter());
    stmtUnreadAmount->SetData(1, uint32(cTime));
    PreparedQueryResult resultUnreadAmount =
        CharacterDatabase.Query(stmtUnreadAmount);
    if (resultUnreadAmount)
    {
        Field* fields = resultUnreadAmount->Fetch();
        unReadMails   = uint8(fields[0].Get<uint64>());
    }
}

void Player::UpdateLocalChannels(uint32 newZone)
{
    // pussywizard: mutex needed (tc changed opcode to THREAD UNSAFE)
    static std::mutex           channelsLock;
    std::lock_guard<std::mutex> guard(channelsLock);

    if (GetSession()->PlayerLoading() && !IsBeingTeleportedFar())
        return; // The client handles it automatically after loading, but not
                // after teleporting

    AreaTableEntry const* current_zone = sAreaTableStore.LookupEntry(newZone);
    if (!current_zone)
        return;

    ChannelMgr* cMgr = ChannelMgr::forTeam(GetTeamId());
    if (!cMgr)
        return;

    std::string current_zone_name =
        current_zone->area_name[GetSession()->GetSessionDbcLocale()];

    for (uint32 i = 0; i < sChatChannelsStore.GetNumRows(); ++i)
    {
        if (ChatChannelsEntry const* channel =
                sChatChannelsStore.LookupEntry(i))
        {
            Channel* usedChannel = nullptr;

            for (Channel* channel : m_channels)
            {
                if (channel && channel->GetChannelId() == i)
                {
                    usedChannel = channel;
                    break;
                }
            }

            Channel* removeChannel = nullptr;
            Channel* joinChannel   = nullptr;
            bool     sendRemove    = true;

            if (CanJoinConstantChannelInZone(channel, current_zone))
            {
                if (!(channel->flags & CHANNEL_DBC_FLAG_GLOBAL))
                {
                    if (channel->flags & CHANNEL_DBC_FLAG_CITY_ONLY &&
                        usedChannel)
                        continue; // Already on the channel, as city channel
                                  // names are not changing

                    char        new_channel_name_buf[100];
                    char const* currentNameExt;

                    if (channel->flags & CHANNEL_DBC_FLAG_CITY_ONLY)
                        currentNameExt = sObjectMgr->GetAcoreStringForDBCLocale(
                            LANG_CHANNEL_CITY);
                    else
                        currentNameExt = current_zone_name.c_str();

                    snprintf(new_channel_name_buf, 100,
                             channel->pattern[m_session->GetSessionDbcLocale()],
                             currentNameExt);

                    joinChannel = cMgr->GetJoinChannel(new_channel_name_buf,
                                                       channel->ChannelID);
                    if (usedChannel)
                    {
                        if (joinChannel != usedChannel)
                        {
                            removeChannel = usedChannel;
                            sendRemove    = false; // Do not send leave channel, it
                                                   // already replaced at client
                        }
                        else
                            joinChannel = nullptr;
                    }
                }
                else
                    joinChannel = cMgr->GetJoinChannel(
                        channel->pattern[m_session->GetSessionDbcLocale()],
                        channel->ChannelID);
            }
            else
                removeChannel = usedChannel;

            if (joinChannel)
                joinChannel->JoinChannel(
                    this, ""); // Changed Channel: ... or Joined Channel: ...

            if (removeChannel)
            {
                removeChannel->LeaveChannel(this,
                                            sendRemove); // Leave old channel
                std::string name =
                    removeChannel
                        ->GetName();        // Store name, (*i)erase in LeftChannel
                LeftChannel(removeChannel); // Remove from player's channel list
            }
        }
    }
}

void Player::UpdateDefense()
{
    if (UpdateSkill(SKILL_DEFENSE,
                    sWorld->getIntConfig(CONFIG_SKILL_GAIN_DEFENSE)))
        UpdateDefenseBonusesMod(); // update dependent from defense skill part
}

void Player::UpdateRating(CombatRating cr)
{
    int32 amount = m_baseRatingValue[cr];
    // Apply bonus from SPELL_AURA_MOD_RATING_FROM_STAT
    // stat used stored in miscValueB for this aura
    AuraEffectList const& modRatingFromStat =
        GetAuraEffectsByType(SPELL_AURA_MOD_RATING_FROM_STAT);
    for (AuraEffectList::const_iterator i = modRatingFromStat.begin();
         i != modRatingFromStat.end(); ++i)
        if ((*i)->GetMiscValue() & (1 << cr))
            amount += int32(CalculatePct(GetStat(Stats((*i)->GetMiscValueB())),
                                         (*i)->GetAmount()));
    if (amount < 0)
        amount = 0;
    SetUInt32Value(static_cast<uint16>(PLAYER_FIELD_COMBAT_RATING_1) + static_cast<uint16>(cr), uint32(amount));

    bool affectStats = CanModifyStats();

    switch (cr)
    {
    case CR_WEAPON_SKILL: // Implemented in Unit::RollMeleeOutcomeAgainst
    case CR_DEFENSE_SKILL:
        UpdateDefenseBonusesMod();
        break;
    case CR_DODGE:
        UpdateDodgePercentage();
        break;
    case CR_PARRY:
        UpdateParryPercentage();
        break;
    case CR_BLOCK:
        UpdateBlockPercentage();
        break;
    case CR_HIT_MELEE:
        UpdateMeleeHitChances();
        break;
    case CR_HIT_RANGED:
        UpdateRangedHitChances();
        break;
    case CR_HIT_SPELL:
        UpdateSpellHitChances();
        break;
    case CR_CRIT_MELEE:
        if (affectStats)
        {
            UpdateCritPercentage(BASE_ATTACK);
            UpdateCritPercentage(OFF_ATTACK);
        }
        break;
    case CR_CRIT_RANGED:
        if (affectStats)
            UpdateCritPercentage(RANGED_ATTACK);
        break;
    case CR_CRIT_SPELL:
        if (affectStats)
            UpdateAllSpellCritChances();
        break;
    case CR_HIT_TAKEN_MELEE: // Implemented in Unit::MeleeMissChanceCalc
    case CR_HIT_TAKEN_RANGED:
        break;
    case CR_HIT_TAKEN_SPELL: // Implemented in Unit::MagicSpellHitResult
        break;
    case CR_CRIT_TAKEN_MELEE: // Implemented in Unit::RollMeleeOutcomeAgainst
                              // (only for chance to crit)
    case CR_CRIT_TAKEN_RANGED:
        break;
    case CR_CRIT_TAKEN_SPELL: // Implemented in Unit::SpellCriticalBonus (only
                              // for chance to crit)
        break;
    case CR_HASTE_MELEE: // Implemented in Player::ApplyRatingMod
    case CR_HASTE_RANGED:
    case CR_HASTE_SPELL:
        break;
    case CR_WEAPON_SKILL_MAINHAND: // Implemented in
                                   // Unit::RollMeleeOutcomeAgainst
    case CR_WEAPON_SKILL_OFFHAND:
    case CR_WEAPON_SKILL_RANGED:
        break;
    case CR_EXPERTISE:
        if (affectStats)
        {
            UpdateExpertise(BASE_ATTACK);
            UpdateExpertise(OFF_ATTACK);
        }
        break;
    case CR_ARMOR_PENETRATION:
        if (affectStats)
            UpdateArmorPenetration(amount);
        break;
    }
}

void Player::UpdateAllRatings()
{
    for (int cr = 0; cr < MAX_COMBAT_RATING; ++cr)
        UpdateRating(CombatRating(cr));
}

// skill+step, checking for max value
bool Player::UpdateSkill(uint32 skill_id, uint32 step)
{
    if (!skill_id)
        return false;

    SkillStatusMap::iterator itr = mSkillStatus.find(skill_id);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return false;

    uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);
    uint32 data       = GetUInt32Value(valueIndex);
    uint32 value      = SKILL_VALUE(data);
    uint32 max        = SKILL_MAX(data);

    if ((!max) || (!value) || (value >= max))
        return false;

    if (value < max)
    {
        uint32 new_value = value + step;
        if (new_value > max)
            new_value = max;

        SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(new_value, max));
        if (itr->second.uState != SKILL_NEW)
            itr->second.uState = SKILL_CHANGED;

        UpdateSkillEnchantments(skill_id, value, new_value);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL,
                                  skill_id);
        return true;
    }

    return false;
}

// iraizo: turn this into a switch statement
inline int SkillGainChance(uint32 SkillValue, uint32 GrayLevel,
                           uint32 GreenLevel, uint32 YellowLevel)
{
    if (SkillValue >= GrayLevel)
        return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_GREY) * 10;
    if (SkillValue >= GreenLevel)
        return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_GREEN) * 10;
    if (SkillValue >= YellowLevel)
        return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_YELLOW) * 10;
    return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_ORANGE) * 10;
}

bool Player::UpdateGatherSkill(uint32 SkillId, uint32 SkillValue,
                               uint32 RedLevel, uint32 Multiplicator)
{
    LOG_DEBUG("entities.player.skills",
              "UpdateGatherSkill(SkillId {} SkillLevel {} RedLevel {})",
              SkillId, SkillValue, RedLevel);

    uint32 gathering_skill_gain =
        sWorld->getIntConfig(CONFIG_SKILL_GAIN_GATHERING);
    sScriptMgr->OnUpdateGatheringSkill(this, SkillId, SkillValue, RedLevel + 100, RedLevel + 50, RedLevel + 25, gathering_skill_gain);

    // For skinning and Mining chance decrease with level. 1-74 - no decrease,
    // 75-149 - 2 times, 225-299 - 8 times
    switch (SkillId)
    {
    case SKILL_HERBALISM:
    case SKILL_LOCKPICKING:
    case SKILL_JEWELCRAFTING:
    case SKILL_INSCRIPTION:
        return UpdateSkillPro(SkillId,
                              SkillGainChance(SkillValue, RedLevel + 100,
                                              RedLevel + 50, RedLevel + 25) *
                                  Multiplicator,
                              gathering_skill_gain);
    case SKILL_SKINNING:
        if (sWorld->getIntConfig(CONFIG_SKILL_CHANCE_SKINNING_STEPS) == 0)
            return UpdateSkillPro(SkillId,
                                  SkillGainChance(SkillValue, RedLevel + 100,
                                                  RedLevel + 50,
                                                  RedLevel + 25) *
                                      Multiplicator,
                                  gathering_skill_gain);
        else
            return UpdateSkillPro(
                SkillId,
                (SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50,
                                 RedLevel + 25) *
                 Multiplicator) >>
                    (SkillValue /
                     sWorld->getIntConfig(CONFIG_SKILL_CHANCE_SKINNING_STEPS)),
                gathering_skill_gain);
    case SKILL_MINING:
        if (sWorld->getIntConfig(CONFIG_SKILL_CHANCE_MINING_STEPS) == 0)
            return UpdateSkillPro(SkillId,
                                  SkillGainChance(SkillValue, RedLevel + 100,
                                                  RedLevel + 50,
                                                  RedLevel + 25) *
                                      Multiplicator,
                                  gathering_skill_gain);
        else
            return UpdateSkillPro(
                SkillId,
                (SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50,
                                 RedLevel + 25) *
                 Multiplicator) >>
                    (SkillValue /
                     sWorld->getIntConfig(CONFIG_SKILL_CHANCE_MINING_STEPS)),
                gathering_skill_gain);
    }
    return false;
}

bool Player::UpdateCraftSkill(uint32 spellid)
{
    LOG_DEBUG("entities.player.skills", "UpdateCraftSkill spellid {}", spellid);

    SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellid);

    for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first;
         _spell_idx != bounds.second; ++_spell_idx)
    {
        if (_spell_idx->second->SkillLine)
        {
            uint32 SkillValue =
                GetPureSkillValue(_spell_idx->second->SkillLine);

            // Alchemy Discoveries here
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
            if (spellInfo && spellInfo->Mechanic == MECHANIC_DISCOVERY)
            {
                if (uint32 discoveredSpell = GetSkillDiscoverySpell(
                        _spell_idx->second->SkillLine, spellid, this))
                    learnSpell(discoveredSpell);
            }

            uint32 craft_skill_gain =
                sWorld->getIntConfig(CONFIG_SKILL_GAIN_CRAFTING);
            sScriptMgr->OnUpdateCraftingSkill(this, _spell_idx->second, SkillValue, craft_skill_gain);

            return UpdateSkillPro(
                _spell_idx->second->SkillLine,
                SkillGainChance(SkillValue,
                                _spell_idx->second->TrivialSkillLineRankHigh,
                                (_spell_idx->second->TrivialSkillLineRankHigh +
                                 _spell_idx->second->TrivialSkillLineRankLow) /
                                    2,
                                _spell_idx->second->TrivialSkillLineRankLow),
                craft_skill_gain);
        }
    }
    return false;
}

float getProbabilityOfLevelUp(uint32 SkillValue)
{
    /* According to El's Extreme Angling page, from 1 to 115 the probability of
     * a skill level up is 100% since 100/1 = 100. From 115 - 135 should average
     * 2 catches per skill up so that means 100/2 = 50%. This returns the
     * probability depending on the player's SkillValue.
     */
    if (!SkillValue)
    {
        return 0.0f;
    }

    std::array<uint32, 10> bounds {115, 135, 160, 190, 215,
                                   295, 315, 355, 425, 450};
    std::array<float, 11>  dens {1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f,
                                9.0f, 10.0f, 11.0f, 12.0f, 1.0f};
    auto                   it =
        std::lower_bound(std::begin(bounds), std::end(bounds), SkillValue);
    return 100 / dens[std::distance(std::begin(bounds), it)];
}

bool Player::UpdateFishingSkill()
{
    LOG_DEBUG("entities.player.skills", "UpdateFishingSkill");

    uint32 SkillValue = GetPureSkillValue(SKILL_FISHING);

    if (SkillValue >= GetMaxSkillValue(SKILL_FISHING))
    {
        return false;
    }

    /* Whenever the player clicks on the fishing gameobject the
     * core will decide based on a probability if the skill raises or not.
     */
    return UpdateSkillPro(
        SKILL_FISHING,
        static_cast<int32>(getProbabilityOfLevelUp(SkillValue)) * 10,
        sWorld->getIntConfig(CONFIG_SKILL_GAIN_GATHERING));
}

// levels sync. with spell requirement for skill levels to learn
// bonus abilities in sSkillLineAbilityStore
// Used only to avoid scan DBC at each skill grow
static uint32       bonusSkillLevels[] = {75, 150, 225, 300, 375, 450};
static const size_t bonusSkillLevelsSize =
    sizeof(bonusSkillLevels) / sizeof(uint32);

bool Player::UpdateSkillPro(uint16 SkillId, int32 Chance, uint32 step)
{
    LOG_DEBUG("entities.player.skills",
              "UpdateSkillPro(SkillId {}, Chance {:3.1f}%)", SkillId,
              Chance / 10.0f);
    if (!SkillId)
        return false;

    if (Chance <= 0) // speedup in 0 chance case
    {
        LOG_DEBUG("entities.player.skills",
                  "Player::UpdateSkillPro Chance={:3.1f}% missed",
                  Chance / 10.0f);
        return false;
    }

    SkillStatusMap::iterator itr = mSkillStatus.find(SkillId);
    if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
        return false;

    uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);

    uint32 data       = GetUInt32Value(valueIndex);
    uint16 SkillValue = SKILL_VALUE(data);
    uint16 MaxValue   = SKILL_MAX(data);

    if (!MaxValue || !SkillValue || SkillValue >= MaxValue)
        return false;

    int32 Roll = irand(1, 1000);

    if (Roll <= Chance)
    {
        uint32 new_value = SkillValue + step;
        if (new_value > MaxValue)
            new_value = MaxValue;

        SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(new_value, MaxValue));
        if (itr->second.uState != SKILL_NEW)
            itr->second.uState = SKILL_CHANGED;

        for (size_t i = 0; i < bonusSkillLevelsSize; ++i)
        {
            uint32 bsl = bonusSkillLevels[i];
            if (SkillValue < bsl && new_value >= bsl)
            {
                learnSkillRewardedSpells(SkillId, new_value);
                break;
            }
        }
        UpdateSkillEnchantments(SkillId, SkillValue, new_value);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL,
                                  SkillId);
        LOG_DEBUG("entities.player.skills",
                  "Player::UpdateSkillPro Chance={:3.1f}% taken",
                  Chance / 10.0f);
        return true;
    }

    LOG_DEBUG("entities.player.skills",
              "Player::UpdateSkillPro Chance={:3.1f}% missed", Chance / 10.0f);
    return false;
}

void Player::UpdateWeaponSkill(Unit* victim, WeaponAttackType attType, Item* item /*= nullptr*/)
{
    if (IsInFeralForm())
        return; // always maximized SKILL_FERAL_COMBAT in fact

    if (GetShapeshiftForm() == FORM_TREE)
        return; // use weapon but not skill up

    if (victim->GetTypeId() == TYPEID_UNIT &&
        (victim->ToCreature()->GetCreatureTemplate()->flags_extra &
         CREATURE_FLAG_EXTRA_NO_SKILL_GAINS))
        return;

    uint32 weapon_skill_gain = sWorld->getIntConfig(CONFIG_SKILL_GAIN_WEAPON);

    Item* tmpitem = GetWeaponForAttack(attType, true);
    if (item && item != tmpitem && !item->IsBroken())
    {
        tmpitem = item;
    }

    if (!tmpitem && attType == BASE_ATTACK)
    {
        // Keep unarmed & fist weapon skills in sync
        UpdateSkill(SKILL_UNARMED, weapon_skill_gain);
        UpdateSkill(SKILL_FIST_WEAPONS, weapon_skill_gain);
    }
    else if (tmpitem && tmpitem->GetTemplate()->SubClass !=
                            ITEM_SUBCLASS_WEAPON_FISHING_POLE)
    {
        switch (tmpitem->GetTemplate()->SubClass)
        {
        case ITEM_SUBCLASS_WEAPON_FISHING_POLE:
            break;
        case ITEM_SUBCLASS_WEAPON_FIST:
            UpdateSkill(SKILL_UNARMED, weapon_skill_gain);
            [[fallthrough]];
        default:
            UpdateSkill(tmpitem->GetSkill(), weapon_skill_gain);
            break;
        }
    }

    UpdateAllCritPercentages();
}

void Player::UpdateCombatSkills(Unit* victim, WeaponAttackType attType, bool defence, Item* item /*= nullptr*/)
{
    uint8  playerLevel = GetLevel();
    uint16 currentSkillValue = defence ? GetBaseDefenseSkillValue() : GetBaseWeaponSkillValue(attType);
    uint16 currentSkillMax = 5 * playerLevel;
    int32  skillDiff = currentSkillMax - currentSkillValue;

    // Max skill reached for level.
    // Can in some cases be less than 0: having max skill and then .level -1 as example.
    if (skillDiff <= 0)
    {
        return;
    }

    uint8 greylevel = Acore::XP::GetGrayLevel(playerLevel);
    uint8 moblevel = defence ? victim->getLevelForTarget(this) : victim->GetLevel(); // if defense than victim == attacker
    /*if (moblevel < greylevel)
        return;*/
    // Patch 3.0.8 (2009-01-20): You can no longer skill up weapons on mobs that are immune to damage.

    if (moblevel > playerLevel + 5)
    {
        moblevel = playerLevel + 5;
    }

    int16 lvldif = moblevel - greylevel;
    if (lvldif < 3)
    {
        lvldif = 3;
    }

    float chance = float(3 * lvldif * skillDiff) / playerLevel;
    if (!defence)
    {
        chance += chance * 0.02f * GetStat(STAT_INTELLECT);
    }

    chance = chance < 1.0f ? 1.0f : chance; // minimum chance to increase skill is 1%

    LOG_DEBUG("entities.player", "Player::UpdateCombatSkills(defence:{}, playerLevel:{}, moblevel:{}) -> ({}/{}) chance to increase skill is {}%", defence, playerLevel, moblevel, currentSkillValue, currentSkillMax, chance);

    if (roll_chance_f(chance))
    {
        if (defence)
        {
            UpdateDefense();
        }
        else
        {
            UpdateWeaponSkill(victim, attType, item);
        }
    }
}

void Player::UpdateSkillsForLevel()
{
    uint16 maxconfskill = sWorld->GetConfigMaxSkillValue();
    uint32 maxSkill     = GetMaxSkillValueForLevel();

    bool alwaysMaxSkill =
        sWorld->getBoolConfig(CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL);

    for (SkillStatusMap::iterator itr = mSkillStatus.begin();
         itr != mSkillStatus.end(); ++itr)
    {
        if (itr->second.uState == SKILL_DELETED)
            continue;

        uint32                         pskill = itr->first;
        SkillRaceClassInfoEntry const* rcEntry =
            GetSkillRaceClassInfo(pskill, getRace(), getClass());
        if (!rcEntry)
            continue;

        if (GetSkillRangeType(rcEntry) != SKILL_RANGE_LEVEL)
            continue;

        uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);
        uint32 data       = GetUInt32Value(valueIndex);
        uint32 max        = SKILL_MAX(data);
        uint32 val        = SKILL_VALUE(data);

        /// update only level dependent max skill values
        if (max != 1)
        {
            /// maximize skill always
            if (alwaysMaxSkill ||
                (rcEntry->Flags & SKILL_FLAG_ALWAYS_MAX_VALUE))
            {
                SetUInt32Value(valueIndex,
                               MAKE_SKILL_VALUE(maxSkill, maxSkill));
                if (itr->second.uState != SKILL_NEW)
                    itr->second.uState = SKILL_CHANGED;
            }
            else if (max != maxconfskill) /// update max skill value if current
                                          /// max skill not maximized
            {
                SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(val, maxSkill));
                if (itr->second.uState != SKILL_NEW)
                    itr->second.uState = SKILL_CHANGED;
            }
        }
    }
}

void Player::UpdateSkillsToMaxSkillsForLevel()
{
    for (SkillStatusMap::iterator itr = mSkillStatus.begin();
         itr != mSkillStatus.end(); ++itr)
    {
        if (itr->second.uState == SKILL_DELETED)
            continue;

        uint32 pskill = itr->first;
        if (IsProfessionOrRidingSkill(pskill))
            continue;
        uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);
        uint32 data       = GetUInt32Value(valueIndex);
        uint32 max        = SKILL_MAX(data);

        if (max > 1)
        {
            SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(max, max));
            if (itr->second.uState != SKILL_NEW)
                itr->second.uState = SKILL_CHANGED;
        }
        if (pskill == SKILL_DEFENSE)
            UpdateDefenseBonusesMod();
    }
}

bool Player::UpdatePosition(float x, float y, float z, float orientation,
                            bool teleport)
{
    if (!Unit::UpdatePosition(x, y, z, orientation, teleport))
        return false;

    // Update player zone if needed
    if (m_needZoneUpdate)
    {
        uint32 newZone, newArea;
        GetZoneAndAreaId(newZone, newArea);
        UpdateZone(newZone, newArea);
        m_needZoneUpdate = false;
    }

    if (GetGroup())
        SetGroupUpdateFlag(GROUP_UPDATE_FLAG_POSITION);

    if (GetTrader() && !IsWithinDistInMap(GetTrader(), INTERACTION_DISTANCE))
        GetSession()->SendCancelTrade();

    CheckAreaExploreAndOutdoor();

    return true;
}

void Player::UpdateHonorFields()
{
    /// called when rewarding honor and at each save
    time_t now   = time_t(GameTime::GetGameTime().count());
    time_t today = time_t(GameTime::GetGameTime().count() / DAY) * DAY;

    if (m_lastHonorUpdateTime < today)
    {
        time_t yesterday = today - DAY;

        uint16 kills_today = PAIR32_LOPART(GetUInt32Value(PLAYER_FIELD_KILLS));

        // update yesterday's contribution
        if (m_lastHonorUpdateTime >= yesterday)
        {
            SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION,
                           GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));

            // this is the first update today, reset today's contribution
            SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
            SetUInt32Value(PLAYER_FIELD_KILLS, MAKE_PAIR32(0, kills_today));
        }
        else
        {
            // no honor/kills yesterday or today, reset
            SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);
            SetUInt32Value(PLAYER_FIELD_KILLS, 0);
        }
    }

    m_lastHonorUpdateTime = now;
}

void Player::UpdateArea(uint32 newArea)
{
    // pussywizard: inform instance, needed for Icecrown Citadel
    if (InstanceScript* instance = GetInstanceScript())
        instance->OnPlayerAreaUpdate(this, m_areaUpdateId, newArea);

    sScriptMgr->OnPlayerUpdateArea(this, m_areaUpdateId, newArea);

    // FFA_PVP flags are area and not zone id dependent
    // so apply them accordingly
    m_areaUpdateId = newArea;

    AreaTableEntry const* area = sAreaTableStore.LookupEntry(newArea);
    pvpInfo.IsInFFAPvPArea     = area && (area->flags & AREA_FLAG_ARENA);
    UpdateFFAPvPState(false);

    UpdateAreaDependentAuras(newArea);

    pvpInfo.IsInNoPvPArea = false;
    if (area && area->IsSanctuary())
    {
        SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY);
        pvpInfo.IsInNoPvPArea = true;
        CombatStopWithPets();
    }
    else
        RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY);

    uint32 const areaRestFlag = (GetTeamId(true) == TEAM_ALLIANCE)
                                    ? AREA_FLAG_REST_ZONE_ALLIANCE
                                    : AREA_FLAG_REST_ZONE_HORDE;
    if (area && area->flags & areaRestFlag)
        SetRestFlag(REST_FLAG_IN_FACTION_AREA);
    else
        RemoveRestFlag(REST_FLAG_IN_FACTION_AREA);
}

void Player::UpdateZone(uint32 newZone, uint32 newArea)
{
    if (!newZone)
    {
        return;
    }

    if (m_zoneUpdateId != newZone)
    {
        sOutdoorPvPMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
        sOutdoorPvPMgr->HandlePlayerEnterZone(this, newZone);
        sBattlefieldMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
        sBattlefieldMgr->HandlePlayerEnterZone(this, newZone);
        SendInitWorldStates(newZone,
                            newArea); // only if really enters to new zone, not
                                      // just area change, works strange...
        if (Guild* guild = GetGuild())
            guild->UpdateMemberData(this, GUILD_MEMBER_DATA_ZONEID, newZone);
    }

    // group update
    if (GetGroup())
        SetGroupUpdateFlag(GROUP_UPDATE_FULL);

    m_zoneUpdateId    = newZone;
    m_zoneUpdateTimer = ZONE_UPDATE_INTERVAL;

    // zone changed, so area changed as well, update it
    UpdateArea(newArea);

    AreaTableEntry const* zone = sAreaTableStore.LookupEntry(newZone);
    if (!zone)
        return;

    if (sWorld->getBoolConfig(CONFIG_WEATHER))
    {
        if (Weather* weather = WeatherMgr::FindWeather(zone->ID))
            weather->SendWeatherUpdateToPlayer(this);
        else if (!WeatherMgr::AddWeather(zone->ID))
            // send fine weather packet to remove old zone's weather
            WeatherMgr::SendFineWeatherUpdateToPlayer(this);
    }

    sScriptMgr->OnPlayerUpdateZone(this, newZone, newArea);

    // in PvP, any not controlled zone (except zone->team == 6, default case)
    // in PvE, only opposition team capital
    switch (zone->team)
    {
    case AREATEAM_ALLY:
        pvpInfo.IsInHostileArea =
            GetTeamId(true) != TEAM_ALLIANCE &&
            (sWorld->IsPvPRealm() || zone->flags & AREA_FLAG_CAPITAL);
        break;
    case AREATEAM_HORDE:
        pvpInfo.IsInHostileArea =
            GetTeamId(true) != TEAM_HORDE &&
            (sWorld->IsPvPRealm() || zone->flags & AREA_FLAG_CAPITAL);
        break;
    case AREATEAM_NONE:
        // overwrite for battlegrounds, maybe batter some zone flags but current
        // known not 100% fit to this
        pvpInfo.IsInHostileArea = sWorld->IsPvPRealm() || InBattleground() ||
                                  zone->flags & AREA_FLAG_WINTERGRASP;
        break;
    default: // 6 in fact
        pvpInfo.IsInHostileArea = false;
        break;
    }

    // Treat players having a quest flagging for PvP as always in hostile area
    pvpInfo.IsHostile = pvpInfo.IsInHostileArea || HasPvPForcingQuest();

    if (zone->flags & AREA_FLAG_CAPITAL) // Is in a capital city
    {
        if (!pvpInfo.IsHostile || zone->IsSanctuary())
            SetRestFlag(REST_FLAG_IN_CITY);

        pvpInfo.IsInNoPvPArea = true;
    }
    else
        RemoveRestFlag(REST_FLAG_IN_CITY); // Recently left a capital city

    UpdatePvPState();

    // remove items with area/map limitations (delete only for alive player to
    // allow back in ghost mode) if player resurrected at teleport this will be
    // applied in resurrect code
    if (IsAlive())
        DestroyZoneLimitedItem(true, newZone);

    // check some item equip limitations (in result lost CanTitanGrip at talent
    // reset, for example)
    AutoUnequipOffhandIfNeed();

    // recent client version not send leave/join channel packets for built-in
    // local channels
    UpdateLocalChannels(newZone);

    UpdateZoneDependentAuras(newZone);
}

void Player::UpdateEquipSpellsAtFormChange()
{
    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i] && !m_items[i]->IsBroken() &&
            CanUseAttackType(GetAttackBySlot(i)))
        {
            ApplyItemEquipSpell(m_items[i], false,
                                true); // remove spells that not fit to form
            ApplyItemEquipSpell(
                m_items[i], true,
                true); // add spells that fit form but not active
        }
    }

    // item set bonuses not dependent from item broken state
    for (size_t setindex = 0; setindex < ItemSetEff.size(); ++setindex)
    {
        ItemSetEffect* eff = ItemSetEff[setindex];
        if (!eff)
            continue;

        for (uint32 y = 0; y < MAX_ITEM_SET_SPELLS; ++y)
        {
            SpellInfo const* spellInfo = eff->spells[y];
            if (!spellInfo)
                continue;

            ApplyEquipSpell(spellInfo, nullptr, false,
                            true); // remove spells that not fit to form
            if (!sScriptMgr->CanApplyEquipSpellsItemSet(this, eff))
                break;
            ApplyEquipSpell(spellInfo, nullptr, true,
                            true); // add spells that fit form but not active
        }
    }
}

void Player::UpdateHomebindTime(uint32 time)
{
    // GMs never get homebind timer online
    if (m_InstanceValid || IsGameMaster())
    {
        if (m_HomebindTimer) // instance valid, but timer not reset
        {
            // hide reminder
            WorldPacket data(SMSG_RAID_GROUP_ONLY, 4 + 4);
            data << uint32(0);
            data << uint32(0);
            GetSession()->SendPacket(&data);
        }
        // instance is valid, reset homebind timer
        m_HomebindTimer = 0;
    }
    else if (m_HomebindTimer > 0)
    {
        if (time >= m_HomebindTimer)
        {
            // teleport to nearest graveyard
            RepopAtGraveyard();
        }
        else
            m_HomebindTimer -= time;
    }
    else
    {
        // instance is invalid, start homebind timer
        m_HomebindTimer = 60000;
        // send message to player
        WorldPacket data(SMSG_RAID_GROUP_ONLY, 4 + 4);
        data << uint32(m_HomebindTimer);
        data << uint32(1);
        GetSession()->SendPacket(&data);
        LOG_DEBUG(
            "maps",
            "PLAYER: Player '{}' ({}) will be teleported to homebind in 60 "
            "seconds",
            GetName(), GetGUID().ToString());
    }
}

void Player::UpdatePvPState()
{
    UpdateFFAPvPState();

    if (pvpInfo.IsHostile) // in hostile area
    {
        if (!IsPvP() || pvpInfo.EndTimer != 0)
            UpdatePvP(true, true);
    }
    else // in friendly area
    {
        if (IsPvP() && !HasPlayerFlag(PLAYER_FLAGS_IN_PVP) &&
            pvpInfo.EndTimer == 0)
            pvpInfo.EndTimer = GameTime::GetGameTime().count(); // start toggle-off
    }
}

void Player::UpdateFFAPvPState(bool reset /*= true*/)
{
    /// @todo: should we always synchronize UNIT_FIELD_BYTES_2, 1 of controller
    // and controlled? no, we shouldn't, those are checked for affecting player
    // by client
    if (!pvpInfo.IsInNoPvPArea && !IsGameMaster() &&
        (pvpInfo.IsInFFAPvPArea || sWorld->IsFFAPvPRealm()))
    {
        if (!IsFFAPvP())
        {
            sScriptMgr->OnFfaPvpStateUpdate(this, true);
            SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
            for (ControlSet::iterator itr = m_Controlled.begin();
                 itr != m_Controlled.end(); ++itr)
                (*itr)->SetByteValue(UNIT_FIELD_BYTES_2, 1,
                                     UNIT_BYTE2_FLAG_FFA_PVP);
        }

        if (pvpInfo.IsInFFAPvPArea)
        {
            pvpInfo.FFAPvPEndTimer = time_t(0);
        }
    }
    else if (IsFFAPvP())
    {
        if ((pvpInfo.IsInNoPvPArea || IsGameMaster()) || reset ||
            !pvpInfo.EndTimer)
        {
            pvpInfo.FFAPvPEndTimer = time_t(0);
            if (HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
            {
                RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
                sScriptMgr->OnFfaPvpStateUpdate(this, false);
            }
            for (ControlSet::iterator itr = m_Controlled.begin();
                 itr != m_Controlled.end(); ++itr)
                (*itr)->RemoveByteFlag(UNIT_FIELD_BYTES_2, 1,
                                       UNIT_BYTE2_FLAG_FFA_PVP);

            // xinef: iterate attackers
            AttackerSet        toRemove;
            AttackerSet const& attackers = getAttackers();
            for (AttackerSet::const_iterator itr = attackers.begin();
                 itr != attackers.end(); ++itr)
                if (!(*itr)->IsValidAttackTarget(this))
                    toRemove.insert(*itr);

            for (AttackerSet::const_iterator itr = toRemove.begin();
                 itr != toRemove.end(); ++itr)
                (*itr)->AttackStop();

            // xinef: remove our own victim
            if (Unit* victim = GetVictim())
                if (!IsValidAttackTarget(victim))
                    AttackStop();
        }
        else
        {
            // Not in FFA PvP Area
            // Not FFA PvP realm
            // Not FFA PvP timer already set
            // Being recently in PvP combat
            if (!pvpInfo.IsInFFAPvPArea && !sWorld->IsFFAPvPRealm() &&
                !pvpInfo.FFAPvPEndTimer)
            {
                pvpInfo.FFAPvPEndTimer =
                    GameTime::GetGameTime().count() +
                    sWorld->getIntConfig(CONFIG_FFA_PVP_TIMER);
            }
        }
    }
}

void Player::UpdatePvP(bool state, bool _override)
{
    if (!state || _override)
    {
        SetPvP(state);
        pvpInfo.EndTimer = 0;
    }
    else
    {
        pvpInfo.EndTimer = GameTime::GetGameTime().count();
        SetPvP(state);
    }

    //npcbot: update pvp flags for bots
    if (HaveBot())
        _botMgr->UpdatePvPForBots();
    //end npcbot

    RemovePlayerFlag(PLAYER_FLAGS_PVP_TIMER);
    sScriptMgr->OnPlayerPVPFlagChange(this, state);
}

void Player::UpdatePotionCooldown(Spell* spell)
{
    // no potion used i combat or still in combat
    if (!GetLastPotionId() || IsInCombat())
        return;

    // Call not from spell cast, send cooldown event for item spells if no in
    // combat
    if (!spell)
    {
        // spell/item pair let set proper cooldown (except not existed charged
        // spell cooldown spellmods for potions)
        if (ItemTemplate const* proto =
                sObjectMgr->GetItemTemplate(GetLastPotionId()))
            for (uint8 idx = 0; idx < MAX_ITEM_SPELLS; ++idx)
                if (proto->Spells[idx].SpellId &&
                    proto->Spells[idx].SpellTrigger == ITEM_SPELLTRIGGER_ON_USE)
                    if (SpellInfo const* spellInfo =
                            sSpellMgr->GetSpellInfo(proto->Spells[idx].SpellId))
                        SendCooldownEvent(spellInfo, GetLastPotionId());
    }
    // from spell cases (m_lastPotionId set in Spell::SendSpellCooldown)
    else
    {
        if (spell->IsIgnoringCooldowns())
            return;

        SendCooldownEvent(spell->m_spellInfo, m_lastPotionId, spell);
    }

    SetLastPotionId(0);
}

template void Player::UpdateVisibilityOf(Player* target, UpdateData& data,
                                         std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(Creature* target, UpdateData& data,
                                         std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(Corpse* target, UpdateData& data,
                                         std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(GameObject* target, UpdateData& data,
                                         std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(DynamicObject*      target,
                                         UpdateData&         data,
                                         std::vector<Unit*>& visibleNow);

void Player::UpdateVisibilityForPlayer(bool mapChange)
{
    // After added to map seer must be a player - there is no possibility to
    // still have different seer (all charm auras must be already removed)
    if (mapChange && m_seer != this)
    {
        m_seer = this;
    }

    Acore::VisibleNotifier notifierNoLarge(
        *this, mapChange,
        false); // visit only objects which are not large; default distance
    Cell::VisitAllObjects(m_seer, notifierNoLarge,
                          GetSightRange() + VISIBILITY_INC_FOR_GOBJECTS);
    notifierNoLarge.SendToSelf();

    Acore::VisibleNotifier notifierLarge(
        *this, mapChange, true); // visit only large objects; maximum distance
    Cell::VisitAllObjects(m_seer, notifierLarge, GetSightRange());
    notifierLarge.SendToSelf();

    if (mapChange)
        m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f, 0.0f);
}

void Player::UpdateObjectVisibility(bool forced, bool fromUpdate)
{
    // Prevent updating visibility if player is not in world (example: LoadFromDB sets drunkstate which updates invisibility while player is not in map)
    if (!IsInWorld())
        return;

    if (!forced)
        AddToNotify(NOTIFY_VISIBILITY_CHANGED);
    else if (!isBeingLoaded())
    {
        if (!fromUpdate) // pussywizard:
        {
            bRequestForcedVisibilityUpdate = true;
            return;
        }
        Unit::UpdateObjectVisibility(true);
        UpdateVisibilityForPlayer();
    }
}

template <class T>
inline void UpdateVisibilityOf_helper(GuidUnorderedSet& s64, T* target,
                                      std::vector<Unit*>& /*v*/)
{
    s64.insert(target->GetGUID());
}

template <>
inline void UpdateVisibilityOf_helper(GuidUnorderedSet& s64, GameObject* target,
                                      std::vector<Unit*>& /*v*/)
{
    // @HACK: This is to prevent objects like deeprun tram from disappearing
    // when player moves far from its spawn point while riding it
    if ((target->GetGOInfo()->type != GAMEOBJECT_TYPE_TRANSPORT))
        s64.insert(target->GetGUID());
}

template <>
inline void UpdateVisibilityOf_helper(GuidUnorderedSet& s64, Creature* target,
                                      std::vector<Unit*>& v)
{
    s64.insert(target->GetGUID());
    v.push_back(target);
}

template <>
inline void UpdateVisibilityOf_helper(GuidUnorderedSet& s64, Player* target,
                                      std::vector<Unit*>& v)
{
    s64.insert(target->GetGUID());
    v.push_back(target);
}

template <class T>
inline void BeforeVisibilityDestroy(T* /*t*/, Player* /*p*/)
{
}

template <>
inline void BeforeVisibilityDestroy<Creature>(Creature* t, Player* p)
{
    if (p->GetPetGUID() == t->GetGUID() && t->IsPet())
        ((Pet*) t)->Remove(PET_SAVE_NOT_IN_SLOT, true);
}

template <class T>
void Player::UpdateVisibilityOf(T* target, UpdateData& data,
                                std::vector<Unit*>& visibleNow)
{
    if (HaveAtClient(target))
    {
        if (!CanSeeOrDetect(target, false, true))
        {
            BeforeVisibilityDestroy<T>(target, this);

            target->BuildOutOfRangeUpdateBlock(&data);
            m_clientGUIDs.erase(target->GetGUID());
        }
    }
    else
    {
        if (CanSeeOrDetect(target, false, true))
        {
            target->BuildCreateUpdateBlockForPlayer(&data, this);
            UpdateVisibilityOf_helper(m_clientGUIDs, target, visibleNow);
        }
    }
}

void Player::GetInitialVisiblePackets(Unit* target)
{
    GetAurasForTarget(target);
    if (target->IsAlive())
    {
        if (target->HasUnitState(UNIT_STATE_MELEE_ATTACKING) &&
            target->GetVictim())
            target->SendMeleeAttackStart(target->GetVictim(), this);
    }
}

void Player::UpdateVisibilityOf(WorldObject* target)
{
    if (HaveAtClient(target))
    {
        if (!CanSeeOrDetect(target, false, true))
        {
            if (target->GetTypeId() == TYPEID_UNIT)
                BeforeVisibilityDestroy<Creature>(target->ToCreature(), this);

            target->DestroyForPlayer(this);
            m_clientGUIDs.erase(target->GetGUID());
        }
    }
    else
    {
        if (CanSeeOrDetect(target, false, true))
        {
            target->SendUpdateToPlayer(this);
            m_clientGUIDs.insert(target->GetGUID());

            // target aura duration for caster show only if target exist at
            // caster client send data at target visibility change (adding to
            // client)
            if (target->isType(TYPEMASK_UNIT))
                GetInitialVisiblePackets((Unit*) target);
        }
    }
}

void Player::UpdateTriggerVisibility()
{
    if (m_clientGUIDs.empty())
        return;

    if (!IsInWorld())
        return;

    UpdateData  udata;
    WorldPacket packet;
    for (GuidUnorderedSet::iterator itr = m_clientGUIDs.begin();
         itr != m_clientGUIDs.end(); ++itr)
    {
        if ((*itr).IsCreatureOrVehicle())
        {
            Creature* creature = GetMap()->GetCreature(*itr);
            // Update fields of triggers, transformed units or unselectable
            // units (values dependent on GM state)
            if (!creature || (!creature->IsTrigger() &&
                              !creature->HasAuraType(SPELL_AURA_TRANSFORM) &&
                              !creature->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE)))
                continue;

            creature->SetFieldNotifyFlag(UF_FLAG_PUBLIC);
            creature->BuildValuesUpdateBlockForPlayer(&udata, this);
            creature->RemoveFieldNotifyFlag(UF_FLAG_PUBLIC);
        }
        else if ((*itr).IsGameObject())
        {
            GameObject* go = GetMap()->GetGameObject(*itr);
            if (!go)
                continue;

            go->SetFieldNotifyFlag(UF_FLAG_PUBLIC);
            go->BuildValuesUpdateBlockForPlayer(&udata, this);
            go->RemoveFieldNotifyFlag(UF_FLAG_PUBLIC);
        }
    }

    if (!udata.HasData())
        return;

    udata.BuildPacket(packet);
    GetSession()->SendPacket(&packet);
}

void Player::UpdateForQuestWorldObjects()
{
    if (m_clientGUIDs.empty())
        return;

    UpdateData  udata;
    WorldPacket packet;
    for (GuidUnorderedSet::iterator itr = m_clientGUIDs.begin(); itr != m_clientGUIDs.end(); ++itr)
    {
        if ((*itr).IsGameObject())
        {
            if (GameObject* obj = ObjectAccessor::GetGameObject(*this, *itr))
                obj->BuildValuesUpdateBlockForPlayer(&udata, this);
        }
        else if ((*itr).IsCreatureOrVehicle())
        {
            Creature* obj = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, *itr);
            if (!obj)
                continue;

            // check if this unit requires quest specific flags
            if (obj->HasNpcFlag(UNIT_NPC_FLAG_SPELLCLICK))
            {
                SpellClickInfoMapBounds clickPair = sObjectMgr->GetSpellClickInfoMapBounds(obj->GetEntry());
                for (SpellClickInfoContainer::const_iterator _itr = clickPair.first; _itr != clickPair.second; ++_itr)
                {
                    //! This code doesn't look right, but it was logically converted to condition system to do the exact
                    //! same thing it did before. It definitely needs to be overlooked for intended functionality.
                    ConditionList conds = sConditionMgr->GetConditionsForSpellClickEvent(obj->GetEntry(), _itr->second.spellId);
                    bool buildUpdateBlock = false;
                    for (ConditionList::const_iterator jtr = conds.begin(); jtr != conds.end() && !buildUpdateBlock; ++jtr)
                        if ((*jtr)->ConditionType == CONDITION_QUESTREWARDED || (*jtr)->ConditionType == CONDITION_QUESTTAKEN)
                            buildUpdateBlock = true;

                    if (buildUpdateBlock)
                    {
                        obj->BuildValuesUpdateBlockForPlayer(&udata, this);
                        break;
                    }
                }
            }
            else if (obj->HasNpcFlag(UNIT_NPC_FLAG_VENDOR_MASK | UNIT_NPC_FLAG_TRAINER))
            {
                obj->BuildValuesUpdateBlockForPlayer(&udata, this);
            }
        }
    }

    udata.BuildPacket(packet);
    GetSession()->SendPacket(&packet);
}

void Player::UpdateTitansGrip()
{
    // 10% damage reduce if 2x2h weapons are used
    if (!CanTitanGrip())
        RemoveAurasDueToSpell(49152);
    else if (Aura* aur = GetAura(49152))
        aur->RecalculateAmountOfEffects();
}

void Player::UpdateZoneDependentAuras(uint32 newZone)
{
    // Some spells applied at enter into zone (with subzones), aura removed in
    // UpdateAreaDependentAuras that called always at zone->area update
    SpellAreaForAreaMapBounds saBounds =
        sSpellMgr->GetSpellAreaForAreaMapBounds(newZone);
    for (SpellAreaForAreaMap::const_iterator itr = saBounds.first;
         itr != saBounds.second; ++itr)
        if (itr->second->autocast &&
            itr->second->IsFitToRequirements(this, newZone, 0))
            if (!HasAura(itr->second->spellId))
                CastSpell(this, itr->second->spellId, true);
}

void Player::UpdateAreaDependentAuras(uint32 newArea)
{
    // remove auras from spells with area limitations
    for (AuraMap::iterator iter = m_ownedAuras.begin();
         iter != m_ownedAuras.end();)
    {
        // use m_zoneUpdateId for speed: UpdateArea called from UpdateZone or
        // instead UpdateZone in both cases m_zoneUpdateId up-to-date
        if (iter->second->GetSpellInfo()->CheckLocation(
                GetMapId(), m_zoneUpdateId, newArea, this, false) !=
            SPELL_CAST_OK)
            RemoveOwnedAura(iter);
        else
            ++iter;
    }

    // Xinef: check controlled auras
    if (!m_Controlled.empty())
        for (ControlSet::iterator itr = m_Controlled.begin();
             itr != m_Controlled.end();)
        {
            Unit* controlled = *itr;
            ++itr;
            if (controlled && !controlled->IsPet())
            {
                Unit::AuraMap& tAuras = controlled->GetOwnedAuras();
                for (Unit::AuraMap::iterator auraIter = tAuras.begin();
                     auraIter != tAuras.end();)
                {
                    if (auraIter->second->GetSpellInfo()->CheckLocation(
                            GetMapId(), m_zoneUpdateId, newArea, nullptr) !=
                        SPELL_CAST_OK)
                        controlled->RemoveOwnedAura(auraIter);
                    else
                        ++auraIter;
                }
            }
        }

    // some auras applied at subzone enter
    SpellAreaForAreaMapBounds saBounds =
        sSpellMgr->GetSpellAreaForAreaMapBounds(newArea);
    for (SpellAreaForAreaMap::const_iterator itr = saBounds.first;
         itr != saBounds.second; ++itr)
        if (itr->second->autocast &&
            itr->second->IsFitToRequirements(this, m_zoneUpdateId, newArea))
            if (!HasAura(itr->second->spellId))
                CastSpell(this, itr->second->spellId, true);

    if (newArea == 4273 && GetVehicle() && GetPositionX() > 400) // Ulduar
    {
        switch (GetVehicleBase()->GetEntry())
        {
        case 33062:
        case 33109:
        case 33060:
            GetVehicle()->Dismiss();
            break;
        }
    }
}

void Player::UpdateCorpseReclaimDelay()
{
    bool pvp = m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH;

    if ((pvp &&
         !sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP)) ||
        (!pvp && !sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE)))
        return;

    time_t now = GameTime::GetGameTime().count();

    if (now < m_deathExpireTime)
    {
        // full and partly periods 1..3
        uint64 count = (m_deathExpireTime - now) / DEATH_EXPIRE_STEP + 1;

        if (count < MAX_DEATH_COUNT)
            m_deathExpireTime = now + (count + 1) * DEATH_EXPIRE_STEP;
        else
            m_deathExpireTime = now + MAX_DEATH_COUNT * DEATH_EXPIRE_STEP;
    }
    else
        m_deathExpireTime = now + DEATH_EXPIRE_STEP;
}

void Player::UpdateCharmedAI()
{
    // Xinef: maybe passed as argument?
    Unit*      charmer   = GetCharmer();
    CharmInfo* charmInfo = GetCharmInfo();

    // Xinef: needs more thinking, maybe kill player?
    if (!charmer || !charmInfo)
        return;

    // Xinef: we should be killed if caster enters evade mode and charm is
    // infinite
    if (charmer->GetTypeId() == TYPEID_UNIT &&
        charmer->ToCreature()->IsInEvadeMode())
    {
        AuraEffectList const& auras =
            GetAuraEffectsByType(SPELL_AURA_MOD_CHARM);
        for (AuraEffectList::const_iterator iter = auras.begin();
             iter != auras.end(); ++iter)
            if ((*iter)->GetCasterGUID() == charmer->GetGUID() &&
                (*iter)->GetBase()->IsPermanent())
            {
                Unit::DealDamage(charmer, this, GetHealth(), nullptr,
                                 DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL,
                                 nullptr, false);
                return;
            }
    }

    Unit* target = GetVictim();
    if (target)
    {
        SetInFront(target);
        SendMovementFlagUpdate(true);
    }

    if (HasUnitState(UNIT_STATE_CASTING))
        return;

    bool Mages =
        getClassMask() & (1 << (CLASS_MAGE - 1) | 1 << (CLASS_WARLOCK - 1) |
                          1 << (CLASS_DRUID - 1) | 1 << (CLASS_HUNTER - 1) |
                          1 << (CLASS_PRIEST - 1));

    // Xinef: charmer type specific actions
    if (charmer->GetTypeId() == TYPEID_PLAYER)
    {
        bool follow = false;
        if (!target)
        {
            if (charmInfo->GetPlayerReactState() == REACT_PASSIVE)
                follow = true;
            else if (charmInfo->GetPlayerReactState() == REACT_DEFENSIVE)
            {
                if (charmer->GetVictim())
                    target = charmer->GetVictim();
                else
                    follow = true;
            }

            if (follow)
            {
                if (!HasUnitState(UNIT_STATE_FOLLOW))
                    GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST,
                                                  PET_FOLLOW_ANGLE);
                return;
            }
        }
        else if (target &&
                 GetMotionMaster()->GetCurrentMovementGeneratorType() !=
                     CHASE_MOTION_TYPE)
            GetMotionMaster()->MoveChase(target, Mages ? 15 : 4);
    }

    if (!target || !IsValidAttackTarget(target))
    {
        target = SelectNearbyTarget(nullptr, GetMap()->IsDungeon() ? 100.f : 30.f);
        if (!target)
        {
            if (!HasUnitState(UNIT_STATE_FOLLOW))
                GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST,
                                              PET_FOLLOW_ANGLE);

            return;
        }

        GetMotionMaster()->MoveChase(target, Mages ? 15 : 4);
        Attack(target, true);
    }
    else
    {
        float Distance = GetDistance(target);
        uint8 rnd      = urand(0, 1);

        if (Mages)
        {
            if ((GetPower(POWER_MANA) * 100 / GetMaxPower(POWER_MANA)) < 10)
            {
                GetMotionMaster()->MoveChase(target, 4);
                return;
            }

            if (Distance <= 3)
            {
                if (urand(0, 1))
                {
                    if (m_charmAISpells[SPELL_T_STUN] &&
                        !HasSpellCooldown(m_charmAISpells[SPELL_T_STUN]))
                        CastSpell(target, m_charmAISpells[SPELL_T_STUN], false);
                    else if (m_charmAISpells[SPELL_ROOT_OR_FEAR] &&
                             !HasSpellCooldown(
                                 m_charmAISpells[SPELL_ROOT_OR_FEAR]))
                        CastSpell(target, m_charmAISpells[SPELL_ROOT_OR_FEAR],
                                  false);
                    else if (m_charmAISpells[SPELL_IMMUNITY] &&
                             !HasSpellCooldown(m_charmAISpells[SPELL_IMMUNITY]))
                        CastSpell(this, m_charmAISpells[SPELL_IMMUNITY], true);
                }
                else
                {
                    switch (urand(0, 1))
                    {
                    case 0:
                        if (m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd] &&
                            !HasSpellCooldown(
                                m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd]))
                            CastSpell(
                                target,
                                m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd],
                                false);
                        break;
                    case 1:
                        if (m_charmAISpells[SPELL_DOT_DAMAGE] &&
                            !HasSpellCooldown(
                                m_charmAISpells[SPELL_DOT_DAMAGE]))
                            CastSpell(target, m_charmAISpells[SPELL_DOT_DAMAGE],
                                      false);
                        break;
                    }
                }
            }
            else
            {
                switch (urand(0, 2))
                {
                case 0:
                    if (m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd] &&
                        !HasSpellCooldown(
                            m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd]))
                        CastSpell(target,
                                  m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd],
                                  false);
                    break;
                case 1:
                    if (m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd] &&
                        !HasSpellCooldown(
                            m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd]))
                        CastSpell(target,
                                  m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd],
                                  false);
                    break;
                case 2:
                    if (m_charmAISpells[SPELL_DOT_DAMAGE] &&
                        !HasSpellCooldown(m_charmAISpells[SPELL_DOT_DAMAGE]))
                        CastSpell(target, m_charmAISpells[SPELL_DOT_DAMAGE],
                                  false);
                    break;
                }
            }
        }
        else
        {
            if (Distance > 10)
            {
                GetMotionMaster()->MoveChase(target, 2.0f);
                if (m_charmAISpells[SPELL_T_CHARGE] &&
                    !HasSpellCooldown(m_charmAISpells[SPELL_T_CHARGE]))
                    CastSpell(target, m_charmAISpells[SPELL_T_CHARGE], false);
                else if (m_charmAISpells[SPELL_FAST_RUN] &&
                         !HasSpellCooldown(m_charmAISpells[SPELL_FAST_RUN]))
                    CastSpell(this, m_charmAISpells[SPELL_FAST_RUN], false);
            }

            if (HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (urand(0, 2))
            {
            case 0:
                if (m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd] &&
                    !HasSpellCooldown(
                        m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd]))
                    CastSpell(target,
                              m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd],
                              false);
                break;
            case 1:
                if (m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd] &&
                    !HasSpellCooldown(
                        m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd]))
                    CastSpell(target, m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd],
                              false);
                break;
            case 2:
                if (m_charmAISpells[SPELL_DOT_DAMAGE] &&
                    !HasSpellCooldown(m_charmAISpells[SPELL_DOT_DAMAGE]))
                    CastSpell(target, m_charmAISpells[SPELL_DOT_DAMAGE], false);
                break;
            }
        }
    }
}

void Player::UpdateLootAchievements(LootItem* item, Loot* loot)
{
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM, item->itemid,
                              item->count);
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE,
                              loot->loot_type, item->count);
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_EPIC_ITEM,
                              item->itemid, item->count);
}

void Player::UpdateAchievementCriteria(AchievementCriteriaTypes type,
                                       uint32                   miscValue1 /*= 0*/,
                                       uint32                   miscValue2 /*= 0*/,
                                       Unit*                    unit /*= nullptr*/)
{
    m_achievementMgr->UpdateAchievementCriteria(type, miscValue1, miscValue2,
                                                unit);
}

void Player::UpdateFallInformationIfNeed(MovementInfo const& minfo,
                                         uint16              opcode)
{
    if (m_lastFallTime >= minfo.fallTime ||
        m_lastFallZ <= minfo.pos.GetPositionZ() || opcode == MSG_MOVE_FALL_LAND)
        SetFallInformation(minfo.fallTime, minfo.pos.GetPositionZ());
}

void Player::UpdateSpecCount(uint8 count)
{
    uint32 curCount = GetSpecsCount();
    if (curCount == count)
        return;

    if (m_activeSpec >= count)
        ActivateSpec(0);

    CharacterDatabaseTransaction        trans = CharacterDatabase.BeginTransaction();
    CharacterDatabasePreparedStatement* stmt  = nullptr;

    // Copy spec data
    if (count > curCount)
    {
        _SaveActions(trans); // make sure the button list is cleaned up
        for (ActionButtonList::iterator itr = m_actionButtons.begin();
             itr != m_actionButtons.end(); ++itr)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_ACTION);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, 1);
            stmt->SetData(2, itr->first);
            stmt->SetData(3, itr->second.GetAction());
            stmt->SetData(4, uint8(itr->second.GetType()));
            trans->Append(stmt);
        }
    }
    // Delete spec data for removed spec.
    else if (count < curCount)
    {
        _SaveActions(trans);

        stmt = CharacterDatabase.GetPreparedStatement(
            CHAR_DEL_CHAR_ACTION_EXCEPT_SPEC);
        stmt->SetData(0, m_activeSpec);
        stmt->SetData(1, GetGUID().GetCounter());
        trans->Append(stmt);

        m_activeSpec = 0;
    }

    CharacterDatabase.CommitTransaction(trans);

    SetSpecsCount(count);

    SendTalentsInfoData(false);
}

void Player::SendUpdateWorldState(uint32 variable, uint32 value) const
{
    WorldPackets::WorldState::UpdateWorldState worldstate;
    worldstate.VariableID = variable;
    worldstate.Value = value;
    SendDirectMessage(worldstate.Write());
}

void Player::ProcessTerrainStatusUpdate()
{
    // process liquid auras using generic unit code
    Unit::ProcessTerrainStatusUpdate();

    LiquidData const& liquidData = GetLiquidData();

    // player specific logic for mirror timers
    if (liquidData.Status != LIQUID_MAP_NO_WATER)
    {
        // Breath bar state (under water in any liquid type)
        if ((liquidData.Flags & MAP_ALL_LIQUIDS) != 0)
        {
            if ((liquidData.Status & LIQUID_MAP_UNDER_WATER) != 0)
                m_MirrorTimerFlags |= UNDERWATER_INWATER;
            else
                m_MirrorTimerFlags &= ~UNDERWATER_INWATER;
        }

        // Fatigue bar state (if not on flight path or transport)
        if ((liquidData.Flags & MAP_LIQUID_TYPE_DARK_WATER) && !IsInFlight() && !GetTransport())
        {
            // Exclude also uncontrollable vehicles
            Vehicle*                vehicle     = GetVehicle();
            VehicleSeatEntry const* vehicleSeat = vehicle ? vehicle->GetSeatForPassenger(this) : nullptr;
            if (!vehicleSeat || vehicleSeat->CanControl())
                m_MirrorTimerFlags |= UNDERWATER_INDARKWATER;
            else
                m_MirrorTimerFlags &= ~UNDERWATER_INDARKWATER;
        }
        else
            m_MirrorTimerFlags &= ~UNDERWATER_INDARKWATER;

        // Lava state (any contact)
        if (liquidData.Flags & MAP_LIQUID_TYPE_MAGMA)
        {
            if (liquidData.Status & MAP_LIQUID_STATUS_IN_CONTACT)
                m_MirrorTimerFlags |= UNDERWATER_INLAVA;
            else
                m_MirrorTimerFlags &= ~UNDERWATER_INLAVA;
        }

        // Slime state (any contact)
        if (liquidData.Flags & MAP_LIQUID_TYPE_SLIME)
        {
            if (liquidData.Status & MAP_LIQUID_STATUS_IN_CONTACT)
                m_MirrorTimerFlags |= UNDERWATER_INSLIME;
            else
                m_MirrorTimerFlags &= ~UNDERWATER_INSLIME;
        }
    }
    else
        m_MirrorTimerFlags &= ~(UNDERWATER_INWATER | UNDERWATER_INLAVA | UNDERWATER_INSLIME | UNDERWATER_INDARKWATER);
}
