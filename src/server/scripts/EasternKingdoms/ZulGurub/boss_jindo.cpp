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
#include "SpellScript.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Say
{
    SAY_AGGRO                       = 1
};

enum Spells
{
    SPELL_BRAIN_WASH_TOTEM          = 24262,
    SPELL_POWERFULL_HEALING_WARD    = 24309,
    SPELL_HEX                       = 24053,
    SPELL_DELUSIONS_OF_JINDO        = 24306,
    SPELL_SUMMON_SHADE_OF_JINDO     = 24308,
    SPELL_BANISH                    = 24466,

    //Healing Ward Spell
    SPELL_HEAL                      = 24311,

    //Shade of Jindo Spell
    SPELL_SHADE_OF_JINDO_PASSIVE    = 24307,
    SPELL_SHADE_OF_JINDO_VISUAL     = 24313,
    SPELL_SHADOW_SHOCK              = 19460,
    SPELL_RANDOM_AGGRO              = 23878
};

enum Events
{
    EVENT_BRAIN_WASH_TOTEM          = 1,
    EVENT_POWERFULL_HEALING_WARD    = 2,
    EVENT_HEX                       = 3,
    EVENT_DELUSIONS_OF_JINDO        = 4,
    EVENT_TELEPORT                  = 5
};

struct boss_jindo : public BossAI
{
    boss_jindo(Creature* creature) : BossAI(creature, DATA_JINDO) { }

    void Reset() override
    {
        _Reset();
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.ScheduleEvent(EVENT_BRAIN_WASH_TOTEM, 20000);
        events.ScheduleEvent(EVENT_POWERFULL_HEALING_WARD, 16000);
        events.ScheduleEvent(EVENT_HEX, 8000);
        events.ScheduleEvent(EVENT_DELUSIONS_OF_JINDO, 10000);
        events.ScheduleEvent(EVENT_TELEPORT, 5000);
        Talk(SAY_AGGRO);
    }

    void JustSummoned(Creature* summon) override
    {
        BossAI::JustSummoned(summon);

        switch (summon->GetEntry())
        {
        case NPC_BRAIN_WASH_TOTEM:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
            {
                summon->CastSpell(target, summon->m_spells[0], true);
            }
            break;
        default:
            break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_BRAIN_WASH_TOTEM:
                DoCastSelf(SPELL_BRAIN_WASH_TOTEM);
                events.ScheduleEvent(EVENT_BRAIN_WASH_TOTEM, urand(18000, 26000));
                break;
            case EVENT_POWERFULL_HEALING_WARD:
                DoCastSelf(SPELL_POWERFULL_HEALING_WARD, true);
                events.ScheduleEvent(EVENT_POWERFULL_HEALING_WARD, urand(14000, 20000));
                break;
            case EVENT_HEX:
                if (me->GetThreatMgr().getThreatList().size() > 1)
                    DoCastVictim(SPELL_HEX, true);
                events.ScheduleEvent(EVENT_HEX, urand(12000, 20000));
                break;
            case EVENT_DELUSIONS_OF_JINDO:
                DoCastRandomTarget(SPELL_DELUSIONS_OF_JINDO);
                events.ScheduleEvent(EVENT_DELUSIONS_OF_JINDO, urand(4000, 12000));
                break;
            case EVENT_TELEPORT:
                DoCastRandomTarget(SPELL_BANISH);
                events.ScheduleEvent(EVENT_TELEPORT, urand(15000, 23000));
                break;
            default:
                break;
            }
        }

        DoMeleeAttackIfReady();
    }

    bool CanAIAttack(Unit const* target) const override
    {
        if (me->GetThreatMgr().getThreatList().size() > 1 && me->GetThreatMgr().getOnlineContainer().getMostHated()->getTarget() == target)
            return !target->HasAura(SPELL_HEX);

        return true;
    }
};

//Healing Ward
struct npc_healing_ward : public ScriptedAI
{
    npc_healing_ward(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _scheduler.
            Schedule(2s, [this](TaskContext context)
            {
                Unit* pJindo = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(DATA_JINDO));
                if (pJindo)
                    DoCast(pJindo, SPELL_HEAL);
                context.Repeat(3s);
            });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

private:
    InstanceScript* _instance;
    TaskScheduler _scheduler;
};

//Shade of Jindo
struct npc_shade_of_jindo : public ScriptedAI
{
    npc_shade_of_jindo(Creature* creature) : ScriptedAI(creature) { }

    void IsSummonedBy(Unit* /*summoner*/) override
    {
        DoZoneInCombat();
        DoCastSelf(SPELL_SHADE_OF_JINDO_PASSIVE, true);
        DoCastSelf(SPELL_SHADE_OF_JINDO_VISUAL, true);
        DoCastAOE(SPELL_RANDOM_AGGRO, true);
    }

    void Reset() override
    {
        _scheduler.CancelAll();

        _scheduler.
            Schedule(1s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_RANDOM_AGGRO, true);
                context.Repeat();
            });
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _scheduler.
            Schedule(1s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SHADOW_SHOCK);
                context.Repeat(2s);
            });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

private:
    TaskScheduler _scheduler;
};

class spell_random_aggro : public SpellScript
{
    PrepareSpellScript(spell_random_aggro);

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!caster || !target || !caster->GetAI())
            return;

        caster->GetAI()->AttackStart(target);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_random_aggro::HandleOnHit);
    }
};

class spell_delusions_of_jindo : public SpellScript
{
    PrepareSpellScript(spell_delusions_of_jindo);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_SHADE_OF_JINDO });
    }

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        if (caster)
            caster->CastSpell(caster, SPELL_SUMMON_SHADE_OF_JINDO, true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_delusions_of_jindo::HandleOnHit);
    }
};

void AddSC_boss_jindo()
{
    RegisterZulGurubCreatureAI(boss_jindo);
    RegisterZulGurubCreatureAI(npc_healing_ward);
    RegisterZulGurubCreatureAI(npc_shade_of_jindo);
    RegisterSpellScript(spell_random_aggro);
    RegisterSpellScript(spell_delusions_of_jindo);
}
