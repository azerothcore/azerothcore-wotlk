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

#include "culling_of_stratholme.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"

enum Says
{
    //Arthas
    //First Act
    SAY_PHASE101                                = 0,
    SAY_PHASE103                                = 1,
    SAY_PHASE104                                = 2,
    SAY_PHASE106                                = 3,
    SAY_PHASE108                                = 4,
    SAY_PHASE110                                = 5,
    SAY_PHASE112                                = 6,
    SAY_PHASE114                                = 7,
    SAY_PHASE116                                = 8,
    SAY_PHASE118                                = 9,

    //Second Act - City Streets
    SAY_PHASE201                                = 10,
    SAY_PHASE203                                = 11,
    SAY_PHASE205                                = 12,
    SAY_PHASE208                                = 13,
    SAY_PHASE209                                = 14,
    SAY_PHASE210                                = 15,

    //Third Act - Town Hall
    SAY_PHASE301                                = 16,
    SAY_PHASE303                                = 17,
    SAY_PHASE304                                = 18,
    SAY_PHASE306                                = 19,
    SAY_PHASE307                                = 20,
    SAY_PHASE308                                = 21,
    SAY_PHASE309                                = 22,
    SAY_PHASE310                                = 23,
    SAY_PHASE311                                = 24,
    SAY_PHASE312                                = 25,
    SAY_PHASE313                                = 26,
    SAY_PHASE315                                = 27,

    //Fourth Act - Fire Corridor
    SAY_PHASE401                                = 28,
    SAY_PHASE402                                = 29,
    SAY_PHASE403                                = 30,
    SAY_PHASE404                                = 31,
    SAY_PHASE405                                = 32,
    SAY_PHASE406                                = 33,
    SAY_PHASE407                                = 34,

    //Fifth Act - Mal'Ganis Fight
    SAY_PHASE501                                = 35,
    SAY_PHASE502                                = 36,
    SAY_PHASE503                                = 37,
    SAY_PHASE504                                = 38,

    //Malganis
    SAY_PHASE206                                = 0,
    SAY_PHASE207                                = 1,

    //Epoch
    SAY_PHASE314                                = 0,

    //Uther
    SAY_PHASE102                                = 0,
    SAY_PHASE105                                = 1,
    SAY_PHASE107                                = 2,
    SAY_PHASE109                                = 3,
    SAY_PHASE111                                = 4,
    SAY_PHASE115                                = 5,

    //Jaina
    SAY_PHASE113                                = 0,
    SAY_PHASE117                                = 1,

    //Cityman
    SAY_PHASE202                                = 0,
    SAY_PHASE204_1                              = 0,

    //Crazyman
    SAY_PHASE204                                = 1,

    //Drakonian
    SAY_PHASE302                                = 0,
    SAY_PHASE305                                = 1,
    SAY_PHASE305_1                              = 39,
};

enum NPCs
{
    // City part
    NPC_RISEN_ZOMBIE                        = 27737,
    NPC_DEVOURING_GHOUL                     = 28249,
    NPC_DARK_NECROMANCER                    = 28200,
    NPC_TOMB_STALKER                        = 28199,
    NPC_CRYPT_FIEND                         = 27734,
    NPC_BILE_GOLEM                          = 28201,
    NPC_ENRAGING_GHOUL                      = 27729,
    NPC_PATCHWORK_CONSTRUCT                 = 27736,

    // Town hall part
    NPC_INFINITE_ADVERSARY                  = 27742,
    NPC_INFINITE_HUNTER                     = 27743,
    NPC_INFINITE_AGENT                      = 27744,

    // Generic
    NPC_INVIS_TARGET                        = 20562,
    NPC_KNIGHT_ESCORT                       = 27745,
    NPC_HORSE_ESCORT                        = 27746,
    NPC_PRIEST_ESCORT                       = 27747,
    NPC_CITY_MAN                            = 28167,
    NPC_CITY_MAN2                           = 28169,
    NPC_CITY_MAN3                           = 31126,
    NPC_CITY_MAN4                           = 31127,
};

enum Spells
{
    // Combat spells
    SPELL_ARTHAS_AURA                       = 52442,
    SPELL_ARTHAS_EXORCISM_N                 = 52445,
    SPELL_ARTHAS_EXORCISM_H                 = 58822,
    SPELL_ARTHAS_HOLY_LIGHT                 = 52444,

    // Visuals
    SPELL_MALGANIS_APPEAR                   = 51908,
    SPELL_GREEN_VISUAL_AURA                 = 25039,
    SPELL_ARTHAS_CRUSADER_STRIKE            = 50773,
};

enum GossipMenuArthas
{
    GOSSIP_MENU_ARTHAS_1                     = 13076,
    GOSSIP_MENU_ARTHAS_2                     = 13125,
    GOSSIP_MENU_ARTHAS_3                     = 13126,
    GOSSIP_MENU_ARTHAS_4                     = 13177,
    GOSSIP_MENU_ARTHAS_5                     = 13179,
    GOSSIP_MENU_ARTHAS_6                     = 13287,
};

enum Misc
{
    // City waves
    ENCOUNTER_WAVES_NUMBER                  = 8,
    ENCOUNTER_WAVES_MAX_SPAWNS              = 4,

    // Town Hall waves
    ENCOUNTER_CHRONO_NUMBER                 = 5,
    ENCOUNTER_CHRONO_MAX_SPAWNS_FIRST       = 5,
    ENCOUNTER_CHRONO_MAX_SPAWNS_SECOND      = 3,

    ACTION_INFECT_CITIZIEN                  = 1,
    ACTION_FORCE_CHANGE_LOCK                = 2,

    POINT_CHRONOS                           = 1,
};

enum Events
{
    EVENT_COMBAT_EXORCISM                   = 1,
    EVENT_COMBAT_HEALTH_CHECK               = 2,
    EVENT_ACTION_PHASE1                     = 100,
    EVENT_ACTION_PHASE2                     = 200,
    EVENT_ACTION_PHASE3                     = 300,
    EVENT_ACTION_PHASE5                     = 500,
};

// Locations for necromancers and add to spawn
float WavesLocations[ENCOUNTER_WAVES_NUMBER][ENCOUNTER_WAVES_MAX_SPAWNS][5] =
{
    {
        {NPC_RISEN_ZOMBIE, 2164.698975f, 1255.392944f, 135.040878f, 0.490202f},
        {NPC_RISEN_ZOMBIE, 2183.501465f, 1263.079102f, 134.859055f, 3.169981f},
        {NPC_DEVOURING_GHOUL, 2177.512939f, 1247.313843f, 135.846695f, 1.696574f},
        {NPC_DEVOURING_GHOUL, 2171.991943f, 1246.615845f, 135.745026f, 1.696574f}
    },
    {
        {NPC_DEVOURING_GHOUL, 2254.434326f, 1163.427612f, 138.055038f, 2.077358f},
        {NPC_DEVOURING_GHOUL, 2254.703613f, 1158.867798f, 138.212234f, 2.345532f},
        {NPC_DEVOURING_GHOUL, 2257.615723f, 1162.310913f, 138.091202f, 2.077358f},
        {NPC_DARK_NECROMANCER, 2258.258057f, 1157.250732f, 138.272873f, 2.387766f}
    },
    {
        {NPC_TOMB_STALKER, 2348.120117f, 1202.302490f, 130.491104f, 4.698538f},
        {NPC_DEVOURING_GHOUL, 2352.863525f, 1207.819092f, 130.424271f, 4.949865f},
        {NPC_DEVOURING_GHOUL, 2343.593750f, 1207.915039f, 130.781311f, 4.321547f},
        {NPC_DARK_NECROMANCER, 2348.257324f, 1212.202515f, 130.670135f, 4.450352f}
    },
    {
        {NPC_TOMB_STALKER, 2139.825195f, 1356.277100f, 132.199615f, 5.820131f},
        {NPC_DEVOURING_GHOUL, 2137.073486f, 1362.464844f, 132.271637f, 5.820131f},
        {NPC_DEVOURING_GHOUL, 2134.075684f, 1354.148071f, 131.885864f, 5.820131f},
        {NPC_DARK_NECROMANCER, 2133.302246f, 1358.907837f, 132.037689f, 5.820131f}
    },
    {
        {NPC_DARK_NECROMANCER, 2164.698975f, 1255.392944f, 135.040878f, 0.490202f},
        {NPC_DEVOURING_GHOUL, 2183.501465f, 1263.079102f, 134.859055f, 3.169981f},
        {NPC_TOMB_STALKER, 2177.512939f, 1247.313843f, 135.846695f, 1.696574f},
        {NPC_CRYPT_FIEND, 2171.991943f, 1246.615845f, 135.745026f, 1.696574f}
    },
    {
        {NPC_BILE_GOLEM, 2349.701660f, 1188.436646f, 130.428864f, 3.908642f},
        {NPC_DEVOURING_GHOUL, 2349.909180f, 1194.582642f, 130.417816f, 3.577001f},
        {NPC_ENRAGING_GHOUL, 2354.662598f, 1185.692017f, 130.552032f, 3.577001f},
        {NPC_ENRAGING_GHOUL, 2354.716797f, 1191.614380f, 130.539810f, 3.577001f}
    },
    {
        {NPC_PATCHWORK_CONSTRUCT, 2145.212891f, 1355.288086f, 132.288773f, 6.004838f},
        {NPC_DARK_NECROMANCER, 2137.078613f, 1357.612671f, 132.173340f, 6.004838f},
        {NPC_ENRAGING_GHOUL, 2139.402100f, 1352.541626f, 132.127518f, 5.812850f},
        {NPC_ENRAGING_GHOUL, 2142.408447f, 1360.760620f, 132.321564f, 5.812850f}
    },
    {
        {NPC_DEVOURING_GHOUL, 2172.686279f, 1259.618164f, 134.391754f, 1.865499f},
        {NPC_CRYPT_FIEND, 2177.649170f, 1256.061157f, 135.096512f, 1.849572f},
        {NPC_PATCHWORK_CONSTRUCT, 2170.782959f, 1253.594849f, 134.973022f, 1.849572f},
        {NPC_DARK_NECROMANCER, 2175.595703f, 1249.041992f, 135.603531f, 1.849572f}
    }
};

// Locations for rifts to spawn and draconians to go
float RiftAndSpawnsLocations[ENCOUNTER_CHRONO_NUMBER][ENCOUNTER_CHRONO_MAX_SPAWNS_FIRST][5] =
{
    {
        {NPC_TIME_RIFT, 2431.790039f, 1190.670044f, 148.076004f, 0.187923f},
        {NPC_INFINITE_ADVERSARY, 2433.857910f, 1185.612061f, 148.075974f, 4.566168f},
        {NPC_INFINITE_ADVERSARY, 2437.577881f, 1188.241089f, 148.075974f, 0.196999f},
        {NPC_INFINITE_AGENT, 2437.165527f, 1192.294922f, 148.075974f, 0.169247f},
        {NPC_INFINITE_HUNTER, 2434.989990f, 1197.679565f, 148.075974f, 0.715971f}
    },
    {
        {NPC_TIME_RIFT, 2403.954834f, 1178.815430f, 148.075943f, 4.966126f},
        {NPC_INFINITE_AGENT, 2403.676758f, 1171.495850f, 148.075607f, 4.902797f},
        {NPC_INFINITE_HUNTER, 2407.691162f, 1172.162720f, 148.075607f, 4.963010f},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    },
    {
        {NPC_TIME_RIFT, 2414.217041f, 1133.446167f, 148.076050f, 1.706972f},
        {NPC_INFINITE_ADVERSARY, 2416.024658f, 1139.456177f, 148.076431f, 1.752129f},
        {NPC_INFINITE_HUNTER, 2410.866699f, 1139.680542f, 148.076431f, 1.752129f},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    },
    {
        {NPC_TIME_RIFT, 2433.081543f, 1099.869751f, 148.076157f, 1.809509f},
        {NPC_INFINITE_ADVERSARY, 2426.947998f, 1107.471680f, 148.076019f, 1.877580f},
        {NPC_INFINITE_HUNTER, 2432.944580f, 1108.896362f, 148.208160f, 2.199241f},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    },
    {
        {NPC_TIME_RIFT, 2444.077637f, 1114.366089f, 148.076157f, 3.049565f},
        {NPC_INFINITE_ADVERSARY, 2438.190674f, 1118.368164f, 148.076172f, 3.139232f},
        {NPC_INFINITE_AGENT, 2435.861328f, 1113.402954f, 148.169327f, 2.390271f},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    }
};

class npc_arthas : public CreatureScript
{
public:
    npc_arthas() : CreatureScript("npc_arthas") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        if (creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
        {
            switch (action)
            {
                case GOSSIP_ACTION_INFO_DEF+1:
                    creature->AI()->DoAction(ACTION_START_CITY);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+2:
                    ClearGossipMenuFor(player);
                    AddGossipItemFor(player, 9681, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    SendGossipMenuFor(player, GOSSIP_MENU_ARTHAS_3, creature->GetGUID());
                    break;
                case GOSSIP_ACTION_INFO_DEF+3:
                    // Start Town Hall part
                    creature->AI()->DoAction(ACTION_START_TOWN_HALL);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+4:
                    // After killing epoch
                    creature->AI()->DoAction(ACTION_START_SECRET_PASSAGE);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    creature->SetTarget();
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+5:
                    creature->AI()->DoAction(ACTION_START_LAST_CITY);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+6:
                    creature->AI()->DoAction(ACTION_START_MALGANIS);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    CloseGossipMenuFor(player);
                    break;
            }
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
            return false;

        switch (pInstance->GetData(DATA_ARTHAS_EVENT))
        {
            case COS_PROGRESS_FINISHED_INTRO:
                AddGossipItemFor(player, 9653, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, GOSSIP_MENU_ARTHAS_1, creature->GetGUID());
                break;
            case COS_PROGRESS_REACHED_TOWN_HALL:
                AddGossipItemFor(player, 9680, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_MENU_ARTHAS_2, creature->GetGUID());
                break;
            case COS_PROGRESS_KILLED_EPOCH:
                AddGossipItemFor(player, 9695, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, GOSSIP_MENU_ARTHAS_4, creature->GetGUID());
                break;
            case COS_PROGRESS_LAST_CITY:
                AddGossipItemFor(player, 9696, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, GOSSIP_MENU_ARTHAS_5, creature->GetGUID());
                break;
            case COS_PROGRESS_BEFORE_MALGANIS:
                AddGossipItemFor(player, 9676, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, GOSSIP_MENU_ARTHAS_6, creature->GetGUID());
                break;
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<npc_arthasAI>(creature);
    }

    struct npc_arthasAI : public npc_escortAI
    {
        npc_arthasAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList summons;
        bool eventInRun;
        EventMap actionEvents;
        EventMap combatEvents;
        uint8 waveGroupId;
        uint8 waveKillCount;
        uint8 timeRiftId;

        Creature* GetEventNpc(uint32 entry);
        void ScheduleNextEvent(uint32 currentEvent, uint32 time);
        void SummonNextWave();
        void ReorderInstance(uint32 data);
        void JustEngagedWith(Unit* /*who*/) override ;
        void SendNextWave(uint32 entry);
        void SpawnTimeRift();

        void JustDied(Unit*) override
        {
            RemoveEscortState(STATE_ESCORT_ESCORTING);
            if (pInstance)
                pInstance->SetData(DATA_ARTHAS_REPOSITION, 2);
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void SummonedCreatureDespawn(Creature* cr) override { summons.Despawn(cr); }

        void SummonedCreatureDies(Creature* cr, Unit*) override
        {
            if (pInstance && pInstance->GetData(DATA_ARTHAS_EVENT) > COS_PROGRESS_FINISHED_INTRO && pInstance->GetData(DATA_ARTHAS_EVENT) < COS_PROGRESS_REACHED_TOWN_HALL)
                SendNextWave(cr->GetEntry());
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_EVENT)
            {
                // Event
                eventInRun = true;
                actionEvents.ScheduleEvent(EVENT_ACTION_PHASE1, 0);
            }
            else if (param == ACTION_START_CITY)
            {
                Talk(SAY_PHASE201);
                actionEvents.ScheduleEvent(EVENT_ACTION_PHASE2, 12000);
                SetRun(false);
                eventInRun = true;

                me->SummonCreature(NPC_CITY_MAN, EventPos[EVENT_SRC_TOWN_CITYMAN1]);
                me->SummonCreature(NPC_CITY_MAN2, EventPos[EVENT_SRC_TOWN_CITYMAN2]);
            }
            else if (param == ACTION_KILLED_SALRAMM)
            {
                waveGroupId = 10;
                eventInRun = true;
                SetRun(true);
                actionEvents.ScheduleEvent(EVENT_ACTION_PHASE2 + 9, 10000);
            }
            else if (param == ACTION_START_TOWN_HALL)
            {
                Talk(SAY_PHASE301);
                SetEscortPaused(false);
                SetRun(false);

                if (Creature* cr = me->SummonCreature(NPC_CITY_MAN3, EventPos[EVENT_SRC_HALL_CITYMAN1]))
                {
                    cr->AI()->DoAction(ACTION_FORCE_CHANGE_LOCK);
                }
                if (Creature* cr = me->SummonCreature(NPC_CITY_MAN4, EventPos[EVENT_SRC_HALL_CITYMAN2]))
                {
                    cr->AI()->DoAction(ACTION_FORCE_CHANGE_LOCK);
                }
                if (Creature* cr = me->SummonCreature(NPC_CITY_MAN,  EventPos[EVENT_SRC_HALL_CITYMAN3]))
                {
                    cr->AI()->DoAction(ACTION_FORCE_CHANGE_LOCK);
                }
            }
            else if (param == ACTION_START_SECRET_PASSAGE)
            {
                Talk(SAY_PHASE401);
                SetEscortPaused(false);
                SetRun(false);
            }
            else if (param == ACTION_START_LAST_CITY)
            {
                Talk(SAY_PHASE404);
                SetEscortPaused(false);
                SetRun(true);
            }
            else if (param == ACTION_START_MALGANIS)
            {
                summons.DespawnAll();
                if (Creature* cr = me->SummonCreature(NPC_MAL_GANIS, EventPos[EVENT_SRC_MALGANIS_FINAL]))
                {
                    summons.Despawn(cr);
                    summons.Summon(cr);
                    cr->SetImmuneToAll(true);
                    cr->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                }
                Talk(SAY_PHASE501);
                SetEscortPaused(false);
                SetRun(true);
            }
            else if (param == ACTION_KILLED_MALGANIS)
            {
                EnterEvadeMode();
                eventInRun = true;
                actionEvents.ScheduleEvent(EVENT_ACTION_PHASE5 + 1, 22000);
                me->SetFacingTo(1.84f);

                if (!me->GetMap()->GetPlayers().IsEmpty())
                    if (Player* player = me->GetMap()->GetPlayers().getFirst()->GetSource())
                        player->RewardPlayerAndGroupAtEvent(31006, player); // Malganis quest entry required
            }
        }

        void Reset() override
        {
            actionEvents.Reset();
            combatEvents.Reset();
            summons.DespawnAll();
            eventInRun = false;
            waveGroupId = 0;
            waveKillCount = 0;
            timeRiftId = 0;

            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (pInstance)
            {
                pInstance->SetData(DATA_ARTHAS_REPOSITION, 1);
                uint32 data = pInstance->GetData(DATA_ARTHAS_EVENT);
                if (data >= COS_PROGRESS_FINISHED_INTRO)
                    ReorderInstance(data);
            }
        }

        void WaypointReached(uint32 uiPointId) override
        {
            switch (uiPointId)
            {
                // Starting waypoint, After reaching uther and jaina
                case 0:
                // On the mountain with uther and jaina
                case 1:
                // Reaching city man in city
                case 9:
                // Reaching city man in town hall
                case 23:
                    SetEscortPaused(true);
                    eventInRun = true;
                    break;
                // After intro, in front of bridge
                case 3:
                    SetRun(true);
                    Talk(SAY_PHASE118);
                    summons.DespawnAll(); // uther, jaina and horses
                    break;
                // Reached City
                case 8:
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    SetEscortPaused(true);
                    if (pInstance)
                        pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_FINISHED_INTRO);

                    if (Creature* stalker = me->SummonCreature(NPC_INVIS_TARGET, 2026.469f, 1287.088f, 143.596f, 1.37f, TEMPSUMMON_TIMED_DESPAWN, 14000))
                    {
                        me->SetFacingToObject(stalker);
                        stalker->DespawnOrUnsummon(500);
                    }
                    break;
                // Reached first cityman
                case 10:
                    if (Creature* cityman = GetEventNpc(NPC_CITY_MAN))
                    {
                        cityman->AI()->Talk(SAY_PHASE204);
                        me->CastSpell(cityman, SPELL_ARTHAS_CRUSADER_STRIKE, true);
                    }
                    break;
                // Reached second cityman
                case 11:
                    if (Creature* cityman = GetEventNpc(NPC_CITY_MAN2))
                    {
                        cityman->AI()->Talk(SAY_PHASE204_1);
                        me->CastSpell(cityman, SPELL_ARTHAS_CRUSADER_STRIKE, true);
                    }
                    me->SetReactState(REACT_DEFENSIVE);
                    SetEscortPaused(true);
                    eventInRun = true;
                    break;
                // Reached Town Hall
                case 20:
                    if (pInstance)
                        pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_REACHED_TOWN_HALL);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    SetRun(false);
                    SetEscortPaused(true);
                    break;
                // Inside Town Hall first scene pos
                case 22:
                    actionEvents.ScheduleEvent(EVENT_ACTION_PHASE3, 0);
                    eventInRun = true;
                    SetEscortPaused(true);
                    break;
                // Town Hall, upper floor first fight
                case 26:
                    SetEscortPaused(true);
                    eventInRun = true;
                    SpawnTimeRift();
                    Talk(SAY_PHASE307);
                    break;
                // Town Hall, upper floor second fight
                case 29:
                    SpawnTimeRift();
                    SpawnTimeRift();
                    Talk(SAY_PHASE309);
                    SetEscortPaused(true);
                    eventInRun = true;
                    break;
                // Town Hall, upper floor third fight
                case 31:
                    SetRun(false);
                    SpawnTimeRift();
                    SpawnTimeRift();
                    Talk(SAY_PHASE312);
                    SetEscortPaused(true);
                    eventInRun = true;
                    break;
                // Book Shelf
                case 34:
                    Talk(SAY_PHASE402);
                    break;
                case 35:
                    Talk(SAY_PHASE403);
                    break;
                // Reached book shelf
                case 36:
                    SetRun(true);
                    if (pInstance)
                        if (GameObject* pGate = pInstance->instance->GetGameObject(pInstance->GetGuidData(DATA_SHKAF_GATE)))
                            pGate->SetGoState(GO_STATE_ACTIVE);
                    break;
                // Behind secred passage
                case 45:
                    SetRun(true);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    SetEscortPaused(true);
                    if (pInstance)
                        pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_LAST_CITY);
                    break;
                // Some walk talk
                case 47:
                    SetRun(false);
                    Talk(SAY_PHASE405);
                    break;
                case 48:
                    SetRun(true);
                    Talk(SAY_PHASE406);
                    break;
                case 53:
                    Talk(SAY_PHASE407);
                    break;
                // Before Malganis event
                case 54:
                    if (pInstance)
                        pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_BEFORE_MALGANIS);

                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    SetEscortPaused(true);
                    break;
                // Infront of malganis
                case 55:
                    Talk(SAY_PHASE502);
                    actionEvents.ScheduleEvent(EVENT_ACTION_PHASE5, 7000);
                    SetEscortPaused(true);
                    eventInRun = true;
                    break;
                // After malganis defeat
                case 56:
                    SetEscortPaused(true);
                    eventInRun = true;
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (eventInRun)
            {
                actionEvents.Update(diff);
                switch (uint32 currentEvent = actionEvents.ExecuteEvent())
                {
                    case EVENT_ACTION_PHASE1:
                        SetRun(false);
                        me->SummonCreature(NPC_JAINA, EventPos[EVENT_SRC_JAINA], TEMPSUMMON_DEAD_DESPAWN, 180000);
                        if (Creature* uther = me->SummonCreature(NPC_UTHER, EventPos[EVENT_SRC_UTHER], TEMPSUMMON_DEAD_DESPAWN, 180000))
                        {
                            uther->GetMotionMaster()->MovePoint(0, EventPos[EVENT_DST_UTHER], false);
                            uther->SetTarget(me->GetGUID());
                            me->SetTarget(uther->GetGUID());
                        }
                        for (int i = 0; i < 3; ++i)
                            if (Creature* horse = me->SummonCreature(NPC_HORSE_ESCORT, EventPos[EVENT_SRC_HORSE1 + i], TEMPSUMMON_DEAD_DESPAWN, 180000))
                                horse->GetMotionMaster()->MovePoint(0, EventPos[EVENT_DST_HORSE1 + i], false);

                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+1:
                        // Start Event
                        Start(true, false);
                        SetDespawnAtEnd(false);

                        ScheduleNextEvent(currentEvent, 9000);
                        break;
                    // After waypoint 0
                    case EVENT_ACTION_PHASE1+2:
                        Talk(SAY_PHASE101);
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE1+3:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                            uther->AI()->Talk(SAY_PHASE102);

                        ScheduleNextEvent(currentEvent, 8000);
                        break;
                    case EVENT_ACTION_PHASE1+4:
                        SetEscortPaused(false);
                        eventInRun = false;
                        Talk(SAY_PHASE103);
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    // After waypoint 1
                    case EVENT_ACTION_PHASE1+5:
                        if (Creature* jaina = GetEventNpc(NPC_JAINA))
                            jaina->SetTarget(me->GetGUID());

                        Talk(SAY_PHASE104);
                        ScheduleNextEvent(currentEvent, 10000);
                        break;
                    case EVENT_ACTION_PHASE1+6:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                            uther->AI()->Talk(SAY_PHASE105);

                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE1+7:
                        Talk(SAY_PHASE106);
                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+8:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                            uther->AI()->Talk(SAY_PHASE107);

                        ScheduleNextEvent(currentEvent, 6000);
                        break;
                    case EVENT_ACTION_PHASE1+9:
                        Talk(SAY_PHASE108);
                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+10:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                            uther->AI()->Talk(SAY_PHASE109);

                        ScheduleNextEvent(currentEvent, 8000);
                        break;
                    case EVENT_ACTION_PHASE1+11:
                        Talk(SAY_PHASE110);
                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+12:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                            uther->AI()->Talk(SAY_PHASE111);

                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+13:
                        Talk(SAY_PHASE112);
                        ScheduleNextEvent(currentEvent, 11000);
                        break;
                    case EVENT_ACTION_PHASE1+14:
                        if (Creature* jaina = GetEventNpc(NPC_JAINA))
                            jaina->AI()->Talk(SAY_PHASE113);

                        ScheduleNextEvent(currentEvent, 2500);
                        break;
                    case EVENT_ACTION_PHASE1+15:
                        Talk(SAY_PHASE114);
                        ScheduleNextEvent(currentEvent, 9000);
                        break;
                    case EVENT_ACTION_PHASE1+16:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                            uther->AI()->Talk(SAY_PHASE115);

                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+17:
                        for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
                        {
                            Creature* summon = ObjectAccessor::GetCreature(*me, *i);
                            if (summon && summon->GetEntry() == NPC_HORSE_ESCORT)
                                summon->GetMotionMaster()->MovePoint(0, EventPos[EVENT_POS_RETREAT], false);
                        }

                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE1+18:
                        if (Creature* uther = GetEventNpc(NPC_UTHER))
                        {
                            uther->SetTarget();
                            uther->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            uther->GetMotionMaster()->MovePoint(0, EventPos[EVENT_POS_RETREAT], false);
                        }
                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE1+19:
                        if (Creature* jaina = GetEventNpc(NPC_JAINA))
                        {
                            jaina->SetTarget();
                            jaina->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            jaina->GetMotionMaster()->MovePoint(0, EventPos[EVENT_POS_RETREAT], false);
                        }
                        Talk(SAY_PHASE116);
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE1+20:
                        if (Creature* jaina = GetEventNpc(NPC_JAINA))
                        {
                            jaina->GetMotionMaster()->MoveIdle();
                            jaina->AI()->Talk(SAY_PHASE117);
                        }

                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE1+21:
                        if (Creature* jaina = GetEventNpc(NPC_JAINA))
                        {
                            jaina->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            jaina->GetMotionMaster()->MovePoint(0, EventPos[EVENT_POS_RETREAT], false);
                        }
                        summons.DespawnEntry(NPC_HORSE_ESCORT);
                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE1+22:
                        SetEscortPaused(false);
                        eventInRun = false;
                        me->SetTarget();
                        // dont schedule next, do it in gossip select!
                        break;
                    //After Gossip 1 (waypoint 8)
                    case EVENT_ACTION_PHASE2:
                        summons.DespawnEntry(NPC_INVIS_TARGET); // remove trigger
                        me->SetTarget();
                        SetEscortPaused(false);
                        eventInRun = false;
                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    // After waypoint 9
                    case EVENT_ACTION_PHASE2+1:
                        if (Creature* cityman = GetEventNpc(NPC_CITY_MAN))
                        {
                            cityman->AI()->Talk(SAY_PHASE202);
                            cityman->SetTarget(me->GetGUID());
                            cityman->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            cityman->GetMotionMaster()->MovePoint(0, EventPos[EVENT_DST_CITYMAN]);
                        }

                        ScheduleNextEvent(currentEvent, 9000);
                        break;
                    case EVENT_ACTION_PHASE2+2:
                        Talk(SAY_PHASE203);
                        SetEscortPaused(false);
                        eventInRun = false;
                        ScheduleNextEvent(currentEvent, 1500);
                        break;
                    // After waypoint 11
                    case EVENT_ACTION_PHASE2+3:
                        if (Creature* stalker = me->SummonCreature(NPC_INVIS_TARGET, 2081.447f, 1287.770f, 141.3241f, 1.37f, TEMPSUMMON_TIMED_DESPAWN, 10000))
                        {
                            me->SetFacingToObject(stalker);
                            stalker->DespawnOrUnsummon(500);
                        }
                        Talk(SAY_PHASE205);
                        ScheduleNextEvent(currentEvent, 4000);
                        break;
                    case EVENT_ACTION_PHASE2+4:
                        if (Creature* malganis = me->SummonCreature(NPC_MAL_GANIS, EventPos[EVENT_SRC_MALGANIS], TEMPSUMMON_TIMED_DESPAWN, 60000))
                        {
                            malganis->CastSpell(malganis, SPELL_MALGANIS_APPEAR, true);
                            malganis->AI()->Talk(SAY_PHASE206);
                            malganis->SetTarget(me->GetGUID());
                            me->SetTarget(malganis->GetGUID());
                            malganis->SetReactState(REACT_PASSIVE);

                            std::list<Creature*> unitList;
                            malganis->GetCreaturesWithEntryInRange(unitList, 20.0f, NPC_CITY_MAN);
                            malganis->GetCreaturesWithEntryInRange(unitList, 20.0f, NPC_CITY_MAN2);

                            for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                                if ((*itr)->ToCreature())
                                {
                                    (*itr)->ToCreature()->AI()->DoAction(ACTION_INFECT_CITIZIEN);
                                    (*itr)->GetMotionMaster()->MoveFleeing(malganis, 2000);
                                }

                            unitList.clear();
                        }

                        ScheduleNextEvent(currentEvent, 12000);
                        break;
                    case EVENT_ACTION_PHASE2+5:
                        if (Creature* malganis = GetEventNpc(NPC_MAL_GANIS))
                            malganis->AI()->Talk(SAY_PHASE207);

                        ScheduleNextEvent(currentEvent, 15000);
                        break;
                    case EVENT_ACTION_PHASE2+6:
                        if (Creature* malganis = GetEventNpc(NPC_MAL_GANIS))
                        {
                            me->SetTarget();
                            me->SetFacingToObject(malganis);
                            malganis->SetVisible(false);
                        }

                        Talk(SAY_PHASE208);
                        ScheduleNextEvent(currentEvent, 11000);
                        break;
                    case EVENT_ACTION_PHASE2+7:
                        summons.DespawnEntry(NPC_MAL_GANIS);
                        summons.DespawnEntry(NPC_CITY_MAN);
                        summons.DespawnEntry(NPC_CITY_MAN2);
                        Talk(SAY_PHASE209);
                        me->SetReactState(REACT_DEFENSIVE);
                        ScheduleNextEvent(currentEvent, 20000);
                        if (pInstance)
                            pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_FINISHED_CITY_INTRO);
                        break;
                    case EVENT_ACTION_PHASE2+8:
                        if (pInstance)
                            pInstance->SetData(DATA_START_WAVES, 1);

                        SummonNextWave();
                        break;
                    case EVENT_ACTION_PHASE2+9:
                        if (pInstance)
                            pInstance->DoUpdateWorldState(WORLDSTATE_WAVE_COUNT, 0);

                        Talk(SAY_PHASE210);
                        eventInRun = false;
                        SetEscortPaused(false);
                        break;
                    // After waypoint 22
                    case EVENT_ACTION_PHASE3:
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN3))
                            cr->SetTarget(me->GetGUID());
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN4))
                            cr->SetTarget(me->GetGUID());
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN))
                            cr->SetTarget(me->GetGUID());
                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE3+1:
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN3))
                            cr->AI()->Talk(SAY_PHASE302);

                        ScheduleNextEvent(currentEvent, 7000);
                        break;
                    case EVENT_ACTION_PHASE3+2:
                        Talk(SAY_PHASE303);
                        SetEscortPaused(false);
                        eventInRun = false;
                        ScheduleNextEvent(currentEvent, 0);
                        break;
                    //After waypoint 23
                    case EVENT_ACTION_PHASE3+3:
                        SetRun(true);
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN3))
                            me->CastSpell(cr, SPELL_ARTHAS_CRUSADER_STRIKE, true);
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE3+4:
                        Talk(SAY_PHASE304);
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE3+5:
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN3))
                            cr->AI()->Talk(SAY_PHASE305);
                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE3+6:
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN))
                        {
                            cr->UpdateEntry(NPC_INFINITE_HUNTER, nullptr, false);
                            cr->SetImmuneToAll(true);
                            cr->SetReactState(REACT_PASSIVE);
                        }
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE3+7:
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN4))
                        {
                            cr->UpdateEntry(NPC_INFINITE_AGENT, nullptr, false);
                            cr->SetImmuneToAll(true);
                            cr->SetReactState(REACT_PASSIVE);
                        }
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE3+8:
                        if (Creature* cr = GetEventNpc(NPC_CITY_MAN3))
                        {
                            cr->UpdateEntry(NPC_INFINITE_ADVERSARY, nullptr, false);
                            cr->SetReactState(REACT_AGGRESSIVE);
                            cr->SetInCombatWithZone();
                            cr->AddThreat(me, 0.0f);
                        }
                        if (Creature* cr = GetEventNpc(NPC_INFINITE_AGENT)) // it is infinite agent now :)
                        {
                            cr->SetImmuneToAll(false);
                            cr->SetReactState(REACT_AGGRESSIVE);
                            cr->SetInCombatWithZone();
                            cr->AddThreat(me, 0.0f);
                        }
                        if (Creature* cr = GetEventNpc(NPC_INFINITE_HUNTER)) // it is infinite hunter now :)
                        {
                            cr->SetImmuneToAll(false);
                            cr->SetReactState(REACT_AGGRESSIVE);
                            cr->SetInCombatWithZone();
                            cr->AddThreat(me, 0.0f);
                        }
                        ScheduleNextEvent(currentEvent, 2000);
                        break;
                    case EVENT_ACTION_PHASE3+9:
                        // Arthas is fighting infinites in town hall
                        if (me->IsInCombat())
                        {
                            actionEvents.RepeatEvent(1000);
                            return;
                        }

                        summons.DespawnAll();
                        Talk(SAY_PHASE305_1);
                        me->SetFacingTo(0.0f);
                        ScheduleNextEvent(currentEvent, 5000);
                        break;
                    case EVENT_ACTION_PHASE3+10:
                        Talk(SAY_PHASE306);
                        ScheduleNextEvent(currentEvent, 5000);
                        break;
                    case EVENT_ACTION_PHASE3+11:
                        SetEscortPaused(false);
                        eventInRun = false;
                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE3+12:
                        // Arthas is fighting first chronos
                        if (me->IsInCombat())
                        {
                            actionEvents.RepeatEvent(1000);
                            return;
                        }

                        eventInRun = false;
                        SetEscortPaused(false);
                        Talk(SAY_PHASE308);
                        me->SetFacingTo(M_PI);
                        ScheduleNextEvent(currentEvent, 0);
                        break;
                    case EVENT_ACTION_PHASE3+13:
                        // Arthas is fighting second chronos
                        if (me->IsInCombat())
                        {
                            actionEvents.RepeatEvent(1000);
                            return;
                        }

                        eventInRun = false;
                        SetEscortPaused(false);
                        Talk(SAY_PHASE311);
                        me->SetFacingTo(M_PI * 3 / 2);
                        ScheduleNextEvent(currentEvent, 0);
                        break;
                    case EVENT_ACTION_PHASE3+14:
                        // Arthas is fighting third chronos
                        if (me->IsInCombat())
                        {
                            actionEvents.RepeatEvent(1000);
                            return;
                        }

                        me->SetFacingTo(M_PI / 2);
                        ScheduleNextEvent(currentEvent, 8000);
                        break;
                    case EVENT_ACTION_PHASE3+15:
                        Talk(SAY_PHASE313);
                        me->SummonCreature(NPC_TIME_RIFT, EventPos[EVENT_SRC_EPOCH], TEMPSUMMON_TIMED_DESPAWN, 20000);
                        if (Creature* cr = me->SummonCreature(NPC_EPOCH, EventPos[EVENT_SRC_EPOCH]))
                        {
                            cr->SetImmuneToAll(true);
                            cr->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            me->SetTarget(cr->GetGUID());
                            cr->GetMotionMaster()->MovePoint(0, EventPos[EVENT_DST_EPOCH]);
                        }

                        ScheduleNextEvent(currentEvent, 3000);
                        break;
                    case EVENT_ACTION_PHASE3+16:
                        if (Creature* cr = GetEventNpc(NPC_EPOCH))
                            cr->AI()->Talk(SAY_PHASE314);

                        ScheduleNextEvent(currentEvent, 14000);
                        break;
                    case EVENT_ACTION_PHASE3+17:
                        Talk(SAY_PHASE315);
                        ScheduleNextEvent(currentEvent, 7000);
                        break;
                    case EVENT_ACTION_PHASE3+18:
                        if (Creature* cr = GetEventNpc(NPC_EPOCH))
                        {
                            cr->SetImmuneToAll(false);
                            cr->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            cr->SetReactState(REACT_AGGRESSIVE);
                            cr->AddThreat(me, 0.0f);
                            cr->SetInCombatWithZone();
                        }
                        ScheduleNextEvent(currentEvent, 1000);
                        break;
                    case EVENT_ACTION_PHASE3+19:
                        // Arthas is fighting epoch chronos
                        if (me->IsInCombat())
                        {
                            actionEvents.RepeatEvent(1000);
                            return;
                        }

                        if (pInstance)
                            pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_KILLED_EPOCH);

                        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        eventInRun = false;
                        break;
                    case EVENT_ACTION_PHASE5:
                        if (Creature* cr = GetEventNpc(NPC_MAL_GANIS))
                        {
                            cr->SetImmuneToAll(false);
                            cr->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            cr->SetInCombatWithZone();
                            cr->AddThreat(me, 0.0f);
                            AttackStart(cr);
                        }
                        eventInRun = false;
                        SetEscortPaused(true);
                        break;
                    case EVENT_ACTION_PHASE5+1:
                        Talk(SAY_PHASE503);
                        SetEscortPaused(false);
                        eventInRun = false;
                        ScheduleNextEvent(currentEvent, 5000);
                        break;
                    case EVENT_ACTION_PHASE5+2:
                        me->SetFacingTo(5.28f);
                        Talk(SAY_PHASE504);
                        if (pInstance)
                        {
                            pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_FINISHED);
                            if (GameObject* go = pInstance->instance->GetGameObject(pInstance->GetGuidData(DATA_EXIT_GATE)))
                                go->SetGoState(GO_STATE_ACTIVE);

                            if (!me->GetMap()->GetPlayers().IsEmpty())
                            {
                                if (Player* player = me->GetMap()->GetPlayers().getFirst()->GetSource())
                                {
                                    if (GameObject* chest = player->SummonGameObject(DUNGEON_MODE(GO_MALGANIS_CHEST_N, GO_MALGANIS_CHEST_H), 2288.35f, 1498.73f, 128.414f, -0.994837f, 0, 0, 0, 0, 0))
                                    {
                                        chest->SetLootRecipient(me->GetMap());
                                    }
                                }
                            }
                        }
                        ScheduleNextEvent(currentEvent, 10000);
                        break;
                    case EVENT_ACTION_PHASE5+3:
                        eventInRun = false;
                        me->SetVisible(false);
                        break;
                }
            }

            //Battling skills
            if (!me->GetVictim())
                return;

            combatEvents.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (combatEvents.ExecuteEvent())
            {
                case EVENT_COMBAT_EXORCISM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_ARTHAS_EXORCISM_N, SPELL_ARTHAS_EXORCISM_H), false);

                    combatEvents.RepeatEvent(7300);
                    break;
                case EVENT_COMBAT_HEALTH_CHECK:
                    if (HealthBelowPct(40))
                        me->CastSpell(me, SPELL_ARTHAS_HOLY_LIGHT, false);

                    combatEvents.RepeatEvent(1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

Creature* npc_arthas::npc_arthasAI::GetEventNpc(uint32 entry)
{
    for (SummonList::iterator i = summons.begin(); i != summons.end();)
    {
        Creature* summon = ObjectAccessor::GetCreature(*me, *i);
        if (!summon)
            summons.erase(i++);
        else if (summon->GetEntry() == entry)
            return summon;
        else
            ++i;
    }

    return nullptr;
}

void npc_arthas::npc_arthasAI::ScheduleNextEvent(uint32 currentEvent, uint32 time)
{
    actionEvents.ScheduleEvent(currentEvent + 1, time);
}

void npc_arthas::npc_arthasAI::SummonNextWave()
{
    Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
    if (!PlayerList.IsEmpty())
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            i->GetSource()->PlayerTalkClass->SendPointOfInterest(1000 + waveGroupId);

    waveKillCount = 0; // this is forced condition!
    uint32 tableId = waveGroupId;
    if (tableId > 4)
        tableId--;

    for (uint32 i = 0; i < ENCOUNTER_WAVES_MAX_SPAWNS; ++i)
        me->SummonCreature(/*entry*/(uint32)WavesLocations[tableId][i][0], WavesLocations[tableId][i][1], WavesLocations[tableId][i][2], WavesLocations[tableId][i][3], WavesLocations[tableId][i][4]);
}

void npc_arthas::npc_arthasAI::JustEngagedWith(Unit* /*who*/)
{
    DoCast(me, SPELL_ARTHAS_AURA);

    // Fight
    combatEvents.ScheduleEvent(EVENT_COMBAT_EXORCISM, 2000);
    combatEvents.ScheduleEvent(EVENT_COMBAT_HEALTH_CHECK, 2000);
}

void npc_arthas::npc_arthasAI::ReorderInstance(uint32 data)
{
    Start(true, true);
    SetEscortPaused(true);
    SetDespawnAtEnd(false);

    switch (data)
    {
        case COS_PROGRESS_FINISHED_INTRO:
            SetNextWaypoint(9, false);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            break;
        case COS_PROGRESS_FINISHED_CITY_INTRO:
        case COS_PROGRESS_KILLED_MEATHOOK:
        case COS_PROGRESS_KILLED_SALRAMM:
            SetNextWaypoint(12, false);
            me->SetReactState(REACT_DEFENSIVE);

            if (data == COS_PROGRESS_FINISHED_CITY_INTRO)
            {
                eventInRun = true;
                actionEvents.RescheduleEvent(EVENT_ACTION_PHASE2 + 8, 10000);
            }
            else if (data == COS_PROGRESS_KILLED_MEATHOOK)
            {
                waveGroupId = 4;
                SendNextWave(NPC_MEATHOOK);
            }
            else // if (data == COS_PROGRESS_KILLED_SALRAMM)
            {
                if (pInstance)
                    pInstance->DoUpdateWorldState(WORLDSTATE_WAVE_COUNT, 10);
                DoAction(ACTION_KILLED_SALRAMM);
            }
            break;
        case COS_PROGRESS_REACHED_TOWN_HALL:
            SetNextWaypoint(21, false);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            break;
        case COS_PROGRESS_KILLED_EPOCH:
            SetNextWaypoint(32, false);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            break;
        case COS_PROGRESS_LAST_CITY:
            SetNextWaypoint(46, false);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            break;
        case COS_PROGRESS_BEFORE_MALGANIS:
            SetNextWaypoint(55, false);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            break;
    }

    if (data >= COS_PROGRESS_KILLED_EPOCH)
        if (pInstance)
            if (GameObject* pGate = pInstance->instance->GetGameObject(pInstance->GetGuidData(DATA_SHKAF_GATE)))
                pGate->SetGoState(GO_STATE_READY);

    pInstance->SetData(DATA_SHOW_INFINITE_TIMER, 1);
}

void npc_arthas::npc_arthasAI::SendNextWave(uint32 entry)
{
    if (!pInstance)
        return;

    if (entry == NPC_MEATHOOK)
    {
        waveKillCount = 4;
        pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_KILLED_MEATHOOK);
    }
    else if (entry == NPC_SALRAMM)
    {
        pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_KILLED_SALRAMM);
        return;
    }

    // Group is killed
    if (++waveKillCount >= 4)
    {
        waveGroupId++;
        if (waveGroupId == 4) // Meathook
            me->SummonCreature(NPC_MEATHOOK, EventPos[EVENT_SRC_MEATHOOK]);
        else if (waveGroupId == 9) // Salramm
            me->SummonCreature(NPC_SALRAMM, EventPos[EVENT_SRC_SALRAMM]);
        else
            SummonNextWave();

        pInstance->DoUpdateWorldState(WORLDSTATE_WAVE_COUNT, waveGroupId + 1);
    }
}

void npc_arthas::npc_arthasAI::SpawnTimeRift()
{
    if (timeRiftId >= 5)
        return;

    for (uint8 i = 0; i < uint8(timeRiftId == 0 ? ENCOUNTER_CHRONO_MAX_SPAWNS_FIRST : ENCOUNTER_CHRONO_MAX_SPAWNS_SECOND); ++i)
    {
        // Spawn everyone at time rift pos
        if (Creature* cr = me->SummonCreature(/*entry*/(uint32)RiftAndSpawnsLocations[timeRiftId][i][0], RiftAndSpawnsLocations[timeRiftId][0][1], RiftAndSpawnsLocations[timeRiftId][0][2], RiftAndSpawnsLocations[timeRiftId][0][3], RiftAndSpawnsLocations[timeRiftId][0][4]))
        {
            if (cr->GetEntry() == NPC_TIME_RIFT)
                cr->DespawnOrUnsummon(10000);
            else // x, y, z (0 is entry)
            {
                // first infinite
                if (i == 1)
                    AttackStart(cr);

                cr->SetInCombatWithZone();
                cr->AddThreat(me, 0.0f);
                cr->SetReactState(REACT_AGGRESSIVE);
                cr->GetMotionMaster()->MovePoint(POINT_CHRONOS, RiftAndSpawnsLocations[timeRiftId][i][1], RiftAndSpawnsLocations[timeRiftId][i][2], RiftAndSpawnsLocations[timeRiftId][i][3]);
            }
        }
    }

    timeRiftId++;
}

class npc_crate_helper : public CreatureScript
{
public:
    npc_crate_helper() : CreatureScript("npc_create_helper_cot") { }

    struct npc_crate_helperAI : public NullCreatureAI
    {
        npc_crate_helperAI(Creature* creature) : NullCreatureAI(creature)
        {
            _marked = false;
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_ARCANE_DISRUPTION && !_marked)
            {
                _marked = true;
                if (InstanceScript* instance = me->GetInstanceScript())
                    instance->SetData(DATA_CRATE_COUNT, 0);
                if (GameObject* crate = me->FindNearestGameObject(GO_SUSPICIOUS_CRATE, 5.0f))
                {
                    crate->SummonGameObject(GO_PLAGUED_CRATE, crate->GetPositionX(), crate->GetPositionY(), crate->GetPositionZ(), crate->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, DAY);
                    crate->Delete();
                }
            }
        }

    private:
        bool _marked;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<npc_crate_helperAI>(creature);
    }
};

enum chromie
{
    ITEM_ARCANE_DISRUPTOR               = 37888,
    QUEST_DISPELLING_ILLUSIONS          = 13149,
    QUEST_A_ROYAL_ESCORT                = 13151,
    SPELL_SUMMON_ARCANE_DISRUPTOR       = 49591
};

class npc_cos_chromie_start : public CreatureScript
{
public:
    npc_cos_chromie_start() : CreatureScript("npc_cos_chromie_start") { }

    bool OnQuestAccept(Player*, Creature* creature, const Quest* pQuest)
    {
        if (pQuest->GetQuestId() == QUEST_DISPELLING_ILLUSIONS)
        {
            if (InstanceScript* pInstance = creature->GetInstanceScript())
            {
                pInstance->SetData(DATA_SHOW_CRATES, 1);
            }
        }

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/)
    {
        // final menu id, show crates if hidden and add item if missing
        if (player->PlayerTalkClass->GetGossipMenu().GetMenuId() == 9595)
        {
            if (InstanceScript* pInstance = creature->GetInstanceScript())
            {
                if (pInstance->GetData(DATA_ARTHAS_EVENT) == COS_PROGRESS_NOT_STARTED)
                {
                    pInstance->SetData(DATA_SHOW_CRATES, 1);
                }
            }

            if (!player->HasItemCount(ITEM_ARCANE_DISRUPTOR))
            {
                creature->CastSpell(player, SPELL_SUMMON_ARCANE_DISRUPTOR);
            }
        }
        // Skip Event
        else if (player->PlayerTalkClass->GetGossipMenu().GetMenuId() == 11277)
        {
            if (InstanceScript* pInstance = creature->GetInstanceScript())
            {
                if (pInstance->GetData(DATA_ARTHAS_EVENT) == COS_PROGRESS_NOT_STARTED)
                {
                    pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_FINISHED_INTRO);
                    if (Creature* arthas = ObjectAccessor::GetCreature(*creature, pInstance->GetGuidData(DATA_ARTHAS)))
                    {
                        arthas->AI()->Reset();
                    }
                }
                player->NearTeleportTo(LeaderIntroPos2.GetPositionX(), LeaderIntroPos2.GetPositionY(), LeaderIntroPos2.GetPositionZ(), LeaderIntroPos2.GetOrientation());
            }
        }

        // return false to display last windows
        return false;
    }
};

class npc_cos_chromie_middle : public CreatureScript
{
public:
    npc_cos_chromie_middle() : CreatureScript("npc_cos_chromie_middle") { }

    bool OnQuestAccept(Player*, Creature* creature, const Quest* pQuest) override
    {
        if (pQuest->GetQuestId() == QUEST_A_ROYAL_ESCORT)
            if (InstanceScript* pInstance = creature->GetInstanceScript())
                if (pInstance->GetData(DATA_ARTHAS_EVENT) == COS_PROGRESS_CRATES_FOUND)
                    pInstance->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_START_INTRO);

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32  /*action*/) override
    {
        if (!creature->GetInstanceScript() || creature->GetInstanceScript()->GetData(DATA_ARTHAS_EVENT) != COS_PROGRESS_CRATES_FOUND)
            return true;

        // We can start event:)
        if (player->PlayerTalkClass->GetGossipMenu().GetMenuId() == 9612)
            creature->GetInstanceScript()->SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_START_INTRO);

        return false;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
            player->SendPreparedQuest(creature->GetGUID());
        }

        if (!creature->GetInstanceScript() || creature->GetInstanceScript()->GetData(DATA_ARTHAS_EVENT) != COS_PROGRESS_CRATES_FOUND)
            return true;

        return false;
    }
};

class npc_cos_stratholme_citizien : public CreatureScript
{
public:
    npc_cos_stratholme_citizien() : CreatureScript("npc_cos_stratholme_citizien") { }

    struct npc_cos_stratholme_citizienAI : public ScriptedAI
    {
        npc_cos_stratholme_citizienAI(Creature* creature) : ScriptedAI(creature)
        {
            allowTimer = 0;
            pInstance = me->GetInstanceScript();
            if (!pInstance || pInstance->GetData(DATA_ARTHAS_EVENT) < COS_PROGRESS_FINISHED_CITY_INTRO)
                allowTimer++;
        }

        bool locked;
        uint32 changeTimer;
        InstanceScript* pInstance;
        uint32 allowTimer;

        void Reset() override
        {
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            locked = false;
            changeTimer = 0;

            if (pInstance)
            {
                uint32 data = pInstance->GetData(DATA_ARTHAS_EVENT);
                if (me->GetDistance(2400, 1200, 135) > 20.0f && data >= COS_PROGRESS_FINISHED_CITY_INTRO)
                {
                    if (data >= COS_PROGRESS_KILLED_SALRAMM)
                        me->DespawnOrUnsummon(500);
                    else
                        InfectMe(3000);
                }
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!allowTimer && !locked && (who->IsPlayer() || who->IsPet()) && me->GetDistance(who) < 15.0f)
                InfectMe(2000);

            ScriptedAI::MoveInLineOfSight(who);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_INFECT_CITIZIEN)
                InfectMe(1);
            else if (param == ACTION_FORCE_CHANGE_LOCK)
                locked = true;
        }

        void InfectMe(uint32 time)
        {
            locked = true;
            changeTimer = time;
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_ARTHAS_CRUSADER_STRIKE)
            {
                if (me->GetEntry() == NPC_CITY_MAN3)
                {
                    me->StopMoving();
                    me->HandleEmoteCommand(54); // laugh
                }
                else
                    Unit::Kill(caster, me);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            ScriptedAI::UpdateAI(diff);

            if (allowTimer)
            {
                allowTimer += diff;
                if (allowTimer >= 8000 && pInstance && pInstance->GetData(DATA_ARTHAS_EVENT) >= COS_PROGRESS_FINISHED_CITY_INTRO)
                    allowTimer = 0;
            }

            if (changeTimer)
            {
                changeTimer += diff;
                if (changeTimer >= 2500 && changeTimer < 10000)
                {
                    me->CastSpell(me, SPELL_GREEN_VISUAL_AURA, true);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_COWER);
                    changeTimer = 10000;
                }
                else if (changeTimer >= 14500 && changeTimer < 20000)
                {
                    me->UpdateEntry(NPC_RISEN_ZOMBIE, nullptr, false);
                    me->SetReactState(REACT_AGGRESSIVE);
                    changeTimer = 20000;
                }
                else if (changeTimer >= 23000)
                {
                    me->RemoveAura(SPELL_GREEN_VISUAL_AURA);
                    changeTimer = 0;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<npc_cos_stratholme_citizienAI>(creature);
    }
};

void AddSC_culling_of_stratholme()
{
    new npc_arthas();
    new npc_crate_helper();
    new npc_cos_chromie_start();
    new npc_cos_chromie_middle();
    new npc_cos_stratholme_citizien();
}
