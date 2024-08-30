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
#include "GridNotifiers.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldPacket.h"
#include "the_eye.h"

enum KTYells
{
    // Kael'thas Speech
    SAY_INTRO                           = 0,
    SAY_INTRO_CAPERNIAN                 = 1,
    SAY_INTRO_TELONICUS                 = 2,
    SAY_INTRO_THALADRED                 = 3,
    SAY_INTRO_SANGUINAR                 = 4,
    SAY_PHASE2_WEAPON                   = 5,
    SAY_PHASE3_ADVANCE                  = 6,
    SAY_PHASE4_INTRO2                   = 7,
    SAY_PHASE5_NUTS                     = 8,
    SAY_SLAY                            = 9,
    SAY_MINDCONTROL                     = 10,
    SAY_GRAVITYLAPSE                    = 11,
    SAY_SUMMON_PHOENIX                  = 12,
    SAY_DEATH                           = 13,
    SAY_PYROBLAST                       = 14,

    // Advisors
    SAY_THALADRED_AGGRO                 = 0,
    SAY_SANGUINAR_AGGRO                 = 0,
    SAY_CAPERNIAN_AGGRO                 = 0,
    SAY_TELONICUS_AGGRO                 = 0,
    SAY_THALADRED_DEATH                 = 1,
    SAY_SANGUINAR_DEATH                 = 1,
    SAY_CAPERNIAN_DEATH                 = 1,
    SAY_TELONICUS_DEATH                 = 1,
    EMOTE_THALADRED_FIXATE              = 2
};

enum KTSpells
{
    // _phase 2 spells
    SPELL_SUMMON_WEAPONS                = 36976,
    SPELL_SUMMON_WEAPONA                = 36958,
    SPELL_SUMMON_WEAPONB                = 36959,
    SPELL_SUMMON_WEAPONC                = 36960,
    SPELL_SUMMON_WEAPOND                = 36961,
    SPELL_SUMMON_WEAPONE                = 36962,
    SPELL_SUMMON_WEAPONF                = 36963,
    SPELL_SUMMON_WEAPONG                = 36964,

    // _phase 3 spells
    SPELL_RESURRECTION                  = 36450,

    // _phase 4 spells
    SPELL_FIREBALL                      = 36805,
    SPELL_ARCANE_DISRUPTION             = 36834,
    SPELL_PHOENIX                       = 36723,
    SPELL_MIND_CONTROL                  = 36797,
    SPELL_SHOCK_BARRIER                 = 36815,
    SPELL_PYROBLAST                     = 36819,
    SPELL_FLAME_STRIKE                  = 36735,
    SPELL_FLAME_STRIKE_DAMAGE           = 36731,

    // transition scene spells
    SPELL_NETHERBEAM_AURA1              = 36364,
    SPELL_NETHERBEAM_AURA2              = 36370,
    SPELL_NETHERBEAM_AURA3              = 36371,
    SPELL_NETHERBEAM1                   = 36089,
    SPELL_NETHERBEAM2                   = 36090,
    SPELL_KAEL_GAINING_POWER            = 36091,
    SPELL_KAEL_EXPLODES1                = 36376,
    SPELL_KAEL_EXPLODES2                = 36375,
    SPELL_KAEL_EXPLODES3                = 36373,
    SPELL_KAEL_EXPLODES4                = 36354,
    SPELL_KAEL_EXPLODES5                = 36092,
    SPELL_GROW                          = 36184,
    SPELL_KEAL_STUNNED                  = 36185,
    SPELL_KAEL_FULL_POWER               = 36187,
    SPELL_FLOATING_DROWNED              = 36550,
    SPELL_DARK_BANISH_STATE             = 52241, // wrong visual apparently
    SPELL_ARCANE_EXPLOSION_VISUAL       = 34807,

    SPELL_PURE_NETHER_BEAM1             = 36196,
    SPELL_PURE_NETHER_BEAM2             = 36197,
    SPELL_PURE_NETHER_BEAM3             = 36198,
    SPELL_PURE_NETHER_BEAM4             = 36201,
    SPELL_PURE_NETHER_BEAM5             = 36290,
    SPELL_PURE_NETHER_BEAM6             = 36291,

    // _phase 5 spells
    SPELL_GRAVITY_LAPSE                 = 35941,
    SPELL_GRAVITY_LAPSE_TELEPORT1       = 35966,
    SPELL_GRAVITY_LAPSE_KNOCKBACK       = 34480,
    SPELL_GRAVITY_LAPSE_AURA            = 39432,
    SPELL_SUMMON_NETHER_VAPOR           = 35865,
    SPELL_NETHER_BEAM                   = 35869,
    SPELL_NETHER_BEAM_DAMAGE            = 35873,

    SPELL_REMOTE_TOY_STUN               = 37029,

    // Advisors
    // Universal
    SPELL_KAEL_PHASE_TWO                = 36709,

    // Sanguinar
    SPELL_BELLOWING_ROAR                = 44863,

    // Capernian
    SPELL_CAPERNIAN_FIREBALL            = 36971,
    SPELL_CONFLAGRATION                 = 37018,
    SPELL_ARCANE_BURST                  = 36970,

    // Telonicus
    SPELL_BOMB                          = 37036,
    SPELL_REMOTE_TOY                    = 37027,

    // Thaladred
    SPELL_PSYCHIC_BLOW                  = 36966,
    SPELL_REND                          = 36965,
    SPELL_SILENCE                       = 30225
};

enum KTPhases
{
    PHASE_NONE                          = 0,
    PHASE_SINGLE_ADVISOR                = 1,
    PHASE_WEAPONS                       = 2,
    PHASE_TRANSITION                    = 3,
    PHASE_ALL_ADVISORS                  = 4,
    PHASE_FINAL                         = 5
};

enum KTMisc
{
    POINT_MIDDLE                        = 1,
    POINT_AIR                           = 2,
    POINT_LAND                          = 3,
    POINT_START_LAST_PHASE              = 4,

    DATA_RESURRECT_CAST                 = 1,

    NPC_WORLD_TRIGGER                   = 19871,
    NPC_NETHER_VAPOR                    = 21002,
    NPC_NETHERSTRAND_LONGBOW            = 21268,
    NPC_STAFF_OF_DISINTEGRATION         = 21274,
};

enum KTPreFightEvents
{
    EVENT_PREFIGHT_PHASE1_01              = 1,
    EVENT_PREFIGHT_PHASE1_02              = 2,
    EVENT_PREFIGHT_PHASE5_01              = 3,
    EVENT_PREFIGHT_PHASE5_02              = 4,
    EVENT_PREFIGHT_PHASE6_02              = 5,
    EVENT_PREFIGHT_PHASE6_03              = 6,
};

enum KTTransitionScene
{
    EVENT_SCENE_1                       = 50, // NYI
    EVENT_SCENE_2                       = 51,
    EVENT_SCENE_3                       = 52,
    EVENT_SCENE_4                       = 53,
    EVENT_SCENE_5                       = 54,
    EVENT_SCENE_6                       = 55,
    EVENT_SCENE_7                       = 56,
    EVENT_SCENE_8                       = 57,
    EVENT_SCENE_9                       = 58,
    EVENT_SCENE_10                      = 59,
    EVENT_SCENE_11                      = 60,
    EVENT_SCENE_12                      = 61,
    EVENT_SCENE_13                      = 62,
    EVENT_SCENE_14                      = 63,
    EVENT_SCENE_15                      = 64,
    EVENT_SCENE_16                      = 65
};

enum KTActions
{
    ACTION_START_SANGUINAR              = 0,
    ACTION_START_CAPERNIAN              = 1,
    ACTION_START_TELONICUS              = 2,
    ACTION_START_WEAPONS                = 3,
    ACTION_PROGRESS_PHASE_CHECK         = 4
};

enum KTSpellGroups
{
    GROUP_PROGRESS_PHASE                = 0,
    GROUP_PYROBLAST                     = 1,
    GROUP_SHOCK_BARRIER                 = 2,
    GROUP_NETHER_BEAM                   = 3
};

const Position triggersPos[6] =
{
    {799.11f, -38.95f, 85.0f, 0.0f},
    {800.16f, 37.65f, 85.0f, 0.0f},
    {847.64f, -16.19f, 64.05f, 0.0f},
    {847.53f, 15.01f, 63.69f, 0.0f},
    {843.44f, -7.87f, 67.14f, 0.0f},
    {843.35f, 6.35f, 67.14f, 0.0f}
};

struct boss_kaelthas : public BossAI
{
    boss_kaelthas(Creature* creature) : BossAI(creature, DATA_KAELTHAS) { }

    void PrepareAdvisors()
    {
        for (uint8 advisorData = DATA_THALADRED; advisorData <= DATA_TELONICUS; ++advisorData)
        {
            if (Creature* advisor = instance->GetCreature(advisorData))
            {
                advisor->Respawn(true);
                advisor->StopMovingOnCurrentPos();
                advisor->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                advisor->SetReactState(REACT_PASSIVE);
                summons.Summon(advisor);
            }
        }
    }

    void SetData(uint32 type, uint32 data) override
    {
        if (type == DATA_RESURRECT_CAST && data == DATA_RESURRECT_CAST)
        {
            summons.DoForAllSummons([&](WorldObject* summon){
                if (Creature* summonedCreature = summon->ToCreature())
                {
                    if (summonedCreature->GetEntry() >= NPC_LORD_SANGUINAR && summonedCreature->GetEntry() <= NPC_THALADRED)
                    {
                        summonedCreature->SetReactState(REACT_PASSIVE);
                        summonedCreature->setDeathState(DeathState::JustRespawned);
                        summonedCreature->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    }
                }
            });
        }
    }

    void SetRoomState(GOState state)
    {
        //TODO: handle door closing
        if (GameObject* window = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_BRIDGE_WINDOW)))
            window->SetGoState(state);
        if (GameObject* window = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_KAEL_STATUE_RIGHT)))
            window->SetGoState(state);
        if (GameObject* window = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_KAEL_STATUE_LEFT)))
            window->SetGoState(state);
    }

    void Reset() override
    {
        BossAI::Reset();
        scheduler.Schedule(1s, [this](TaskContext)
        {
            PrepareAdvisors();
        });

        _phase = PHASE_NONE;
        _transitionSceneReached = false;

        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HOVER, true);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
        SetRoomState(GO_STATE_READY);
        me->SetDisableGravity(false);
        me->SetWalk(false);
    }

    void AttackStart(Unit* who) override
    {
        if (_phase == PHASE_FINAL /* check is scheduled&& events.GetNextEventTime(EVENT_GRAVITY_LAPSE_END) == 0*/)
            BossAI::AttackStart(who);
    }

    void JustReachedHome() override
    {
        Reset();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (_phase == PHASE_NONE && who->IsPlayer() && me->IsValidAttackTarget(who))
        {
            _phase = PHASE_SINGLE_ADVISOR;
            me->SetInCombatWithZone();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
            Talk(SAY_INTRO);
            ScheduleUniqueTimedEvent(23s, [&]
            {
                Talk(SAY_INTRO_THALADRED);
            }, EVENT_PREFIGHT_PHASE1_01);
            ScheduleUniqueTimedEvent(30s, [&]
            {
                if (Creature* thaladred = summons.GetCreatureWithEntry(NPC_THALADRED))
                {
                    thaladred->SetReactState(REACT_AGGRESSIVE);
                    thaladred->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        thaladred->AI()->AttackStart(target);
                    thaladred->SetInCombatWithZone();
                }
            }, EVENT_PREFIGHT_PHASE1_02);
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_SLAY);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_NETHER_VAPOR)
            summon->GetMotionMaster()->MoveRandom(20.0f);
        if (summon->GetEntry() >= NPC_NETHERSTRAND_LONGBOW && summon->GetEntry() <= NPC_STAFF_OF_DISINTEGRATION)
            summon->SetReactState(REACT_PASSIVE);
    }

    void DoAction(int32 action) override
    {
        switch(action)
        {
            case ACTION_START_SANGUINAR:
                IntroduceNewAdvisor(SAY_INTRO_SANGUINAR, ACTION_START_SANGUINAR);
                break;
            case ACTION_START_CAPERNIAN:
                IntroduceNewAdvisor(SAY_INTRO_CAPERNIAN, ACTION_START_CAPERNIAN);
                break;
            case ACTION_START_TELONICUS:
                IntroduceNewAdvisor(SAY_INTRO_TELONICUS, ACTION_START_TELONICUS);
                break;
            case ACTION_START_WEAPONS:
                ScheduleUniqueTimedEvent(3s, [&]{
                    Talk(SAY_PHASE2_WEAPON);
                    DoCastSelf(SPELL_SUMMON_WEAPONS);
                    _phase = PHASE_WEAPONS;
                }, EVENT_PREFIGHT_PHASE5_01);
                ScheduleUniqueTimedEvent(9s, [&]{
                    summons.DoForAllSummons([&](WorldObject* summon)
                    {
                        if (Creature* summonedCreature = summon->ToCreature())
                        {
                            if (!summonedCreature->GetSpawnId())
                            {
                                summonedCreature->SetReactState(REACT_AGGRESSIVE);
                                summonedCreature->SetInCombatWithZone();
                                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                                {
                                    summonedCreature->AI()->AttackStart(target);
                                }
                            }
                        }
                    });
                    scheduler.Schedule(90s, GROUP_PROGRESS_PHASE, [this](TaskContext)
                    {
                        PhaseAllAdvisorsExecute();
                    });
                }, EVENT_PREFIGHT_PHASE5_02);
                break;
            case ACTION_PROGRESS_PHASE_CHECK:
                if (_phase == PHASE_ALL_ADVISORS)
                {
                    bool advisorAlive = false;
                    summons.DoForAllSummons([&advisorAlive](WorldObject* summon)
                    {
                        if (Creature* summonedCreature = summon->ToCreature())
                        {
                            if (summonedCreature->IsAlive())
                            {
                                if (summonedCreature->GetEntry() >= NPC_LORD_SANGUINAR && summonedCreature->GetEntry() <= NPC_THALADRED)
                                {
                                    advisorAlive = true;
                                    return;
                                }
                            }
                        }
                    });
                    if (!advisorAlive)
                        PhaseKaelExecute();
                }
            default:
                break;
        }
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (point == POINT_MIDDLE)
        {
            ExecuteMiddleEvent();
        }
        else if (point == POINT_START_LAST_PHASE)
        {
            me->SetDisableGravity(false);
            me->SetWalk(false);
            me->RemoveAurasDueToSpell(SPELL_KAEL_FULL_POWER);
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            //re-set validator
            scheduler.SetValidator([this]{
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
            ScheduleTimedEvent(0ms, [&]
            {
                DoCastVictim(SPELL_FIREBALL);
            }, 2400ms, 7500ms);
            ScheduleTimedEvent(10000ms, [&]
            {
                DoCastRandomTarget(SPELL_FLAME_STRIKE, 0, 100.0f);
            }, 30250ms, 50650ms);
            ScheduleTimedEvent(50000ms, [&]
            {
                Talk(SAY_SUMMON_PHOENIX);
                DoCastSelf(SPELL_PHOENIX);
            }, 61450ms, 96550ms);
            ScheduleTimedEvent(5s, [&]
            {
                scheduler.DelayAll(30s);
                me->setAttackTimer(BASE_ATTACK, 30000);
                DoCastSelf(SPELL_GRAVITY_LAPSE);
                DoCastSelf(SPELL_SUMMON_NETHER_VAPOR);
                scheduler.Schedule(4s, GROUP_NETHER_BEAM, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_NETHER_BEAM);
                    context.Repeat(4s);
                }).Schedule(0s, GROUP_SHOCK_BARRIER, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_SHOCK_BARRIER);
                    context.Repeat(10s);
                }).Schedule(20500ms, GROUP_SHOCK_BARRIER, [this](TaskContext)
                {
                    scheduler.CancelGroup(GROUP_SHOCK_BARRIER);
                }).Schedule(32s, [this](TaskContext)
                {
                    summons.DespawnEntry(NPC_NETHER_VAPOR);
                    scheduler.CancelGroup(GROUP_NETHER_BEAM);

                    if (Unit* victim = me->GetVictim())
                    {
                        me->SetTarget(victim->GetGUID());
                        me->GetMotionMaster()->MoveChase(victim);
                    }
                });
                me->SetTarget();
                me->GetMotionMaster()->Clear();
                me->StopMoving();
                Talk(SAY_GRAVITYLAPSE);
            }, 90s);
            if (me->GetVictim())
            {
                me->SetTarget(me->GetVictim()->GetGUID());
                AttackStart(me->GetVictim());
            }
        }
    }

    void ExecuteMiddleEvent()
    {
        scheduler.ClearValidator();
        me->SetTarget();
        me->SetFacingTo(M_PI);
        me->SetWalk(true);
        Talk(SAY_PHASE5_NUTS);
        ScheduleUniqueTimedEvent(2500ms, [&]
        {
            me->SetTarget();
            DoCastSelf(SPELL_KAEL_EXPLODES1, true);
            DoCastSelf(SPELL_KAEL_GAINING_POWER);
        }, EVENT_SCENE_2);
        ScheduleUniqueTimedEvent(4000ms, [&]
        {
            me->SetTarget();
            for (uint8 i = 0; i < 2; ++i)
                if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, triggersPos[i], TEMPSUMMON_TIMED_DESPAWN, 60000))
                    trigger->CastSpell(me, SPELL_NETHERBEAM1 + i, false);
            me->SetDisableGravity(true);
            me->SendMovementFlagUpdate();
            me->GetMotionMaster()->MoveTakeoff(POINT_AIR, me->GetPositionX(), me->GetPositionY(), 75.0f, 2.99);
            DoCastSelf(SPELL_GROW, true);
        }, EVENT_SCENE_3);
        ScheduleUniqueTimedEvent(7000ms, [&]
        {
            me->SetTarget();
            DoCastSelf(SPELL_GROW, true);
            DoCastSelf(SPELL_KAEL_EXPLODES2, true);
            DoCastSelf(SPELL_NETHERBEAM_AURA1, true);
            for (uint8 i = 0; i < 2; ++i)
                if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, triggersPos[i + 2], TEMPSUMMON_TIMED_DESPAWN, 60000))
                    trigger->CastSpell(me, SPELL_NETHERBEAM1 + i, false);
        }, EVENT_SCENE_4);
        ScheduleUniqueTimedEvent(10000ms, [&]
        {
            me->SetTarget();
            DoCastSelf(SPELL_GROW, true);
            DoCastSelf(SPELL_KAEL_EXPLODES3, true);
            DoCastSelf(SPELL_NETHERBEAM_AURA2, true);
            for (uint8 i = 0; i < 2; ++i)
                if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, triggersPos[i + 4], TEMPSUMMON_TIMED_DESPAWN, 60000))
                    trigger->CastSpell(me, SPELL_NETHERBEAM1 + i, false);
        }, EVENT_SCENE_5);
        ScheduleUniqueTimedEvent(14000ms, [&]
        {
            DoCastSelf(SPELL_GROW, true);
            DoCastSelf(SPELL_KAEL_EXPLODES4, true);
            DoCastSelf(SPELL_NETHERBEAM_AURA3, true);
        }, EVENT_SCENE_6);
        ScheduleUniqueTimedEvent(17500ms, [&]
        {
            SetRoomState(GO_STATE_ACTIVE);
        }, EVENT_SCENE_7);
        ScheduleUniqueTimedEvent(19000ms, [&]
        {
            summons.DespawnEntry(WORLD_TRIGGER);
            me->RemoveAurasDueToSpell(SPELL_NETHERBEAM_AURA1);
            me->RemoveAurasDueToSpell(SPELL_NETHERBEAM_AURA2);
            me->RemoveAurasDueToSpell(SPELL_NETHERBEAM_AURA3);
            DoCastSelf(SPELL_KAEL_EXPLODES5, true);
            DoCastSelf(SPELL_FLOATING_DROWNED);
            //me->CastSpell(me, SPELL_KEAL_STUNNED, true);
        }, EVENT_SCENE_8);
        ScheduleUniqueTimedEvent(22000ms, [&]
        {
            DoCastSelf(SPELL_DARK_BANISH_STATE, true);
            DoCastSelf(SPELL_ARCANE_EXPLOSION_VISUAL, true);
            me->SummonCreature(NPC_WORLD_TRIGGER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM1, true);
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX() - 5, me->GetPositionY(), me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM2, true);
        }, EVENT_SCENE_9);
        ScheduleUniqueTimedEvent(22800ms, [&]
        {
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX() - 5, me->GetPositionY() - 5, me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM3, true);
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX() + 5, me->GetPositionY() + 5, me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM1, true);
        }, EVENT_SCENE_10);
        ScheduleUniqueTimedEvent(23600ms, [&]
        {
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX(), me->GetPositionY() + 5, me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM2, true);
        }, EVENT_SCENE_11);
        ScheduleUniqueTimedEvent(24500ms, [&]
        {
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX(), me->GetPositionY() - 5, me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM3, true);
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX() + 5, me->GetPositionY() - 5, me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM1, true);
        }, EVENT_SCENE_12);
        ScheduleUniqueTimedEvent(24800ms, [&]
        {
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX() - 5, me->GetPositionY() + 5, me->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM2, true);
        }, EVENT_SCENE_13);
        ScheduleUniqueTimedEvent(25300ms, [&]
        {
            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()-5, me->GetPositionY()+5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM3, true);
        }, EVENT_SCENE_14);
        ScheduleUniqueTimedEvent(32000ms, [&]
        {
            me->RemoveAurasDueToSpell(SPELL_FLOATING_DROWNED);
            me->RemoveAurasDueToSpell(SPELL_KEAL_STUNNED);
            DoCastSelf(SPELL_KAEL_FULL_POWER);
            DoCastSelf(SPELL_KAEL_PHASE_TWO, true);
            DoCastSelf(SPELL_PURE_NETHER_BEAM4, true);
            DoCastSelf(SPELL_PURE_NETHER_BEAM5, true);
            DoCastSelf(SPELL_PURE_NETHER_BEAM6, true);
        }, EVENT_SCENE_15);
        ScheduleUniqueTimedEvent(36000ms, [&]
        {
            summons.DespawnEntry(WORLD_TRIGGER);
            me->CastStop();
            me->GetMotionMaster()->Clear();
            me->RemoveAurasDueToSpell(SPELL_DARK_BANISH_STATE); // WRONG VISUAL
            me->GetMotionMaster()->MoveLand(POINT_LAND, me->GetPositionX(), me->GetPositionY(), 48.0f, 2.99f); // Moveland doesn't handle POINT_START_LAST_PHASE so we need to use MovePoint
            me->GetMotionMaster()->MovePoint(POINT_START_LAST_PHASE, me->GetHomePosition(), false, true);
        }, EVENT_SCENE_16);
    }

    void IntroduceNewAdvisor(KTYells talkIntroduction, KTActions kaelAction)
    {
        std::chrono::milliseconds attackStartTimer = 0ms;
        EyeNPCs advisorNPCId = NPC_THALADRED;
        scheduler.Schedule(2s, [this, talkIntroduction](TaskContext)
        {
            Talk(talkIntroduction);
        });
        //switch because talk times are different
        switch(kaelAction)
        {
            case ACTION_START_SANGUINAR:
                attackStartTimer = 14500ms;
                advisorNPCId = NPC_LORD_SANGUINAR;
                break;
            case ACTION_START_CAPERNIAN:
                attackStartTimer = 9000ms;
                advisorNPCId = NPC_CAPERNIAN;
                break;
            case ACTION_START_TELONICUS:
                attackStartTimer = 10400ms;
                advisorNPCId = NPC_TELONICUS;
                break;
            default:
                break;
        }
        scheduler.Schedule(attackStartTimer, [this, advisorNPCId](TaskContext)
        {
            if (Creature* advisor = summons.GetCreatureWithEntry(advisorNPCId))
            {
                advisor->SetReactState(REACT_AGGRESSIVE);
                advisor->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    advisor->AI()->AttackStart(target);
                advisor->SetInCombatWithZone();
            }
        });
    }

    void PhaseAllAdvisorsExecute()
    {
        _phase = PHASE_TRANSITION;
        scheduler.CancelGroup(GROUP_PROGRESS_PHASE);
        Talk(SAY_PHASE3_ADVANCE);
        ScheduleUniqueTimedEvent(6s, [&]{
            DoCastSelf(SPELL_RESURRECTION);
        }, EVENT_PREFIGHT_PHASE6_02);
        ScheduleUniqueTimedEvent(12s, [&]{
            _phase = PHASE_ALL_ADVISORS;
            summons.DoForAllSummons([&](WorldObject* summon)
            {
                if (Creature* summonedCreature = summon->ToCreature())
                {
                    if (summonedCreature->GetSpawnId())
                    {
                        summonedCreature->SetReactState(REACT_AGGRESSIVE);
                        summonedCreature->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        summonedCreature->SetInCombatWithZone();
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            summonedCreature->AI()->AttackStart(target);
                        }
                    }
                }
            });
            scheduler.Schedule(3min, GROUP_PROGRESS_PHASE, [this](TaskContext)
            {
                PhaseKaelExecute();
            });
        }, EVENT_PREFIGHT_PHASE6_03);
    }

    void PhaseKaelExecute()
    {
        scheduler.CancelAll();
        Talk(SAY_PHASE4_INTRO2);
        _phase = PHASE_FINAL;
        DoResetThreatList();
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
        {
            AttackStart(target);
        }
        ScheduleHealthCheckEvent(50, [&]{
            if(!_transitionSceneReached)
            {
                _transitionSceneReached = true;
                scheduler.CancelAll();
                me->CastStop();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->MovePoint(POINT_MIDDLE, me->GetHomePosition(), true, true);
                me->ClearUnitState(UNIT_STATE_MELEE_ATTACKING);
                me->SendMeleeAttackStop();

                ThreatContainer::StorageType threatList = me->GetThreatMgr().GetThreatList();
                for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
                {
                    if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                    {
                       target->AttackStop();
                    }
                }
            }
        });
        ScheduleTimedEvent(1000ms, [&]
        {
            DoCastVictim(SPELL_FIREBALL);
        }, 2400ms, 7500ms);
        ScheduleTimedEvent(15000ms, [&]
        {
            DoCastRandomTarget(SPELL_FLAME_STRIKE, 0, 100.0f);
        }, 30250ms, 50650ms);
        ScheduleTimedEvent(50000ms, [&]
        {
            Talk(SAY_SUMMON_PHOENIX);
            DoCastSelf(SPELL_PHOENIX);
        }, 35450ms, 41550ms);
        ScheduleTimedEvent(20s, 23s, [&]
        {
            if (roll_chance_i(50))
                Talk(SAY_MINDCONTROL);
            me->CastCustomSpell(SPELL_MIND_CONTROL, SPELLVALUE_MAX_TARGETS, 3, me, false);
            scheduler.Schedule(3s, [this](TaskContext)
            {
                DoCastSelf(SPELL_ARCANE_DISRUPTION);
            });
        }, 23s, 26s);
        ScheduleTimedEvent(60s, [&]
        {
            Talk(SAY_PYROBLAST);
            DoCastSelf(SPELL_SHOCK_BARRIER);
            scheduler.DelayAll(10s);
            scheduler.Schedule(0s, GROUP_PYROBLAST, [this](TaskContext context)
            {
                DoCastVictim(SPELL_PYROBLAST);
                context.Repeat(4s);
            }).Schedule(8500ms, GROUP_PYROBLAST, [this](TaskContext)
            {
                scheduler.CancelGroup(GROUP_PYROBLAST);
            });
        }, 50s);
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->GetHomePosition().GetExactDist2d(me) > 165.0f || !SelectTargetFromPlayerList(165.0f);
    }

private:
    uint32 _phase;
    bool _transitionSceneReached = false;
};
struct npc_lord_sanguinar : public ScriptedAI
{
    npc_lord_sanguinar(Creature* creature) : ScriptedAI(creature) {
        _instance = creature->GetInstanceScript();
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
        _hasDied = false;
        me->SetReactState(REACT_PASSIVE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!_hasDied)
        {
            Talk(SAY_SANGUINAR_AGGRO);
        }
        ScheduleTimedEvent(0s, 2s, [&]{
            DoCastSelf(SPELL_BELLOWING_ROAR);
        }, 30s, 40s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* kael = _instance->GetCreature(DATA_KAELTHAS))
        {
            kael->AI()->DoAction(ACTION_PROGRESS_PHASE_CHECK);
            if (!_hasDied)
            {
                Talk(SAY_SANGUINAR_DEATH);
                DoCastSelf(SPELL_KAEL_PHASE_TWO, true);
                kael->AI()->DoAction(ACTION_START_CAPERNIAN);
                _hasDied = true;
            }
        }
        scheduler.CancelAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
private:
    InstanceScript* _instance;
    bool _hasDied;
};

struct npc_capernian : public ScriptedAI
{
    npc_capernian(Creature* creature) : ScriptedAI(creature) {
        _instance = creature->GetInstanceScript();
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
        _hasDied = false;
        me->SetReactState(REACT_PASSIVE);
    }

    void AttackStart(Unit* who) override
    {
        if (who && who->isTargetableForAttack() && me->GetReactState() != REACT_PASSIVE)
        {
            if (me->Attack(who, false))
            {
                me->GetMotionMaster()->MoveChase(who, 30.0f, 0);
                me->AddThreat(who, 0.0f);
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!_hasDied)
        {
            Talk(SAY_CAPERNIAN_AGGRO);
        }
        ScheduleTimedEvent(0ms, [&]{

            if (!me->CanCastSpell(SPELL_CAPERNIAN_FIREBALL))
            {
                me->ResumeChasingVictim();
            }
            else
            {
                me->GetMotionMaster()->MoveChase(me->GetVictim(), 30.0f);
                DoCastVictim(SPELL_CAPERNIAN_FIREBALL);
            }

        }, 2500ms);
        ScheduleTimedEvent(7000ms, 10000ms, [&]{
            DoCastRandomTarget(SPELL_CONFLAGRATION, 0, 30.0f);
        }, 18500ms, 20500ms);
        ScheduleTimedEvent(3s, [&]{
            DoCastRandomTarget(SPELL_ARCANE_BURST, 0, 8.0f);
        }, 6s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* kael = _instance->GetCreature(DATA_KAELTHAS))
        {
            kael->AI()->DoAction(ACTION_PROGRESS_PHASE_CHECK);
            if (!_hasDied)
            {
                Talk(SAY_CAPERNIAN_DEATH);
                DoCastSelf(SPELL_KAEL_PHASE_TWO, true);
                kael->AI()->DoAction(ACTION_START_TELONICUS);
                _hasDied = true;
            }
        }
        scheduler.CancelAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
private:
    InstanceScript* _instance;
    bool _hasDied;
};

struct npc_telonicus : public ScriptedAI
{
    npc_telonicus(Creature* creature) : ScriptedAI(creature) {
        _instance = creature->GetInstanceScript();
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
        _hasDied = false;
        me->SetReactState(REACT_PASSIVE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!_hasDied)
        {
            Talk(SAY_TELONICUS_AGGRO);
        }
        ScheduleTimedEvent(0ms, [&]{
            DoCastVictim(SPELL_BOMB);
        }, 3600ms, 7100ms);
        ScheduleTimedEvent(13250ms, [&]{
            DoCastRandomTarget(SPELL_REMOTE_TOY, 0, 100.0f);
        }, 15750ms);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* kael = _instance->GetCreature(DATA_KAELTHAS))
        {
            kael->AI()->DoAction(ACTION_PROGRESS_PHASE_CHECK);
            if (!_hasDied)
            {
                Talk(SAY_TELONICUS_DEATH);
                DoCastSelf(SPELL_KAEL_PHASE_TWO, true);
                kael->AI()->DoAction(ACTION_START_WEAPONS);
                _hasDied = true;
            }
        }
        scheduler.CancelAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
private:
    InstanceScript* _instance;
    bool _hasDied;
};

struct npc_thaladred : public ScriptedAI
{
    npc_thaladred(Creature* creature) : ScriptedAI(creature) {
        _instance = creature->GetInstanceScript();
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetReactState(REACT_PASSIVE);
        _hasDied = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!_hasDied)
        {
            Talk(SAY_THALADRED_AGGRO);
        }
        ScheduleTimedEvent(100ms, [&]
        {
            DoResetThreatList();
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
            {
                me->AddThreat(target, 10000000.0f);
                Talk(EMOTE_THALADRED_FIXATE, target);
            }
        }, 10000ms);
        ScheduleTimedEvent(4000ms, 19350ms, [&]
        {
            DoCastVictim(SPELL_PSYCHIC_BLOW);
        }, 15700ms, 48900ms);
        ScheduleTimedEvent(3000ms, 6050ms, [&]
        {
            DoCastVictim(SPELL_REND);
        }, 15700ms, 48900ms);
        ScheduleTimedEvent(3000ms, 6050ms, [&]
        {
            if (Unit* victim = me->GetVictim())
            {
                if (victim->IsNonMeleeSpellCast(false, false, true))
                {
                    DoCastSelf(SPELL_SILENCE);
                }
            }
        }, 3600ms, 15200ms);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* kael = _instance->GetCreature(DATA_KAELTHAS))
        {
            kael->AI()->DoAction(ACTION_PROGRESS_PHASE_CHECK);
            if (!_hasDied)
            {
                Talk(SAY_THALADRED_DEATH);
                DoCastSelf(SPELL_KAEL_PHASE_TWO, true);
                kael->AI()->DoAction(ACTION_START_SANGUINAR);
                _hasDied = true;
            }
        }
        scheduler.CancelAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
private:
    InstanceScript* _instance;
    bool _hasDied;
};

class spell_kaelthas_kael_phase_two : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_kael_phase_two);

    bool Load() override
    {
        if (GetCaster()->GetTypeId() == TYPEID_UNIT)
            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                if (Creature* kael = instance->GetCreature(DATA_KAELTHAS))
                    kael->AI()->SummonedCreatureDies(GetCaster()->ToCreature(), nullptr);
        return true;
    }

    void Register() override
    {
    }
};

class spell_kaelthas_remote_toy : public AuraScript
{
    PrepareAuraScript(spell_kaelthas_remote_toy);

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        PreventDefaultAction();
        if (roll_chance_i(66))
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_REMOTE_TOY_STUN, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_kaelthas_remote_toy::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_kaelthas_summon_weapons : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_summon_weapons);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        for (uint32 i = SPELL_SUMMON_WEAPONA; i <= SPELL_SUMMON_WEAPONG; ++i)
            GetCaster()->CastSpell(GetCaster(), i, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kaelthas_summon_weapons::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_kaelthas_resurrection : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_resurrection);

    void HandleBeforeCast()
    {
        GetCaster()->GetAI()->SetData(DATA_RESURRECT_CAST, DATA_RESURRECT_CAST);
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_kaelthas_resurrection::HandleBeforeCast);
    }
};

class spell_kaelthas_mind_control : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_mind_control);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        if (Unit* victim = GetCaster()->GetVictim())
        {
            targets.remove_if(Acore::ObjectGUIDCheck(victim->GetGUID(), true));
        }

        targets.remove_if([&](WorldObject const* target) -> bool
        {
            if (!target->ToPlayer())
                return true;

            return (!GetCaster()->IsWithinLOSInMap(target));
        });
    }

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        if (!GetCaster() || !GetHitPlayer())
            return;

        if (Player* player = GetHitPlayer())
            GetCaster()->GetThreatMgr().ResetThreat(player);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kaelthas_mind_control::SelectTarget, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_kaelthas_mind_control::HandleEffect, EFFECT_ALL, SPELL_AURA_ANY);
    }
};

class spell_kaelthas_burn : public AuraScript
{
    PrepareAuraScript(spell_kaelthas_burn);

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        Unit::DealDamage(GetUnitOwner(), GetUnitOwner(), GetUnitOwner()->CountPctFromMaxHealth(5) + 1);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_kaelthas_burn::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_kaelthas_flame_strike : public AuraScript
{
    PrepareAuraScript(spell_kaelthas_flame_strike);

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->RemoveAllAuras();
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FLAME_STRIKE_DAMAGE, true);
        GetUnitOwner()->ToCreature()->DespawnOrUnsummon(2000);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_kaelthas_flame_strike::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class lapseTeleport : public BasicEvent
{
public:
    lapseTeleport(Player* owner) : _owner(owner)
    {
    }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        if (_owner->IsBeingTeleportedNear())
            _owner->m_Events.AddEvent(new lapseTeleport(_owner), _owner->m_Events.CalculateTime(1));
        else if (!_owner->IsBeingTeleported())
        {
            _owner->CastSpell(_owner, SPELL_GRAVITY_LAPSE_KNOCKBACK, true);
            _owner->CastSpell(_owner, SPELL_GRAVITY_LAPSE_AURA, true);
        }
        return true;
    }

private:
    Player* _owner;
};

class spell_kaelthas_gravity_lapse : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_gravity_lapse);

    bool Load() override
    {
        _currentSpellId = SPELL_GRAVITY_LAPSE_TELEPORT1;
        return true;
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        if (_currentSpellId < SPELL_GRAVITY_LAPSE_TELEPORT1 + 25)
            if (Player* target = GetHitPlayer())
            {
                GetCaster()->CastSpell(target, _currentSpellId++, true);
                target->m_Events.AddEvent(new lapseTeleport(target), target->m_Events.CalculateTime(1));
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kaelthas_gravity_lapse::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }

private:
    uint32 _currentSpellId;
};

class spell_kaelthas_nether_beam : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_nether_beam);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);

        ThreatContainer::StorageType const& ThreatList = GetCaster()-> GetThreatMgr().GetThreatList();
        std::list<Unit*> targetList;
        for (ThreatContainer::StorageType::const_iterator itr = ThreatList.begin(); itr != ThreatList.end(); ++itr)
        {
            Unit* target = ObjectAccessor::GetUnit(*GetCaster(), (*itr)->getUnitGuid());
            if (target && target->IsPlayer())
                targetList.push_back(target);
        }

        Acore::Containers::RandomResize(targetList, 5);
        for (std::list<Unit*>::const_iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
            GetCaster()->CastSpell(*itr, SPELL_NETHER_BEAM_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kaelthas_nether_beam::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_kaelthas_summon_nether_vapor : public SpellScript
{
    PrepareSpellScript(spell_kaelthas_summon_nether_vapor);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        for (uint32 i = 0; i < 5; ++i)
            GetCaster()->SummonCreature(NPC_NETHER_VAPOR, GetCaster()->GetPositionX() + 6 * cos(i / 5.0f * 2 * M_PI), GetCaster()->GetPositionY() + 6 * std::sin(i / 5.0f * 2 * M_PI), GetCaster()->GetPositionZ() + 7.0f + i, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kaelthas_summon_nether_vapor::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_kael_pyroblast : public SpellScript
{
    PrepareSpellScript(spell_kael_pyroblast);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (GetCaster()->GetVictim())
        {
            if (Unit* victim = GetCaster()->GetVictim())
                targets.remove_if(Acore::ObjectGUIDCheck(victim->GetGUID(), false));
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kael_pyroblast::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_kaelthas()
{
    RegisterTheEyeAI(boss_kaelthas);
    RegisterTheEyeAI(npc_lord_sanguinar);
    RegisterTheEyeAI(npc_capernian);
    RegisterTheEyeAI(npc_telonicus);
    RegisterTheEyeAI(npc_thaladred);
    RegisterSpellScript(spell_kaelthas_kael_phase_two);
    RegisterSpellScript(spell_kaelthas_remote_toy);
    RegisterSpellScript(spell_kaelthas_summon_weapons);
    RegisterSpellScript(spell_kaelthas_resurrection);
    RegisterSpellScript(spell_kaelthas_mind_control);
    RegisterSpellScript(spell_kaelthas_burn);
    RegisterSpellScript(spell_kaelthas_flame_strike);
    RegisterSpellScript(spell_kaelthas_gravity_lapse);
    RegisterSpellScript(spell_kaelthas_nether_beam);
    RegisterSpellScript(spell_kaelthas_summon_nether_vapor);
    RegisterSpellScript(spell_kael_pyroblast);
}
