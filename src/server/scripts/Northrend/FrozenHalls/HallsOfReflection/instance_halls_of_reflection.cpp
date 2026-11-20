/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Transport.h"
#include "TransportMgr.h"
#include "WorldStateDefines.h"
#include "halls_of_reflection.h"
#include <algorithm>
#include <cstring>
#include <iterator>

enum UtherBatteredHiltSteps
{
    UTHER_STEP_APPEAR = 1,
    UTHER_STEP_HALT,
    UTHER_STEP_SUMMON_QUEL,
    UTHER_STEP_MOVE_ASIDE,
    UTHER_STEP_KNEEL,
    UTHER_STEP_QUEL_LAND,
    UTHER_STEP_QUEL_PREPARE,
    UTHER_STEP_QUEL_ATTACK,
    UTHER_STEP_OUTRO_1,
    UTHER_STEP_OUTRO_2,
    UTHER_STEP_OUTRO_3,
    UTHER_STEP_OUTRO_4,
    UTHER_STEP_HOLY_LIGHT,
    UTHER_STEP_DESPAWN
};

enum WaveResumeSteps
{
    WAVE_RESUME_NONE,
    WAVE_RESUME_SHOW_BOSSES,
    WAVE_RESUME_SHOW_TRASH,
    WAVE_RESUME_HIDE_ALL
};

enum LichKingOutroSteps
{
    OUTRO_NONE,
    OUTRO_HARVEST_SOUL,
    OUTRO_SUMMON_GUNSHIP,
    OUTRO_GUNSHIP_FIRE,
    OUTRO_CAVE_IN,
    OUTRO_HIDE_LICH_KING,
    OUTRO_GUNSHIP_MOVE,
    OUTRO_SUMMON_STAIRS,
    OUTRO_BOARD_GUNSHIP,
    OUTRO_LEADER_FINAL,
    OUTRO_QUEST_CREDIT,
    OUTRO_QUEST_GIVER,
    OUTRO_FINISH
};

class UtherBatteredHiltEvent : public BasicEvent
{
public:
    UtherBatteredHiltEvent(Creature& owner, uint8 eventId) : _owner(owner), _eventId(eventId) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        switch (_eventId)
        {
            case UTHER_STEP_APPEAR:
                _owner.UpdatePosition(5300.53f, 1987.80f, 707.70f, 3.89f, true);
                _owner.StopMovingOnCurrentPos();
                _owner.GetMotionMaster()->Clear();
                _owner.SetVisible(true);
                _owner.NearTeleportTo(5300.53f, 1987.80f, 707.70f, 3.89f);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_HALT), 1s);
                break;
            case UTHER_STEP_HALT:
                _owner.AI()->Talk(SAY_BATTERED_HILT_HALT);
                break;
            case UTHER_STEP_SUMMON_QUEL:
                _owner.CastSpell((Unit*)nullptr, SPELL_SUMMON_EVIL_QUEL, true);
                _owner.AI()->Talk(SAY_BATTERED_HILT_REALIZE);
                if (InstanceScript* inst = _owner.GetInstanceScript())
                    inst->SetData(DATA_BATTERED_HILT, BATTERED_HILT_QUEL_SUMMONED);
                if (Creature* quel = _owner.FindNearestCreature(NPC_QUEL_DELAR, 50))
                    quel->AI()->Talk(EMOTE_QUEL_SPAWN);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_MOVE_ASIDE), 3500ms);
                break;
            case UTHER_STEP_MOVE_ASIDE:
                _owner.SetWalk(false);
                _owner.GetMotionMaster()->MovePoint(0, 5337.53f, 1981.21f, 709.32f);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_KNEEL), 6s);
                break;
            case UTHER_STEP_KNEEL:
                _owner.SetFacingTo(2.82f);
                _owner.SetStandState(UNIT_STAND_STATE_KNEEL);
                break;
            case UTHER_STEP_QUEL_LAND:
                if (InstanceScript* inst = _owner.GetInstanceScript())
                    inst->SetData(DATA_BATTERED_HILT, BATTERED_HILT_QUEL_LAND);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_QUEL_PREPARE), 2s);
                break;
            case UTHER_STEP_QUEL_PREPARE:
                if (InstanceScript* inst = _owner.GetInstanceScript())
                    inst->SetData(DATA_BATTERED_HILT, BATTERED_HILT_QUEL_PREPARE);
                if (Creature* quel = _owner.FindNearestCreature(NPC_QUEL_DELAR, 50))
                    quel->AI()->Talk(EMOTE_QUEL_PREPARE);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_QUEL_ATTACK), 4s);
                break;
            case UTHER_STEP_QUEL_ATTACK:
                _owner.SetReactState(REACT_AGGRESSIVE);
                _owner.SetImmuneToAll(false);
                if (InstanceScript* inst = _owner.GetInstanceScript())
                    inst->SetData(DATA_BATTERED_HILT, BATTERED_HILT_QUEL_ATTACK);
                break;
            case UTHER_STEP_OUTRO_1:
                _owner.AI()->Talk(SAY_BATTERED_HILT_OUTRO1);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_OUTRO_2), 11s);
                break;
            case UTHER_STEP_OUTRO_2:
                _owner.AI()->Talk(SAY_BATTERED_HILT_OUTRO2);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_OUTRO_3), 7500ms);
                break;
            case UTHER_STEP_OUTRO_3:
                _owner.AI()->Talk(SAY_BATTERED_HILT_OUTRO3);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_OUTRO_4), 8s);
                break;
            case UTHER_STEP_OUTRO_4:
                _owner.AI()->Talk(SAY_BATTERED_HILT_OUTRO4);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_HOLY_LIGHT), 5s);
                break;
            case UTHER_STEP_HOLY_LIGHT:
                _owner.CastSpell((Unit*)nullptr, SPELL_UTHER_HOLY_LIGHT_VISUAL, true);
                _owner.m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(_owner, UTHER_STEP_DESPAWN), 3s);
                break;
            case UTHER_STEP_DESPAWN:
            {
                Position homePos = _owner.GetHomePosition();
                _owner.SetReactState(REACT_PASSIVE);
                _owner.SetImmuneToAll(true);
                _owner.SetVisible(false);
                _owner.UpdatePosition(homePos.GetPositionX(), homePos.GetPositionY(), homePos.GetPositionZ(), homePos.GetOrientation(), true);
                _owner.StopMovingOnCurrentPos();
                _owner.GetMotionMaster()->Clear();
                if (InstanceScript* inst = _owner.GetInstanceScript())
                    inst->SetData(DATA_BATTERED_HILT, BATTERED_HILT_FINISHED);
                break;
            }
            default:
                break;
        }
        return true;
    }

private:
    Creature& _owner;
    uint8 _eventId;
};

ObjectData const creatureData[] =
{
    { NPC_FALRIC,                      DATA_FALRIC                      },
    { NPC_MARWYN,                      DATA_MARWYN                      },
    { NPC_SYLVANAS_PART1,              DATA_SYLVANAS_PART1              },
    { NPC_DARK_RANGER_LORALEN,         DATA_DARK_RANGER_LORALEN         },
    { NPC_UTHER,                       DATA_UTHER                       },
    { NPC_LICH_KING_EVENT,             DATA_LICH_KING_EVENT             },
    { NPC_FROSTSWORN_GENERAL,          DATA_FROSTSWORN_GENERAL          },
    { NPC_LICH_KING_BOSS,              DATA_LICH_KING                   },
    { NPC_SYLVANAS_PART2,              DATA_SYLVANAS_PART2              },
    { NPC_ALTAR_BUNNY,                 DATA_ALTAR_BUNNY                 },
    { NPC_HIGH_CAPTAIN_JUSTIN_BARLETT, DATA_SHIP_CAPTAIN                },
    { NPC_SKY_REAVER_KORM_BLACKSKAR,   DATA_SHIP_CAPTAIN                },
    { 0,                               0                                }
};

ObjectData const gameObjectData[] =
{
    { GO_FROSTMOURNE,        DATA_FROSTMOURNE        },
    { GO_FROSTMOURNE_ALTAR,  DATA_FROSTMOURNE_ALTAR  },
    { GO_FRONT_DOOR,         DATA_FRONT_DOOR         },
    { GO_ARTHAS_DOOR,        DATA_ARTHAS_DOOR        },
    { GO_CAVE_IN,            DATA_CAVE_IN            },
    { GO_DOOR_BEFORE_THRONE, DATA_DOOR_BEFORE_THRONE },
    { GO_DOOR_AFTER_THRONE,  DATA_DOOR_AFTER_THRONE  },
    { GO_ICE_WALL,           DATA_ICE_WALL           },
    { 0,                     0                       }
};

class instance_halls_of_reflection : public InstanceScript
{
public:
    instance_halls_of_reflection(Map* map) : InstanceScript(map)
    {
        SetHeaders(DataHeader);
        SetBossNumber(MAX_ENCOUNTER);
        SetPersistentDataCount(PERSISTENT_DATA_COUNT);
        LoadObjectData(creatureData, gameObjectData);
    }

    void Initialize() override
    {
        std::fill(std::begin(_trashActive), std::end(_trashActive), false);
        _trashCounter = 0;
        std::memset(&_chosenComposition, 0, sizeof(_chosenComposition));
        _waveNumber = 0;
        _nextWaveTimer = 0;
        _playerCheckTimer = 5000;
        _waveResumeTimer = 0;
        _waveResumeStep = WAVE_RESUME_NONE;
        _falricPhaseComplete = false;
        _remainingTrashKills = 0;
        _isLichKingFightActive = false;
        _batteredHiltStatus = 0;
        _outroTimer = 0;
        _outroStep = OUTRO_NONE;
        _gunshipGuid.Clear();
    }

    bool IsEncounterInProgress() const override
    {
        return (instance->HavePlayers() && _waveNumber) || _isLichKingFightActive;
    }

    void OnCreatureCreate(Creature* creature) override
    {
        InstanceScript::OnCreatureCreate(creature);

        switch (creature->GetEntry())
        {
            case NPC_SYLVANAS_PART1:
                creature->SetVisible(false);
                creature->SetSpeed(MOVE_RUN, 1.1f);
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    creature->UpdateEntry(NPC_JAINA_PART1);
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                creature->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                break;
            case NPC_DARK_RANGER_LORALEN:
                creature->SetVisible(false);
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    creature->UpdateEntry(NPC_ARCHMAGE_KORELN);
                break;
            case NPC_UTHER:
                creature->SetVisible(false);
                creature->SetReactState(REACT_PASSIVE);
                break;
            case NPC_LICH_KING_EVENT:
                creature->SetVisible(false);
                creature->SetReactState(REACT_PASSIVE);
                creature->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                break;
            case NPC_FALRIC:
                creature->SetVisible(false);
                creature->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                break;
            case NPC_MARWYN:
                creature->SetVisible(false);
                creature->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                break;
            case NPC_WAVE_MERCENARY:
            case NPC_WAVE_FOOTMAN:
            case NPC_WAVE_RIFLEMAN:
            case NPC_WAVE_PRIEST:
            case NPC_WAVE_MAGE:
                if (_trashCounter < NUM_OF_TRASH)
                    _trashGUID[_trashCounter++] = creature->GetGUID();
                if (GetBossState(DATA_MARWYN) != DONE && !creature->IsAlive())
                    creature->Respawn();
                creature->SetVisible(false);
                break;
            case NPC_FROSTSWORN_GENERAL:
                if (GetBossState(DATA_MARWYN) != DONE)
                {
                    creature->SetVisible(false);
                    creature->SetReactState(REACT_PASSIVE);
                }
                break;
            case NPC_SPIRITUAL_REFLECTION:
                for (uint8 i = 0; i < MAX_SPIRITUAL_REFLECTIONS; ++i)
                    if (!_spiritualReflectionGUID[i])
                    {
                        _spiritualReflectionGUID[i] = creature->GetGUID();
                        break;
                    }
                creature->SetVisible(false);
                break;
            case NPC_LICH_KING_BOSS:
                if (!GetPersistentData(PERSISTENT_DATA_FROSTSWORN_GENERAL))
                    creature->SetVisible(false);
                if (!GetPersistentData(PERSISTENT_DATA_LK_INTRO))
                {
                    creature->SetEmoteState(EMOTE_ONESHOT_ATTACK2HTIGHT);
                    creature->CastSpell(creature, SPELL_SOUL_REAPER, true);
                }
                else if (GetBossState(DATA_LICH_KING) != DONE)
                    creature->AddAura(GetTeamIdInInstance() == TEAM_ALLIANCE ? SPELL_JAINA_ICE_PRISON : SPELL_SYLVANAS_DARK_BINDING, creature);
                else
                    creature->SetVisible(false);

                creature->SetHealth((creature->GetMaxHealth() * 3) / 4);
                creature->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                break;
            case NPC_SYLVANAS_PART2:
                if (!creature->IsAlive())
                    creature->Respawn();
                creature->SetWalk(false);
                creature->SetSheath(SHEATH_STATE_MELEE);
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    creature->UpdateEntry(NPC_JAINA_PART2);
                creature->SetHealth(creature->GetMaxHealth() / 20);
                if (!GetPersistentData(PERSISTENT_DATA_FROSTSWORN_GENERAL))
                    creature->SetVisible(false);
                if (!GetPersistentData(PERSISTENT_DATA_LK_INTRO))
                {
                    creature->SetSheath(SHEATH_STATE_MELEE);
                    creature->SetEmoteState(GetTeamIdInInstance() == TEAM_ALLIANCE ? EMOTE_ONESHOT_ATTACK2HTIGHT : EMOTE_ONESHOT_ATTACK1H);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    creature->CastSpell(creature, GetTeamIdInInstance() == TEAM_ALLIANCE ? SPELL_JAINA_ICE_BARRIER : SPELL_SYLVANAS_CLOAK_OF_DARKNESS, true);
                }
                else if (GetBossState(DATA_LICH_KING) != DONE)
                {
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    creature->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    creature->UpdatePosition(LeaderEscapePos, true);
                    creature->StopMovingOnCurrentPos();
                }
                else
                {
                    creature->UpdatePosition(PathWaypoints[PATH_WP_COUNT - 1], true);
                    creature->StopMovingOnCurrentPos();
                }
                creature->SetSheath(SHEATH_STATE_MELEE);
                creature->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                break;
            case NPC_ICE_WALL_TARGET:
                if (creature->GetPositionX() > 5525.0f)
                    _iceWallTargetGUID[0] = creature->GetGUID();
                else if (creature->GetPositionX() > 5475.0f)
                    _iceWallTargetGUID[1] = creature->GetGUID();
                else if (creature->GetPositionX() > 5400.0f)
                    _iceWallTargetGUID[2] = creature->GetGUID();
                else
                    _iceWallTargetGUID[3] = creature->GetGUID();
                break;
            case NPC_QUEL_DELAR:
                _quelDelarGuid = creature->GetGUID();
                creature->SetReactState(REACT_PASSIVE);
                break;
            default:
                break;
        }
    }

    void OnGameObjectCreate(GameObject* go) override
    {
        switch (go->GetEntry())
        {
            case GO_FROSTMOURNE:
                HandleGameObject(ObjectGuid::Empty, false, go);
                if (GetPersistentData(PERSISTENT_DATA_INTRO))
                    go->SetPhaseMask(PHASEMASK_HIDDEN, true);
                break;
            case GO_FRONT_DOOR:
                HandleGameObject(ObjectGuid::Empty, true, go);
                break;
            case GO_ARTHAS_DOOR:
                HandleGameObject(ObjectGuid::Empty, GetBossState(DATA_MARWYN) == DONE, go);
                break;
            default:
                break;
        }

        InstanceScript::OnGameObjectCreate(go);
    }

    bool SetBossState(uint32 type, EncounterState state) override
    {
        if (!InstanceScript::SetBossState(type, state))
            return false;

        switch (type)
        {
            case DATA_FALRIC:
                if (_waveNumber)
                {
                    if (state == NOT_STARTED)
                        HandleWaveWipe();
                    else if (state == DONE)
                        _nextWaveTimer = 60000;
                }
                break;
            case DATA_MARWYN:
                if (_waveNumber)
                {
                    if (state == NOT_STARTED)
                        HandleWaveWipe();
                    else if (state == DONE)
                    {
                        HandleGameObject(DATA_FRONT_DOOR, true);
                        HandleGameObject(DATA_ARTHAS_DOOR, true);
                        if (Creature* general = GetCreature(DATA_FROSTSWORN_GENERAL))
                        {
                            general->SetVisible(true);
                            general->ClearEmoteState();
                            general->SetReactState(REACT_AGGRESSIVE);
                            general->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        }
                        _waveNumber = 0;
                        DoUpdateWorldState(WORLD_STATE_HALLS_OF_REFLECTION_WAVES_ENABLED, 0);

                        instance->DoForAllPlayers([](Player* player)
                        {
                            player->CastSpell(player, player->GetTeamId() == TEAM_ALLIANCE ? SPELL_HOR_START_QUEST_ALLY : SPELL_HOR_START_QUEST_HORDE, true);
                        });
                    }
                }
                break;
            case DATA_LICH_KING:
                if (state == DONE)
                {
                    if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                        leader->setActive(false);
                    if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                    {
                        lichKing->GetThreatMgr().ClearAllThreat();
                        lichKing->CombatStop(true);
                        lichKing->setActive(false);
                    }
                    _isLichKingFightActive = false;
                    _outroStep = OUTRO_HARVEST_SOUL;
                    _outroTimer = 0;
                }
                break;
            default:
                break;
        }

        return true;
    }

    void SetData(uint32 type, uint32 data) override
    {
        switch (type)
        {
            case DATA_INTRO:
                StorePersistentData(PERSISTENT_DATA_INTRO, 1);
                StartNextWave();
                break;
            case DATA_SHOW_TRASH:
                RandomizeCompositionsAndShow();
                break;
            case DATA_FROSTSWORN_GENERAL:
                StorePersistentData(PERSISTENT_DATA_FROSTSWORN_GENERAL, 1);
                if (data == DONE)
                {
                    if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                        lichKing->SetVisible(true);
                    if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                        leader->SetVisible(true);
                }
                break;
            case DATA_SPIRITUAL_REFLECTIONS_COPY:
            {
                uint8 reflectionIdx = 0;
                instance->DoForAllPlayers([&](Player* player)
                {
                    if (reflectionIdx >= MAX_SPIRITUAL_REFLECTIONS || !player->IsAlive() || player->IsGameMaster())
                        return;
                    Creature* reflection = instance->GetCreature(_spiritualReflectionGUID[reflectionIdx++]);
                    if (!reflection)
                        return;
                    if (!reflection->IsAlive())
                        reflection->Respawn();
                    reflection->SetCanFly(true);
                    reflection->SetDisableGravity(true);
                    reflection->SetVisible(true);

                    // Virtual item slots 0-2 line up with the weapon attack types
                    for (WeaponAttackType attackType : { BASE_ATTACK, OFF_ATTACK, RANGED_ATTACK })
                    {
                        Item* weapon = player->GetWeaponForAttack(attackType);
                        reflection->SetVirtualItem(attackType, weapon ? weapon->GetEntry() : 0);
                    }
                    player->CastSpell(reflection, SPELL_HOR_CLONE, true);
                    player->CastSpell(reflection, SPELL_HOR_CLONE_NAME, true);
                });
                break;
            }
            case DATA_SPIRITUAL_REFLECTIONS_ACTIVATE:
            {
                Creature* general = GetCreature(DATA_FROSTSWORN_GENERAL);
                if (!general)
                    break;
                for (uint8 i = 0; i < MAX_SPIRITUAL_REFLECTIONS; ++i)
                    if (Creature* reflection = instance->GetCreature(_spiritualReflectionGUID[i]))
                        if (reflection->IsVisible())
                        {
                            reflection->SetInCombatWithZone();
                            reflection->SetCanFly(false);
                            reflection->SetDisableGravity(false);
                            reflection->GetMotionMaster()->MoveJump(general->GetPositionX(), general->GetPositionY(), general->GetPositionZ(), 20.0f, 10.0f);
                        }
                break;
            }
            case DATA_SPIRITUAL_REFLECTIONS_HIDE:
                for (uint8 i = 0; i < MAX_SPIRITUAL_REFLECTIONS; ++i)
                    if (Creature* reflection = instance->GetCreature(_spiritualReflectionGUID[i]))
                        reflection->AI()->EnterEvadeMode();
                break;
            case DATA_LK_INTRO:
                StorePersistentData(PERSISTENT_DATA_LK_INTRO, 1);
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    leader->AI()->DoAction(ACTION_START_INTRO);
                break;
            case DATA_START_LK_FIGHT:
                SetBossState(DATA_LICH_KING, IN_PROGRESS);
                _isLichKingFightActive = true;
                DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_RETREATING_TIMED_EVENT);
                DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_RETREATING_TIMED_EVENT);
                break;
            case DATA_STOP_LK_FIGHT:
                if (!_isLichKingFightActive)
                    break;
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                {
                    if (!leader->IsAlive())
                    {
                        leader->Respawn();
                        if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                            leader->UpdateEntry(NPC_JAINA_PART2);
                    }
                    leader->GetThreatMgr().ClearAllThreat();
                    leader->CombatStop(true);
                    leader->InterruptNonMeleeSpells(true);
                    leader->GetMotionMaster()->Clear();
                    leader->GetMotionMaster()->MoveIdle();
                    leader->UpdatePosition(LeaderEscapePos, true);
                    leader->StopMovingOnCurrentPos();
                    leader->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    leader->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    leader->SetHealth(leader->GetMaxHealth() / 20);
                    leader->AI()->Reset();
                    leader->setActive(false);
                    leader->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    leader->ClearEmoteState();
                }
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    lichKing->GetThreatMgr().ClearAllThreat();
                    lichKing->CombatStop(true);
                    lichKing->InterruptNonMeleeSpells(true);
                    lichKing->GetMotionMaster()->Clear();
                    lichKing->GetMotionMaster()->MoveIdle();
                    lichKing->UpdatePosition(lichKing->GetHomePosition(), true);
                    lichKing->StopMovingOnCurrentPos();
                    lichKing->RemoveAllAuras();
                    lichKing->AddAura(GetTeamIdInInstance() == TEAM_ALLIANCE ? SPELL_JAINA_ICE_PRISON : SPELL_SYLVANAS_DARK_BINDING, lichKing);
                    lichKing->AI()->Reset();
                    lichKing->setActive(false);
                    lichKing->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    lichKing->ClearEmoteState();
                    lichKing->SetSpeed(MOVE_RUN, lichKing->GetCreatureTemplate()->speed_run);
                }
                _isLichKingFightActive = false;
                SetBossState(DATA_LICH_KING, FAIL);
                _outroTimer = 0;
                _outroStep = OUTRO_NONE;
                [[fallthrough]];
            case DATA_DELETE_ICE_WALL:
                HandleGameObject(DATA_ICE_WALL, true);
                break;
            case DATA_BATTERED_HILT:
            {
                if (GetPersistentData(PERSISTENT_DATA_BATTERED_HILT))
                    return;

                switch (data)
                {
                    case BATTERED_HILT_DISABLE:
                        StorePersistentData(PERSISTENT_DATA_BATTERED_HILT, 1);
                        break;
                    case BATTERED_HILT_START:
                        if (_batteredHiltStatus)
                            break;
                        _batteredHiltStatus |= BHSF_STARTED;
                        if (Creature* bunny = GetCreature(DATA_ALTAR_BUNNY))
                            bunny->CastSpell(bunny, SPELL_FROSTMOURNE_ALTAR_GLOW, true);
                        if (Creature* uther = GetCreature(DATA_UTHER))
                            uther->m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(*uther, UTHER_STEP_APPEAR), 3s);
                        break;
                    case BATTERED_HILT_THROW:
                        if (!(_batteredHiltStatus & BHSF_STARTED) || (_batteredHiltStatus & BHSF_THROWN))
                            break;
                        _batteredHiltStatus |= BHSF_THROWN;
                        if (Creature* uther = GetCreature(DATA_UTHER))
                            uther->m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(*uther, UTHER_STEP_SUMMON_QUEL), 5500ms);
                        break;
                    case BATTERED_HILT_QUEL_SUMMONED:
                        if (Creature* quelDelar = instance->GetCreature(_quelDelarGuid))
                        {
                            quelDelar->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            quelDelar->SetSpeed(MOVE_RUN, 2.5f);
                        }
                        break;
                    case BATTERED_HILT_QUEL_ARRIVED:
                        if (Creature* uther = GetCreature(DATA_UTHER))
                            uther->m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(*uther, UTHER_STEP_QUEL_LAND), 3s);
                        break;
                    case BATTERED_HILT_QUEL_LAND:
                        if (Creature* quelDelar = instance->GetCreature(_quelDelarGuid))
                        {
                            quelDelar->SetSpeed(MOVE_RUN, quelDelar->GetCreatureTemplate()->speed_run);
                            quelDelar->GetMotionMaster()->MoveLand(0, quelDelar->GetPositionX(), quelDelar->GetPositionY(), 707.70f, 7.0f);
                        }
                        break;
                    case BATTERED_HILT_QUEL_PREPARE:
                        if (Creature* quelDelar = instance->GetCreature(_quelDelarGuid))
                        {
                            quelDelar->SetReactState(REACT_AGGRESSIVE);
                            quelDelar->SetImmuneToAll(false);
                            quelDelar->RemoveAurasDueToSpell(SPELL_QUEL_DELAR_HATRED);
                        }
                        break;
                    case BATTERED_HILT_QUEL_ATTACK:
                        if (Creature* quelDelar = instance->GetCreature(_quelDelarGuid))
                            quelDelar->SetInCombatWithZone();
                        break;
                    case BATTERED_HILT_FINISHED:
                        StorePersistentData(PERSISTENT_DATA_BATTERED_HILT, 1);
                        _batteredHiltStatus |= BHSF_FINISHED;
                        break;
                    default:
                        break;
                }
                return;
            }
            default:
                break;
        }
    }

    uint32 GetData(uint32 type) const override
    {
        switch (type)
        {
            case DATA_WAVE_NUMBER:
                return static_cast<uint32>(_waveNumber);
            case DATA_BATTERED_HILT:
                return _batteredHiltStatus;
            default:
                break;
        }

        return 0;
    }

    ObjectGuid GetGuidData(uint32 type) const override
    {
        switch (type)
        {
            case DATA_ICE_WALL_TARGET_1:
            case DATA_ICE_WALL_TARGET_2:
            case DATA_ICE_WALL_TARGET_3:
            case DATA_ICE_WALL_TARGET_4:
                return _iceWallTargetGUID[type - DATA_ICE_WALL_TARGET_1];
            default:
                return GetObjectGuid(type);
        }
    }

    void OnUnitDeath(Unit* unit) override
    {
        if (_waveNumber && _remainingTrashKills)
        {
            switch (unit->GetEntry())
            {
                case NPC_WAVE_MERCENARY:
                case NPC_WAVE_FOOTMAN:
                case NPC_WAVE_RIFLEMAN:
                case NPC_WAVE_PRIEST:
                case NPC_WAVE_MAGE:
                    if ((--_remainingTrashKills) == 0 && _waveNumber % 5 && _nextWaveTimer > 5000)
                        _nextWaveTimer = 5000;
                    break;
                default:
                    break;
            }
        }

        if (unit->GetEntry() == NPC_QUEL_DELAR)
            if (Creature* uther = GetCreature(DATA_UTHER))
            {
                uther->SetStandState(UNIT_STAND_STATE_STAND);
                uther->SetWalk(false);
                uther->GetMotionMaster()->MovePoint(0, 5313.92f, 1989.36f, 707.70f);
                uther->m_Events.AddEventAtOffset(new UtherBatteredHiltEvent(*uther, UTHER_STEP_OUTRO_1), 7s);
            }
    }

    void RandomizeCompositionsAndShow()
    {
        uint8 r1 = urand(0, 1);
        uint8 r2 = urand(2, 3);
        for (uint8 i = 0; i < MAX_WAVE_MOBS; ++i)
        {
            _chosenComposition[0][i] = allowedCompositions[r1][i];
            _chosenComposition[1][i] = allowedCompositions[r1 == 0 ? 1 : 0][i];
            _chosenComposition[2][i] = allowedCompositions[r2][i];
            _chosenComposition[3][i] = allowedCompositions[r2 == 2 ? 3 : 2][i];
        }

        // The second half of the compositions fills the waves after Falric in random order
        constexpr uint8 shuffledCount = MAX_WAVE_COMPOSITIONS / 2;
        bool left[shuffledCount];
        std::fill(std::begin(left), std::end(left), true);
        for (uint8 k = shuffledCount; k > 0; --k)
        {
            uint8 r = urand(0, k - 1);
            uint8 ur = 0;
            for (uint8 j = 0; j < shuffledCount; ++j)
                if (left[j])
                {
                    if (ur == r)
                    {
                        left[j] = false;
                        for (uint8 i = 0; i < MAX_WAVE_MOBS; ++i)
                            _chosenComposition[MAX_WAVE_COMPOSITIONS - k][i] = allowedCompositions[shuffledCount + j][i];
                        break;
                    }
                    ++ur;
                }
        }
        if (_falricPhaseComplete)
        {
            for (; _waveNumber < 4; ++_waveNumber)
            {
                uint8 numToActivate = (_waveNumber <= 1) ? 3 : 4;

                for (uint8 i = 0; i < numToActivate; ++i)
                {
                    uint32 entry = _chosenComposition[_waveNumber][i];
                    bool forward = !!urand(0, 1);
                    for (int8 j = (forward ? 0 : NUM_OF_TRASH - 1); (forward ? j < NUM_OF_TRASH : j >= 0); (forward ? ++j : --j))
                        if (!_trashActive[j])
                            if (Creature* creature = instance->GetCreature(_trashGUID[j]))
                                if (creature->GetEntry() == entry)
                                {
                                    _trashActive[j] = true;
                                    Unit::Kill(creature, creature);
                                    break;
                                }
                }
            }
            _waveNumber = 5;
        }

        for (uint8 i = 0; i < NUM_OF_TRASH; ++i)
            if (!_trashActive[i])
                if (Creature* creature = instance->GetCreature(_trashGUID[i]))
                {
                    creature->SetVisible(true);
                    creature->CastSpell(creature, SPELL_WELL_OF_SOULS_VISUAL, false);
                }
    }

    void StartNextWave()
    {
        if (_waveNumber >= 10)
            return;

        ++_waveNumber;
        if (_waveNumber >= 6)
            _falricPhaseComplete = true;

        DoUpdateWorldState(WORLD_STATE_HALLS_OF_REFLECTION_WAVES_ENABLED, 1);
        DoUpdateWorldState(WORLD_STATE_HALLS_OF_REFLECTION_WAVE_COUNT, _waveNumber);
        HandleGameObject(DATA_FRONT_DOOR, false);

        for (uint8 i = 0; i < NUM_OF_TRASH; ++i)
            if (_trashActive[i])
                if (Creature* creature = instance->GetCreature(_trashGUID[i]))
                    if (creature->IsAlive() && !creature->IsInCombat())
                        creature->AI()->DoAction(ACTION_WAVE_ENGAGE);

        if (_waveNumber == 5 || _waveNumber == 10)
        {
            _nextWaveTimer = 0;
            if (_waveNumber == 5)
            {
                if (Creature* falric = GetCreature(DATA_FALRIC))
                {
                    if (falric->IsAlive())
                        falric->AI()->DoAction(ACTION_WAVE_ENGAGE);
                    else
                        _nextWaveTimer = 1;
                }
            }
            else
            {
                if (Creature* marwyn = GetCreature(DATA_MARWYN))
                    if (marwyn->IsAlive())
                        marwyn->AI()->DoAction(ACTION_WAVE_ENGAGE);
            }
        }
        else
        {
            _nextWaveTimer = 150000;

            uint8 numToActivate = 5;
            if (_waveNumber <= 2)
                numToActivate = 3;
            else if (_waveNumber <= 4)
                numToActivate = 4;
            _remainingTrashKills += numToActivate;
            for (uint8 i = 0; i < numToActivate; ++i)
            {
                uint32 entry = _chosenComposition[_waveNumber - (_waveNumber > 5 ? 2 : 1)][i];
                bool forward = !!urand(0, 1);
                for (int8 j = (forward ? 0 : NUM_OF_TRASH - 1); (forward ? j < NUM_OF_TRASH : j >= 0); (forward ? ++j : --j))
                    if (!_trashActive[j])
                        if (Creature* creature = instance->GetCreature(_trashGUID[j]))
                            if (creature->GetEntry() == entry)
                            {
                                _trashActive[j] = true;
                                creature->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                                creature->SetImmuneToAll(false);
                                creature->AI()->DoAction(ACTION_WAVE_ENGAGE);
                                break;
                            }
            }
        }
    }

    void HandleWaveWipe()
    {
        if (!_waveNumber)
            return;

        DoUpdateWorldState(WORLD_STATE_HALLS_OF_REFLECTION_WAVES_ENABLED, 0);
        DoUpdateWorldState(WORLD_STATE_HALLS_OF_REFLECTION_WAVE_COUNT, 0);
        HandleGameObject(DATA_FRONT_DOOR, true);

        _trashCounter = NUM_OF_TRASH;
        _waveNumber = 0;
        _nextWaveTimer = 0;
        std::memset(&_chosenComposition, 0, sizeof(_chosenComposition));

        for (uint8 i = 0; i < NUM_OF_TRASH; ++i)
            if (_trashActive[i])
                if (Creature* creature = instance->GetCreature(_trashGUID[i]))
                {
                    creature->GetThreatMgr().ClearAllThreat();
                    creature->CombatStop(true);
                    creature->InterruptNonMeleeSpells(true);
                    creature->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    creature->SetImmuneToAll(true);
                    creature->Respawn(true);
                    creature->UpdatePosition(creature->GetHomePosition(), true);
                    creature->StopMovingOnCurrentPos();
                }
        std::fill(std::begin(_trashActive), std::end(_trashActive), false);
        if (Creature* falric = GetCreature(DATA_FALRIC))
            falric->AI()->EnterEvadeMode();
        if (Creature* marwyn = GetCreature(DATA_MARWYN))
            marwyn->AI()->EnterEvadeMode();

        _waveResumeTimer = 5000;
        _waveResumeStep = WAVE_RESUME_HIDE_ALL;
        _remainingTrashKills = 0;
    }

    void Update(uint32 diff) override
    {
        if (!instance->HavePlayers())
            return;

        if (_playerCheckTimer <= diff)
        {
            _playerCheckTimer = 5000;
            if ((GetPersistentData(PERSISTENT_DATA_INTRO)) && GetBossState(DATA_MARWYN) != DONE)
            {
                Map::PlayerList const& pl = instance->GetPlayers();
                if (_waveNumber || _nextWaveTimer)
                {
                    bool allDead = true;
                    bool outOfRange = false;
                    for (auto itr = pl.begin(); itr != pl.end(); ++itr)
                    {
                        Player* player = itr->GetSource();
                        if (!player || player->IsGameMaster())
                            continue;
                        if (player->IsAlive())
                            allDead = false;
                        if (player->GetExactDist2d(&CenterPos) > MAX_DIST_FROM_CENTER_IN_COMBAT)
                        {
                            outOfRange = true;
                            break;
                        }
                    }
                    if (allDead || outOfRange)
                        HandleWaveWipe();
                }
                else if (!_waveResumeTimer)
                {
                    bool allInRange = (instance->GetPlayersCountExceptGMs() > 0);
                    for (auto itr = pl.begin(); itr != pl.end(); ++itr)
                    {
                        Player* player = itr->GetSource();
                        if (!player || player->IsGameMaster())
                            continue;
                        if (player->GetExactDist2d(&CenterPos) > MAX_DIST_FROM_CENTER_TO_START || !player->IsAlive())
                        {
                            allInRange = false;
                            break;
                        }
                    }
                    if (allInRange)
                    {
                        _waveResumeTimer = 1;
                        _waveResumeStep = WAVE_RESUME_SHOW_BOSSES;
                    }
                }
            }
        }
        else
            _playerCheckTimer -= diff;

        if (_nextWaveTimer)
        {
            if (_nextWaveTimer <= diff)
            {
                _nextWaveTimer = 0;
                StartNextWave();
            }
            else
                _nextWaveTimer -= diff;
        }

        if (_waveResumeTimer)
        {
            if (_waveResumeTimer <= diff)
            {
                switch (_waveResumeStep)
                {
                    case WAVE_RESUME_SHOW_BOSSES:
                        if (Creature* falric = GetCreature(DATA_FALRIC))
                        {
                            falric->UpdatePosition(5274.9f, 2039.2f, 709.319f, 5.4619f, true);
                            falric->StopMovingOnCurrentPos();
                            falric->SetVisible(true);
                            if (falric->IsAlive())
                            {
                                falric->GetMotionMaster()->MovePoint(0, FalricMovePos);
                                if (Aura* a = falric->AddAura(SPELL_SHADOWMOURNE_VISUAL, falric))
                                    a->SetDuration(8000);
                            }
                        }
                        if (Creature* marwyn = GetCreature(DATA_MARWYN))
                        {
                            marwyn->UpdatePosition(5343.77f, 1973.86f, 709.319f, 2.35173f, true);
                            marwyn->StopMovingOnCurrentPos();
                            marwyn->SetVisible(true);
                            if (marwyn->IsAlive())
                            {
                                marwyn->GetMotionMaster()->MovePoint(0, MarwynMovePos);
                                if (Aura* a = marwyn->AddAura(SPELL_SHADOWMOURNE_VISUAL, marwyn))
                                    a->SetDuration(8000);
                            }
                            marwyn->AI()->Talk(EMOTE_MARWYN_INTRO_SPIRIT);
                        }
                        _waveResumeStep = WAVE_RESUME_SHOW_TRASH;
                        _waveResumeTimer = 7500;
                        break;
                    case WAVE_RESUME_SHOW_TRASH:
                        if (Creature* falric = GetCreature(DATA_FALRIC))
                        {
                            if (falric->IsAlive())
                                falric->AI()->Talk(SAY_FALRIC_INTRO_2);
                            else if (Creature* marwyn = GetCreature(DATA_MARWYN))
                                marwyn->AI()->Talk(SAY_MARWYN_WIPE_AFTER_FALRIC);
                        }
                        SetData(DATA_SHOW_TRASH, 1);
                        _waveResumeStep = WAVE_RESUME_NONE;
                        _waveResumeTimer = 0;
                        _nextWaveTimer = 7000;
                        break;
                    case WAVE_RESUME_HIDE_ALL:
                        for (uint8 i = 0; i < NUM_OF_TRASH; ++i)
                            if (Creature* creature = instance->GetCreature(_trashGUID[i]))
                                creature->SetVisible(false);
                        if (Creature* falric = GetCreature(DATA_FALRIC))
                            falric->SetVisible(false);
                        if (Creature* marwyn = GetCreature(DATA_MARWYN))
                            marwyn->SetVisible(false);
                        _waveResumeStep = WAVE_RESUME_NONE;
                        _waveResumeTimer = 0;
                        break;
                    default:
                        break;
                }
            }
            else
                _waveResumeTimer -= diff;
        }

        if (_outroStep)
        {
            if (_outroTimer <= diff)
                UpdateOutro();
            else
                _outroTimer -= diff;
        }
    }

private:
    void UpdateOutro()
    {
        switch (_outroStep)
        {
            case OUTRO_HARVEST_SOUL:
                if (Creature* lk = GetCreature(DATA_LICH_KING))
                {
                    lk->UpdatePosition(PathWaypoints[PATH_WP_COUNT - 2], true);
                    lk->StopMovingOnCurrentPos();
                    lk->RemoveAllAuras();
                    lk->SetEmoteState(EMOTE_ONESHOT_CUSTOM_SPELL_02);
                    if (!lk->IsVisible())
                        lk->SetVisible(true);
                    if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    {
                        leader->UpdatePosition(PathWaypoints[PATH_WP_COUNT - 1], true);
                        leader->StopMovingOnCurrentPos();
                        leader->RemoveAllAuras();
                        leader->SetEmoteState(EMOTE_ONESHOT_READY1H);
                        if (!leader->IsVisible())
                            leader->SetVisible(true);
                        lk->CastSpell(leader, SPELL_HARVEST_SOUL, false);
                    }
                }
                _outroStep = OUTRO_SUMMON_GUNSHIP;
                _outroTimer = 500;
                break;
            case OUTRO_SUMMON_GUNSHIP:
            {
                uint32 entry = GetTeamIdInInstance() == TEAM_ALLIANCE ? GO_THE_SKYBREAKER : GO_ORGRIMS_HAMMER;
                if (MotionTransport* gunship = sTransportMgr->CreateTransport(entry, 0, instance))
                    _gunshipGuid = gunship->GetGUID();
                _outroStep = OUTRO_GUNSHIP_FIRE;
                _outroTimer = GetTeamIdInInstance() == TEAM_ALLIANCE ? 10000 : 10500;
                break;
            }
            case OUTRO_GUNSHIP_FIRE:
                if (MotionTransport* gunship = GetGunship())
                    gunship->EnableMovement(false);
                if (Creature* captain = GetCreature(DATA_SHIP_CAPTAIN))
                    captain->AI()->Talk(GetTeamIdInInstance() == TEAM_ALLIANCE ? SAY_FIRE_ALLY : SAY_FIRE_HORDE);
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                {
                    leader->RemoveAllAuras();
                    leader->CastSpell(leader, SPELL_GUNSHIP_CANNON_FIRE_PERIODIC, true);
                }
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    lichKing->InterruptNonMeleeSpells(true);
                    lichKing->RemoveAllAuras();
                }
                _outroStep = OUTRO_CAVE_IN;
                _outroTimer = 5000;
                break;
            case OUTRO_CAVE_IN:
                HandleGameObject(DATA_CAVE_IN, false);
                _outroStep = OUTRO_HIDE_LICH_KING;
                _outroTimer = 3000;
                break;
            case OUTRO_HIDE_LICH_KING:
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    leader->ClearEmoteState();
                if (Creature* lichKing = GetCreature(DATA_LICH_KING))
                {
                    lichKing->ClearEmoteState();
                    lichKing->GetThreatMgr().ClearAllThreat();
                    lichKing->CombatStop(true);
                    lichKing->InterruptNonMeleeSpells(true);
                    lichKing->SetVisible(false);
                }
                if (instance->IsHeroic())
                    instance->ToInstanceMap()->PermBindAllPlayers();
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    leader->CastSpell(leader, SPELL_ACHIEVEMENT_CHECK, true);
                _outroStep = OUTRO_GUNSHIP_MOVE;
                _outroTimer = 1000;
                break;
            case OUTRO_GUNSHIP_MOVE:
                if (MotionTransport* gunship = GetGunship())
                    gunship->EnableMovement(true);
                _outroStep = OUTRO_SUMMON_STAIRS;
                _outroTimer = 3500;
                break;
            case OUTRO_SUMMON_STAIRS:
                if (MotionTransport* gunship = GetGunship())
                    gunship->EnableMovement(false);
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                {
                    uint8 index = GetTeamIdInInstance() == TEAM_ALLIANCE ? 0 : 1;
                    for (Position const& stairsPos : StairsPos[index])
                        if (stairsPos.GetPositionX())
                            if (GameObject* go = leader->SummonGameObject(GetTeamIdInInstance() == TEAM_ALLIANCE ? GO_STAIRS_ALLIANCE : GO_STAIRS_HORDE, stairsPos.GetPositionX(), stairsPos.GetPositionY(), stairsPos.GetPositionZ(), stairsPos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 86400, false))
                                go->SetGameObjectFlag(GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);
                }
                _outroStep = OUTRO_BOARD_GUNSHIP;
                _outroTimer = 1000;
                break;
            case OUTRO_BOARD_GUNSHIP:
                if (Creature* captain = GetCreature(DATA_SHIP_CAPTAIN))
                    captain->AI()->Talk(GetTeamIdInInstance() == TEAM_ALLIANCE ? SAY_ONBOARD_ALLY : SAY_ONBOARD_HORDE);
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                {
                    leader->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    leader->GetMotionMaster()->MovePoint(0, WalkCaveInPos);
                    leader->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                }
                _outroStep = OUTRO_LEADER_FINAL;
                _outroTimer = 6000;
                break;
            case OUTRO_LEADER_FINAL:
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    leader->AI()->Talk(GetTeamIdInInstance() == TEAM_ALLIANCE ? SAY_JAINA_FINAL_1 : SAY_SYLVANA_FINAL);
                HandleGameObject(DATA_CAVE_IN, true);
                _outroStep = OUTRO_QUEST_CREDIT;
                _outroTimer = 11000;
                break;
            case OUTRO_QUEST_CREDIT:
                _outroStep = OUTRO_QUEST_GIVER;
                _outroTimer = 0;
                instance->DoForAllPlayers([](Player* player)
                {
                    player->KilledMonsterCredit(NPC_WRATH_OF_THE_LICH_KING_CREDIT);
                });
                if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    {
                        leader->AI()->Talk(SAY_JAINA_FINAL_2);
                        _outroTimer = 10000;
                    }
                break;
            case OUTRO_QUEST_GIVER:
                if (Creature* leader = GetCreature(DATA_SYLVANAS_PART2))
                    leader->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                _outroStep = OUTRO_FINISH;
                _outroTimer = 300 * 1000;
                break;
            case OUTRO_FINISH:
                _outroStep = OUTRO_NONE;
                _outroTimer = 0;
                if (MotionTransport* gunship = GetGunship())
                    gunship->setActive(false);
                break;
            default:
                break;
        }
    }

    MotionTransport* GetGunship()
    {
        if (Transport* transport = instance->GetTransport(_gunshipGuid))
            return transport->ToMotionTransport();
        return nullptr;
    }

    // GUIDs not handled by ObjectData (arrays with position-based assignment)
    ObjectGuid _spiritualReflectionGUID[MAX_SPIRITUAL_REFLECTIONS];
    ObjectGuid _iceWallTargetGUID[MAX_ICE_WALL_TARGETS];
    ObjectGuid _trashGUID[NUM_OF_TRASH];
    // Summoned by Uther's spell, so kept out of ObjectData
    ObjectGuid _quelDelarGuid;

    // Runtime state (not persisted)
    uint32 _batteredHiltStatus{};

    // Wave system
    bool _trashActive[NUM_OF_TRASH]{};
    uint8 _trashCounter{};
    uint32 _chosenComposition[MAX_WAVE_COMPOSITIONS][MAX_WAVE_MOBS]{};
    uint8 _waveNumber{};
    uint32 _nextWaveTimer{};
    uint16 _playerCheckTimer{};
    uint16 _waveResumeTimer{};
    uint8 _waveResumeStep{};
    bool _falricPhaseComplete{};
    uint8 _remainingTrashKills{};

    // Lich King fight
    bool _isLichKingFightActive{};
    uint32 _outroTimer{};
    uint8 _outroStep{};
    ObjectGuid _gunshipGuid;
};

void AddSC_instance_halls_of_reflection()
{
    RegisterInstanceScript(instance_halls_of_reflection, MAP_HALLS_OF_REFLECTION);
}
