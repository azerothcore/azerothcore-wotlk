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
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO                 = 0,
    SAY_DING_KILL             = 1,
    SAY_WATCH                 = 2,
    SAY_WATCH_WHISPER         = 3,
    SAY_OHGAN_DEAD            = 4,
    SAY_GRATS_JINDO           = 0,
};

enum Spells
{
    SPELL_CHARGE              = 24408,
    SPELL_OVERPOWER           = 24407,
    SPELL_FRIGHTENING_SHOUT   = 19134,
    SPELL_WHIRLWIND           = 13736, // triggers 15589
    SPELL_MORTAL_STRIKE       = 16856,
    SPELL_FRENZY              = 24318,
    SPELL_WATCH               = 24314, // triggers 24315 and 24316
    SPELL_WATCH_CHARGE        = 24315, // triggers 24316
    SPELL_LEVEL_UP            = 24312,
    SPELL_EXECUTE             = 7160,
    SPELL_MANDOKIR_CLEAVE     = 20691,
    SPELL_SUMMON_PLAYER       = 25104,

    SPELL_REVIVE              = 24341 // chained spirit
};

enum Events
{
    EVENT_CHECK_SPEAKER       = 1,
    EVENT_CHECK_START         = 2,
    EVENT_STARTED             = 3,
    EVENT_OVERPOWER           = 4,
    EVENT_MORTAL_STRIKE       = 5,
    EVENT_WHIRLWIND           = 6,
    EVENT_CHECK_OHGAN         = 7,
    EVENT_WATCH_PLAYER        = 8,
    EVENT_CHARGE_PLAYER       = 9,
    EVENT_EXECUTE             = 10,
    EVENT_CLEAVE              = 11
};

enum Action
{
    ACTION_START_REVIVE       = 1, // broodlord mandokir
    ACTION_REVIVE             = 2 // chained spirit
};

enum Misc
{
    POINT_START_REVIVE        = 1, // chained spirit

    MODEL_OHGAN_MOUNT         = 15271,
    PATH_MANDOKIR             = 492861,
    POINT_MANDOKIR_END        = 24,
    CHAINED_SPIRIT_COUNT      = 20,
    ACTION_CHARGE             = 1
};

Position const PosSummonChainedSpirits[CHAINED_SPIRIT_COUNT] =
{
    { -12167.17f, -1979.330f, 133.0992f, 2.268928f },
    { -12262.74f, -1953.394f, 133.5496f, 0.593412f },
    { -12176.89f, -1983.068f, 133.7841f, 2.129302f },
    { -12226.45f, -1977.933f, 132.7982f, 1.466077f },
    { -12204.74f, -1890.431f, 135.7569f, 4.415683f },
    { -12216.70f, -1891.806f, 136.3496f, 4.677482f },
    { -12236.19f, -1892.034f, 134.1041f, 5.044002f },
    { -12248.24f, -1893.424f, 134.1182f, 5.270895f },
    { -12257.36f, -1897.663f, 133.1484f, 5.462881f },
    { -12265.84f, -1903.077f, 133.1649f, 5.654867f },
    { -12158.69f, -1972.707f, 133.8751f, 2.408554f },
    { -12178.82f, -1891.974f, 134.1786f, 3.944444f },
    { -12193.36f, -1890.039f, 135.1441f, 4.188790f },
    { -12275.59f, -1932.845f, 134.9017f, 0.174533f },
    { -12273.51f, -1941.539f, 136.1262f, 0.314159f },
    { -12247.02f, -1963.497f, 133.9476f, 0.872665f },
    { -12238.68f, -1969.574f, 133.6273f, 1.134464f },
    { -12192.78f, -1982.116f, 132.6966f, 1.919862f },
    { -12210.81f, -1979.316f, 133.8700f, 1.797689f },
    { -12283.51f, -1924.839f, 133.5170f, 0.069813f }
};

Position const PosMandokir[2] =
{
    { -12167.8f, -1927.25f, 153.73f, 3.76991f },
    { -12197.86f, -1949.392f, 130.2745f, 0.0f }
};

void RevivePlayer(Unit* victim, ObjectGuid& reviveGUID)
{
    std::list<Creature*> chainedSpirits;
    GetCreatureListWithEntryInGrid(chainedSpirits, victim, NPC_CHAINED_SPIRIT, 200.f);
    if (chainedSpirits.empty())
        return;

    // Sort the list by distance to the victim.
    chainedSpirits.sort([victim](Creature const* c1, Creature const* c2)
        {
            return c1->GetDistance2d(victim) < c2->GetDistance2d(victim);
        });

    // Now we have to check if the spirit is already reviving someone...
    for (Creature* spirit : chainedSpirits)
    {
        if (!spirit->isMoving() && !spirit->HasUnitState(UNIT_STATE_CASTING))
        {
            spirit->AI()->SetGUID(reviveGUID);
            spirit->AI()->DoAction(ACTION_REVIVE);
            reviveGUID.Clear();
            break;
        }
    }
}

class boss_mandokir : public CreatureScript
{
public:
    boss_mandokir() : CreatureScript("boss_mandokir") { }

    struct boss_mandokirAI : public BossAI
    {
        boss_mandokirAI(Creature* creature) : BossAI(creature, DATA_MANDOKIR) { }

        void Reset() override
        {
            BossAI::Reset();
            killCount = 0;
            if (me->GetPositionZ() > 140.0f)
            {
                events.ScheduleEvent(EVENT_CHECK_START, 1000);
                if (Creature* speaker = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_VILEBRANCH_SPEAKER)))
                {
                    if (!speaker->IsAlive())
                    {
                        speaker->Respawn(true);
                    }
                }
            }
            me->RemoveAurasDueToSpell(SPELL_FRENZY);
            me->SetImmuneToAll(false);
            instance->SetBossState(DATA_OHGAN, NOT_STARTED);
            me->Mount(MODEL_OHGAN_MOUNT);
            reviveGUID.Clear();
            _useExecute = false;
            _chargeTarget.first.Clear();
        }

        void JustDied(Unit* /*killer*/) override
        {
            std::list<Creature*> chainedSpirits;
            GetCreatureListWithEntryInGrid(chainedSpirits, me, NPC_CHAINED_SPIRIT, 200.f);
            for (Creature* spirit : chainedSpirits)
                spirit->DespawnOrUnsummon();

            instance->SetBossState(DATA_MANDOKIR, DONE);
            instance->SaveToDB();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_OVERPOWER, 1s);
            events.ScheduleEvent(EVENT_MORTAL_STRIKE, 14s, 28s);
            events.ScheduleEvent(EVENT_WHIRLWIND, 24s, 30s);
            events.ScheduleEvent(EVENT_CHECK_OHGAN, 1s);
            events.ScheduleEvent(EVENT_WATCH_PLAYER, 12s, 24s);
            events.ScheduleEvent(EVENT_CHARGE_PLAYER, 30s, 40s);
            events.ScheduleEvent(EVENT_CLEAVE, 1s);
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            Talk(SAY_AGGRO);
            me->Dismount();
            // Summon Ohgan (Spell missing) TEMP HACK
            me->SummonCreature(NPC_OHGAN, me->GetPositionX() - 3, me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 35000);
            for (int i = 0; i < CHAINED_SPIRIT_COUNT; ++i)
            {
                me->SummonCreature(NPC_CHAINED_SPIRIT, PosSummonChainedSpirits[i], TEMPSUMMON_CORPSE_DESPAWN);
            }
            DoZoneInCombat();
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            reviveGUID = victim->GetGUID();
            RevivePlayer(victim, reviveGUID);
            if (++killCount == 3)
            {
                Talk(SAY_DING_KILL);
                if (Creature* jindo = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_JINDO)))
                {
                    if (jindo->IsAlive())
                    {
                        jindo->AI()->Talk(SAY_GRATS_JINDO);
                    }
                }
                DoCastSelf(SPELL_LEVEL_UP, true);
                killCount = 0;
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_REVIVE)
            {
                std::list<Creature*> creatures;
                GetCreatureListWithEntryInGrid(creatures, me, NPC_CHAINED_SPIRIT, 200.0f);
                if (creatures.empty())
                    return;

                for (std::list<Creature*>::iterator itr = creatures.begin(); itr != creatures.end(); ++itr)
                {
                    if (Creature* chainedSpirit = ObjectAccessor::GetCreature(*me, (*itr)->GetGUID()))
                    {
                        chainedSpirit->AI()->SetGUID(reviveGUID);
                        chainedSpirit->AI()->DoAction(ACTION_REVIVE);
                        reviveGUID.Clear();
                    }
                }
            }
        }

        void SetGUID(ObjectGuid const guid, int32 type) override
        {
            if (type == ACTION_CHARGE)
            {
                if (_chargeTarget.first == guid && _chargeTarget.second > 0.f)
                {
                    if (Unit* target = ObjectAccessor::GetUnit(*me, _chargeTarget.first))
                    {
                        me->RemoveAurasDueToSpell(SPELL_WHIRLWIND);
                        DoCast(target, SPELL_WATCH_CHARGE, true);
                    }
                }
            }
            else
            {
                reviveGUID = guid;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == WAYPOINT_MOTION_TYPE)
            {
                me->SetWalk(false);
                if (id == POINT_MANDOKIR_END)
                {
                    me->SetHomePosition(PosMandokir[0]);
                    instance->SetBossState(DATA_MANDOKIR, NOT_STARTED);
                }
            }
        }

        void CalculateThreat(Unit* hatedUnit, float& threat, SpellInfo const* threatSpell) override
        {
            if (_chargeTarget.first == hatedUnit->GetGUID())
            {
                // Do not count DOTs/HOTs
                if (!(threatSpell && (threatSpell->HasAura(SPELL_AURA_DAMAGE_SHIELD) || threatSpell->HasAttribute(SPELL_ATTR0_CU_NO_INITIAL_THREAT))))
                {
                    _chargeTarget.second += threat;
                }
            }
        }

        void DamageDealt(Unit* doneTo, uint32& damage, DamageEffectType /*damagetype*/) override
        {
            if (doneTo && doneTo == me->GetVictim())
            {
                if (doneTo->HealthBelowPctDamaged(20, damage))
                {
                    if (!_useExecute)
                    {
                        _useExecute = true;
                        events.ScheduleEvent(EVENT_EXECUTE, 1s);
                    }
                }
                else if (_useExecute)
                {
                    _useExecute = false;
                    events.CancelEvent(EVENT_EXECUTE);
                }
            }
        }

        bool OnTeleportUnreacheablePlayer(Player* player) override
        {
            DoCast(player, SPELL_SUMMON_PLAYER, true);
            return true;
        }

        void DoMeleeAttackIfReady(bool ignoreCasting)
        {
            if (!ignoreCasting && me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            Unit* victim = me->GetVictim();
            if (!victim || !victim->IsInWorld())
                return;

            if (!me->IsWithinMeleeRange(victim))
                return;

            //Make sure our attack is ready and we aren't currently casting before checking distance
            if (me->isAttackReady())
            {
                // xinef: prevent base and off attack in same time, delay attack at 0.2 sec
                if (me->haveOffhandWeapon())
                    if (me->getAttackTimer(OFF_ATTACK) < ATTACK_DISPLAY_DELAY)
                        me->setAttackTimer(OFF_ATTACK, ATTACK_DISPLAY_DELAY);

                me->AttackerStateUpdate(victim, BASE_ATTACK, false, ignoreCasting);
                me->resetAttackTimer();
            }

            if (me->haveOffhandWeapon() && me->isAttackReady(OFF_ATTACK))
            {
                // xinef: delay main hand attack if both will hit at the same time (players code)
                if (me->getAttackTimer(BASE_ATTACK) < ATTACK_DISPLAY_DELAY)
                    me->setAttackTimer(BASE_ATTACK, ATTACK_DISPLAY_DELAY);

                me->AttackerStateUpdate(victim, OFF_ATTACK, false, ignoreCasting);
                me->resetAttackTimer(OFF_ATTACK);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (!UpdateVictim())
            {
                if (instance->GetBossState(DATA_MANDOKIR) == NOT_STARTED || instance->GetBossState(DATA_MANDOKIR) == SPECIAL)
                {
                    while (uint32 eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_CHECK_START:
                                if (instance->GetBossState(DATA_MANDOKIR) == SPECIAL)
                                {
                                    me->GetMotionMaster()->MovePoint(0, PosMandokir[1].m_positionX, PosMandokir[1].m_positionY, PosMandokir[1].m_positionZ);
                                    events.ScheduleEvent(EVENT_STARTED, 6s);
                                }
                                else
                                {
                                    events.ScheduleEvent(EVENT_CHECK_START, 1s);
                                }
                                break;
                            case EVENT_STARTED:
                                me->SetImmuneToAll(false);
                                me->SetInCombatWithZone();
                                break;
                            default:
                                break;
                        }
                    }
                }
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->HasUnitState(UNIT_STATE_CHARGING))
            {
                if (me->GetCurrentSpellCastTime(SPELL_WATCH) >= 0)
                {
                    DoMeleeAttackIfReady(true);
                }

                return;
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_OVERPOWER:
                        if (DoCastVictim(SPELL_OVERPOWER) == SPELL_CAST_OK)
                        {
                            events.ScheduleEvent(EVENT_OVERPOWER, 6s, 8s);
                        }
                        else
                        {
                            events.ScheduleEvent(EVENT_OVERPOWER, 1s);
                        }
                        break;
                    case EVENT_MORTAL_STRIKE:
                        DoCastVictim(SPELL_MORTAL_STRIKE);
                        events.ScheduleEvent(EVENT_MORTAL_STRIKE, 14s, 28s);
                        break;
                    case EVENT_WHIRLWIND:
                        DoCast(me, SPELL_WHIRLWIND);
                        events.ScheduleEvent(EVENT_WHIRLWIND, 22s,  26s);
                        break;
                    case EVENT_CHECK_OHGAN:
                        if (instance->GetBossState(DATA_OHGAN) == DONE)
                        {
                            DoCast(me, SPELL_FRENZY);
                            Talk(SAY_OHGAN_DEAD);
                        }
                        else
                        {
                            events.ScheduleEvent(EVENT_CHECK_OHGAN, 1s);
                        }
                        break;
                    case EVENT_WATCH_PLAYER:
                        if (Unit* player = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                        {
                            DoCast(player, SPELL_WATCH);
                            Talk(SAY_WATCH, player);
                            _chargeTarget = std::make_pair(player->GetGUID(), 0.f);
                        }
                        events.ScheduleEvent(EVENT_WATCH_PLAYER, 12s, 24s);
                        break;
                    case EVENT_CHARGE_PLAYER:
                        if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, [this](Unit const* target)
                            {
                                if (!me || !target)
                                    return false;
                                if (target->GetTypeId() != TYPEID_PLAYER || !me->IsWithinLOSInMap(target))
                                    return false;
                                return true;
                            }))
                        {
                            DoCast(target, SPELL_CHARGE);
                            events.DelayEvents(1500ms);
                            if (Unit* mainTarget = SelectTarget(SelectTargetMethod::MaxThreat, 0, 100.0f))
                            {
                                me->GetThreatMgr().ModifyThreatByPercent(mainTarget, -100);
                            }
                        }
                        events.ScheduleEvent(EVENT_CHARGE_PLAYER, 30s, 40s);
                        break;
                    case EVENT_EXECUTE:
                        DoCastVictim(SPELL_EXECUTE, true);
                        events.ScheduleEvent(EVENT_EXECUTE, 7s, 14s);
                        break;
                    case EVENT_CLEAVE:
                        {
                            std::list<Unit*> meleeRangeTargets;
                            auto i = me->GetThreatMgr().GetThreatList().begin();
                            for (; i != me->GetThreatMgr().GetThreatList().end(); ++i)
                            {
                                Unit* target = (*i)->getTarget();
                                if (me->IsWithinMeleeRange(target))
                                {
                                    meleeRangeTargets.push_back(target);
                                }
                            }
                            if (meleeRangeTargets.size() >= 5)
                            {
                                DoCastVictim(SPELL_MANDOKIR_CLEAVE);
                                events.ScheduleEvent(EVENT_CLEAVE, 10s, 20s);
                            }
                            else
                            {
                                events.ScheduleEvent(EVENT_CLEAVE, 1s);
                            }
                            break;
                        }
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady(false);
        }

    private:
        uint8 killCount;
        ObjectGuid reviveGUID;
        bool _useExecute;
        std::pair<ObjectGuid, float> _chargeTarget;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_mandokirAI>(creature);
    }
};

// Ohgan
enum OhganSpells
{
    SPELL_SUNDERARMOR         = 24317,
    SPELL_THRASH              = 3391
};

class npc_ohgan : public CreatureScript
{
public:
    npc_ohgan() : CreatureScript("npc_ohgan") { }

    struct npc_ohganAI : public ScriptedAI
    {
        npc_ohganAI(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript()) { }

        void Reset() override
        {
            _scheduler.CancelAll();
            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });

            reviveGUID.Clear();
        }

        void JustEngagedWith(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            _scheduler.Schedule(6s, 12s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SUNDERARMOR);
                context.Repeat(6s, 12s);
            });
            _scheduler.Schedule(12s, 18s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_THRASH);
                context.Repeat(12s, 18s);
            });
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            reviveGUID = victim->GetGUID();
            RevivePlayer(victim, reviveGUID);
        }

        void SetGUID(ObjectGuid const guid, int32 /*type = 0 */) override
        {
            reviveGUID = guid;
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetBossState(DATA_OHGAN, DONE);
        }

        void UpdateAI(uint32 diff) override
        {
            _scheduler.Update(diff);

            if (!UpdateVictim())
            {
                return;
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* instance;
        ObjectGuid reviveGUID;
        TaskScheduler _scheduler;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_ohganAI>(creature);
    }
};

struct npc_chained_spirit : public ScriptedAI
{
public:
    npc_chained_spirit(Creature* creature) : ScriptedAI(creature)
    {
        instance = me->GetInstanceScript();
        me->AddUnitMovementFlag(MOVEMENTFLAG_HOVER);
    }

    void Reset() override
    {
        revivePlayerGUID.Clear();
    }

    void SetGUID(ObjectGuid const guid, int32 /*id*/) override
    {
        revivePlayerGUID = guid;
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_REVIVE)
        {
            if (Player* target = ObjectAccessor::GetPlayer(*me, revivePlayerGUID))
            {
                Position pos;
                target->GetNearPoint(me, pos.m_positionX, pos.m_positionY, pos.m_positionZ, 0.0f, 0.0f, target->GetAbsoluteAngle(me));
                me->GetMotionMaster()->MovePoint(POINT_START_REVIVE, pos);
            }
        }
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type != POINT_MOTION_TYPE || !revivePlayerGUID)
            return;

        if (pointId == POINT_START_REVIVE)
        {
            if (Player* target = ObjectAccessor::GetPlayer(*me, revivePlayerGUID))
            {
                DoCast(target, SPELL_REVIVE);
            }
            me->DespawnOrUnsummon(1000);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon();
    }

    void UpdateAI(uint32 /*diff*/) override { }

private:
    InstanceScript* instance;
    ObjectGuid revivePlayerGUID;

};

enum VilebranchSpells
{
    SPELL_DEMORALIZING_SHOUT  = 13730,
    SPELL_CLEAVE              = 15284
};

struct npc_vilebranch_speaker : public ScriptedAI
{
    npc_vilebranch_speaker(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript()) { }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler
            .Schedule(2s, 4s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_DEMORALIZING_SHOUT);
                context.Repeat(22s, 30s);
            })
            .Schedule(5s, 8s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_CLEAVE, true);
                context.Repeat(6s, 9s);
            });
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetBossState(DATA_MANDOKIR, SPECIAL);
    }

    void UpdateAI(uint32 diff) override
    {
        // Return since we have no target
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

private:
    TaskScheduler _scheduler;
    InstanceScript* instance;
};

class spell_threatening_gaze : public SpellScriptLoader
{
public:
    spell_threatening_gaze() : SpellScriptLoader("spell_threatening_gaze") { }

    class spell_threatening_gaze_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_threatening_gaze_AuraScript);

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
            {
                if (Unit* target = GetTarget())
                {
                    if (Unit* caster = GetCaster())
                    {
                        if (Creature* cCaster = caster->ToCreature())
                        {
                            if (cCaster->IsAIEnabled)
                            {
                                cCaster->AI()->SetGUID(target->GetGUID(), ACTION_CHARGE);
                            }
                        }
                    }
                }
            }
        }

        void Register() override
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_threatening_gaze_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_threatening_gaze_AuraScript();
    }
};

class spell_mandokir_charge : public SpellScript
{
    PrepareSpellScript(spell_mandokir_charge);

    void LaunchHit(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (caster && target)
            caster->CastSpell(target, SPELL_FRIGHTENING_SHOUT, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_mandokir_charge::LaunchHit, EFFECT_0, SPELL_EFFECT_CHARGE);
    }
};

class spell_threatening_gaze_charge : public SpellScript
{
    PrepareSpellScript(spell_threatening_gaze_charge)

    void PreventLaunchHit(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
    }

    void LaunchHit(SpellEffIndex effIndex)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetHitUnit())
                caster->CastSpell(target, GetSpellInfo()->Effects[effIndex].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_threatening_gaze_charge::PreventLaunchHit, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
        OnEffectHitTarget += SpellEffectFn(spell_threatening_gaze_charge::LaunchHit, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

void AddSC_boss_mandokir()
{
    new boss_mandokir();
    new npc_ohgan();
    RegisterZulGurubCreatureAI(npc_chained_spirit);
    RegisterZulGurubCreatureAI(npc_vilebranch_speaker);
    new spell_threatening_gaze();
    RegisterSpellScript(spell_mandokir_charge);
    RegisterSpellScript(spell_threatening_gaze_charge);
}
