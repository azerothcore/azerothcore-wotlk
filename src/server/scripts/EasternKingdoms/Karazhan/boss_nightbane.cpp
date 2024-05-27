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
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "karazhan.h"

enum Spells
{
    // Fly Phase
    SPELL_BELLOWING_ROAR        = 39427,
    SPELL_CLEAVE                = 30131,
    SPELL_CHARRED_EARTH         = 30129,
    SPELL_DISTRACTING_ASH       = 30130,
    SPELL_SMOLDERING_BREATH     = 30210,
    SPELL_TAIL_SWEEP            = 25653,
    // Ground Phase
    SPELL_RAIN_OF_BONES         = 37098,
    SPELL_SMOKING_BLAST         = 37057,
    SPELL_FIREBALL_BARRAGE      = 30282,
    SPELL_SEARING_CINDERS       = 30127,
    SPELL_SUMMON_SKELETON       = 30170
};

enum Says
{
    EMOTE_SUMMON                = 0,
    YELL_AGGRO                  = 1,
    YELL_FLY_PHASE              = 2,
    YELL_LAND_PHASE             = 3,
    EMOTE_BREATH                = 4
};

enum Actions
{
    ACTION_START_INTRO = 0
};

enum Phases
{
    PHASE_INTRO                 = 0,
    PHASE_GROUND                = 1,
    PHASE_FLY                   = 2,
    PHASE_TAKE_OFF              = 3,
    PHASE_LAND                  = 4
};

 enum Groups
{
    GROUP_GROUND                = 0,
    GROUP_FLYING                = 1,
    GROUP_LAND                  = 2
 };

enum Points
{
    POINT_DESPAWN = 10, // Other points used dynamically throughout the script
    POINT_INTRO_END             = 11,
    POINT_LANDING_END           = 6,
    POINT_ID_AIR_MID            = 1,
    POINT_ID_AIR_PHASE          = 2,
    POINT_ID_GROUND             = 3,

    POINT_TAKE_OFF_INTRO = 12,
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
}; //TODO: move to table


Position const positionLanding = {-11142.712f, -1891.193f, 92.25038f};
Position const FlyPosition = { -11160.13f, -1870.683f, 97.73876f, 0.0f };
Position const FlyPositionLeft = { -11094.42f, -1866.992f, 107.8375f, 0.0f };
Position const FlyPositionRight = { -11193.77f, -1921.983f, 107.9845f, 0.0f };


// -11110.674,  -1878.7712,  107.89686 intermediate do land or go circle

// -11162.23f, -1900.329f, 91.47265f Landing location, cmangos after combat

enum Misc
{
    NPC_NIGHTBANE_HELPER_TARGET = 17260
};

struct boss_nightbane : public BossAI
{
    boss_nightbane(Creature* creature) : BossAI(creature, DATA_NIGHTBANE)
    {
        _intro = true;
        _skeletonCount = 5;
        _movePhase = 0;
    }

    void Reset() override
    {
        BossAI::Reset();
        _skeletonscheduler.CancelAll();

        // me->SetSpeed(MOVE_RUN, 2.0f);
        // me->SetDisableGravity(_intro);
        // me->SetWalk(false);
        // me->setActive(true);

        _flying = false;
        _movement = false;
        _intro = true;
        // Phase = 1;
        _movePhase = 0;
        _triggerCountTakeOffWhileFlying = 0;
        _flightPhasesCompleted = 0;

        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetReactState(REACT_PASSIVE);

        ScheduleHealthCheckEvent({ 75, 50, 25 }, [&]{
            TakeOff();
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);
        me->SetDisableGravity(true);
        me->SendMovementFlagUpdate();
        me->GetMotionMaster()->MoveTakeoff(POINT_DESPAWN, -11013.246f, -1770.5212f, 166.50139f);
    }


    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damageEffectType, SpellSchoolMask spellSchoolMask) override
    {
        if (_flightPhasesCompleted < 3)
        {
            if (damage >= me->GetHealth())
            {
                damage = me->GetHealth() - 1;
            }
        }
        BossAI::DamageTaken(attacker, damage, damageEffectType, spellSchoolMask);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        _intro = false;
        _phase = PHASE_GROUND;

        Talk(YELL_AGGRO);
        ScheduleGround();
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_START_INTRO)
        {
            me->GetMap()->LoadGrid(-11260.0f, -1771.0f); // load grid at far end of path
            me->GetMap()->SetVisibilityRange(300.0f); // see nightbane
            me->AddUnitState(UNIT_STATE_IGNORE_PATHFINDING);
            _phase = PHASE_INTRO;
            me->AI()->Talk(EMOTE_SUMMON);
            scheduler.Schedule(2s, [this](TaskContext context)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                // me->SetHover(true);
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MoveTakeoff(POINT_TAKE_OFF_INTRO, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 10.0f, 14.0f);
            }).Schedule(4s, [this](TaskContext context)
            {
                me->GetMotionMaster()->MovePath(me->GetEntry()*10, false);
            });
            // me->GetMotionMaster()->MovePoint(0, IntroWay[0][0], IntroWay[0][1], IntroWay[0][2]);
            // me->SetCanFly(true);
            // me->SetDisableGravity(true);
            // me->SetHover(true);
            // me->GetMotionMaster()->MoveSplinePath(me->GetEntry()); //Crashes
            // me->SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_FLY);
            // me->SendMovementFlagUpdate();
//            // _phase = PHASE_INTRO;
//            // Talk(EMOTE_SUMMON);
//            me->setActive(true);
//            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
//
//            // me->RemoveByteFlag(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, UNIT_BYTE1_FLAG_ALWAYS_STAND);

//            // me->SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER , UNIT_BYTE1_FLAG_FLY);
//            me->SetDisableGravity(true);
//            me->setActive(true);
//            me->GetMotionMaster()->MoveSplinePath(me->GetEntry());
        }
     }


    void ScheduleGround()
    {
        scheduler.Schedule(30s, GROUP_GROUND, [this](TaskContext context)
        {
            DoCastAOE(SPELL_BELLOWING_ROAR);
            context.Repeat(30s, 40s);
        }).Schedule(15s, GROUP_GROUND, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_CHARRED_EARTH, 0, 100.0f, true);
            context.Repeat(20s);
        }).Schedule(10s, GROUP_GROUND, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SMOLDERING_BREATH);
            context.Repeat(20s);
        }).Schedule(12s, GROUP_GROUND, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
            {
                if (!me->HasInArc(M_PI, target))
                {
                    DoCast(target, SPELL_TAIL_SWEEP);
                }
            }
            context.Repeat(15s);
        }).Schedule(14s, GROUP_GROUND, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_SEARING_CINDERS);
            context.Repeat(10s);
        }).Schedule(1500ms, GROUP_GROUND, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(1500ms, 45s);
        });
    }

    void ScheduleFly()
    {
        _skeletonSpawnCounter = 0;

        scheduler.Schedule(2s, GROUP_FLYING, [this](TaskContext)
        {
            DoResetThreatList();
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
            {
                _skeletonSpawnPos = target->GetPosition();
                me->CastSpell(_skeletonSpawnPos.GetPositionX(), _skeletonSpawnPos.GetPositionY(), _skeletonSpawnPos.GetPositionZ(), SPELL_RAIN_OF_BONES, true);
                _skeletonscheduler.Schedule(50ms, [this](TaskContext context)
                {
                    //spawns skeletons every 2 seconds until skeletonCount is reached
                    if(_skeletonSpawnCounter < _skeletonCount)
                    {
                        me->CastSpell(_skeletonSpawnPos.GetPositionX(), _skeletonSpawnPos.GetPositionY(), _skeletonSpawnPos.GetPositionZ(), SPELL_SUMMON_SKELETON, true);
                        _skeletonSpawnCounter++;
                        context.Repeat(2s);
                    }
                });
            }
        }).Schedule(20s, GROUP_FLYING, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DISTRACTING_ASH);
            context.Repeat(2s); //timer wrong?
        }).Schedule(25s, GROUP_FLYING, [this](TaskContext context)
        {
            //5 seconds added due to double trigger?
            //trigger for timer in original + in rain of bones
            //timers need some investigation
            DoCastVictim(SPELL_SMOKING_BLAST);
            context.Repeat(1500ms); //timer wrong?
        }).Schedule(13s, GROUP_FLYING, [this](TaskContext context)
        {
            DoCastOnFarAwayPlayers(SPELL_FIREBALL_BARRAGE, false, 80.0f);
            context.Repeat(20s);
        });
    }

    void AttackStart(Unit* who) override
    {
        if (_phase == PHASE_GROUND)
            ScriptedAI::AttackStart(who);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (_phase == PHASE_GROUND)
            ScriptedAI::MoveInLineOfSight(who);
    }

    void MovementInform(uint32 type, uint32 id) override
    {

    if (type == WAYPOINT_MOTION_TYPE)
        {
            if (me->IsInCombat()) // combat movement
            {
                if (id == POINT_LANDING_END)
                {
                    // me->GetMap()->SetVisibilityRange(200.0f); // see nightbane
                    // me->ClearUnitState(UNIT_STATE_IGNORE_PATHFINDING);
                    // m_creature->RemoveByteFlag(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_MISC_FLAGS, UNIT_BYTE1_FLAG_FLY_ANIM);
                    // m_creature->SetByteFlag(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_MISC_FLAGS, UNIT_BYTE1_FLAG_ALWAYS_STAND);
                    // me->SetCanFly(false);
                    // me->SetHover(false);
                    me->GetMotionMaster()->MovePoint(POINT_ID_GROUND, -11162.23f, -1900.329f, 91.47265f); // noted as falling in sniff
                }
            }
            else // intro movement
            {
                if (id == 8)
                {
                    ScheduleIntroLand();
                    me->GetMap()->SetVisibilityRange(200.0f); // see nightbane
                }
            }
        }

        if (type != POINT_MOTION_TYPE)
            return;


        if (id == POINT_DESPAWN)
        {
            me->DespawnOnEvade();
        }

        if (_intro)
        {
            if (id >= 11)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                me->SetInCombatWithZone();
                return;
            }

            _movePhase = id + 1;
            return;
        }

        if (_flying)
        {
            if (id == 0)
            {
                Talk(EMOTE_BREATH);
                _flying = false;
                Phase = 2;
                return;
            }

            if (id < 8)
                _movePhase = id + 1;
            else
            {
                _flying = false;
                _flightPhasesCompleted++;
                if (_triggerCountTakeOffWhileFlying > 0)
                {
                    _triggerCountTakeOffWhileFlying--;
                    scheduler.Schedule(2s, [this](TaskContext)
                    {
                        TakeOff(true);
                    });
                }
                else
                {
                    Phase = 1;
                    _movement = true;
                    ScheduleGround();
                }
                return;
            }
        }
    }

    void ScheduleIntroLand()
    {
        scheduler.Schedule(2s, [this](TaskContext /*context*/)
        {
            // me->GetMotionMaster()->MovePoint(POINT_INTRO_END, positionLanding);
            me->GetMotionMaster()->MoveLand(POINT_INTRO_END, positionLanding, 14.0f);
            me->ClearUnitState(UNIT_STATE_IGNORE_PATHFINDING);
        }).Schedule(5s, [this](TaskContext /*context*/)
        {
            // me->GetMotionMaster()->MoveIdle();
            // me->GetMotionMaster()->Clear(false);
            // me->ClearUnitState(UNIT_STATE_IGNORE_PATHFINDING);
            // me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            // me->SetReactState(REACT_AGGRESSIVE);
            // me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
            // me->SetCanFly(false);
            // me->SetHover(false);
            // me->SetDisableGravity(false);
            // // me->SetStandState(UNIT_STAND_STATE_STAND);
            // ScheduleGround();

            // me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);

            // me->GetMotionMaster()->MoveIdle();

            me->SetSpeed(MOVE_RUN, 2.0f);
            me->SetCanFly(false);
            // me->SetHover(false);
            // me->SetDisableGravity(true);
            me->SetDisableGravity(false);
            // Position land = me->GetPosition();
            // me->GetMotionMaster()->MoveLand(0, land, 14.0f);

            _movement = true; // attack on landing
        });
    }

    void JustSummoned(Creature* summon) override
    {
        summon->AI()->AttackStart(me->GetVictim());
        summons.Summon(summon);
    }

    void DoCastOnFarAwayPlayers(uint32 spellid, bool triggered, float tresholddistance)
    {
        //resembles DoCastToAllHostilePlayers a bit/lot
        ThreatContainer::StorageType targets = me->GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
        {
            if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
            {
                if (unit->IsPlayer() && !unit->IsWithinDist(me, tresholddistance, false))
                {
                    me->CastSpell(unit, spellid, triggered);
                }
            }
        }
    }

    void TakeOff(bool justLanded = false)
    {
        if ((_flying || Phase == 2) && !justLanded)
        {
            _triggerCountTakeOffWhileFlying++;
            return;
        }
        Talk(YELL_FLY_PHASE);
        scheduler.CancelGroup(GROUP_GROUND);

        me->InterruptSpell(CURRENT_GENERIC_SPELL);
        me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
        me->SetDisableGravity(true);
        me->GetMotionMaster()->Clear(false);
        // me->GetMotionMaster()->MovePoint(0, IntroWay[2][0], IntroWay[2][1], IntroWay[2][2]);

        _flying = true;

        ScheduleFly();

        //handle landing again
        scheduler.Schedule(45s, 60s, [this](TaskContext)
        {
            Talk(YELL_LAND_PHASE);

            me->GetMotionMaster()->Clear(false);
            // me->GetMotionMaster()->MovePoint(3, IntroWay[3][0], IntroWay[3][1], IntroWay[3][2]);

            _flying = true;
            scheduler.CancelGroup(GROUP_FLYING);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        // if (_intro)
        // {
        //     if (_movePhase)
        //     {
        //         if (_movePhase >= 10)
        //         {
        //             me->SetDisableGravity(false);
        //             me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
        //         }
        //         _movePhase = 0;
        //     }
        //     return;
        // }

        // if (_flying && _movePhase)
        // {
        //     if (_movePhase >= 7)
        //     {
        //         me->SetDisableGravity(false);
        //         DoResetThreatList();
        //         me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
        //         me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
        //         // me->GetMotionMaster()->MovePoint(8, IntroWay[7][0], IntroWay[7][1], IntroWay[7][2]);
        //     }
        //     else
        //         // me->GetMotionMaster()->MovePoint(_movePhase, IntroWay[_movePhase][0], IntroWay[_movePhase][1], IntroWay[_movePhase][2]);

        //     _movePhase = 0;
        scheduler.Update(diff);
        // }
        // if (isIntroPathComplete && _phase == PHASE_INTRO)
        // {
            // scheduler.Schedule(2s, [this](TaskContext /*context*/)
            // {
                // me->GetMotionMaster()->MovePoint(POINT_INTRO_END, positionLanding, false, true);
                // me->GetMotionMaster()->MovePoint(POINT_INTRO_END, positionLanding, 14.0f);
                // me->GetMotionMaster()->MovePoint(POINT_INTRO_END, positionLanding, false, true);
            // });
            // isIntroPathComplete = false;
        // }

        if (!UpdateVictim())
            return;

        // if (_flying)
        //     return;

        _skeletonscheduler.Update(diff);

        //  Phase 1 "GROUND FIGHT"
        if (_phase == PHASE_GROUND)
        {
            if (_movement)
            {
                DoStartMovement(me->GetVictim());
                _movement = false;
            }

            DoMeleeAttackIfReady();
        }
    }

private:
    uint32 Phase;

    TaskScheduler _skeletonscheduler;

    bool _intro;
    bool _flying;
    bool _movement;

    bool isIntroPathComplete;
    uint8 _phase;

    uint32 _movePhase;
    uint8 _skeletonCount;
    uint8 _skeletonSpawnCounter;
    Position _skeletonSpawnPos;
    uint8 _triggerCountTakeOffWhileFlying;
    uint8 _flightPhasesCompleted;
};

class go_blackened_urn : public GameObjectScript
{
public:
    go_blackened_urn() : GameObjectScript("go_blackened_urn") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (instance->GetBossState(DATA_NIGHTBANE) == DONE || instance->GetBossState(DATA_NIGHTBANE) == IN_PROGRESS)
                return false;
            if (Creature* nightbane = instance->GetCreature(DATA_NIGHTBANE))
            {
                nightbane->AI()->DoAction(ACTION_START_INTRO);
            }
        }
        return false;
    }
};

struct npc_nightbane_helper_target : public NullCreatureAI
{
    npc_nightbane_helper_target(Creature* creature) : NullCreatureAI(creature)
    {
        me->SetDisableGravity(true);
    }
};

void AddSC_boss_nightbane()
{
    RegisterKarazhanCreatureAI(boss_nightbane);
    new go_blackened_urn();
    RegisterKarazhanCreatureAI(npc_nightbane_helper_target);
}
