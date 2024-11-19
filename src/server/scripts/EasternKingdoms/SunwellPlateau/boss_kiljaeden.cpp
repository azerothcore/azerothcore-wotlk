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
#include "CreatureTextMgr.h"
#include "MoveSplineInit.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "sunwell_plateau.h"

enum Yells
{
    SAY_KJ_OFFCOMBAT                            = 0,

    SAY_KALECGOS_ENCOURAGE                      = 0,
    SAY_KALECGOS_READY1                         = 1,
    SAY_KALECGOS_READY2                         = 2,
    SAY_KALECGOS_READY_ALL                      = 3,
    SAY_KALECGOS_AWAKEN                         = 5,
    SAY_KALECGOS_LETGO                          = 6,
    SAY_KALECGOS_FOCUS                          = 7,
    SAY_KALECGOS_FATE                           = 8,
    SAY_KALECGOS_GOODBYE                        = 9,
    SAY_KALECGOS_JOIN                           = 10,

    SAY_KJ_DEATH                                = 0,
    SAY_KJ_SLAY                                 = 1,
    SAY_KJ_REFLECTION                           = 2,
    SAY_KJ_EMERGE                               = 3,
    SAY_KJ_DARKNESS                             = 4,
    SAY_KJ_PHASE3                               = 5,
    SAY_KJ_PHASE4                               = 6,
    SAY_KJ_PHASE5                               = 7,
    EMOTE_KJ_DARKNESS                           = 8,

    SAY_ANVEENA_IMPRISONED                      = 0,
    SAY_ANVEENA_LOST                            = 1,
    SAY_ANVEENA_KALEC                           = 2,
    SAY_ANVEENA_GOODBYE                         = 3
};

enum Spells
{
    // Kil'jaeden spells
    SPELL_REBIRTH                               = 44200,
    SPELL_SOUL_FLAY                             = 45442,
    SPELL_LEGION_LIGHTNING                      = 45664,
    SPELL_FIRE_BLOOM                            = 45641,
    SPELL_SHADOW_SPIKE                          = 46680,
    SPELL_SINISTER_REFLECTION                   = 45892,
    SPELL_FLAME_DART                            = 45737,
    SPELL_FLAME_DART_EXPLOSION                  = 45746,
    SPELL_DARKNESS_OF_A_THOUSAND_SOULS          = 46605,
    SPELL_DARKNESS_OF_A_THOUSAND_SOULS_DAMAGE   = 45657,
    SPELL_ARMAGEDDON_PERIODIC                   = 45921,
    SPELL_ARMAGEDDON_VISUAL                     = 45911,
    SPELL_ARMAGEDDON_MISSILE                    = 45909,
    SPELL_CUSTOM_08_STATE                       = 45800,
    SPELL_DESTROY_ALL_DRAKES                    = 46707,

    // Sinister Reflections
    SPELL_SINISTER_REFLECTION_SUMMON            = 45891,
    SPELL_SINISTER_REFLECTION_CLASS             = 45893,
    SPELL_SINISTER_REFLECTION_CLONE             = 45785,

    // Misc
    SPELL_ANVEENA_ENERGY_DRAIN                  = 46410,
    SPELL_RING_OF_BLUE_FLAMES                   = 45825,
    SPELL_SUMMON_BLUE_DRAKE                     = 45836,
    SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT          = 45839,
    SPELL_POSSESS_DRAKE_IMMUNITY                = 45838,
    SPELL_SACRIFICE_OF_ANVEENA                  = 46474,
};

enum Misc
{
    PHASE_DECEIVERS                 = 1,
    PHASE_NORMAL                    = 2,
    PHASE_DARKNESS                  = 3,
    PHASE_ARMAGEDDON                = 4,
    PHASE_SACRIFICE                 = 5,

    ACTION_START_POST_EVENT         = 1,
    ACTION_NO_KILL_TALK             = 2
};

class CastArmageddon : public BasicEvent
{
public:
    CastArmageddon(Creature* caster) : _caster(caster) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        _caster->CastSpell(_caster, SPELL_ARMAGEDDON_MISSILE, true);
        _caster->SetPosition(_caster->GetPositionX(), _caster->GetPositionY(), _caster->GetPositionZ() - 20.0f, 0.0f);
        return true;
    }

private:
    Creature* _caster;
};

struct npc_kiljaeden_controller : public NullCreatureAI
{
    npc_kiljaeden_controller(Creature* creature) : NullCreatureAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void ResetOrbs()
    {
        for (uint8 i = DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1; i < DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_4 + 1; ++i)
            if (GameObject* orb = instance->GetGameObject(i))
                orb->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
    }

    void Reset() override
    {
        instance->SetBossState(DATA_KILJAEDEN, NOT_STARTED);
        summons.DespawnAll();
        ResetOrbs();

        me->SummonCreature(NPC_HAND_OF_THE_DECEIVER, 1702.62f, 611.19f, 27.66f, 1.81f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
        me->SummonCreature(NPC_HAND_OF_THE_DECEIVER, 1684.099f, 618.848f, 27.67f, 0.589f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
        me->SummonCreature(NPC_HAND_OF_THE_DECEIVER, 1688.38f, 641.10f, 27.50f, 5.43f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
        me->SummonCreature(NPC_ANVEENA, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 40.0f, 0.0f);

        DoCastAOE(SPELL_DESTROY_ALL_DRAKES, true);
        DoCastSelf(SPELL_ANVEENA_ENERGY_DRAIN, true);

        scheduler.Schedule(1min, [this](TaskContext context) {
            if (instance->GetBossState(DATA_KILJAEDEN) == NOT_STARTED)
                Talk(SAY_KJ_OFFCOMBAT);

            context.Repeat(90s, 3min);
        });
    }

    void JustDied(Unit*) override
    {
        EntryCheckPredicate kilCheck(NPC_KILJAEDEN);
        EntryCheckPredicate kalCheck(NPC_KALECGOS_KJ);
        summons.DespawnIf(kilCheck);
        summons.DoAction(ACTION_START_POST_EVENT, kalCheck);
        summons.DespawnIf(kalCheck);

        DoCastAOE(SPELL_DESTROY_ALL_DRAKES, true);
        summons.DespawnAll();
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_SINISTER_REFLECTION)
            summon->SetInCombatWithZone();
        else if (summon->GetEntry() == NPC_KALECGOS_KJ)
            summon->setActive(true);
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);

        if (summon->GetEntry() == NPC_HAND_OF_THE_DECEIVER)
        {
            instance->SetBossState(DATA_KILJAEDEN, IN_PROGRESS);

            scheduler.Schedule(1s, [this](TaskContext context) {
                auto const& playerList = me->GetMap()->GetPlayers();
                for (auto const& playerRef : playerList)
                    if (Player* player = playerRef.GetSource())
                        if (!player->IsGameMaster() && me->GetDistance2d(player) < 60.0f && player->IsAlive())
                        {
                            context.Repeat();
                            return;
                        }

                CreatureAI::EnterEvadeMode();
            });

            if (!summons.HasEntry(NPC_HAND_OF_THE_DECEIVER))
            {
                me->RemoveAurasDueToSpell(SPELL_ANVEENA_ENERGY_DRAIN);
                me->SummonCreature(NPC_KILJAEDEN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 1.5f, 4.3f, TEMPSUMMON_MANUAL_DESPAWN);
                me->SummonCreature(NPC_KALECGOS_KJ, 1726.80f, 661.43f, 138.65f, 3.95f, TEMPSUMMON_MANUAL_DESPAWN);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    InstanceScript* instance;
    SummonList summons;
};

struct boss_kiljaeden : public BossAI
{
    boss_kiljaeden(Creature* creature) : BossAI(creature, DATA_KILJAEDEN)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetVisible(false);

        me->m_Events.AddEventAtOffset([&] {
            me->SetVisible(true);
            DoCastSelf(SPELL_REBIRTH);
        }, 1s);

        me->m_Events.AddEventAtOffset([&] {
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetInCombatWithZone();
        }, 11s);
    }

    void Reset() override
    {
        _phase = PHASE_NORMAL;

        ScheduleHealthCheckEvent(85, [&]{
            _phase = PHASE_DARKNESS;
            if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
                kalec->AI()->Talk(SAY_KALECGOS_AWAKEN, 16s);

            if (Creature* anveena = instance->GetCreature(DATA_ANVEENA))
                anveena->AI()->Talk(SAY_ANVEENA_IMPRISONED, 22s);

            Talk(SAY_KJ_PHASE3, 28s);

            scheduler.CancelAll();

            ScheduleBasicAbilities();

            me->m_Events.AddEventAtOffset([&] {
                if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
                    kalec->AI()->Talk(SAY_KALECGOS_READY1);
                EmpowerOrb(false);
            }, 35s);

            me->m_Events.AddEventAtOffset([&] {
                Talk(SAY_KJ_REFLECTION);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
            }, 1s);

            scheduler.Schedule(1s+200ms, [this](TaskContext)
            {
                DoCastSelf(SPELL_SHADOW_SPIKE);
            });

            ScheduleTimedEvent(3s, [&] {
                DoCastSelf(SPELL_FLAME_DART);
            }, 10s);

            ScheduleTimedEvent(16s, [&] {
                Talk(EMOTE_KJ_DARKNESS);
                DoCastAOE(SPELL_DARKNESS_OF_A_THOUSAND_SOULS);
            }, 45s);
        });

        ScheduleHealthCheckEvent(55, [&] {
            _phase = PHASE_ARMAGEDDON;
            if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
                kalec->AI()->Talk(SAY_KALECGOS_LETGO, 16s);

            if (Creature* anveena = instance->GetCreature(DATA_ANVEENA))
                anveena->AI()->Talk(SAY_ANVEENA_LOST, 22s);

            Talk(SAY_KJ_PHASE4, 28s);

            scheduler.CancelAll();

            ScheduleBasicAbilities();

            me->m_Events.AddEventAtOffset([&] {
                if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
                    kalec->AI()->Talk(SAY_KALECGOS_READY2);
                EmpowerOrb(false);
            }, 35s);

            me->m_Events.AddEventAtOffset([&] {
                Talk(SAY_KJ_REFLECTION);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
            }, 1s);

            scheduler.Schedule(1s + 200ms, [this](TaskContext)
            {
                DoCastSelf(SPELL_SHADOW_SPIKE);
            });

            ScheduleTimedEvent(15s, [&] {
                Talk(EMOTE_KJ_DARKNESS);
                DoCastAOE(SPELL_DARKNESS_OF_A_THOUSAND_SOULS);
            }, 45s);

            ScheduleTimedEvent(10s, [&] {
                DoCastSelf(SPELL_ARMAGEDDON_PERIODIC, true);
            }, 40s);
        });

        ScheduleHealthCheckEvent(25, [&] {
            _phase = PHASE_SACRIFICE;
            if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
            {
                kalec->AI()->Talk(SAY_KALECGOS_FOCUS, 8s);
                kalec->AI()->Talk(SAY_KALECGOS_FATE, 20s + 200ms);
            }

            if (Creature* anveena = instance->GetCreature(DATA_ANVEENA))
            {
                anveena->AI()->Talk(SAY_ANVEENA_KALEC, 18s);
                anveena->AI()->Talk(SAY_ANVEENA_GOODBYE, 25s);
            }

            scheduler.CancelAll();

            me->m_Events.AddEventAtOffset([&] {
                if (Creature* anveena = instance->GetCreature(DATA_ANVEENA))
                {
                    anveena->RemoveAllAuras();
                    anveena->DespawnOrUnsummon(3500);
                }
            }, 28s);

            me->m_Events.AddEventAtOffset([&] {
                if (Creature* anveena = instance->GetCreature(DATA_ANVEENA))
                {
                    anveena->CastSpell(anveena, SPELL_SACRIFICE_OF_ANVEENA, true);
                    DoCastSelf(SPELL_CUSTOM_08_STATE, true);
                    me->SetUnitFlag(UNIT_FLAG_PACIFIED);
                    scheduler.DelayAll(7100ms);

                    me->m_Events.AddEventAtOffset([&] {
                        me->RemoveAurasDueToSpell(SPELL_CUSTOM_08_STATE);
                        me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);

                        ScheduleBasicAbilities();

                        me->m_Events.AddEventAtOffset([&] {
                            Talk(SAY_KJ_REFLECTION);
                            me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                            me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                            me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                            me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                        }, 1s);

                        ScheduleTimedEvent(15s, [&] {
                            Talk(EMOTE_KJ_DARKNESS);
                            DoCastAOE(SPELL_DARKNESS_OF_A_THOUSAND_SOULS);
                        }, 25s);

                        ScheduleTimedEvent(1500ms, [&] {
                            DoCastSelf(SPELL_ARMAGEDDON_PERIODIC, true);
                        }, 20s);
                    }, 7s);
                }
                Talk(SAY_KJ_PHASE5);
            }, 30s);

            me->m_Events.AddEventAtOffset([&] {
                if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
                    kalec->AI()->Talk(SAY_KALECGOS_READY_ALL);
                EmpowerOrb(true);
            }, 61s);
        });
    }

    void ScheduleBasicAbilities()
    {
        ScheduleTimedEvent(1s, [&] {
            DoCastVictim(SPELL_SOUL_FLAY);
        }, 4s, 5s);

        ScheduleTimedEvent(7s, [&] {
            DoCastRandomTarget(SPELL_LEGION_LIGHTNING, 0, 40.0f);
        }, _phase == PHASE_SACRIFICE ? 15s : 30s);

        ScheduleTimedEvent(9s, [&] {
            me->CastCustomSpell(SPELL_FIRE_BLOOM, SPELLVALUE_MAX_TARGETS, 5, me, TRIGGERED_NONE);
            me->SetTarget(me->GetVictim()->GetGUID());
        }, _phase == PHASE_SACRIFICE ? 20s : 40s);

        if (_phase != PHASE_SACRIFICE)
        {
            ScheduleTimedEvent(10s, [&] {
                for (uint8 i = 1; i < _phase; ++i)
                {
                    float x = me->GetPositionX() + 18.0f * cos((i * 2.0f - 1.0f) * M_PI / 3.0f);
                    float y = me->GetPositionY() + 18.0f * std::sin((i * 2.0f - 1.0f) * M_PI / 3.0f);
                    if (Creature* orb = me->SummonCreature(NPC_SHIELD_ORB, x, y, 40.0f, 0, TEMPSUMMON_CORPSE_DESPAWN))
                    {
                        Movement::PointsArray movementArray;
                        movementArray.push_back(G3D::Vector3(x, y, 40.0f));

                        // generate movement array
                        for (uint8 j = 1; j < 20; ++j)
                        {
                            x = me->GetPositionX() + 18.0f * cos(((i * 2.0f - 1.0f) * M_PI / 3.0f) + (j / 20.0f * 2 * M_PI));
                            y = me->GetPositionY() + 18.0f * std::sin(((i * 2.0f - 1.0f) * M_PI / 3.0f) + (j / 20.0f * 2 * M_PI));
                            movementArray.push_back(G3D::Vector3(x, y, 40.0f));
                        }

                        Movement::MoveSplineInit init(orb);
                        init.MovebyPath(movementArray);
                        init.SetCyclic();
                        init.Launch();
                    }
                }
            }, 40s);
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (me->GetReactState() == REACT_PASSIVE)
            return;
        ScriptedAI::EnterEvadeMode(why);
    }

    void AttackStart(Unit* who) override
    {
        if (me->GetReactState() == REACT_PASSIVE)
            return;
        ScriptedAI::AttackStart(who);
    }

    void DamageTaken(Unit* unit, uint32& damage, DamageEffectType damageType, SpellSchoolMask schoolMask) override
    {
        BossAI::DamageTaken(unit, damage, damageType, schoolMask);

        if (damage >= me->GetHealth())
        {
            me->SetTarget();
            me->SetReactState(REACT_PASSIVE);
            me->RemoveAllAuras();
            me->GetThreatMgr().ClearAllThreat();
            me->SetRegeneratingHealth(false);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->HandleEmoteCommand(EMOTE_ONESHOT_DROWN);
            me->resetAttackTimer();
            events.Reset();
            damage = 0;
            me->m_Events.AddEventAtOffset([&] {
                me->KillSelf();
            }, 1s);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_KJ_DEATH);
        instance->SetBossState(DATA_KILJAEDEN, DONE);
        if (Creature* controller = instance->GetCreature(DATA_KJ_CONTROLLER))
            controller->KillSelf();
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_NO_KILL_TALK)
            Talk(SAY_KJ_DARKNESS);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KJ_SLAY);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (Creature* kalec = instance->GetCreature(DATA_KALECGOS_KJ))
            kalec->AI()->Talk(SAY_KALECGOS_JOIN, 26s);

        Talk(SAY_KJ_EMERGE);
        ScheduleBasicAbilities();
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_ARMAGEDDON_TARGET)
        {
            summon->SetCanFly(true);
            summon->SetDisableGravity(true);
            summon->CastSpell(summon, SPELL_ARMAGEDDON_VISUAL, true);
            summon->SetPosition(summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ() + 20.0f, 0.0f);
            summon->m_Events.AddEvent(new CastArmageddon(summon), summon->m_Events.CalculateTime(6000));
            summon->DespawnOrUnsummon(10000);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (me->GetReactState() != REACT_AGGRESSIVE)
            return;

        if (!UpdateVictim())
            return;

        scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }

    void EmpowerOrb(bool empowerAll)
    {
        for (uint8 i = DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1; i < DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_4 + 1; ++i)
        {
            if (GameObject* orb = instance->GetGameObject(i))
            {
                if (orb->HasGameObjectFlag(GO_FLAG_NOT_SELECTABLE))
                {
                    orb->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    if (Creature* trigger = me->SummonTrigger(orb->GetPositionX(), orb->GetPositionY(), orb->GetPositionZ(), 0, 10 * MINUTE * IN_MILLISECONDS))
                    {
                        trigger->CastSpell(trigger, SPELL_RING_OF_BLUE_FLAMES, true, nullptr, nullptr, trigger->GetGUID());
                        if (Creature* controller = instance->GetCreature(DATA_KJ_CONTROLLER))
                            controller->AI()->JustSummoned(trigger);
                    }

                    if (!empowerAll)
                        break;
                }
            }
        }
    }

    private:
        uint8 _phase;
};

enum postEvent
{
    SAY_VELEN_01                        = 0,
    SAY_VELEN_02                        = 1,
    SAY_VELEN_03                        = 2,
    SAY_VELEN_04                        = 3,
    SAY_VELEN_05                        = 4,
    SAY_VELEN_06                        = 5,
    SAY_VELEN_07                        = 6,
    SAY_VELEN_08                        = 7,
    SAY_VELEN_09                        = 8,
    SAY_LIADRIN_01                      = 0,
    SAY_LIADRIN_02                      = 1,
    SAY_LIADRIN_03                      = 2,

    NPC_SHATTERED_SUN_RIFTWAKER         = 26289,
    NPC_SHATTRATH_PORTAL_DUMMY          = 26251,
    NPC_INERT_PORTAL                    = 26254,
    NPC_SHATTERED_SUN_SOLDIER           = 26259,
    NPC_LADY_LIADRIN                    = 26247,
    NPC_PROPHET_VELEN                   = 26246,
    NPC_THE_CORE_OF_ENTROPIUS           = 26262,

    SPELL_TELEPORT_AND_TRANSFORM        = 46473,
    SPELL_OPEN_PORTAL_FROM_SHATTRATH    = 46801,
    SPELL_TELEPORT_VISUAL               = 35517,
    SPELL_BOSS_ARCANE_PORTAL_STATE      = 42047,
    SPELL_CALL_ENTROPIUS                = 46818,
    SPELL_BLAZE_TO_LIGHT                = 46821,
    SPELL_SUNWELL_IGNITION              = 46822,

    EVENT_SCENE_01                      = 1,
    EVENT_SCENE_02,
    EVENT_SCENE_03,
    EVENT_SCENE_04,
    EVENT_SCENE_05,
    EVENT_SCENE_06,
    EVENT_SCENE_07,
    EVENT_SCENE_08,
    EVENT_SCENE_09,
    EVENT_SCENE_10,
    EVENT_SCENE_11,
    EVENT_SCENE_12,
    EVENT_SCENE_13,
    EVENT_SCENE_14,
    EVENT_SCENE_15,
    EVENT_SCENE_16,
    EVENT_SCENE_17,
    EVENT_SCENE_18,
    EVENT_SCENE_19,
    EVENT_SCENE_20,
    EVENT_SCENE_21,
    EVENT_SCENE_22,
    EVENT_SCENE_23,
    EVENT_SCENE_24,
    EVENT_SCENE_25,
    EVENT_SCENE_26,
    EVENT_SCENE_27
};

class MoveDelayed : public BasicEvent
{
public:
    MoveDelayed(Creature* owner, float x, float y, float z, float o) : _owner(owner), _x(x), _y(y), _z(z), _o(o) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        Movement::MoveSplineInit init(_owner);
        init.MoveTo(_x, _y, _z, false, true);
        init.SetFacing(_o);
        init.Launch();
        return true;
    }

private:
    Creature* _owner;
    float _x, _y, _z, _o;
};

class FixOrientation : public BasicEvent
{
public:
    FixOrientation(Creature* owner) : _owner(owner) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        std::list<Creature*> cList;
        _owner->GetCreaturesWithEntryInRange(cList, 20.0f, NPC_SHATTERED_SUN_SOLDIER);
        for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr)
            (*itr)->SetFacingTo(_owner->GetOrientation());
        return true;
    }

private:
    Creature* _owner;
};

struct npc_kalecgos_kj : public NullCreatureAI
{
    npc_kalecgos_kj(Creature* creature) : NullCreatureAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
    }

    EventMap events;
    InstanceScript* instance;
    SummonList summons;

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_START_POST_EVENT)
        {
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            me->CastSpell(me, SPELL_TELEPORT_AND_TRANSFORM, true);
            events.ScheduleEvent(EVENT_SCENE_01, 35000);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_SHATTERED_SUN_RIFTWAKER)
        {
            summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
            Movement::MoveSplineInit init(summon);
            if (summons.size() == 1)
            {
                init.MoveTo(1727.08f, 656.82f, 28.37f, false, true);
                init.SetFacing(5.14f);
            }
            else
            {
                init.MoveTo(1738.84f, 627.32f, 28.26f, false, true);
                init.SetFacing(2.0f);
            }
            init.Launch();
        }
        else if (summon->GetEntry() == NPC_SHATTRATH_PORTAL_DUMMY)
        {
            if (Creature* riftwaker = summon->FindNearestCreature(NPC_SHATTERED_SUN_RIFTWAKER, 10.0f))
                riftwaker->CastSpell(summon, SPELL_OPEN_PORTAL_FROM_SHATTRATH, false);
            summon->SetWalk(true);
            summon->GetMotionMaster()->MovePoint(0, summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ() + 30.0f, false, true);
        }
        else if (summon->GetEntry() == NPC_INERT_PORTAL)
            summon->CastSpell(summon, SPELL_BOSS_ARCANE_PORTAL_STATE, true);
        else if (summon->GetEntry() == NPC_SHATTERED_SUN_SOLDIER)
            summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
        else if (summon->GetEntry() == NPC_LADY_LIADRIN)
        {
            summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
            summon->SetWalk(true);
        }
        else if (summon->GetEntry() == NPC_PROPHET_VELEN)
        {
            summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
            summon->SetWalk(true);
            summon->GetMotionMaster()->MovePoint(0, 1710.15f, 639.23f, 27.311f, false, true);
        }
        else if (summon->GetEntry() == NPC_THE_CORE_OF_ENTROPIUS)
            summon->GetMotionMaster()->MovePoint(0, summon->GetPositionX(), summon->GetPositionY(), 30.0f);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (uint32 eventId = events.ExecuteEvent())
        {
        case EVENT_SCENE_01:
            Talk(SAY_KALECGOS_GOODBYE);
            events.ScheduleEvent(eventId + 1, 15000);
            break;
        case EVENT_SCENE_02:
            me->SummonCreature(NPC_SHATTERED_SUN_RIFTWAKER, 1688.42f, 641.82f, 27.60f, 0.67f);
            me->SummonCreature(NPC_SHATTERED_SUN_RIFTWAKER, 1712.58f, 616.29f, 27.78f, 0.76f);
            events.ScheduleEvent(eventId + 1, 6000);
            break;
        case EVENT_SCENE_03:
            me->SummonCreature(NPC_SHATTRATH_PORTAL_DUMMY, 1727.08f + cos(5.14f), 656.82f + std::sin(5.14f), 28.37f + 2.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 10000);
            me->SummonCreature(NPC_SHATTRATH_PORTAL_DUMMY, 1738.84f + cos(2.0f), 627.32f + std::sin(2.0f), 28.26f + 2.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 10000);
            events.ScheduleEvent(eventId + 1, 11000);
            break;
        case EVENT_SCENE_04:
            me->SummonCreature(NPC_INERT_PORTAL, 1734.96f, 642.43f, 28.06f, 3.49f);
            events.ScheduleEvent(eventId + 1, 4000);
            break;
        case EVENT_SCENE_05:
            if (Creature* first = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f, 640.49f, 28.06f, 3.49f))
            {
                first->m_Events.AddEvent(new MoveDelayed(first, 1718.70f, 607.78f, 28.06f, 2.323f), first->m_Events.CalculateTime(5000));
                first->m_Events.AddEvent(new FixOrientation(first), first->m_Events.CalculateTime(12000));
                for (uint8 i = 0; i < 9; ++i)
                    if (Creature* follower = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f + 5 * cos(i * 2.0f * M_PI / 9), 640.49f + 5 * std::sin(i * 2.0f * M_PI / 9), 28.06f, 3.49f))
                        follower->GetMotionMaster()->MoveFollow(first, 3.0f, follower->GetAngle(first));
            }
            events.ScheduleEvent(eventId + 1, 10000);
            break;
        case EVENT_SCENE_06:
            if (Creature* first = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f, 640.49f, 28.06f, 3.49f))
            {
                first->m_Events.AddEvent(new MoveDelayed(first, 1678.69f, 649.27f, 28.06f, 5.46f), first->m_Events.CalculateTime(5000));
                first->m_Events.AddEvent(new FixOrientation(first), first->m_Events.CalculateTime(14500));
                for (uint8 i = 0; i < 9; ++i)
                    if (Creature* follower = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f + 5 * cos(i * 2.0f * M_PI / 9), 640.49f + 5 * std::sin(i * 2.0f * M_PI / 9), 28.06f, 3.49f))
                        follower->GetMotionMaster()->MoveFollow(first, 3.0f, follower->GetAngle(first));
            }
            events.ScheduleEvent(eventId + 1, 12000);
            break;
        case EVENT_SCENE_07:
            me->SummonCreature(NPC_LADY_LIADRIN, 1719.87f, 644.265f, 28.06f, 3.83f);
            me->SummonCreature(NPC_PROPHET_VELEN, 1717.97f, 646.44f, 28.06f, 3.94f);
            events.ScheduleEvent(eventId + 1, 7000);
            break;
        case EVENT_SCENE_08:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_01);
            events.ScheduleEvent(eventId + 1, 25000);
            break;
        case EVENT_SCENE_09:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_02);
            events.ScheduleEvent(eventId + 1, 14500);
            break;
        case EVENT_SCENE_10:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_03);
            events.ScheduleEvent(eventId + 1, 12500);
            break;
        case EVENT_SCENE_11:
            me->SummonCreature(NPC_THE_CORE_OF_ENTROPIUS, 1698.86f, 628.73f, 92.83f, 0.0f);
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->CastSpell(velen, SPELL_CALL_ENTROPIUS, false);
            events.ScheduleEvent(eventId + 1, 8000);
            break;
        case EVENT_SCENE_12:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
            {
                velen->InterruptNonMeleeSpells(false);
                velen->AI()->Talk(SAY_VELEN_04);
            }
            events.ScheduleEvent(eventId + 1, 20000);
            break;
        case EVENT_SCENE_13:
            if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                liadrin->GetMotionMaster()->MovePoint(0, 1711.28f, 637.29f, 27.29f);
            events.ScheduleEvent(eventId + 1, 6000);
            break;
        case EVENT_SCENE_14:
            if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                liadrin->AI()->Talk(SAY_LIADRIN_01);
            events.ScheduleEvent(eventId + 1, 10000);
            break;
        case EVENT_SCENE_15:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_05);
            events.ScheduleEvent(eventId + 1, 14000);
            break;
        case EVENT_SCENE_16:
            if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                liadrin->AI()->Talk(SAY_LIADRIN_02);
            events.ScheduleEvent(eventId + 1, 2000);
            break;
        case EVENT_SCENE_17:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_06);
            events.ScheduleEvent(eventId + 1, 3000);
            break;
        case EVENT_SCENE_18:
            if (Creature* core = summons.GetCreatureWithEntry(NPC_THE_CORE_OF_ENTROPIUS))
            {
                core->RemoveAllAuras();
                core->CastSpell(core, SPELL_BLAZE_TO_LIGHT, true);
            }
            events.ScheduleEvent(eventId + 1, 8000);
            break;
        case EVENT_SCENE_19:
            if (Creature* core = summons.GetCreatureWithEntry(NPC_THE_CORE_OF_ENTROPIUS))
            {
                core->SetObjectScale(0.75f);
                core->GetMotionMaster()->MovePoint(0, core->GetPositionX(), core->GetPositionY(), 28.0f);
            }
            events.ScheduleEvent(eventId + 1, 2000);
            break;
        case EVENT_SCENE_20:
            if (Creature* core = summons.GetCreatureWithEntry(NPC_THE_CORE_OF_ENTROPIUS))
                core->CastSpell(core, SPELL_SUNWELL_IGNITION, true);
            events.ScheduleEvent(eventId + 1, 3000);
            break;
        case EVENT_SCENE_21:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_07);
            events.ScheduleEvent(eventId + 1, 15000);
            break;
        case EVENT_SCENE_22:
            if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                liadrin->AI()->Talk(SAY_LIADRIN_03);
            events.ScheduleEvent(eventId + 1, 20000);
            break;
        case EVENT_SCENE_23:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_08);
            if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                liadrin->SetStandState(UNIT_STAND_STATE_KNEEL);
            events.ScheduleEvent(eventId + 1, 8000);
            break;
        case EVENT_SCENE_24:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                velen->AI()->Talk(SAY_VELEN_09);
            events.ScheduleEvent(eventId + 1, 5000);
            break;
        case EVENT_SCENE_25:
            if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
            {
                velen->GetMotionMaster()->MovePoint(0, 1739.38f, 643.79f, 28.06f);
                velen->DespawnOrUnsummon(5000);
            }
            events.ScheduleEvent(eventId + 1, 3000);
            break;
        case EVENT_SCENE_26:
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                    if (summon->GetEntry() == NPC_SHATTERED_SUN_SOLDIER)
                    {
                        summon->GetMotionMaster()->MovePoint(0, 1739.38f, 643.79f, 28.06f);
                        summon->DespawnOrUnsummon(summon->GetExactDist2d(1734.96f, 642.43f) * 100);
                    }
            events.ScheduleEvent(eventId + 1, 7000);
            break;
        case EVENT_SCENE_27:
            me->setActive(false);
            summons.DespawnEntry(NPC_INERT_PORTAL);
            summons.DespawnEntry(NPC_SHATTERED_SUN_RIFTWAKER);
            break;
        }
    }
};

class spell_kiljaeden_shadow_spike_aura : public AuraScript
{
    PrepareAuraScript(spell_kiljaeden_shadow_spike_aura);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_kiljaeden_shadow_spike_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_kiljaeden_sinister_reflection : public SpellScript
{
    PrepareSpellScript(spell_kiljaeden_sinister_reflection);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SINISTER_REFLECTION_SUMMON, SPELL_SINISTER_REFLECTION_CLONE });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT));
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SINISTER_REFLECTION_SUMMON, true);
            //target->CastSpell(target, SPELL_SINISTER_REFLECTION_CLONE, true);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kiljaeden_sinister_reflection::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_kiljaeden_sinister_reflection::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_kiljaeden_sinister_reflection_clone : public SpellScript
{
    PrepareSpellScript(spell_kiljaeden_sinister_reflection_clone);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        WorldObject* target = targets.front();

        targets.clear();
        if (target && target->IsCreature())
        {
            target->ToCreature()->AI()->SetData(1, GetCaster()->getClass());
            targets.push_back(target);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kiljaeden_sinister_reflection_clone::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_kiljaeden_flame_dart : public SpellScript
{
    PrepareSpellScript(spell_kiljaeden_flame_dart);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLAME_DART_EXPLOSION });
    }

    void HandleSchoolDamage(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_FLAME_DART_EXPLOSION, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kiljaeden_flame_dart::HandleSchoolDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class spell_kiljaeden_darkness_aura : public AuraScript
{
    PrepareAuraScript(spell_kiljaeden_darkness_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DARKNESS_OF_A_THOUSAND_SOULS_DAMAGE });
    }

    void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetUnitOwner()->IsCreature())
            GetUnitOwner()->ToCreature()->AI()->DoAction(ACTION_NO_KILL_TALK);

        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_DARKNESS_OF_A_THOUSAND_SOULS_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_kiljaeden_darkness_aura::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_kiljaeden_power_of_the_blue_flight : public SpellScript
{
    PrepareSpellScript(spell_kiljaeden_power_of_the_blue_flight);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_BLUE_DRAKE, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Player* player = GetHitPlayer())
        {
            player->CastSpell(player, SPELL_SUMMON_BLUE_DRAKE, true);
            player->CastSpell(player, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kiljaeden_power_of_the_blue_flight::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_kiljaeden_vengeance_of_the_blue_flight_aura : public AuraScript
{
    PrepareAuraScript(spell_kiljaeden_vengeance_of_the_blue_flight_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_POSSESS_DRAKE_IMMUNITY });
    }

    void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_POSSESS_DRAKE_IMMUNITY, true);
    }

    void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->RemoveAurasDueToSpell(SPELL_POSSESS_DRAKE_IMMUNITY);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_kiljaeden_vengeance_of_the_blue_flight_aura::HandleApply, EFFECT_0, SPELL_AURA_MOD_POSSESS, AURA_EFFECT_HANDLE_REAL);
        OnEffectApply += AuraEffectApplyFn(spell_kiljaeden_vengeance_of_the_blue_flight_aura::HandleApply, EFFECT_2, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_kiljaeden_vengeance_of_the_blue_flight_aura::HandleRemove, EFFECT_0, SPELL_AURA_MOD_POSSESS, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_kiljaeden_vengeance_of_the_blue_flight_aura::HandleRemove, EFFECT_2, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_kiljaeden_armageddon_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_kiljaeden_armageddon_periodic_aura);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_kiljaeden_armageddon_periodic_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_kiljaeden_armageddon_missile : public SpellScript
{
    PrepareSpellScript(spell_kiljaeden_armageddon_missile);

    void SetDest(SpellDestination& dest)
    {
        Position const offset = { 0.0f, 0.0f, -20.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_kiljaeden_armageddon_missile::SetDest, EFFECT_0, TARGET_DEST_CASTER);
    }
};

class spell_kiljaeden_dragon_breath : public SpellScript
{
    PrepareSpellScript(spell_kiljaeden_dragon_breath);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kiljaeden_dragon_breath::FilterTargets, EFFECT_ALL, TARGET_UNIT_CONE_ALLY);
    }
};

void AddSC_boss_kiljaeden()
{
    RegisterSunwellPlateauCreatureAI(npc_kiljaeden_controller);
    RegisterSunwellPlateauCreatureAI(boss_kiljaeden);
    RegisterSunwellPlateauCreatureAI(npc_kalecgos_kj);
    RegisterSpellScript(spell_kiljaeden_shadow_spike_aura);
    RegisterSpellScript(spell_kiljaeden_sinister_reflection);
    RegisterSpellScript(spell_kiljaeden_sinister_reflection_clone);
    RegisterSpellScript(spell_kiljaeden_flame_dart);
    RegisterSpellScript(spell_kiljaeden_darkness_aura);
    RegisterSpellScript(spell_kiljaeden_power_of_the_blue_flight);
    RegisterSpellScript(spell_kiljaeden_vengeance_of_the_blue_flight_aura);
    RegisterSpellScript(spell_kiljaeden_armageddon_periodic_aura);
    RegisterSpellScript(spell_kiljaeden_armageddon_missile);
    RegisterSpellScript(spell_kiljaeden_dragon_breath);
}
