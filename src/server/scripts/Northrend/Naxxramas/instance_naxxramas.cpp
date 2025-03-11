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

#include "AreaTriggerScript.h"
#include "CellImpl.h"
#include "CreatureAIImpl.h"
#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "naxxramas.h"

struct LivingPoisonData
{
    Position Start {};
    Position End {};
    uint32 DespawnTime {};
};

static const LivingPoisonData LivingPoisonDataList[3]
{
    { Position { 3128.59, -3118.81, 293.346, 4.76754 }, Position { 3130.322, -3156.51,  293.324 }, 15200 },
    { Position { 3154.25, -3125.7,  293.43,  4.47694 }, Position { 3144.779, -3158.416, 293.324 }, 14800 },
    { Position { 3175.42, -3134.86, 293.34,  4.284   }, Position { 3158.778, -3164.201, 293.312 }, 14800 }
};

static const float HeiganPos[2]
{
    2796, -3707
};

static const float HeiganEruptionSlope[3]
{
    (-3685 - HeiganPos[1]) / (2724 - HeiganPos[0]),
    (-3647 - HeiganPos[1]) / (2749 - HeiganPos[0]),
    (-3637 - HeiganPos[1]) / (2771 - HeiganPos[0]),
};

static constexpr std::array<uint32, HorsemanCount> HorsemanDataGroup
{
    DATA_BARON_RIVENDARE_BOSS,
    DATA_SIR_ZELIEK_BOSS,
    DATA_LADY_BLAUMEUX_BOSS,
    DATA_THANE_KORTHAZZ_BOSS
};

static WorldLocation const SapphironTeleportPos
{
    NaxxramasMapId, 3498.300049f, -5349.490234f, 144.968002f, 1.3698910f
};

static DoorData const doorData[]
{
    { GO_PATCHWERK_GATE,         BOSS_PATCHWERK,  DOOR_TYPE_PASSAGE },
    { GO_PATCHWERK_GATE,         BOSS_GROBBULUS,  DOOR_TYPE_ROOM    },
    { GO_GLUTH_GATE,             BOSS_GLUTH,      DOOR_TYPE_PASSAGE },
    { GO_THADDIUS_GATE,          BOSS_GLUTH,      DOOR_TYPE_PASSAGE },
    { GO_NOTH_ENTRY_GATE,        BOSS_NOTH,       DOOR_TYPE_ROOM    },
    { GO_NOTH_EXIT_GATE,         BOSS_NOTH,       DOOR_TYPE_PASSAGE },
    { GO_HEIGAN_ENTRY_GATE,      BOSS_NOTH,       DOOR_TYPE_PASSAGE },
    { GO_HEIGAN_ENTRY_GATE,      BOSS_HEIGAN,     DOOR_TYPE_ROOM    },
    { GO_HEIGAN_EXIT_GATE,       BOSS_HEIGAN,     DOOR_TYPE_PASSAGE },
    { GO_LOATHEB_GATE,           BOSS_HEIGAN,     DOOR_TYPE_PASSAGE },
    { GO_LOATHEB_GATE,           BOSS_LOATHEB,    DOOR_TYPE_ROOM    },
    { GO_PLAGUE_EYE_PORTAL,      BOSS_LOATHEB,    DOOR_TYPE_PASSAGE },
    { GO_PLAG_EYE_RAMP_BOSS,     BOSS_LOATHEB,    DOOR_TYPE_PASSAGE },
    { GO_ANUB_GATE,              BOSS_ANUB,       DOOR_TYPE_ROOM    },
    { GO_ANUB_NEXT_GATE,         BOSS_ANUB,       DOOR_TYPE_PASSAGE },
    { GO_FAERLINA_WEB,           BOSS_FAERLINA,   DOOR_TYPE_ROOM    },
    { GO_FAERLINA_GATE,          BOSS_FAERLINA,   DOOR_TYPE_PASSAGE },
    { GO_MAEXXNA_GATE,           BOSS_FAERLINA,   DOOR_TYPE_PASSAGE },
    { GO_MAEXXNA_GATE,           BOSS_MAEXXNA,    DOOR_TYPE_ROOM    },
    { GO_SPIDER_EYE_PORTAL,      BOSS_MAEXXNA,    DOOR_TYPE_PASSAGE },
    { GO_ARAC_EYE_RAMP_BOSS,     BOSS_MAEXXNA,    DOOR_TYPE_PASSAGE },
    { GO_THADDIUS_GATE,          BOSS_THADDIUS,   DOOR_TYPE_ROOM    },
    { GO_ABOM_EYE_PORTAL,        BOSS_THADDIUS,   DOOR_TYPE_PASSAGE },
    { GO_CONS_EYE_RAMP_BOSS,     BOSS_THADDIUS,   DOOR_TYPE_PASSAGE },
    { GO_GOTHIK_ENTER_GATE,      BOSS_GOTHIK,     DOOR_TYPE_ROOM    },
    { GO_GOTHIK_INNER_GATE,      BOSS_GOTHIK,     DOOR_TYPE_ROOM    },
    { GO_GOTHIK_EXIT_GATE,       BOSS_GOTHIK,     DOOR_TYPE_PASSAGE },
    { GO_HORSEMEN_GATE,          BOSS_GOTHIK,     DOOR_TYPE_PASSAGE },
    { GO_HORSEMEN_GATE,          BOSS_HORSEMAN,   DOOR_TYPE_ROOM    },
    { GO_DEATHKNIGHT_EYE_PORTAL, BOSS_HORSEMAN,   DOOR_TYPE_PASSAGE },
    { GO_MILI_EYE_RAMP_BOSS,     BOSS_HORSEMAN,   DOOR_TYPE_PASSAGE },
    { GO_KELTHUZAD_GATE,         BOSS_KELTHUZAD,  DOOR_TYPE_ROOM    },
    { 0,                         0,               DOOR_TYPE_ROOM    }
};

static ObjectData const creatureData[]
{
    { NPC_PATCHWERK,       DATA_PATCHWERK_BOSS       },
    { NPC_STALAGG,         DATA_STALAGG_BOSS         },
    { NPC_FEUGEN,          DATA_FEUGEN_BOSS          },
    { NPC_THADDIUS,        DATA_THADDIUS_BOSS        },
    { NPC_RAZUVIOUS,       DATA_RAZUVIOUS_BOSS       },
    { NPC_GOTHIK,          DATA_GOTHIK_BOSS          },
    { NPC_BARON_RIVENDARE, DATA_BARON_RIVENDARE_BOSS },
    { NPC_SIR_ZELIEK,      DATA_SIR_ZELIEK_BOSS      },
    { NPC_LADY_BLAUMEUX,   DATA_LADY_BLAUMEUX_BOSS   },
    { NPC_THANE_KORTHAZZ,  DATA_THANE_KORTHAZZ_BOSS  },
    { NPC_SAPPHIRON,       DATA_SAPPHIRON_BOSS       },
    { NPC_KELTHUZAD,       DATA_KELTHUZAD_BOSS       },
    { NPC_LICH_KING,       DATA_LICH_KING_BOSS       },
    { 0,                   0                         }
};

static ObjectData const gameObjectData[]
{
    { GO_GOTHIK_INNER_GATE,  DATA_GOTHIK_INNER_GATE  },
    { GO_LOATHEB_PORTAL,     DATA_LOATHEB_PORTAL     },
    { GO_MAEXXNA_PORTAL,     DATA_MAEXXNA_PORTAL     },
    { GO_THADDIUS_PORTAL,    DATA_THADDIUS_PORTAL    },
    { GO_HORSEMAN_PORTAL,    DATA_HORSEMAN_PORTAL    },
    { GO_SAPPHIRON_GATE,     DATA_SAPPHIRON_GATE     },
    { GO_KELTHUZAD_FLOOR,    DATA_KELTHUZAD_FLOOR    },
    { GO_KELTHUZAD_GATE,     DATA_KELTHUZAD_GATE     },
    { GO_KELTHUZAD_PORTAL_1, DATA_KELTHUZAD_PORTAL_1 },
    { GO_KELTHUZAD_PORTAL_2, DATA_KELTHUZAD_PORTAL_2 },
    { GO_KELTHUZAD_PORTAL_3, DATA_KELTHUZAD_PORTAL_3 },
    { GO_KELTHUZAD_PORTAL_4, DATA_KELTHUZAD_PORTAL_4 },
    { 0,                     0                       }
};

class instance_naxxramas : public InstanceScript
{
public:
    instance_naxxramas(Map* map) : InstanceScript(map)
    {
        SetHeaders(DataHeader);
        SetBossNumber(MAX_ENCOUNTERS);
        SetPersistentDataCount(PERSISTENT_DATA_COUNT);
        LoadDoorData(doorData);
        LoadObjectData(creatureData, gameObjectData);

        // GameObjects
        for (auto& i : _heiganEruption)
            i.clear();

        // NPCs
        _patchwerkRoomTrash.clear();

        // Controls
        _events.Reset();
        _currentWingTaunt = SAY_FIRST_WING_TAUNT;
        _horsemanLoaded = 0;

        // Achievements
        _abominationsKilled = 0;
        _faerlinaAchievement = true;
        _thaddiusAchievement = true;
        _loathebAchievement = true;
        _heiganAchievement = true;
        _sapphironAchievement = true;
        _horsemanAchievement = true;
    }

    inline void CreatureTalk(uint32 dataCreature, uint8 dialog)
    {
        if (Creature* creature = GetCreature(dataCreature))
            creature->AI()->Talk(dialog);
    }

    inline void SetGoState(uint32 dataGameObject, GOState state)
    {
        if (GameObject* go = GetGameObject(dataGameObject))
            go->SetGoState(state);
    }

    inline void ActivateWingPortal(GameObject* go, EncounterState state)
    {
        if (!go || state != DONE)
            return;

        go->SetGoState(GO_STATE_ACTIVE);
        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
    }

    inline void ActivateWingPortal(uint32 wingPortal)
    {
        ActivateWingPortal(GetGameObject(wingPortal), DONE);
        _events.RescheduleEvent(EVENT_KELTHUZAD_WING_TAUNT, 6s);
    }

    static inline uint8 GetEruptionSection(float x, float y)
    {
        y -= HeiganPos[1];
        if (y < 1.0f)
            return 0;

        x -= HeiganPos[0];
        if (x > -1.0f)
            return 3;

        float slope = y / x;
        for (uint32 i = 0; i < 3; ++i)
            if (slope > HeiganEruptionSlope[i])
                return i;

        return 3;
    }

    inline void HeiganEruptSections(uint32 section)
    {
        for (uint8 i = 0; i < HeiganEruptSectionCount; ++i)
        {
            if (i == section)
                continue;

            for (GameObject* go : _heiganEruption[i])
            {
                go->SendCustomAnim(go->GetGoAnimProgress());
                go->CastSpell(nullptr, SPELL_ERUPTION);
            }
        }
    }

    void OnPlayerEnter(Player* player) override
    {
        InstanceScript::OnPlayerEnter(player);

        _events.ScheduleEvent(EVENT_THADDIUS_SCREAMS, 2min, 2min + 30s);
    }

    void OnCreatureCreate(Creature* creature) override
    {
        switch (creature->GetEntry())
        {
            case NPC_LIVING_MONSTROSITY:
            case NPC_MAD_SCIENTIST:
            case NPC_PATCHWORK_GOLEM:
            case NPC_SURGICAL_ASSIST:
                _patchwerkRoomTrash.push_back(creature->GetGUID());
                return;
            case NPC_BILE_RETCHER:
            case NPC_SLUDGE_BELCHER:
                if (creature->GetPositionY() > -3258.0f) // we want only those inside the room, not before
                    _patchwerkRoomTrash.push_back(creature->GetGUID());
                return;
            case NPC_BARON_RIVENDARE:
            case NPC_SIR_ZELIEK:
            case NPC_LADY_BLAUMEUX:
            case NPC_THANE_KORTHAZZ:
                if (++_horsemanLoaded == HorsemanCount)
                    SetBossState(BOSS_HORSEMAN, GetBossState(BOSS_HORSEMAN));
                break;
            default:
                break;
        }

        InstanceScript::OnCreatureCreate(creature);
    }

    void OnGameObjectCreate(GameObject* go) override
    {
        switch (go->GetGOInfo()->displayId)
        {
            case GO_DISPLAY_ID_HEIGAN_ERUPTION1:
            case GO_DISPLAY_ID_HEIGAN_ERUPTION2:
                _heiganEruption[GetEruptionSection(go->GetPositionX(), go->GetPositionY())].insert(go);
                break;
            default:
                break;
        }

        switch (go->GetEntry())
        {
            case GO_SAPPHIRON_GATE:
                if (GetBossState(BOSS_SAPPHIRON) == DONE)
                    go->SetGoState(GO_STATE_ACTIVE);
                break;
            case GO_LOATHEB_PORTAL:
                ActivateWingPortal(go, GetBossState(BOSS_LOATHEB));
                break;
            case GO_THADDIUS_PORTAL:
                ActivateWingPortal(go, GetBossState(BOSS_THADDIUS));
                break;
            case GO_MAEXXNA_PORTAL:
                ActivateWingPortal(go, GetBossState(BOSS_MAEXXNA));
                break;
            case GO_HORSEMAN_PORTAL:
                ActivateWingPortal(go, GetBossState(BOSS_HORSEMAN));
                break;
            default:
                break;
        }

        InstanceScript::OnGameObjectCreate(go);
    }

    void OnGameObjectRemove(GameObject* go) override
    {
        switch (go->GetGOInfo()->displayId)
        {
            case GO_DISPLAY_ID_HEIGAN_ERUPTION1:
            case GO_DISPLAY_ID_HEIGAN_ERUPTION2:
                _heiganEruption[GetEruptionSection(go->GetPositionX(), go->GetPositionY())].erase(go);
                break;
            default:
                break;
        }

        switch (go->GetEntry())
        {
            case GO_SAPPHIRON_BIRTH:
                if (Creature* cr = GetCreature(DATA_SAPPHIRON_BOSS))
                    cr->AI()->DoAction(ACTION_SAPPHIRON_BIRTH);
                break;
            default:
                break;
        }

        InstanceScript::OnGameObjectRemove(go);
    }

    bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
    {
        switch (criteria_id)
        {
            case ACHIEV_CRITERIA_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER_10_PLAYER:
            case ACHIEV_CRITERIA_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER_25_PLAYER:
                return _horsemanAchievement;
            case ACHIEV_CRITERIA_JUST_CANT_GET_ENOUGH_10_PLAYER:
            case ACHIEV_CRITERIA_JUST_CANT_GET_ENOUGH_25_PLAYER:
                return _abominationsKilled >= AbominationKillCountReq;
            case ACHIEV_CRITERIA_MOMMA_SAID_KNOCK_YOU_OUT_10_PLAYER:
            case ACHIEV_CRITERIA_MOMMA_SAID_KNOCK_YOU_OUT_25_PLAYER:
                return _faerlinaAchievement;
            case ACHIEV_CRITERIA_SHOKING_10_PLAYER:
            case ACHIEV_CRITERIA_SHOKING_25_PLAYER:
                return _thaddiusAchievement;
            case ACHIEV_CRITERIA_SPORE_LOSER_10_PLAYER:
            case ACHIEV_CRITERIA_SPORE_LOSER_25_PLAYER:
                return _loathebAchievement;
            case ACHIEV_CRITERIA_THE_SAFETY_DANCE_10_PLAYER:
            case ACHIEV_CRITERIA_THE_SAFETY_DANCE_25_PLAYER:
                return _heiganAchievement;
            case ACHIEV_CRITERIA_SUBTRACTION_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_KELTHUZAD_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_GOTHIK_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_ANUB_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_GROBBULUS_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_HEIGAN_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_FAERLINA_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_MAEXXNA_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_SAPPHIRON_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_LOATHEB_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_GLUTH_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_THADDIUS_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_PATCHWERK_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_RAZUVIOUS_10_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_NOTH_10_PLAYER:
                return instance->GetPlayersCountExceptGMs() < TheDedicatedFew10PlayerReq;
            case ACHIEV_CRITERIA_SUBTRACTION_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_ANUB_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_FAERLINA_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_MAEXXNA_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_PATCHWERK_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_GROBBULUS_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_GLUTH_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_THADDIUS_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_NOTH_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_HEIGAN_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_LOATHEB_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_RAZUVIOUS_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_GOTHIK_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_SAPPHIRON_25_PLAYER:
            case ACHIEV_CRITERIA_THE_DEDICATED_FEW_KELTHUZAD_25_PLAYER:
                return instance->GetPlayersCountExceptGMs() < TheDedicatedFew25PlayerReq;
            case ACHIEV_CRITERIA_THE_HUNDRED_CLUB_10_PLAYER:
            case ACHIEV_CRITERIA_THE_HUNDRED_CLUB_25_PLAYER:
                return _sapphironAchievement;
            case ACHIEV_CRITERIA_THE_UNDYING_KELTHUZAD:
            case ACHIEV_CRITERIA_THE_UNDYING_THE_FOUR_HORSEMEN:
            case ACHIEV_CRITERIA_THE_UNDYING_MAEXXNA:
            case ACHIEV_CRITERIA_THE_UNDYING_LOATHEB:
            case ACHIEV_CRITERIA_THE_UNDYING_THADDIUS:
            case ACHIEV_CRITERIA_THE_IMMORTAL_KELTHUZAD:
            case ACHIEV_CRITERIA_THE_IMMORTAL_THE_FOUR_HORSEMEN:
            case ACHIEV_CRITERIA_THE_IMMORTAL_MAEXXNA:
            case ACHIEV_CRITERIA_THE_IMMORTAL_LOATHEB:
            case ACHIEV_CRITERIA_THE_IMMORTAL_THADDIUS:
                for (int i = 0; i < MAX_ENCOUNTERS; ++i)
                    if (GetBossState(i) != DONE)
                        return false;

                return !GetPersistentData(PERSISTENT_DATA_IMMORTAL_FAIL);
            default:
                return false;
        }
    }

    void SetData(uint32 id, uint32 data) override
    {
        switch (id)
        {
            case DATA_ABOMINATION_KILLED:
                ++_abominationsKilled;
                return;
            case DATA_FRENZY_REMOVED:
                _faerlinaAchievement = false;
                return;
            case DATA_CHARGES_CROSSED:
                _thaddiusAchievement = false;
                return;
            case DATA_SPORE_KILLED:
                _loathebAchievement = false;
                return;
            case DATA_HUNDRED_CLUB:
                _sapphironAchievement = false;
                return;
            case DATA_DANCE_FAIL:
                _heiganAchievement = false;
                return;
            case DATA_HEIGAN_ERUPTION:
                HeiganEruptSections(data);
                return;
            default:
                return;
        }
    }

    bool SetBossState(uint32 bossId, EncounterState state) override
    {
        switch (bossId)
        {
            case BOSS_PATCHWERK:
            {
                if (state != IN_PROGRESS)
                    break;

                // pull all the trash if not killed
                if (Creature* patchwerk = GetCreature(DATA_PATCHWERK_BOSS))
                {
                    for (auto& itr : _patchwerkRoomTrash)
                    {
                        Creature* trash = ObjectAccessor::GetCreature(*patchwerk, itr);
                        if (trash && trash->IsAlive() && !trash->IsInCombat())
                            trash->AI()->AttackStart(patchwerk->GetVictim());
                    }
                }

                break;
            }
            case BOSS_HEIGAN:
            {
                if (state == NOT_STARTED)
                    _heiganAchievement = true;

                break;
            }
            case BOSS_LOATHEB:
            {
                switch (state)
                {
                    case NOT_STARTED:
                        _loathebAchievement = true;
                        break;
                    case DONE:
                        ActivateWingPortal(DATA_LOATHEB_PORTAL);
                        break;
                    default:
                        break;
                }

                break;
            }
            case BOSS_FAERLINA:
            {
                if (state == NOT_STARTED)
                    _faerlinaAchievement = true;

                break;
            }
            case BOSS_MAEXXNA:
            {
                if (state == DONE)
                    ActivateWingPortal(DATA_MAEXXNA_PORTAL);

                break;
            }
            case BOSS_THADDIUS:
            {
                switch (state)
                {
                    case NOT_STARTED:
                        _thaddiusAchievement = true;
                        break;
                    case DONE:
                        ActivateWingPortal(DATA_THADDIUS_PORTAL);
                        break;
                    default:
                        break;
                }

                break;
            }
            case BOSS_HORSEMAN:
            {
                uint32 horsemanKilled = std::count_if(HorsemanDataGroup.begin(), HorsemanDataGroup.end(), [this](auto&& entry)
                {
                    Creature* cr = GetCreature(entry);
                    return cr && !cr->IsAlive();
                });

                switch (state)
                {
                    case NOT_STARTED:
                    {
                        _horsemanAchievement = true;

                        if (!horsemanKilled)
                            break;

                        for (auto&& entry : HorsemanDataGroup)
                        {
                            if (Creature* cr = GetCreature(entry))
                            {
                                cr->SetPosition(cr->GetHomePosition());
                                cr->Respawn();
                            }
                        }

                        break;
                    }
                    case IN_PROGRESS:
                    {
                        for (auto&& entry : HorsemanDataGroup)
                            if (Creature* cr = GetCreature(entry))
                                cr->SetInCombatWithZone();

                        break;
                    }
                    case DONE:
                    {
                        _events.RescheduleEvent(EVENT_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER, 15s);

                        if (horsemanKilled != HorsemanCount)
                            return false;

                        // all horsemans are killed
                        if (Creature* cr = GetCreature(DATA_BARON_RIVENDARE_BOSS))
                            cr->CastSpell(cr, SPELL_THE_FOUR_HORSEMAN_CREDIT, true);

                        ActivateWingPortal(DATA_HORSEMAN_PORTAL);
                        break;
                    }
                    default:
                        break;
                }

                break;
            }
            case BOSS_SAPPHIRON:
            {
                switch (state)
                {
                    case NOT_STARTED:
                        _sapphironAchievement = true;
                        break;
                    case DONE:
                    {
                        if (GetPersistentData(PERSISTENT_DATA_KELTHUZAD_DIALOG))
                            break;

                        StorePersistentData(PERSISTENT_DATA_KELTHUZAD_DIALOG, 1);
                        SetGoState(DATA_KELTHUZAD_GATE, GO_STATE_READY);
                        _events.ScheduleEvent(EVENT_FROSTWYRM_WATERFALL_DOOR, 5s);
                        break;
                    }
                    default:
                        break;
                }

                break;
            }
            case BOSS_KELTHUZAD:
            {
                if (state == NOT_STARTED)
                    _abominationsKilled = 0;

                break;
            }
            default:
                break;
        }

        return InstanceScript::SetBossState(bossId, state);
    }

    void Update(uint32 diff) override
    {
        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_THADDIUS_SCREAMS:
            {
                if (GetBossState(BOSS_THADDIUS) == DONE)
                    break;

                instance->PlayDirectSoundToMap(SOUND_SCREAM + urand(0, 3));
                return _events.ScheduleEvent(EVENT_THADDIUS_SCREAMS, 2min, 2min + 30s);
            }
            case EVENT_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER:
                _horsemanAchievement = false;
                break;
            case EVENT_KELTHUZAD_WING_TAUNT:
                return CreatureTalk(DATA_KELTHUZAD_BOSS, _currentWingTaunt++);
            case EVENT_HORSEMEN_INTRO1:
                CreatureTalk(DATA_THANE_KORTHAZZ_BOSS, SAY_HORSEMEN_DIALOG1);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO2, 4500ms);
            case EVENT_HORSEMEN_INTRO2:
                CreatureTalk(DATA_SIR_ZELIEK_BOSS, SAY_HORSEMEN_DIALOG1);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO3, 6500ms);
            case EVENT_HORSEMEN_INTRO3:
                CreatureTalk(DATA_LADY_BLAUMEUX_BOSS, SAY_HORSEMEN_DIALOG1);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO4, 6500ms);
            case EVENT_HORSEMEN_INTRO4:
                CreatureTalk(DATA_BARON_RIVENDARE_BOSS, SAY_HORSEMEN_DIALOG1);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO5, 6500ms);
            case EVENT_HORSEMEN_INTRO5:
                CreatureTalk(DATA_LADY_BLAUMEUX_BOSS, SAY_HORSEMEN_DIALOG2);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO6, 6500ms);
            case EVENT_HORSEMEN_INTRO6:
                CreatureTalk(DATA_SIR_ZELIEK_BOSS, SAY_HORSEMEN_DIALOG2);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO7, 6500ms);
            case EVENT_HORSEMEN_INTRO7:
                CreatureTalk(DATA_THANE_KORTHAZZ_BOSS, SAY_HORSEMEN_DIALOG2);
                return _events.ScheduleEvent(EVENT_HORSEMEN_INTRO8, 6500ms);
            case EVENT_HORSEMEN_INTRO8:
                return CreatureTalk(DATA_BARON_RIVENDARE_BOSS, SAY_HORSEMEN_DIALOG2);
            case EVENT_FROSTWYRM_WATERFALL_DOOR:
                SetGoState(DATA_SAPPHIRON_GATE, GO_STATE_ACTIVE);
                return _events.ScheduleEvent(EVENT_KELTHUZAD_LICH_KING_TALK1, 5s);
            case EVENT_KELTHUZAD_LICH_KING_TALK1:
                CreatureTalk(DATA_KELTHUZAD_BOSS, SAY_SAPP_DIALOG1);
                return _events.ScheduleEvent(EVENT_KELTHUZAD_LICH_KING_TALK2, 10s);
            case EVENT_KELTHUZAD_LICH_KING_TALK2:
                CreatureTalk(DATA_LICH_KING_BOSS, SAY_SAPP_DIALOG2_LICH);
                return _events.ScheduleEvent(EVENT_KELTHUZAD_LICH_KING_TALK3, 14s);
            case EVENT_KELTHUZAD_LICH_KING_TALK3:
                CreatureTalk(DATA_KELTHUZAD_BOSS, SAY_SAPP_DIALOG3);
                return _events.ScheduleEvent(EVENT_KELTHUZAD_LICH_KING_TALK4, 10s);
            case EVENT_KELTHUZAD_LICH_KING_TALK4:
                CreatureTalk(DATA_LICH_KING_BOSS, SAY_SAPP_DIALOG4_LICH);
                return _events.ScheduleEvent(EVENT_KELTHUZAD_LICH_KING_TALK5, 12s);
            case EVENT_KELTHUZAD_LICH_KING_TALK5:
                CreatureTalk(DATA_KELTHUZAD_BOSS, SAY_SAPP_DIALOG5);
                return _events.ScheduleEvent(EVENT_KELTHUZAD_LICH_KING_TALK6, 5s);
            case EVENT_KELTHUZAD_LICH_KING_TALK6:
                CreatureTalk(DATA_KELTHUZAD_BOSS, SAY_SAPP_DIALOG6);
                return SetGoState(DATA_KELTHUZAD_GATE, GO_STATE_ACTIVE);
            default:
                break;
        }
    }

private:
    // Controls
    EventMap _events;
    uint8 _currentWingTaunt;
    uint8 _horsemanLoaded;

    // GameObjects
    std::set<GameObject*> _heiganEruption[HeiganEruptSectionCount];

    // NPCs
    GuidList _patchwerkRoomTrash;

    // Achievements
    uint8 _abominationsKilled;
    bool _faerlinaAchievement;
    bool _thaddiusAchievement;
    bool _loathebAchievement;
    bool _sapphironAchievement;
    bool _heiganAchievement;
    bool _horsemanAchievement;
};

class npc_mr_bigglesworth : public NullCreatureAI
{
public:
    npc_mr_bigglesworth(Creature* c) : NullCreatureAI(c) { }

    void JustDied(Unit* /*killer*/) override
    {
        InstanceScript* instance = me->GetInstanceScript();
        if (!instance)
            return;

        Creature* kelThuzard = instance->GetCreature(DATA_KELTHUZAD_BOSS);
        if (!kelThuzard)
            return;

        kelThuzard->AI()->Talk(SAY_CAT_DIED);
    }
};

class npc_living_poison : public NullCreatureAI
{
public:
    npc_living_poison(Creature* c) : NullCreatureAI(c) { }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (me->SelectNearestTarget(1.5f, true))
            me->CastSpell(me, SPELL_EXPLODE, true);
    }
};

class npc_naxxramas_trigger : public NullCreatureAI
{
public:
    npc_naxxramas_trigger(Creature* c) : NullCreatureAI(c) { }

    void Reset() override
    {
        _events.Reset();
        _events.ScheduleEvent(EVENT_SUMMON_LIVING_POISON, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);
        switch (_events.ExecuteEvent())
        {
            case EVENT_SUMMON_LIVING_POISON:
            {
                for (LivingPoisonData const& entry : LivingPoisonDataList)
                    if (Creature* cr = me->SummonCreature(NPC_LIVING_POISON, entry.Start, TEMPSUMMON_TIMED_DESPAWN, entry.DespawnTime))
                    {
                        cr->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        cr->GetMotionMaster()->MovePoint(0, entry.End, false);
                    }

                _events.Repeat(5s);
                break;
            }
            default:
                break;
        }
    }

private:
    EventMap _events;
};

class at_naxxramas_hub_portal : public AreaTriggerScript
{
public:
    at_naxxramas_hub_portal() : AreaTriggerScript("at_naxxramas_hub_portal") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (!player->IsAlive() || player->IsInCombat())
            return false;

        InstanceScript* instance = player->GetInstanceScript();
        if (!instance)
            return false;

        if ((instance->GetBossState(BOSS_MAEXXNA)  != DONE) ||
            (instance->GetBossState(BOSS_LOATHEB)  != DONE) ||
            (instance->GetBossState(BOSS_THADDIUS) != DONE) ||
            (instance->GetBossState(BOSS_HORSEMAN) != DONE))
            return false;

        player->TeleportTo(SapphironTeleportPos);
        return true;
    }
};

void AddSC_instance_naxxramas()
{
    RegisterInstanceScript(instance_naxxramas, NaxxramasMapId);
    RegisterNaxxramasCreatureAI(npc_mr_bigglesworth);
    RegisterNaxxramasCreatureAI(npc_living_poison);
    RegisterNaxxramasCreatureAI(npc_naxxramas_trigger);
    new at_naxxramas_hub_portal();
}
