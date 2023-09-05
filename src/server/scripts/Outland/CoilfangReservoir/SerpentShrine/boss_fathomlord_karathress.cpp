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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "serpent_shrine.h"
#include "TaskScheduler.h"

enum Talk
{
    SAY_AGGRO                       = 0,
    SAY_GAIN_BLESSING               = 1,
    SAY_GAIN_ABILITY1               = 2,
    SAY_GAIN_ABILITY2               = 3,
    SAY_GAIN_ABILITY3               = 4,
    SAY_SLAY                        = 5,
    SAY_DEATH                       = 6
};

enum Spells
{
    //Fathomlord Karathress
    SPELL_CATACLYSMIC_BOLT          = 38441,
    SPELL_SEAR_NOVA                 = 38445,
    SPELL_ENRAGE                    = 24318,
    SPELL_BLESSING_OF_THE_TIDES     = 38449,
    //Fathomguard Sharkkis
    SPELL_HURL_TRIDENT              = 38374,
    SPELL_LEECHING_THROW            = 29436,
    SPELL_MULTI_TOSS                = 38366,
    SPELL_SUMMON_FATHOM_SPOREBAT    = 38431,
    SPELL_SUMMON_FATHOM_LUKER       = 38433,
    SPELL_CAST_THE_BEAST_WITHIN     = 38373,
    SPELL_CAST_BESTIAL_WRATH        = 38371,
    SPELL_POWER_OF_SHARKKIS         = 38455,
    //Fathomguard Tidalvess
    SPELL_FROST_SHOCK               = 38234,
    SPELL_EARTHBIND_TOTEM           = 38304,
    SPELL_POISON_CLEANSING_TOTEM    = 38306,
    SPELL_SPITFIRE_TOTEM            = 38236,
    SPELL_POWER_OF_TIDALVESS        = 38452,
    //Fathomguard Caribdis
    SPELL_SUMMON_CYCLONE            = 38337,
    SPELL_WATER_BOLT_VOLLEY         = 38335,
    SPELL_TIDAL_SURGE               = 38358,
    SPELL_HEALING_WAVE              = 38330,
    SPELL_POWER_OF_CARIBDIS         = 38451
};

enum Misc
{
    MAX_ADVISORS                    = 3,
    NPC_FATHOM_GUARD_CARIBDIS       = 21964,
    NPC_FATHOM_GUARD_TIDALVESS      = 21965,
    NPC_FATHOM_GUARD_SHARKKIS       = 21966,
    NPC_SEER_OLUM                   = 22820,
    GO_CAGE                         = 185952,
};

enum FKActions
{
    ACTION_COMBATZONE               = 1
};

const Position advisorsPosition[MAX_ADVISORS + 2] =
{
    {459.61f, -534.81f, -7.54f, 3.82f},
    {463.83f, -540.23f, -7.54f, 3.15f},
    {459.94f, -547.28f, -7.54f, 2.42f},
    {448.37f, -544.71f, -7.54f, 0.00f},
    {457.37f, -544.71f, -7.54f, 0.00f}
};

struct boss_fathomlord_karathress : public BossAI
{
    boss_fathomlord_karathress(Creature* creature) : BossAI(creature, DATA_FATHOM_LORD_KARATHRESS)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        _recentlySpoken = false;

        me->SummonCreature(NPC_FATHOM_GUARD_TIDALVESS, advisorsPosition[0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
        me->SummonCreature(NPC_FATHOM_GUARD_SHARKKIS, advisorsPosition[1], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
        me->SummonCreature(NPC_FATHOM_GUARD_CARIBDIS, advisorsPosition[2], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);

        ScheduleHealthCheckEvent(75, [&]{
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
            {
                if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                {
                    if (summon->GetMaxHealth() > 500000)
                    {
                        summon->CastSpell(me, SPELL_BLESSING_OF_THE_TIDES, true);
                    }
                }
            }
            if (me->HasAura(SPELL_BLESSING_OF_THE_TIDES))
            {
                Talk(SAY_GAIN_BLESSING);
            }
        });
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_SEER_OLUM)
        {
            summon->SetWalk(true);
            summon->GetMotionMaster()->MovePoint(0, advisorsPosition[MAX_ADVISORS + 1], false);
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);
        if (summon->GetEntry() == NPC_FATHOM_GUARD_TIDALVESS)
            Talk(SAY_GAIN_ABILITY1);
        if (summon->GetEntry() == NPC_FATHOM_GUARD_SHARKKIS)
            Talk(SAY_GAIN_ABILITY2);
        if (summon->GetEntry() == NPC_FATHOM_GUARD_CARIBDIS)
            Talk(SAY_GAIN_ABILITY3);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;
        }
        scheduler.Schedule(6s, [this](TaskContext)
        {
            _recentlySpoken = false;
        });
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
        me->SummonCreature(NPC_SEER_OLUM, advisorsPosition[MAX_ADVISORS], TEMPSUMMON_TIMED_DESPAWN, 3600000);
        if (GameObject* gobject = me->FindNearestGameObject(GO_CAGE, 100.0f))
        {
            gobject->SetGoState(GO_STATE_ACTIVE);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        
        instance->DoForAllMinions(DATA_FATHOM_LORD_KARATHRESS, [&](Creature* fathomguard) {
            fathomguard->AI()->DoAction(ACTION_COMBATZONE);
        });

        scheduler.Schedule(10s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 50.0f, true)))
            {
                me->CastSpell(target, SPELL_CATACLYSMIC_BOLT);
            }
            context.Repeat(6s);
        }).Schedule(25s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SEAR_NOVA);
            context.Repeat(20s, 40s);
        }).Schedule(10min, [this](TaskContext)
        {
            DoCastSelf(SPELL_ENRAGE, true);
        });
    }
private:
    bool _recentlySpoken;
};

struct boss_fathomguard_sharkkis : public ScriptedAI
{
    boss_fathomguard_sharkkis(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_COMBATZONE)
        {
            me->SetInCombatWithZone();
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {

    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* karathress = _instance->GetCreature(DATA_FATHOM_LORD_KARATHRESS))
        {
            me->CastSpell(karathress, SPELL_POWER_OF_SHARKKIS);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
    InstanceScript* _instance;
};

struct boss_fathomguard_tidalvess : public ScriptedAI
{
    boss_fathomguard_tidalvess(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_COMBATZONE)
        {
            me->SetInCombatWithZone();
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {

    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* karathress = _instance->GetCreature(DATA_FATHOM_LORD_KARATHRESS))
        {
            me->CastSpell(karathress, SPELL_POWER_OF_TIDALVESS);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
    InstanceScript* _instance;
};

struct boss_fathomguard_caribdis : public ScriptedAI
{
    boss_fathomguard_caribdis(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_COMBATZONE)
        {
            me->SetInCombatWithZone();
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {

    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* karathress = _instance->GetCreature(DATA_FATHOM_LORD_KARATHRESS))
        {
            me->CastSpell(karathress, SPELL_POWER_OF_CARIBDIS);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
    InstanceScript* _instance;
};

class spell_karathress_power_of_caribdis : public SpellScriptLoader
{
public:
    spell_karathress_power_of_caribdis() : SpellScriptLoader("spell_karathress_power_of_caribdis") { }

    class spell_karathress_power_of_caribdis_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_karathress_power_of_caribdis_AuraScript);

        void OnPeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            if (Unit* victim = GetUnitOwner()->GetVictim())
                GetUnitOwner()->CastSpell(victim, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_karathress_power_of_caribdis_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_karathress_power_of_caribdis_AuraScript();
    }
};

void AddSC_boss_fathomlord_karathress()
{
    RegisterSerpentShrineAI(boss_fathomlord_karathress);
    RegisterSerpentShrineAI(boss_fathomguard_sharkkis);
    RegisterSerpentShrineAI(boss_fathomguard_tidalvess);
    RegisterSerpentShrineAI(boss_fathomguard_caribdis);
    new spell_karathress_power_of_caribdis();
}
