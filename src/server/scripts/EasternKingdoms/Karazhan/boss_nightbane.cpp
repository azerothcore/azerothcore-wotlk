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
#include "PassiveAI.h"
#include "karazhan.h"

enum Spells
{
    // Ground Phase
    SPELL_RAIN_OF_BONES         = 37098,
    SPELL_SMOKING_BLAST         = 37057,
    SPELL_FIREBALL_BARRAGE      = 30282,
    SPELL_SEARING_CINDERS       = 30127,
    // Air Phase
    SPELL_BELLOWING_ROAR        = 39427,
    SPELL_CLEAVE                = 30131,
    SPELL_CHARRED_EARTH         = 30129,
    SPELL_DISTRACTING_ASH       = 30130,
    SPELL_SMOLDERING_BREATH     = 30210,
    SPELL_TAIL_SWEEP            = 25653,
    SPELL_SUMMON_SKELETON       = 30170
};

enum Says
{
    EMOTE_SUMMON                = 0,
    YELL_AGGRO                  = 1,
    YELL_AIR_PHASE              = 2,
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
    PHASE_TRANSITION            = 3,
};

 enum Groups
{
    GROUP_GROUND                = 0,
    GROUP_AIR                   = 1,
    GROUP_LAND                  = 2
 };

enum Points
{
    POINT_INTRO_TAKE_OFF        =  11,
    POINT_INTRO_PRE_LAND        =  8,
    POINT_INTRO_LAND            =  12,
    POINT_PRE_FLY_EAST          =  21,
    POINT_PRE_FLY_SOUTH         =  22,
    POINT_PRE_FLY_WEST          =  23,
    POINT_PRE_FLY               =  24,
    POINT_FLY                   =  31,
    POINT_LANDING_PRE           =  41,
    POINT_LANDING_WEST          =  42,
    POINT_PRE_LAND              =  5,
    POINT_LAND                  =  51,
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

Position const homePos        =  {-11003.7f,      -1760.19f,     140.253f};
Position const introLandPos   =  {-11142.712f,    -1891.193f,    92.25038f};
Position const preFlySouthPos =  {-11193.77f,     -1921.983f,    107.9845f};
Position const preFlyEastPos  =  {-11167.065f,    -1976.3473f,   109.91183f};
Position const preFlyWestPos  =  {-11095.48f,     -1866.5396f,   107.868996};
Position const preFlyPos      =  {-11154.900391f, -1850.670044f, 103.264999f};
Position const flyPos         =  {-11160.125f,    -1870.683f,    97.73876f};
Position const landPos        =  {-11162.231f,    -1900.3287f,   91.47627f};

struct boss_nightbane : public BossAI
{
    boss_nightbane(Creature* creature) : BossAI(creature, DATA_NIGHTBANE)
    {
        _skeletonCount = 5;
    }

    void Reset() override
    {
        BossAI::Reset();
        _skeletonscheduler.CancelAll();

        _triggerCountTakeOffWhileFlying = 0;
        _airPhasesCompleted = 0;

        me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
        me->SetCanFly(true);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetReactState(REACT_PASSIVE);

        ScheduleHealthCheckEvent({ 75, 50, 25 }, [&]{
            TriggerHealthTakeOff();
        });
    }

    void JustReachedHome() override
    {
        BossAI::JustReachedHome();
        me->DespawnOnEvade();
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetHomePosition(homePos);
        me->SetCanFly(true);
        me->SetDisableGravity(true);
        me->SendMovementFlagUpdate();
        BossAI::EnterEvadeMode(why);
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damageEffectType, SpellSchoolMask spellSchoolMask) override
    {
        if (_airPhasesCompleted < 3)
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
        Talk(YELL_AGGRO);
        ScheduleGround();
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_START_INTRO)
        {
            me->GetMap()->LoadGrid(-11260.0f, -1771.0f); // load grid at far end of intro path
            me->GetMap()->SetVisibilityRange(DEFAULT_VISIBILITY_INSTANCE + 100.0f); // see nightbane
            me->AddUnitState(UNIT_STATE_IGNORE_PATHFINDING);
            _phase = PHASE_INTRO;
            Talk(EMOTE_SUMMON);
            scheduler.Schedule(2s, [this](TaskContext /*context*/)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MoveTakeoff(POINT_INTRO_TAKE_OFF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 10.0f, 13.99879f);
            }).Schedule(4s, [this](TaskContext /*context*/)
            {
                me->GetMotionMaster()->MovePath(me->GetEntry()*10, false);
            });
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

        scheduler.Schedule(2s, GROUP_AIR, [this](TaskContext)
        {
            DoResetThreatList();
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
            {
                _skeletonSpawnPos = target->GetPosition();
                me->SetFacingTo(_skeletonSpawnPos.GetOrientation());
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
        }).Schedule(20s, GROUP_AIR, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random))
            {
                me->SetFacingToObject(target);
                DoCast(target, SPELL_DISTRACTING_ASH);
            }
            context.Repeat(2s); //timer wrong?
        }).Schedule(25s, GROUP_AIR, [this](TaskContext context)
        {
            //5 seconds added due to double trigger?
            //trigger for timer in original + in rain of bones
            //timers need some investigation
            me->SetFacingToObject(me->GetVictim());
            DoCastVictim(SPELL_SMOKING_BLAST);
            context.Repeat(1500ms); //timer wrong?
        }).Schedule(13s, GROUP_AIR, [this](TaskContext context)
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

    void PathEndReached(uint32 pathId) override
    {
        BossAI::PathEndReached(pathId);
        if (pathId == me->GetEntry()*10) // intro
        {
            me->GetMap()->SetVisibilityRange(DEFAULT_VISIBILITY_INSTANCE); // restore visibility
            scheduler.Schedule(0s, [this](TaskContext /*context*/)
            {
                me->ClearUnitState(UNIT_STATE_IGNORE_PATHFINDING);
                me->GetMotionMaster()->MovePoint(POINT_INTRO_LAND, introLandPos);
                me->SetSpeed(MOVE_RUN, 2.0f);
            }).Schedule(3s, [this](TaskContext /*context*/)
            {
                me->SetDisableGravity(false);
                me->SetCanFly(false);
                me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                _phase = PHASE_GROUND;
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
            }).Schedule(8s, [this](TaskContext /*context*/)
            {
                if (!SelectTargetFromPlayerList(45.0f))
                {
                    EnterEvadeMode(EVADE_REASON_NO_HOSTILES);
                }
            });
        }
        else if (pathId == me->GetEntry()*10+1) // landing
        {
            _airPhasesCompleted++;
            if (_triggerCountTakeOffWhileFlying > 0)
            {
                _triggerCountTakeOffWhileFlying--;
                scheduler.Schedule(0s, [this](TaskContext /*context*/)
                {
                    me->GetMotionMaster()->MovePoint(POINT_PRE_FLY_SOUTH, preFlySouthPos);
                });
            }
            else
            {
                scheduler.Schedule(0s, [this](TaskContext /*context*/)
                {
                    DoResetThreatList();
                    me->GetMotionMaster()->MovePoint(POINT_LAND, landPos);
                    me->SetDisableGravity(false);
                    me->SetCanFly(false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    _phase = PHASE_GROUND;
                    ScheduleGround();
                });
            }
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        switch (id)
        {
            case POINT_INTRO_TAKE_OFF:
                break;
            case POINT_INTRO_LAND:
                DoStartMovement(me->GetVictim());
                break;
            case POINT_PRE_FLY_EAST:
                scheduler.Schedule(0s, [this](TaskContext /*context*/)
                {
                    me->GetMotionMaster()->MovePoint(POINT_PRE_FLY_SOUTH, preFlySouthPos);
                });
                break;
            case POINT_PRE_FLY_SOUTH:
            case POINT_PRE_FLY_WEST:
                scheduler.Schedule(0s, [this](TaskContext /*context*/)
                {
                    me->GetMotionMaster()->MovePoint(POINT_PRE_FLY, preFlyPos);
                });
                break;
            case POINT_PRE_FLY:
                scheduler.Schedule(0s, [this](TaskContext /*context*/)
                {
                    me->GetMotionMaster()->MovePoint(POINT_FLY, flyPos);
                });
                break;
            case POINT_FLY:
                _phase = PHASE_FLY;
                Talk(EMOTE_BREATH);
                ScheduleFly();
                ScheduleLand();
                break;
            case POINT_LANDING_PRE:
                scheduler.Schedule(0s, [this](TaskContext /*context*/)
                {
                    me->GetMotionMaster()->MovePoint(POINT_LANDING_WEST, preFlyWestPos);
                });
                break;
            case POINT_LANDING_WEST:
                if (_triggerCountTakeOffWhileFlying > 0)
                {
                    _airPhasesCompleted++;
                    _triggerCountTakeOffWhileFlying--;
                    scheduler.Schedule(0s, [this](TaskContext /*context*/)
                    {
                        me->GetMotionMaster()->MovePoint(POINT_PRE_FLY, preFlyPos);
                    });
                }
                else
                {
                    scheduler.Schedule(0s, [this](TaskContext /*context*/)
                    {
                        me->GetMotionMaster()->MovePath(me->GetEntry()*10+1, false);
                    });
                }
                break;
            case POINT_LAND:
                DoStartMovement(me->GetVictim());
                break;
        }
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

    void TriggerHealthTakeOff()
    {
        if (_phase != PHASE_GROUND)
        {
            _triggerCountTakeOffWhileFlying++;
            return;
        }
        _phase = PHASE_TRANSITION;
        Talk(YELL_AIR_PHASE);
        scheduler.CancelGroup(GROUP_GROUND);
        me->InterruptSpell(CURRENT_GENERIC_SPELL);
        me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
        me->SetDisableGravity(true);
        me->SetCanFly(true);
        me->SendMovementFlagUpdate();
        me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
        FlyToClosestPreFlyWayPoint();
    }

    void FlyToClosestPreFlyWayPoint()
    {
        Position closestWP = preFlyPos;
        if (me->GetDistance(preFlyEastPos) < me->GetDistance(closestWP))
            closestWP = preFlyEastPos;
        if (me->GetDistance(preFlySouthPos) < me->GetDistance(closestWP))
            closestWP = preFlySouthPos;
        if (me->GetDistance(preFlyWestPos) < me->GetDistance(closestWP))
            closestWP = preFlyWestPos;

        me->GetMotionMaster()->Clear(false);
        if (closestWP == preFlyPos)
            me->GetMotionMaster()->MovePoint(POINT_PRE_FLY, closestWP);
        else if (closestWP == preFlyEastPos)
            me->GetMotionMaster()->MovePoint(POINT_PRE_FLY_EAST, closestWP);
        else if (closestWP == preFlySouthPos)
            me->GetMotionMaster()->MovePoint(POINT_PRE_FLY_SOUTH, closestWP);
        else if (closestWP == preFlyWestPos)
            me->GetMotionMaster()->MovePoint(POINT_PRE_FLY_WEST, closestWP);
    }

    void ScheduleLand()
    {
        scheduler.Schedule(30s, GROUP_LAND, [this](TaskContext) /*context*/
        {
            Talk(YELL_LAND_PHASE);
            scheduler.CancelGroup(GROUP_AIR);
            _phase = PHASE_TRANSITION;

            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MovePoint(POINT_LANDING_PRE, preFlyPos);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
        _skeletonscheduler.Update(diff);

        if (!UpdateVictim())
            return;

        if (_phase == PHASE_GROUND)
        {
            DoMeleeAttackIfReady();
        }
    }

private:
    uint8 _phase;
    uint8 _airPhasesCompleted;
    uint8 _triggerCountTakeOffWhileFlying;

    TaskScheduler _skeletonscheduler;
    uint8 _skeletonCount;
    uint8 _skeletonSpawnCounter;
    Position _skeletonSpawnPos;
};

class go_blackened_urn : public GameObjectScript
{
public:
    go_blackened_urn() : GameObjectScript("go_blackened_urn") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            // if (instance->GetBossState(DATA_NIGHTBANE) == NOT_STARTED || instance->GetBossState(DATA_NIGHTBANE) == FAIL)
            if (instance->GetBossState(DATA_NIGHTBANE) == NOT_STARTED)
            {
                if (Creature* nightbane = instance->GetCreature(DATA_NIGHTBANE))
                {
                    if (nightbane->IsAlive())
                    {
                        nightbane->AI()->DoAction(ACTION_START_INTRO);
                        return true;
                    }
                }
            }
        }
        return false;
    }
};

struct npc_nightbane_helper_target : public NullCreatureAI
{
    npc_nightbane_helper_target(Creature* creature) : NullCreatureAI(creature) { me->SetDisableGravity(true); }
};

void AddSC_boss_nightbane()
{
    RegisterKarazhanCreatureAI(boss_nightbane);
    new go_blackened_urn();
    RegisterKarazhanCreatureAI(npc_nightbane_helper_target);
}
