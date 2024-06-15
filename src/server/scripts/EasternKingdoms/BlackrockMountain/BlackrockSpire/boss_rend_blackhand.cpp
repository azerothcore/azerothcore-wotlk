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
};

enum Adds
{
    NPC_CHROMATIC_WHELP             = 10442,
    NPC_CHROMATIC_DRAGONSPAWN       = 10447,
    NPC_BLACKHAND_DRAGON_HANDLER    = 10742
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
    EVENT_TURN_TO_FACING_3          = 9,
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
            if (!summons.IsAnyCreatureAlive())
            {
                events.ScheduleEvent(EVENT_WAVES_TEXT_1 + _currentWave, 10s);
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

                    events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
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
                        case EVENT_START_2:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                            events.ScheduleEvent(EVENT_START_3, 4s);
                            break;
                        case EVENT_START_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_1);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 2s);
                            events.ScheduleEvent(EVENT_TURN_TO_REND, 4s);
                            break;
                        case EVENT_TURN_TO_REND:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                            {
                                victor->SetFacingToObject(me);
                                victor->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            }
                            break;
                        case EVENT_TURN_TO_PLAYER:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                if (Unit* player = victor->SelectNearestPlayer(60.0f))
                                    victor->SetFacingToObject(player);
                            break;
                        case EVENT_TURN_TO_FACING_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->SetFacingTo(1.518436f);
                            break;
                        case EVENT_TURN_TO_FACING_2:
                            me->SetFacingTo(1.658063f);
                            break;
                        case EVENT_TURN_TO_FACING_3:
                            me->SetFacingTo(1.500983f);
                            break;
                        case EVENT_WAVES_EMOTE_1:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                            break;
                        case EVENT_WAVES_EMOTE_2:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                            break;
                        case EVENT_WAVES_TEXT_1:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0ms);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_2);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4s);
                            events.ScheduleEvent(EVENT_WAVES_EMOTE_1, 5s);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 3s);
                            break;
                        case EVENT_WAVES_TEXT_2:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_3);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4s);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 3s);
                            break;
                        case EVENT_WAVES_TEXT_3:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_4);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4s);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 3s);
                            break;
                        case EVENT_WAVES_TEXT_4:
                            Talk(SAY_BLACKHAND_1);
                            events.ScheduleEvent(EVENT_WAVES_EMOTE_2, 4s);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_3, 8s);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 3s);
                            break;
                        case EVENT_WAVES_TEXT_5:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_5);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4s);
                            events.ScheduleEvent(EVENT_SPAWN_WAVE, 3s);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_1:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_6);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4s);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_2, 13s);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_2:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_7);
                            Talk(SAY_BLACKHAND_2);
                            events.ScheduleEvent(EVENT_PATH_REND, 1s);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_3, 4s);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_8);
                            events.ScheduleEvent(EVENT_PATH_NEFARIUS, 1s);
                            events.ScheduleEvent(EVENT_PATH_REND, 1s);
                            break;
                        case EVENT_PATH_NEFARIUS:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->GetMotionMaster()->MovePath(NEFARIUS_PATH_1, true);
                            break;
                        case EVENT_PATH_REND:
                            me->GetMotionMaster()->MovePath(REND_PATH_1, false);
                            break;
                        case EVENT_TELEPORT_1:
                            me->NearTeleportTo(194.2993f, -474.0814f, 121.4505f, -0.01225555f);
                            events.ScheduleEvent(EVENT_TELEPORT_2, 13s);
                            break;
                        case EVENT_TELEPORT_2:
                            me->NearTeleportTo(216.485f, -434.93f, 110.888f, -0.01225555f);
                            me->SummonCreature(NPC_GYTH, 211.762f, -397.5885f, 111.1817f, 4.747295f);
                            break;
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
