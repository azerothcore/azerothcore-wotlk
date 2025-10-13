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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_WHIRLWIND                 = 13736, // sniffed
    SPELL_CLEAVE                    = 15284,
    SPELL_MORTAL_STRIKE             = 16856,
    SPELL_FRENZY                    = 8269,
    SPELL_KNOCKDOWN                 = 13360  // On spawn during Gyth fight
};

enum Says
{
    // Rend Blackhand
    SAY_BLACKHAND_1                 = 0,
    SAY_BLACKHAND_2                 = 1,
    EMOTE_BLACKHAND_DISMOUNT        = 2,
    SAY_BLACKHAND_3                 = 3, // Lanny
    SAY_BLACKHAND_4                 = 4, // Lanny
    SAY_BLACKHAND_5                 = 5, // Lanny
    SAY_BLACKHAND_6                 = 6, // Lanny
	
    // Victor Nefarius
    SAY_NEFARIUS_0                  = 0,
    SAY_NEFARIUS_1                  = 1,
    SAY_NEFARIUS_2                  = 2,
    SAY_NEFARIUS_3                  = 3,
    SAY_NEFARIUS_4                  = 4,
    SAY_NEFARIUS_5                  = 5,
    SAY_NEFARIUS_6                  = 6,
    SAY_NEFARIUS_7                  = 7,
    SAY_NEFARIUS_8                  = 8,
    SAY_NEFARIUS_9                  = 9,
    SAY_NEFARIUS_19                 = 19, // Lanny
    SAY_NEFARIUS_20                 = 20, // Lanny
    SAY_NEFARIUS_21                 = 21, // Lanny
    SAY_NEFARIUS_22                 = 22, // Lanny
    SAY_NEFARIUS_23                 = 23, // Lanny
};

enum Adds
{
    NPC_CHROMATIC_WHELP             = 10442,
    NPC_CHROMATIC_DRAGONSPAWN       = 10447,
    NPC_BLACKHAND_DRAGON_HANDLER    = 10742,
    NPC_BLACKHAND_ELITE             = 10317 // Lanny
};

enum Misc
{
    NEFARIUS_PATH_1                 = 1379670,
    NEFARIUS_PATH_2                 = 1379671,
    NEFARIUS_PATH_3                 = 1379672,
    REND_PATH_1                     = 1379680,
    REND_PATH_2                     = 1379681,
};

/*Position const GythLoc =      { 211.762f,  -397.5885f, 111.1817f,  4.747295f   };
Position const Teleport1Loc = { 194.2993f, -474.0814f, 121.4505f, -0.01225555f };
Position const Teleport2Loc = { 216.485f,  -434.93f,   110.888f,  -0.01225555f };*/

enum Events
{
    EVENT_START_1                   = 1,
    EVENT_START_2                   = 2,
    EVENT_START_3                   = 3,
    EVENT_START_4                   = 4,
    EVENT_TURN_TO_REND              = 5,
    EVENT_TURN_TO_PLAYER            = 6,
    EVENT_TURN_TO_FACING_1          = 7,
    EVENT_TURN_TO_FACING_2          = 8,
    EVENT_SPAWN_WAVE                = 10,
    EVENT_WAVES_TEXT_1              = 16,
    EVENT_WAVES_TEXT_2              = 17,
    EVENT_WAVES_TEXT_3              = 18,
    EVENT_WAVES_TEXT_4              = 19,
    EVENT_WAVES_TEXT_5              = 20,
    EVENT_WAVES_COMPLETE_TEXT_1     = 21,
    EVENT_WAVES_COMPLETE_TEXT_2     = 22,
    EVENT_WAVES_COMPLETE_TEXT_3     = 23,
    EVENT_WAVES_EMOTE_1             = 24,
    EVENT_WAVES_EMOTE_2             = 25,
    EVENT_PATH_REND                 = 26,
    EVENT_PATH_NEFARIUS             = 27,
    EVENT_TELEPORT_1                = 28,
    EVENT_TELEPORT_2                = 29,
    EVENT_WHIRLWIND                 = 30,
    EVENT_CLEAVE                    = 31,
    EVENT_MORTAL_STRIKE             = 32,
    EVENT_STOP_MOVEMENT_1           = 33, // Lanny
    EVENT_RANDOM_TALK_VICTOR        = 34, // Lanny
    EVENT_RANDOM_TALK_REND          = 35, // Lanny
    EVENT_RANDOM_TAUNT_VICTOR       = 36, // Lanny
    EVENT_RANDOM_TAUNT_REND         = 37, // Lanny
    EVENT_RP_NEFARIUS_1             = 38, // Lanny
    EVENT_RP_NEFARIUS_2             = 39, // Lanny
    EVENT_RP_NEFARIUS_3             = 40, // Lanny
    EVENT_RP_NEFARIUS_4             = 41, // Lanny
    EVENT_RP_REND_1                 = 42, // Lanny
    EVENT_RP_REND_2                 = 43, // Lanny
    EVENT_SPAWN_SPECTATOR           = 44, // Lanny
};

class boss_rend_blackhand : public CreatureScript
{
public:
    boss_rend_blackhand() : CreatureScript("boss_rend_blackhand") { }

    struct boss_rend_blackhandAI : public BossAI
    {
        boss_rend_blackhandAI(Creature* creature) : BossAI(creature, DATA_WARCHIEF_REND_BLACKHAND) { }

        void Reset() override
        {
            _Reset();

            if (instance->GetBossState(DATA_GYTH) == IN_PROGRESS)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PREPARATION);
                me->SetImmuneToAll(false);
                return;
            }

            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PREPARATION);
            me->SetImmuneToAll(true);
            gythEvent = false;
            SpectatorEvent = false; //Lanny
            victorGUID.Clear();
            waveDoorGUID.Clear();
            _currentWave = 0;

            summons.DespawnAll();

            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 5.0f, true))
                victor->Respawn(true);

            if (GameObject* exitDoor = me->GetMap()->GetGameObject(instance->GetGuidData(GO_GYTH_ENTRY_DOOR)))
                exitDoor->SetGoState(GO_STATE_ACTIVE);

            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, NOT_STARTED);
        }

        void SummonedCreatureDies(Creature* /*creature*/, Unit* /*killer*/) override
        {
            //if (!summons.IsAnyCreatureAlive())
            if (!summons.IsAnyCreatureWithEntryAlive(NPC_CHROMATIC_DRAGONSPAWN) && !summons.IsAnyCreatureWithEntryAlive(NPC_CHROMATIC_WHELP) && !summons.IsAnyCreatureWithEntryAlive(NPC_BLACKHAND_DRAGON_HANDLER)) // Lanny - Spectators fix
            {
                events.ScheduleEvent(EVENT_WAVES_TEXT_1 + _currentWave - 1, 10s); // Misses the first wave (minus 1) - Lanny
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);

            if (summon->GetEntry() == NPC_GYTH)
            {
                me->DespawnOrUnsummon();
                return;
            }
            if (!SpectatorEvent) //Lanny
                summon->AI()->DoZoneInCombat(nullptr, 100.0f);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_WHIRLWIND, 13s, 15s);
            events.ScheduleEvent(EVENT_CLEAVE, 15s, 17s);
            events.ScheduleEvent(EVENT_MORTAL_STRIKE, 17s, 19s);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, FAIL);
            instance->SetBossState(DATA_GYTH, FAIL);
            BossAI::EnterEvadeMode(why);
            me->DespawnOrUnsummon();
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            Talk(EMOTE_BLACKHAND_DISMOUNT);
            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 75.0f, true))
                victor->AI()->Talk(SAY_NEFARIUS_9);		
        }

        void KilledUnit(Unit* victim) override
        {
            if (!victim->IsPlayer())
			{
                return;
            }
            else
            {
                int8 _taunt = urand(1, 2);
			    if (_taunt == 1)
                {
                    events.ScheduleEvent(EVENT_RANDOM_TAUNT_VICTOR, 2s);
				}
                else
                {
                    events.ScheduleEvent(EVENT_RANDOM_TAUNT_REND, 2s);
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 75.0f, true))
                victor->AI()->SetData(1, 2);

            if (GameObject* exitDoor = me->GetMap()->GetGameObject(instance->GetGuidData(GO_GYTH_ENTRY_DOOR)))
                exitDoor->SetGoState(GO_STATE_ACTIVE);

            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, DONE);
        }

        void SummonedCreatureDespawn(Creature* creature) override
        {
            if (creature->IsAlive() && !summons.IsAnyCreatureInCombat())
            {
                instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, FAIL);
            }

            BossAI::SummonedCreatureDespawn(creature);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == AREATRIGGER && data == AREATRIGGER_BLACKROCK_STADIUM)
            {
                if (!gythEvent)
                {
                    gythEvent = true;

                    if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 5.0f))
                    {
                        if (!victor->IsAlive())
                        {
                            victor->Respawn(true);
                        }

                        victorGUID = victor->GetGUID();
                    }

                    if (GameObject* portcullis = me->FindNearestGameObject(GO_DR_PORTCULLIS, 50.0f))
                        waveDoorGUID = portcullis->GetGUID();

                    events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0ms);
                    events.ScheduleEvent(EVENT_START_1, 1s);
                }
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == WAYPOINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case 5:
                        events.ScheduleEvent(EVENT_TELEPORT_1, 2s);
                        break;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (gythEvent)
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_START_1:
                            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, IN_PROGRESS);
                            instance->SetData(DATA_VAELASTRASZ, NOT_STARTED);

                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_0);

                            if (GameObject* door2 = me->GetMap()->GetGameObject(instance->GetGuidData(GO_GYTH_ENTRY_DOOR)))
                                door2->SetGoState(GO_STATE_READY);

                            events.ScheduleEvent(EVENT_START_2, 4s);
                            break;
                        //Lanny
                        case EVENT_START_2:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0ms);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                            events.ScheduleEvent(EVENT_START_3, 1s);
                            break;
                        case EVENT_START_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_1);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 6s);
                            events.ScheduleEvent(EVENT_TURN_TO_REND, 4s);
                            events.ScheduleEvent(EVENT_RP_NEFARIUS_1, 4s); // Roleplay Begin
                            events.ScheduleEvent(EVENT_RP_NEFARIUS_2, 8s);
                            events.ScheduleEvent(EVENT_RP_REND_1, 10s);
                            events.ScheduleEvent(EVENT_RP_NEFARIUS_3, 14s);
                            events.ScheduleEvent(EVENT_RP_REND_2, 18s);
                            events.ScheduleEvent(EVENT_RP_NEFARIUS_4, 23s); // Roleplay End
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 24s);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_2, 25s);
                            break;
                        case EVENT_TURN_TO_REND:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                            {
                                victor->SetFacingToObject(me);
                            }
                            break;
                        case EVENT_TURN_TO_PLAYER:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                if (Unit* player = victor->SelectNearestPlayer(60.0f))
                                    victor->SetFacingToObject(player);
                            break;
                        case EVENT_TURN_TO_FACING_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->SetFacingTo(1.518436f);  // Victor Face arena
                            break;
                        case EVENT_TURN_TO_FACING_2:
                            me->SetFacingTo(1.500983f); //Rend Face Arena
                            break;
                        case EVENT_WAVES_EMOTE_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                            break;
                        case EVENT_WAVES_EMOTE_2:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                            break;
                        case EVENT_WAVES_TEXT_1:
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 0s);
                            events.ScheduleEvent(EVENT_RANDOM_TALK_VICTOR, 2s);
                            events.ScheduleEvent(EVENT_RANDOM_TALK_VICTOR, 8s);
                            break;
                        case EVENT_WAVES_TEXT_2:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0ms);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 0s);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_3);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 3s);
                            events.ScheduleEvent(EVENT_RANDOM_TALK_REND, 6s);
                            break;
                        case EVENT_WAVES_TEXT_3:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0ms);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_4);
                            events.ScheduleEvent(EVENT_SPAWN_SPECTATOR, 0ms);						
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 2s);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 3s);
                            events.ScheduleEvent(EVENT_RANDOM_TALK_VICTOR, 6s);
                            break;
                        case EVENT_WAVES_TEXT_4:
                            Talk(SAY_BLACKHAND_1);
                            events.ScheduleEvent(EVENT_WAVES_EMOTE_2, 0s);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 1s);
                            events.ScheduleEvent(EVENT_RANDOM_TALK_REND, 6s);
                            break;
                        case EVENT_WAVES_TEXT_5:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0ms);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_5);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 1s);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 3s);
                            events.ScheduleEvent(EVENT_RANDOM_TALK_VICTOR, 6s);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_7);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_2, 1s);							
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_2:
                            Talk(SAY_BLACKHAND_2);
                            events.ScheduleEvent(EVENT_PATH_REND, 1s);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_3, 4s);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_8);
                            events.ScheduleEvent(EVENT_PATH_NEFARIUS, 1s);
                            break;
                        case EVENT_PATH_NEFARIUS:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                            {
                                victor->GetMotionMaster()->MovePath(NEFARIUS_PATH_1, true);
                                victor->AI()->Talk(SAY_NEFARIUS_6);
                            }
                            events.ScheduleEvent(EVENT_STOP_MOVEMENT_1, 12s);
                            break;
                        case EVENT_PATH_REND:
                            me->GetMotionMaster()->MovePath(REND_PATH_1, false);
                            break;
                        case EVENT_TELEPORT_1:
                            me->NearTeleportTo(194.2993f, -474.0814f, 121.4505f, -0.01225555f);
                            events.ScheduleEvent(EVENT_TELEPORT_2, 13s);
                            break;
                        case EVENT_TELEPORT_2:
                            me->NearTeleportTo(216.485f, -434.93f, 110.888f, -0.01225555f); // Drops from ceiling for some reason - please fix
                            me->SummonCreature(NPC_GYTH, 211.762f, -397.5885f, 111.1817f, 4.747295f);
                            break;
                        case EVENT_RP_NEFARIUS_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_20);
                            break;
                        case EVENT_RP_NEFARIUS_2:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_21);
                            break;
                        case EVENT_RP_NEFARIUS_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_22);
                            break;
                        case EVENT_RP_NEFARIUS_4:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_23);
                            break;
                        case EVENT_RP_REND_1:
                            Talk(SAY_BLACKHAND_5);
                            break;							
                        case EVENT_RP_REND_2:
                            Talk(SAY_BLACKHAND_6);
                            break;								
                        case EVENT_STOP_MOVEMENT_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
							{
                                victor->GetMotionMaster()->Clear();
                                victor->GetMotionMaster()->MoveIdle();
                                victor->StopMovingOnCurrentPos();
								//victor->SetFacingTo(1.518436f);
                            }
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 0s);
                            break;
                        case EVENT_RANDOM_TALK_VICTOR:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_2);
                            break;
                        case EVENT_RANDOM_TALK_REND:
                            Talk(SAY_BLACKHAND_4);
                            break;
                        case EVENT_RANDOM_TAUNT_VICTOR:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_19);
                            break;
                        case EVENT_RANDOM_TAUNT_REND:
                            Talk(SAY_BLACKHAND_3);
                            break;
                        case EVENT_SPAWN_SPECTATOR:
                            SpectatorEvent = true;
                            me->SummonCreature(NPC_BLACKHAND_ELITE, 155.07152f, -395.59592f, 121.97532f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_ELITE, 147.99828f, -395.6054f, 121.975296f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 145.42926f, -395.67053f, 121.97536f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 146.46133f, -392.2175f, 121.97536f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 143.71658f, -392.31836f, 121.97536f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 149.48524f, -392.19565f, 121.97536f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 163.55032f, -390.38922f, 121.97533f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 161.1205f, -389.09076f, 121.97533f, 4.7225f);
                            me->SummonCreature(NPC_BLACKHAND_VETERAN, 166.6152f, -389.147f, 121.97533f, 4.7225f);
                            break;
                        //End Lanny NPCBot
                        case EVENT_SPAWN_WAVE:
                            SummonWave();
                            break;
                        default:
                            break;
                    }
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WHIRLWIND:
                        DoCast(SPELL_WHIRLWIND);
                        events.ScheduleEvent(EVENT_WHIRLWIND, 13s, 18s);
                        break;
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 10s, 14s);
                        break;
                    case EVENT_MORTAL_STRIKE:
                        DoCastVictim(SPELL_MORTAL_STRIKE);
                        events.ScheduleEvent(EVENT_MORTAL_STRIKE, 14s, 18s);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

        void SummonWave()
        {
            SpectatorEvent = false; // Lanny

            me->SummonCreatureGroup(_currentWave);

            if (GameObject* waveDoor = me->GetMap()->GetGameObject(waveDoorGUID))
            {
                waveDoor->UseDoorOrButton();
            }

            ++_currentWave;
        }

    private:
        bool   gythEvent;
        uint8 _currentWave;
        ObjectGuid victorGUID;
        ObjectGuid waveDoorGUID;
        bool   SpectatorEvent; //Lanny
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_rend_blackhandAI>(creature);
    }
};

void AddSC_boss_rend_blackhand()
{
    new boss_rend_blackhand();
}
