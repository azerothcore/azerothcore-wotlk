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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include <limits>

/*######
## npc_koltira_deathweaver
######*/

enum Koltira
{
    SAY_BREAKOUT0                   = 0,
    SAY_BREAKOUT1                   = 1,
    SAY_BREAKOUT2                   = 2,
    SAY_BREAKOUT3                   = 3,
    SAY_BREAKOUT4                   = 4,
    SAY_BREAKOUT5                   = 5,
    SAY_BREAKOUT6                   = 6,
    SAY_BREAKOUT7                   = 7,
    SAY_BREAKOUT8                   = 8,
    SAY_BREAKOUT9                   = 9,
    SAY_BREAKOUT10                  = 10,
    EMOTE_KOLTIRA_COLLAPSES         = 11,

    SAY_VALROTH_WAVE3               = 0,
    SAY_VALROTH_AGGRO               = 1,
    SAY_VALROTH_WAVE1               = 4,
    SAY_VALROTH_WAVE2               = 5,

    SPELL_KOLTIRA_TRANSFORM         = 52899,
    SPELL_ANTI_MAGIC_ZONE           = 52894,

    QUEST_BREAKOUT                  = 12727,

    NPC_CRIMSON_ACOLYTE             = 29007,
    NPC_HIGH_INQUISITOR_VALROTH     = 29001,

    //not sure about this id
    //NPC_DEATH_KNIGHT_MOUNT        = 29201,
    MODEL_DEATH_KNIGHT_MOUNT        = 25278,

    POINT_STAND_UP                  = 1,
    POINT_BOX                       = 2,
    POINT_ANTI_MAGIC_ZONE           = 3,

    POINT_MOUNT                     = 1,
    POINT_DESPAWN                   = 2
};

class npc_koltira_deathweaver : public CreatureScript
{
public:
    npc_koltira_deathweaver() : CreatureScript("npc_koltira_deathweaver") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_koltira_deathweaverAI(creature);
    }

    struct npc_koltira_deathweaverAI : public ScriptedAI
    {
        npc_koltira_deathweaverAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            scheduler.CancelAll();
            me->m_Events.KillAllEvents(false);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
            me->setActive(false);
        }

        void StartEvent()
        {
            if (!me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP)) // Already in progress
                return;

            me->SetStandState(UNIT_STAND_STATE_SIT);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->setActive(true);

            Talk(SAY_BREAKOUT0);

            me->m_Events.AddEventAtOffset([&] {
                me->GetMotionMaster()->MoveWaypoint(me->GetEntry() * 10, false);
            }, 5s);
        }

        void sQuestAccept(Player* /*player*/, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_BREAKOUT)
                StartEvent();
        }

        void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 /*gossipListId*/) override
        {
            if (player->GetQuestStatus(QUEST_BREAKOUT) == QUEST_STATUS_INCOMPLETE)
            {
                CloseGossipMenuFor(player);
                StartEvent();
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            if (!me->HasUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC))
            {
                if (id == POINT_MOUNT)
                    me->Mount(MODEL_DEATH_KNIGHT_MOUNT);
                else if (id == POINT_DESPAWN)
                {
                    me->Dismount();
                    me->DespawnOrUnsummon();
                }

                return;
            }

            switch (id)
            {
                case POINT_STAND_UP:
                    Talk(SAY_BREAKOUT1);
                    break;
                case POINT_BOX:
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);

                    scheduler.Schedule(5s, [this](TaskContext context)
                    {
                        switch (context.GetRepeatCounter())
                        {
                        case 0:
                            Talk(SAY_BREAKOUT3);

                            // Shouldn't actually be spawned at this point, but no way to send his yells otherwise?
                            if (Creature* valroth = me->SummonCreature(NPC_HIGH_INQUISITOR_VALROTH, 1640.8596f, -6030.834f, 134.82211f, 4.606426715850830078f, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                _valrothGUID = valroth->GetGUID();
                                valroth->AI()->Talk(SAY_VALROTH_WAVE1);
                                valroth->SetReactState(REACT_PASSIVE);
                            }

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.6724f, -6032.0527f, 134.82213f, 4.654973506927490234f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint(NPC_CRIMSON_ACOLYTE * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1641.0055f, -6031.893f, 134.82211f, 0.401425719261169433f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 1) * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1639.7053f, -6031.7373f, 134.82213f, 2.443460941314697265f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 2) * 10, false);
                            break;
                        case 1:
                            Talk(SAY_BREAKOUT4);

                            if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                                valroth->AI()->Talk(SAY_VALROTH_WAVE2);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.7958f, -6030.307f, 134.82211f, 4.65355682373046875f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 3) * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1641.7305f, -6030.751f, 134.82211f, 6.143558979034423828f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 4) * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1639.4657f, -6030.404f, 134.82211f, 4.502949237823486328f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 5) * 10, false);
                            break;
                        case 2:
                            Talk(SAY_BREAKOUT5);

                            if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                                valroth->AI()->Talk(SAY_VALROTH_WAVE3);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1641.3405f, -6031.436f, 134.82211f, 4.612849712371826171f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 6) * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1642.0404f, -6030.3843f, 134.82211f, 1.378810048103332519f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 7) * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.1162f, -6029.7817f, 134.82211f, 5.707226753234863281f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 8) * 10, false);

                            if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.9948f, -6029.8027f, 134.82211f, 1.605702877044677734f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 9) * 10, false);
                            break;
                        case 3:
                            Talk(SAY_BREAKOUT6);
                            me->m_Events.AddEventAtOffset([this]
                            {
                                Talk(EMOTE_KOLTIRA_COLLAPSES, me);
                                me->KillSelf();

                                if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                                    valroth->DespawnOrUnsummon();
                            }, 2min);

                            if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                            {
                                valroth->AI()->Talk(SAY_VALROTH_AGGRO);
                                valroth->SetReactState(REACT_AGGRESSIVE);
                                valroth->GetMotionMaster()->MoveWaypoint(NPC_HIGH_INQUISITOR_VALROTH * 10, false);
                            }
                            return;
                        default:
                            break;
                        }

                        context.Repeat(20s);
                    });

                    scheduler.Schedule(3s, [this](TaskContext)
                    {
                        DoCastSelf(SPELL_KOLTIRA_TRANSFORM);
                        me->LoadEquipment();
                    });
                    break;
                case POINT_ANTI_MAGIC_ZONE:
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    Talk(SAY_BREAKOUT2);
                    DoCastSelf(SPELL_ANTI_MAGIC_ZONE);
                    break;
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            if (summon->GetEntry() == NPC_HIGH_INQUISITOR_VALROTH)
            {
                me->m_Events.KillAllEvents(false);
                me->RemoveAurasDueToSpell(SPELL_ANTI_MAGIC_ZONE);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                Talk(SAY_BREAKOUT8, 3s);
                Talk(SAY_BREAKOUT9, 8s);
                scheduler.Schedule(11s, [this](TaskContext)
                {
                    Talk(SAY_BREAKOUT10);
                    SetInvincibility(true);
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
                    me->GetMotionMaster()->MoveWaypoint((me->GetEntry() + 1) * 10, false);
                });
            }
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);
        }

        private:
            ObjectGuid _valrothGUID;
    };
};

//Scarlet courier
enum ScarletCourierEnum
{
    SAY_TREE1                          = 0,
    SAY_TREE2                          = 1,
    SPELL_SHOOT                        = 52818,
    GO_INCONSPICUOUS_TREE              = 191144,
    NPC_SCARLET_COURIER                = 29076
};

class npc_scarlet_courier : public CreatureScript
{
public:
    npc_scarlet_courier() : CreatureScript("npc_scarlet_courier") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_scarlet_courierAI(creature);
    }

    struct npc_scarlet_courierAI : public ScriptedAI
    {
        npc_scarlet_courierAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiStage;
        uint32 uiStage_timer;

        void Reset() override
        {
            me->Mount(14338); // not sure about this id
            uiStage = 1;
            uiStage_timer = 3000;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_TREE2);
            me->Dismount();
            uiStage = 0;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 1)
                uiStage = 2;
        }

        void UpdateAI(uint32 diff) override
        {
            if (uiStage && !me->IsInCombat())
            {
                if (uiStage_timer <= diff)
                {
                    switch (uiStage)
                    {
                        case 1:
                            me->SetWalk(true);
                            if (GameObject* tree = me->FindNearestGameObject(GO_INCONSPICUOUS_TREE, 40.0f))
                            {
                                Talk(SAY_TREE1);
                                float x, y, z;
                                tree->GetContactPoint(me, x, y, z);
                                me->GetMotionMaster()->MovePoint(1, x, y, z);
                            }
                            break;
                        case 2:
                            if (GameObject* tree = me->FindNearestGameObject(GO_INCONSPICUOUS_TREE, 40.0f))
                                if (Unit* unit = tree->GetOwner())
                                    AttackStart(unit);
                            break;
                    }
                    uiStage_timer = 3000;
                    uiStage = 0;
                }
                else uiStage_timer -= diff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_a_special_surprise
######*/
//used by 29032, 29061, 29065, 29067, 29068, 29070, 29074, 29072, 29073, 29071 but signed for 29032
enum SpecialSurprise
{
    SAY_EXEC_START = 0,
    SAY_EXEC_PROG = 1,
    SAY_EXEC_NAME = 2,
    SAY_EXEC_RECOG = 3,
    SAY_EXEC_NOREM = 4,
    SAY_EXEC_THINK = 5,
    SAY_EXEC_LISTEN = 6,
    SAY_EXEC_TIME = 7,
    SAY_EXEC_WAITING = 8,
    EMOTE_DIES = 9,

    SAY_PLAGUEFIST = 0,
    NPC_PLAGUEFIST = 29053
};

class npc_a_special_surprise : public CreatureScript
{
public:
    npc_a_special_surprise() : CreatureScript("npc_a_special_surprise") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_a_special_surpriseAI(creature);
    }

    struct npc_a_special_surpriseAI : public ScriptedAI
    {
        npc_a_special_surpriseAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 ExecuteSpeech_Timer;
        uint32 ExecuteSpeech_Counter;
        ObjectGuid PlayerGUID;

        void Reset() override
        {
            ExecuteSpeech_Timer = 0;
            ExecuteSpeech_Counter = 0;
            PlayerGUID.Clear();

            me->SetReactState(REACT_PASSIVE);
            me->SetImmuneToPC(true);
        }

        bool MeetQuestCondition(Player* player)
        {
            switch (me->GetEntry())
            {
                case 29061:                                     // Ellen Stanbridge
                    if (player->GetQuestStatus(12742) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29072:                                     // Kug Ironjaw
                    if (player->GetQuestStatus(12748) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29067:                                     // Donovan Pulfrost
                    if (player->GetQuestStatus(12744) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29065:                                     // Yazmina Oakenthorn
                    if (player->GetQuestStatus(12743) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29071:                                     // Antoine Brack
                    if (player->GetQuestStatus(12750) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29032:                                     // Malar Bravehorn
                    if (player->GetQuestStatus(12739) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29068:                                     // Goby Blastenheimer
                    if (player->GetQuestStatus(12745) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29073:                                     // Iggy Darktusk
                    if (player->GetQuestStatus(12749) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29074:                                     // Lady Eonys
                    if (player->GetQuestStatus(12747) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29070:                                     // Valok the Righteous
                    if (player->GetQuestStatus(12746) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
            }

            return false;
        }

        void MoveInLineOfSight(Unit* who) override

        {
            if (PlayerGUID || !who->IsPlayer() || !who->IsWithinDist(me, INTERACTION_DISTANCE))
                return;

            if (MeetQuestCondition(who->ToPlayer()))
                PlayerGUID = who->GetGUID();
        }

        void UpdateAI(uint32 diff) override
        {
            if (PlayerGUID && !me->GetVictim() && me->IsAlive())
            {
                if (ExecuteSpeech_Timer <= diff)
                {
                    Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);

                    if (!player)
                    {
                        Reset();
                        return;
                    }

                    switch (ExecuteSpeech_Counter)
                    {
                    case 0:
                        Talk(SAY_EXEC_START, player);
                        break;
                    case 1:
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        break;
                    case 2:
                        Talk(SAY_EXEC_PROG, player);
                        break;
                    case 3:
                        Talk(SAY_EXEC_NAME, player);
                        break;
                    case 4:
                        Talk(SAY_EXEC_RECOG, player);
                        break;
                    case 5:
                        Talk(SAY_EXEC_NOREM, player);
                        break;
                    case 6:
                        Talk(SAY_EXEC_THINK, player);
                        break;
                    case 7:
                        Talk(SAY_EXEC_LISTEN, player);
                        break;
                    case 8:
                        if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                        {
                            Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                        }
                        break;
                    case 9:
                        Talk(SAY_EXEC_TIME, player);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->SetReactState(REACT_PASSIVE);
                        me->SetImmuneToPC(false);
                        break;
                    case 10:
                        Talk(SAY_EXEC_WAITING, player);
                        break;
                    case 11:
                        Talk(EMOTE_DIES);
                        me->setDeathState(DeathState::JustDied);
                        me->SetHealth(0);
                        return;
                    }

                    if (ExecuteSpeech_Counter >= 9)
                        ExecuteSpeech_Timer = 15000;
                    else
                        ExecuteSpeech_Timer = 7000;

                    ++ExecuteSpeech_Counter;
                }
                else
                    ExecuteSpeech_Timer -= diff;
            }
        }
    };
};

// Spell and NPC IDs for Scourge Assault event
enum NecroSpells
{
    SPELL_SCARLET_GHOUL   = 52683,  // Raises a Scarlet Ghoul from a humanoid corpse
    SPELL_SCOURGE_GRYPHON = 52685,  // Raises a Scourge Gryphon from a gryphon corpse
    SPELL_GHOULPLOSION    = 52672   // Causes a Gluttonous Geist to explode (kill)
};

enum NecroNPCs
{
    NPC_GLUTTONOUS_GEIST            = 28905,
    NPC_DEAD_SCARLET_MEDIC          = 28895,
    NPC_DEAD_SCARLET_INFANTRYMAN    = 28896,
    NPC_DEAD_SCARLET_CAPTAIN        = 28898,
    NPC_DEAD_SCARLET_PEASANT        = 28892,
    NPC_DEAD_SCARLET_MINER          = 28891,
    NPC_DEAD_SCARLET_FLEET_DEFENDER = 28886,
    NPC_DEAD_SCARLET_GRYPHON        = 28893
};

/*######
## npc_acherus_necromancer (Entry 28889)
######*/
class npc_acherus_necromancer : public CreatureScript
{
public:
    npc_acherus_necromancer() : CreatureScript("npc_acherus_necromancer") { }

    struct npc_acherus_necromancerAI : public ScriptedAI
    {
        npc_acherus_necromancerAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        ObjectGuid targetCorpseGUID;
        ObjectGuid geistGUID;
        bool isOnRitual;

        // Event timers (IDs)
        enum Events
        {
            EVENT_START_RITUAL = 1,
            EVENT_GHOULPLOSION,
            EVENT_RAISE_GHOUL,
            EVENT_RESUME_WP
        };

        // Point ID for movement
        enum Points
        {
            POINT_CORPSE_REACHED = 1
        };

        void Reset() override
        {
            events.Reset();
            targetCorpseGUID.Clear();
            geistGUID.Clear();
            isOnRitual = false;
            // Start waypoint movement using WaypointMovementGenerator
            if (uint32 pathId = me->GetWaypointPath())
            {
                me->GetMotionMaster()->MoveWaypoint(pathId, true); // true = repeatable
            }
            // Schedule the first ritual after 20-30s
            events.ScheduleEvent(EVENT_START_RITUAL, 20s, 30s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_START_RITUAL:
                    {
                        if (isOnRitual) // Already performing ritual
                        {
                            events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                            break;
                        }

                        // Find nearest dead Scarlet humanoid (exclude gryphon)
                        Creature* nearestCorpse = nullptr;
                        float nearestDist = std::numeric_limits<float>::max();
                        static const uint32 corpseEntries[] = {
                            NPC_DEAD_SCARLET_MEDIC, NPC_DEAD_SCARLET_INFANTRYMAN, NPC_DEAD_SCARLET_CAPTAIN,
                            NPC_DEAD_SCARLET_PEASANT, NPC_DEAD_SCARLET_MINER, NPC_DEAD_SCARLET_FLEET_DEFENDER
                        };
                        for (uint32 entry : corpseEntries)
                        {
                            // Search up to 60 yards for each type
                            if (Creature* corpse = me->FindNearestCreature(entry, 60.0f, true))
                            {
                                float dist = me->GetDistance(corpse);
                                if (dist < nearestDist)
                                {
                                    nearestDist = dist;
                                    nearestCorpse = corpse;
                                }
                            }
                        }
                        if (!nearestCorpse)
                        {
                            // No corpse found nearby: try again later
                            events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                            break;
                        }
                        // Start ritual
                        isOnRitual = true;
                        targetCorpseGUID = nearestCorpse->GetGUID();
                        geistGUID.Clear();
                        // Pause waypoint movement and move to the corpse
                        me->PauseMovement();
                        float x, y, z;
                        // Keep it at a distance from the corpse
                        nearestCorpse->GetClosePoint(x, y, z, me->GetObjectSize());
                        me->GetMotionMaster()->MovePoint(POINT_CORPSE_REACHED, x, y, z);
                        break;
                    }

                    case EVENT_GHOULPLOSION:
                    {
                        if (Creature* geist = ObjectAccessor::GetCreature(*me, geistGUID))
                        {
                            me->SetFacingToObject(geist);
                            DoCast(geist, SPELL_GHOULPLOSION);
                        }
                        break;
                    }

                    case EVENT_RAISE_GHOUL:
                    {
                        if (Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID))
                        {
                            // Cast Scarlet Ghoul on the corpse (always a humanoid for necromancer)
                            me->SetFacingToObject(corpse);
                            DoCast(corpse, SPELL_SCARLET_GHOUL);
                        }
                        break;
                    }

                    case EVENT_RESUME_WP:
                    {
                        // Resume waypoint movement
                        isOnRitual = false;

                        targetCorpseGUID.Clear();

                        // Resume paused waypoint movement
                        me->ResumeMovement();
                        // Schedule next ritual in 20-30s
                        events.ScheduleEvent(EVENT_START_RITUAL, 20s, 30s);
                        break;
                    }
                }
            }

            // Necromancers are not expected to engage in combat; no melee UpdateAI needed beyond events.
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_CORPSE_REACHED)
            {
                // Reached the corpse
                // Check for nearby Gluttonous Geist within ~3 yards
                Creature* geist = me->FindNearestCreature(NPC_GLUTTONOUS_GEIST, 3.0f, true);
                if (geist)
                {
                    me->SetFacingToObject(geist);
                    geistGUID = geist->GetGUID();
                    // Geist found: schedule Ghoulplosion at +3s, then raising at +6s, then resume at +9s
                    events.ScheduleEvent(EVENT_GHOULPLOSION, 3s);
                    events.ScheduleEvent(EVENT_RAISE_GHOUL, 6s);
                    events.ScheduleEvent(EVENT_RESUME_WP, 9s);
                }
                else
                {
                    // No Geist: just raise after 3s, resume 3s later

                    Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID);
                    if (corpse)
                    {
                        me->SetFacingToObject(corpse);
                    }

                    events.ScheduleEvent(EVENT_RAISE_GHOUL, 3s);
                    events.ScheduleEvent(EVENT_RESUME_WP, 6s);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_acherus_necromancerAI(creature);
    }
};

/*######
## npc_gothik_the_harvester (Entry 28890)
######*/
class npc_gothik_the_harvester : public CreatureScript
{
public:
    npc_gothik_the_harvester() : CreatureScript("npc_gothik_the_harvester") { }

    struct npc_gothik_the_harvesterAI : public ScriptedAI
    {
        npc_gothik_the_harvesterAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        ObjectGuid targetCorpseGUID;
        ObjectGuid geistGUID;
        bool isOnRitual;

        enum Events
        {
            EVENT_START_RITUAL = 1,
            EVENT_GHOULPLOSION,
            EVENT_RAISE_DEAD,
            EVENT_RESUME_WP
        };

        enum Points
        {
            POINT_CORPSE_REACHED = 1
        };

        // Text identifiers for creature_text (see SQL below)
        enum Says
        {
            SAY_GRYPHON = 0,  // "You will fly again, beast..."
            SAY_GHOUL   = 1,  // "Surprise, surprise! Another ghoul!"
            SAY_GEIST   = 2   // "Is Gothik the Harvester going to have to choke a geist?"
        };

        void Reset() override
        {
            events.Reset();
            targetCorpseGUID.Clear();
            geistGUID.Clear();
            isOnRitual = false;
            // Start waypoint movement using WaypointMovementGenerator
            if (uint32 pathId = me->GetWaypointPath())
            {
                me->GetMotionMaster()->MoveWaypoint(pathId, true); // true = repeatable
            }
            // Schedule the first ritual after 50-60s
            events.ScheduleEvent(EVENT_START_RITUAL, 50s, 60s);
        }
        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_START_RITUAL:
                    {
                        if (isOnRitual) // Already performing ritual
                        {
                            events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                            break;
                        }

                        // Find nearest dead Scarlet NPC (including gryphon)
                        Creature* nearestCorpse = nullptr;
                        float nearestDist = std::numeric_limits<float>::max();
                        static const uint32 corpseEntries[] = {
                            NPC_DEAD_SCARLET_MEDIC, NPC_DEAD_SCARLET_INFANTRYMAN, NPC_DEAD_SCARLET_CAPTAIN,
                            NPC_DEAD_SCARLET_PEASANT, NPC_DEAD_SCARLET_MINER, NPC_DEAD_SCARLET_FLEET_DEFENDER,
                            NPC_DEAD_SCARLET_GRYPHON
                        };
                        for (uint32 entry : corpseEntries)
                        {
                            // Search up to 60 yards for each type
                            if (Creature* corpse = me->FindNearestCreature(entry, 60.0f, true))
                            {
                                float dist = me->GetDistance(corpse);
                                if (dist < nearestDist)
                                {
                                    nearestDist = dist;
                                    nearestCorpse = corpse;
                                }
                            }
                        }
                        if (!nearestCorpse)
                        {
                            events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                            break;
                        }
                        // Start ritual
                        isOnRitual = true;
                        targetCorpseGUID = nearestCorpse->GetGUID();
                        geistGUID.Clear();
                        // Pause waypoint movement and move to the corpse
                        me->PauseMovement();
                        float x, y, z;
                        // Keep it at a distance from the corpse
                        nearestCorpse->GetClosePoint(x, y, z, me->GetObjectSize());
                        me->GetMotionMaster()->MovePoint(POINT_CORPSE_REACHED, x, y, z);
                        break;
                    }
                    case EVENT_GHOULPLOSION:
                    {
                        // Cast Ghoulplosion on the Geist and say the Geist line
                        if (Creature* geist = ObjectAccessor::GetCreature(*me, geistGUID))
                        {
                            Talk(SAY_GEIST);
                            me->SetFacingToObject(geist);
                            DoCast(geist, SPELL_GHOULPLOSION);
                        }
                        break;
                    }

                    case EVENT_RAISE_DEAD:
                    {
                        // Cast the appropriate raise spell on the corpse (griffon or ghoul)
                        if (Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID))
                        {
                            me->SetFacingToObject(corpse);
                            uint32 entry = corpse->GetEntry();
                            if (entry == NPC_DEAD_SCARLET_GRYPHON)
                            {
                                DoCast(corpse, SPELL_SCOURGE_GRYPHON);
                            }
                            else
                            {
                                DoCast(corpse, SPELL_SCARLET_GHOUL);
                            }
                        }
                        break;
                    }
                    case EVENT_RESUME_WP:
                    {
                        // Resume waypoint movement
                        isOnRitual = false;
                        targetCorpseGUID.Clear();
                        // Resume paused waypoint movement
                        me->ResumeMovement();
                        // Schedule next ritual in 50-60s
                        events.ScheduleEvent(EVENT_START_RITUAL, 50s, 60s);
                        break;
                    }
                }
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_CORPSE_REACHED)
            {
                // Reached the target corpse
                Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID);
                if (corpse)
                {
                    me->SetFacingToObject(corpse);
                    // Say line depending on corpse type (gryphon or humanoid)
                    if (corpse->GetEntry() == NPC_DEAD_SCARLET_GRYPHON)
                        Talk(SAY_GRYPHON);
                    else
                        Talk(SAY_GHOUL);
                }
                // Check for Geist nearby
                Creature* geist = me->FindNearestCreature(NPC_GLUTTONOUS_GEIST, 3.0f, true);
                if (geist)
                {
                    me->SetFacingToObject(geist);
                    geistGUID = geist->GetGUID();
                    // Geist present: Ghoulplosion in 3s (with SAY_GEIST), raise in 6s, resume in 9s
                    events.ScheduleEvent(EVENT_GHOULPLOSION, 3s);
                    events.ScheduleEvent(EVENT_RAISE_DEAD, 6s);
                    events.ScheduleEvent(EVENT_RESUME_WP, 9s);
                }
                else
                {
                    // No Geist: raise in 3s, resume in 6s
                    events.ScheduleEvent(EVENT_RAISE_DEAD, 3s);
                    events.ScheduleEvent(EVENT_RESUME_WP, 6s);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_gothik_the_harvesterAI(creature);
    }
};

//How to win friends and influence enemies
// texts signed for creature 28939 but used for 28939, 28940, 28610
enum win_friends
{
    SAY_CRUSADER             = 1,
    SAY_PERSUADED1           = 2,
    SAY_PERSUADED2           = 3,
    SAY_PERSUADED3           = 4,
    SAY_PERSUADED4           = 5,
    SAY_PERSUADED5           = 6,
    SAY_PERSUADED6           = 7,
    SAY_PERSUADE_RAND        = 8,
    QUEST_HOW_TO_WIN_FRIENDS = 12720,

    NPC_SCARLET_PREACHER     = 28939,
    NPC_SCARLET_COMMANDER    = 28936,
    NPC_SCARLET_CRUSADER     = 28940,
    NPC_SCARLET_MARKSMAN     = 28610,
    NPC_SCARLET_LORD_MCCREE  = 28964
};

// 52781 - Persuasive Strike
class spell_chapter2_persuasive_strike : public SpellScript
{
    PrepareSpellScript(spell_chapter2_persuasive_strike);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsPlayer()
            && GetCaster()->ToPlayer()->GetQuestStatus(QUEST_HOW_TO_WIN_FRIENDS) == QUEST_STATUS_INCOMPLETE;
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Creature* creature = GetHitCreature();
        Player* player = GetCaster()->ToPlayer();

        if (!creature || !player)
            return;

        if (!creature->EntryEquals(NPC_SCARLET_PREACHER, NPC_SCARLET_COMMANDER, NPC_SCARLET_CRUSADER, NPC_SCARLET_MARKSMAN, NPC_SCARLET_LORD_MCCREE))
            return;

        sCreatureTextMgr->SendChat(creature, SAY_PERSUADE_RAND, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, player);

        if (roll_chance_f(30.0f))
        {
            creature->CombatStop(true);
            creature->GetMotionMaster()->MoveIdle();
            creature->SetImmuneToPC(true);
            creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            creature->SetReactState(REACT_PASSIVE);

            creature->AI()->Talk(SAY_PERSUADED1, 8s);
            creature->AI()->Talk(SAY_PERSUADED2, 16s);
            creature->AI()->Talk(SAY_PERSUADED3, 24s);
            creature->AI()->Talk(SAY_PERSUADED4, 32s);

            ObjectGuid playerGuid = player->GetGUID();

            creature->m_Events.AddEventAtOffset([creature, playerGuid]
            {
                if (Player* caster = ObjectAccessor::GetPlayer(*creature, playerGuid))
                    sCreatureTextMgr->SendChat(creature, SAY_PERSUADED5, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, caster);
            }, 40s);

            creature->m_Events.AddEventAtOffset([creature, playerGuid]
            {
                creature->AI()->Talk(SAY_PERSUADED6);

                if (Player* caster = ObjectAccessor::GetPlayer(*creature, playerGuid))
                {
                    Unit::Kill(caster, creature);
                    caster->GroupEventHappens(QUEST_HOW_TO_WIN_FRIENDS, creature);
                }
                else
                    creature->KillSelf();
            }, 48s);
        }
        else
            creature->AI()->Talk(SAY_CRUSADER, 1s);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_chapter2_persuasive_strike::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum AcherusPortal
{
    SPELL_PORTAL_EFFECT_ACHERUS   = 53098,
    QUEST_SCARLET_ARMIES_APPROACH = 12757
};

class spell_portal_effect_acherus : public SpellScript
{
    PrepareSpellScript(spell_portal_effect_acherus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PORTAL_EFFECT_ACHERUS });
    }

    SpellCastResult CheckCast()
    {
        Unit* target = GetExplTargetUnit();
        if (target && target->IsPlayer() && target->ToPlayer()->HasQuest(QUEST_SCARLET_ARMIES_APPROACH))
            return SPELL_CAST_OK;

        return SPELL_FAILED_DONT_REPORT;
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (Player* player = GetHitPlayer())
                caster->CastSpell(player, GetEffectValue(), true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_portal_effect_acherus::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_portal_effect_acherus::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_the_scarlet_enclave_c2()
{
    new npc_scarlet_courier();
    new npc_koltira_deathweaver();
    new npc_a_special_surprise();
    new npc_acherus_necromancer();
    new npc_gothik_the_harvester();
    RegisterSpellScript(spell_chapter2_persuasive_strike);
    RegisterSpellScript(spell_portal_effect_acherus);
}
