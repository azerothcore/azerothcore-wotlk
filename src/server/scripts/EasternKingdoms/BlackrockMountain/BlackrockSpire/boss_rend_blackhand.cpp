/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"
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


struct Wave
{
    uint32 entry;
    float  x_pos;
    float  y_pos;
    float  z_pos;
};
	
static Wave Wave1[] = // 22 sec
{
    { 10447, 202.511f, -421.307f, 110.9877f },
    { 10442, 204.015f, -418.443f, 110.989f },
    { 10442, 203.142f, -423.999f, 110.986f },
    { 10442, 201.008f, -416.648f, 110.974f }
};

static Wave Wave2[]= // 22 sec
{
    { 10447, 209.8637f, -428.2729f, 110.9877f },
    { 10442, 209.3122f, -430.8724f, 110.9814f },
    { 10442, 211.3309f, -425.9111f, 111.0006f }
};

static Wave Wave3[]= // 60 sec
{
    { 10742, 208.6493f, -424.5787f, 110.9872f },
    { 10447, 203.9482f, -428.9446f, 110.982f, },
    { 10442, 203.3441f, -426.8668f, 110.9772f },
    { 10442, 206.3079f, -424.7509f, 110.9943f }
};

static Wave Wave4[]= // 49 sec
{
    { 10742, 212.3541f, -412.6826f, 111.0352f },
    { 10447, 212.5754f, -410.2841f, 111.0296f },
    { 10442, 212.3449f, -414.8659f, 111.0348f },
    { 10442, 210.6568f, -412.1552f, 111.0124f }
};

static Wave Wave5[]= // 60 sec
{
    { 10742, 210.2188f, -410.6686f, 111.0211f },
    { 10447, 209.4078f, -414.13f,   111.0264f },
    { 10442, 208.0858f, -409.3145f, 111.0118f },
    { 10442, 207.9811f, -413.0728f, 111.0098f },
    { 10442, 208.0854f, -412.1505f, 111.0057f }
};

static Wave Wave6[]= // 27 sec
{
    { 10742, 213.9138f, -426.512f,  111.0013f },
    { 10447, 213.7121f, -429.8102f, 110.9888f },
    { 10447, 213.7157f, -424.4268f, 111.009f, },
    { 10442, 210.8935f, -423.913f,  111.0125f },
    { 10442, 212.2642f, -430.7648f, 110.9807f }
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
    EVENT_WAVE_1                    = 10,
    EVENT_WAVE_2                    = 11,
    EVENT_WAVE_3                    = 12,
    EVENT_WAVE_4                    = 13,
    EVENT_WAVE_5                    = 14,
    EVENT_WAVE_6                    = 15,
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

        void Reset()
        {
            _Reset();

            if (instance->GetBossState(DATA_GYTH) == IN_PROGRESS)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_PREPARATION);
                return;
            }

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_PREPARATION);
            gythEvent = false;
            victorGUID = 0;
            waveDoorGUID = 0;

            summons.DespawnAll();

            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 5.0f, true))
                victor->Respawn(true);

            if (GameObject* exitDoor = me->GetMap()->GetGameObject(instance->GetData64(GO_GYTH_ENTRY_DOOR)))
                exitDoor->SetGoState(GO_STATE_ACTIVE);

            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, NOT_STARTED);
        }

        void SummonWave(Wave* wave, uint32 size)
        {
            for (uint8 i = 0; i < size; ++i)
                me->SummonCreature(wave[i].entry, wave[i].x_pos, wave[i].y_pos, wave[i].z_pos, M_PI);

            if (GameObject* waveDoor = me->GetMap()->GetGameObject(waveDoorGUID))
                waveDoor->UseDoorOrButton();
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);

            if (summon->GetEntry() == NPC_GYTH)
            {
                summon->AI()->SetData(1, 1);
                me->DespawnOrUnsummon();
                return;
            }

            if (Unit* target = SelectTargetFromPlayerList(100.0f))
                summon->AI()->AttackStart(target);
            else
                Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_WHIRLWIND,     urand(13000, 15000));
            events.ScheduleEvent(EVENT_CLEAVE,        urand(15000, 17000));
            events.ScheduleEvent(EVENT_MORTAL_STRIKE, urand(17000, 19000));
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 75.0f, true))
                victor->AI()->SetData(1, 2);

            if (GameObject* exitDoor = me->GetMap()->GetGameObject(instance->GetData64(GO_GYTH_ENTRY_DOOR)))
                exitDoor->SetGoState(GO_STATE_ACTIVE);

            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, DONE);
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type == AREATRIGGER && data == AREATRIGGER_BLACKROCK_STADIUM)
            {
                if (!gythEvent)
                {
                    gythEvent = true;

                    Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 5.0f, false);

                    if (victor)
                        victor->Respawn();
                    else
                        victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 5.0f, true);

                    if (victor)
                        victorGUID = victor->GetGUID();

                    if (GameObject* portcullis = me->FindNearestGameObject(GO_DR_PORTCULLIS, 50.0f))
                        waveDoorGUID = portcullis->GetGUID();

                    events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                    events.ScheduleEvent(EVENT_START_1, 1000);
                }
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == WAYPOINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case 5:
                        events.ScheduleEvent(EVENT_TELEPORT_1, 2000);
                        break;
                }
            }
        }

        void UpdateAI(uint32 diff)
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

                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_0);

                            if (GameObject* door2 = me->GetMap()->GetGameObject(instance->GetData64(GO_GYTH_ENTRY_DOOR)))
                                door2->SetGoState(GO_STATE_READY);

                            events.ScheduleEvent(EVENT_START_2, 4000);
                            break;
                        case EVENT_START_2:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                            events.ScheduleEvent(EVENT_START_3, 4000);
                            break;
                        case EVENT_START_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_1);
                            events.ScheduleEvent(EVENT_WAVE_1, 2000);
                            events.ScheduleEvent(EVENT_TURN_TO_REND, 4000);
                            events.ScheduleEvent(EVENT_WAVES_TEXT_1, 20000);
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
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                    victor->AI()->Talk(SAY_NEFARIUS_2);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4000);
                            events.ScheduleEvent(EVENT_WAVES_EMOTE_1, 5000);
                            events.ScheduleEvent(EVENT_WAVE_2, 2000);
                            events.ScheduleEvent(EVENT_WAVES_TEXT_2, 20000);
                            break;
                        case EVENT_WAVES_TEXT_2:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_3);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4000);
                            events.ScheduleEvent(EVENT_WAVE_3, 2000);
                            events.ScheduleEvent(EVENT_WAVES_TEXT_3, 20000);
                            break;
                        case EVENT_WAVES_TEXT_3:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_4);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4000);
                            events.ScheduleEvent(EVENT_WAVE_4, 2000);
                            events.ScheduleEvent(EVENT_WAVES_TEXT_4, 20000);
                            break;
                        case EVENT_WAVES_TEXT_4:
                            Talk(SAY_BLACKHAND_1);
                            events.ScheduleEvent(EVENT_WAVES_EMOTE_2, 4000);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_3, 8000);
                            events.ScheduleEvent(EVENT_WAVE_5, 2000);
                            events.ScheduleEvent(EVENT_WAVES_TEXT_5, 20000);
                            break;
                        case EVENT_WAVES_TEXT_5:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_5);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4000);
                            events.ScheduleEvent(EVENT_WAVE_6, 2000);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_1, 20000);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_1:
                            events.ScheduleEvent(EVENT_TURN_TO_PLAYER, 0);
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_6);
                            events.ScheduleEvent(EVENT_TURN_TO_FACING_1, 4000);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_2, 13000);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_2:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_7);
                            Talk(SAY_BLACKHAND_2);
                            events.ScheduleEvent(EVENT_PATH_REND, 1000);
                            events.ScheduleEvent(EVENT_WAVES_COMPLETE_TEXT_3, 4000);
                            break;
                        case EVENT_WAVES_COMPLETE_TEXT_3:
                            if (Creature* victor = ObjectAccessor::GetCreature(*me, victorGUID))
                                victor->AI()->Talk(SAY_NEFARIUS_8);
                            events.ScheduleEvent(EVENT_PATH_NEFARIUS, 1000);
                            events.ScheduleEvent(EVENT_PATH_REND, 1000);
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
                            events.ScheduleEvent(EVENT_TELEPORT_2, 13000);
                            break;
                        case EVENT_TELEPORT_2:
                            me->NearTeleportTo(216.485f, -434.93f, 110.888f, -0.01225555f);
                            me->SummonCreature(NPC_GYTH, 211.762f, -397.5885f, 111.1817f, 4.747295f);
                            break;
                        case EVENT_WAVE_1:
                            SummonWave(Wave1,4);
                            break;
                        case EVENT_WAVE_2:
                            SummonWave(Wave2,3);
                            break;
                        case EVENT_WAVE_3:
                            SummonWave(Wave3,4);
                            break;
                        case EVENT_WAVE_4:
                            SummonWave(Wave4,4);
                            break;
                        case EVENT_WAVE_5:
                            SummonWave(Wave5,5);
                            break;
                        case EVENT_WAVE_6:
                            SummonWave(Wave6,5);
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
                        events.ScheduleEvent(EVENT_WHIRLWIND, urand(13000, 18000));
                        break;
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, urand(10000, 14000));
                        break;
                    case EVENT_MORTAL_STRIKE:
                        DoCastVictim(SPELL_MORTAL_STRIKE);
                        events.ScheduleEvent(EVENT_MORTAL_STRIKE, urand(14000, 16000));
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

        private:
            bool   gythEvent;
            uint64 victorGUID;
            uint64 waveDoorGUID;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_rend_blackhandAI>(creature);
    }
};

void AddSC_boss_rend_blackhand()
{
    new boss_rend_blackhand();
}
