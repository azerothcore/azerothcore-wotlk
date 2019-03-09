/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Nightbane
SD%Complete: 80
SDComment: SDComment: Timers may incorrect
SDCategory: Karazhan
EndScriptData */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "karazhan.h"

enum Spells
{
    // phase 1
    SPELL_BELLOWING_ROAR        = 39427,
    SPELL_CHARRED_EARTH         = 30129,
    SPELL_DISTRACTING_ASH       = 30130,
    SPELL_SMOLDERING_BREATH     = 30210,
    SPELL_TAIL_SWEEP            = 25653,
    // phase 2
    SPELL_RAIN_OF_BONES         = 37098,
    SPELL_SMOKING_BLAST         = 37057,
    SPELL_FIREBALL_BARRAGE      = 30282,
    SPELL_SEARING_CINDERS       = 30127,
    SPELL_SUMMON_SKELETON       = 30170
};

enum Says
{
    EMOTE_SUMMON                = 0, // Not used in script
    YELL_AGGRO                  = 1,
    YELL_FLY_PHASE              = 2,
    YELL_LAND_PHASE             = 3,
    EMOTE_BREATH                = 4
};

float IntroWay[8][3] =
{
    {-11053.37f, -1794.48f, 149.00f},
    {-11141.07f, -1841.40f, 125.00f},
    {-11187.28f, -1890.23f, 125.00f},
    {-11189.20f, -1931.25f, 125.00f},
    {-11153.76f, -1948.93f, 125.00f},
    {-11128.73f, -1929.75f, 125.00f},
    {-11140.00f, -1915.00f, 122.00f},
    {-11163.00f, -1903.00f, 91.473f}
};

class boss_nightbane : public CreatureScript
{
public:
    boss_nightbane() : CreatureScript("boss_nightbane") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_nightbaneAI (creature);
    }

    struct boss_nightbaneAI : public ScriptedAI
    {
        boss_nightbaneAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            Intro = true;
        }

        InstanceScript* instance;

        uint32 Phase;

        bool RainBones;
        bool Skeletons;

        uint32 BellowingRoarTimer;
        uint32 CharredEarthTimer;
        uint32 DistractingAshTimer;
        uint32 SmolderingBreathTimer;
        uint32 TailSweepTimer;
        uint32 RainofBonesTimer;
        uint32 SmokingBlastTimer;
        uint32 FireballBarrageTimer;
        uint32 SearingCindersTimer;

        uint32 FlyCount;
        uint32 FlyTimer;

        bool Intro;
        bool Flying;
        bool Movement;

        uint32 MovePhase;

        void Reset()
        {
            BellowingRoarTimer = 30000;
            CharredEarthTimer = 15000;
            DistractingAshTimer = 20000;
            SmolderingBreathTimer = 10000;
            TailSweepTimer = 12000;
            RainofBonesTimer = 10000;
            SmokingBlastTimer = 20000;
            FireballBarrageTimer = 13000;
            SearingCindersTimer = 14000;

            Phase = 1;
            FlyCount = 0;
            MovePhase = 0;

            me->SetSpeed(MOVE_RUN, 2.0f);
            me->SetDisableGravity(Intro);
            me->SetWalk(false);
            me->setActive(true);

            if (instance)
            {
                if (instance->GetData64(DATA_NIGHTBANE) == DONE)
                    me->DisappearAndDie();
                else
                    instance->SetData64(DATA_NIGHTBANE, NOT_STARTED);
            }

            HandleTerraceDoors(true);

            Flying = false;
            Movement = false;

            if (!Intro)
            {
                me->SetHomePosition(IntroWay[7][0], IntroWay[7][1], IntroWay[7][2], 0);
                me->GetMotionMaster()->MoveTargetedHome();
            }
        }

        void HandleTerraceDoors(bool open)
        {
            if (instance)
            {
                instance->HandleGameObject(instance->GetData64(DATA_MASTERS_TERRACE_DOOR_1), open);
                instance->HandleGameObject(instance->GetData64(DATA_MASTERS_TERRACE_DOOR_2), open);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (instance)
                instance->SetData64(DATA_NIGHTBANE, IN_PROGRESS);

            HandleTerraceDoors(false);
           Talk(YELL_AGGRO);
        }

        void AttackStart(Unit* who)
        {
            if (!Intro && !Flying)
                ScriptedAI::AttackStart(who);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                instance->SetData(DATA_NIGHTBANE, DONE);

            HandleTerraceDoors(true);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!Intro && !Flying)
                ScriptedAI::MoveInLineOfSight(who);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (Intro)
            {
                if (id >= 8)
                {
                    Intro = false;
                    me->SetHomePosition(IntroWay[7][0], IntroWay[7][1], IntroWay[7][2], 0);
                    return;
                }

                MovePhase = id+1;
                return;
            }

            if (Flying)
            {
                if (id == 0)
                {
                    Talk(EMOTE_BREATH);
                    Flying = false;
                    Phase = 2;
                    return;
                }

                if (id < 8)
                    MovePhase = id+1;
                else
                {
                    Phase = 1;
                    Flying = false;
                    Movement = true;
                    return;
                }
            }
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->AI()->AttackStart(me->GetVictim());
        }

        void TakeOff()
        {
            Talk(YELL_FLY_PHASE);

            me->InterruptSpell(CURRENT_GENERIC_SPELL);
            me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            me->SetDisableGravity(true);
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MovePoint(0, IntroWay[2][0], IntroWay[2][1], IntroWay[2][2]);

            Flying = true;

            FlyTimer = urand(45000, 60000); //timer wrong between 45 and 60 seconds
            ++FlyCount;

            RainofBonesTimer = 5000; //timer wrong (maybe)
            RainBones = false;
            Skeletons = false;
         }

        void UpdateAI(uint32 diff)
        {
            if (Intro)
            {
                if (MovePhase)
                {
                    if (MovePhase >= 7)
                    {
                        me->SetDisableGravity(false);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                        me->GetMotionMaster()->MovePoint(8, IntroWay[7][0], IntroWay[7][1], IntroWay[7][2]);
                    }
                    else
                    {
                        me->GetMotionMaster()->MovePoint(MovePhase, IntroWay[MovePhase][0], IntroWay[MovePhase][1], IntroWay[MovePhase][2]);
                    }
                    MovePhase = 0;
                }
                return;
            }

            if (Flying && MovePhase)
            {
                if (MovePhase >= 7)
                {
                    me->SetDisableGravity(false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->GetMotionMaster()->MovePoint(8, IntroWay[7][0], IntroWay[7][1], IntroWay[7][2]);
                }
                else
                    me->GetMotionMaster()->MovePoint(MovePhase, IntroWay[MovePhase][0], IntroWay[MovePhase][1], IntroWay[MovePhase][2]);
                    
                MovePhase = 0;
            }

            if (!UpdateVictim())
                return;

            if (Flying)
                return;

            //  Phase 1 "GROUND FIGHT"
            if (Phase == 1)
            {
                if (Movement)
                {
                    DoStartMovement(me->GetVictim());
                    Movement = false;
                }

                if (BellowingRoarTimer <= diff)
                {
                    DoCastVictim(SPELL_BELLOWING_ROAR);
                    BellowingRoarTimer = urand(30000, 40000);
                } else 
                    BellowingRoarTimer -= diff;

                if (SmolderingBreathTimer <= diff)
                {
                    DoCastVictim(SPELL_SMOLDERING_BREATH);
                    SmolderingBreathTimer = 20000;
                } else 
                    SmolderingBreathTimer -= diff;

                if (CharredEarthTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(target, SPELL_CHARRED_EARTH);
                    CharredEarthTimer = 20000;
                } else 
                    CharredEarthTimer -= diff;

                if (TailSweepTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        if (!me->HasInArc(M_PI, target))
                            DoCast(target, SPELL_TAIL_SWEEP);
                    TailSweepTimer = 15000;
                } else 
                    TailSweepTimer -= diff;

                if (SearingCindersTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(target, SPELL_SEARING_CINDERS);
                    SearingCindersTimer = 10000;
                } else 
                    SearingCindersTimer -= diff;

                uint32 Prozent = uint32(me->GetHealthPct());

                if (Prozent < 75 && FlyCount == 0) // first take off 75%
                    TakeOff();

                if (Prozent < 50 && FlyCount == 1) // secound take off 50%
                    TakeOff();

                if (Prozent < 25 && FlyCount == 2) // third take off 25%
                    TakeOff();

                DoMeleeAttackIfReady();
            }

            //Phase 2 "FLYING FIGHT"
            if (Phase == 2)
            {
                if (!RainBones)
                {
                    if (!Skeletons)
                    {
                        for (uint8 i = 0; i <= 3; ++i)
                        {
                            DoCastVictim(SPELL_SUMMON_SKELETON);
                            Skeletons = true;
                        }
                    }

                    if (RainofBonesTimer < diff && !RainBones) // only once at the beginning of phase 2
                    {
                        DoCastVictim(SPELL_RAIN_OF_BONES);
                        RainBones = true;
                        SmokingBlastTimer = 20000;
                    } else 
                        RainofBonesTimer -= diff;

                    if (DistractingAshTimer <= diff)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            DoCast(target, SPELL_DISTRACTING_ASH);
                        DistractingAshTimer = 2000; //timer wrong
                    } else 
                        DistractingAshTimer -= diff;
                }

                if (RainBones)
                {
                    if (SmokingBlastTimer <= diff)
                     {
                        DoCastVictim(SPELL_SMOKING_BLAST);
                        SmokingBlastTimer = 1500; //timer wrong
                     } else 
                        SmokingBlastTimer -= diff;
                }

                if (FireballBarrageTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0))
                        DoCast(target, SPELL_FIREBALL_BARRAGE);
                    FireballBarrageTimer = 20000;
                } else 
                    FireballBarrageTimer -= diff;

                if (FlyTimer <= diff) //landing
                {
                    Talk(YELL_LAND_PHASE);

                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MovePoint(3, IntroWay[3][0], IntroWay[3][1], IntroWay[3][2]);

                    Flying = true;
                } else 
					FlyTimer -= diff;
            }
        }
    };

};

class go_blackened_urn : public GameObjectScript
{
public:
    go_blackened_urn() : GameObjectScript("go_blackened_urn") { }

    bool OnGossipHello(Player* pPlayer, GameObject *pGo)
    {
        if (InstanceScript* pInstance = pGo->GetInstanceScript())
        {
            if (pInstance->GetData(DATA_NIGHTBANE) != DONE && !pGo->FindNearestCreature(NPC_NIGHTBANE, 40.0f))
                if (Creature *cr = ObjectAccessor::GetCreature(*pPlayer, pInstance->GetData64(DATA_NIGHTBANE)))
                    cr->GetMotionMaster()->MovePoint(0, IntroWay[0][0], IntroWay[0][1], IntroWay[0][2]);
        }
        return false;
    }
};

void AddSC_boss_nightbane()
{
    new boss_nightbane();
    new go_blackened_urn();
}
