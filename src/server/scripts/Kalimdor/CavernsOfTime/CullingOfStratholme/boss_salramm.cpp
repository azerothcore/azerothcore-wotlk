/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_SHADOW_BOLT                           = 57725,
    SPELL_STEAL_FLESH_CHANNEL                   = 52708,
    SPELL_STEAL_FLESH_TARGET                    = 52711,
    SPELL_STEAL_FLESH_CASTER                    = 52712,
    SPELL_SUMMON_GHOULS                         = 52451,
    SPELL_EXPLODE_GHOUL                         = 52480,
    SPELL_CURSE_OF_TWISTED_FAITH                = 58845,
};

enum Events
{
    EVENT_SPELL_SHADOW_BOLT                     = 1,
    EVENT_SPELL_STEAL_FLESH                     = 2,
    EVENT_SPELL_SUMMON_GHOULS                   = 3,
    EVENT_EXPLODE_GHOUL                         = 4,
    EVENT_SPELL_CURSE                           = 5,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SPAWN                                   = 1,
    SAY_SLAY                                    = 2,
    SAY_DEATH                                   = 3,
    SAY_EXPLODE_GHOUL                           = 4,
    SAY_STEAL_FLESH                             = 5,
    SAY_SUMMON_GHOULS                           = 6
};

class boss_salramm : public CreatureScript
{
public:
    boss_salramm() : CreatureScript("boss_salramm") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<boss_salrammAI>(creature);
    }

    struct boss_salrammAI : public ScriptedAI
    {
        boss_salrammAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            Talk(SAY_SPAWN);
        }

        EventMap events;
        SummonList summons;
        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
        }

        void JustSummoned(Creature* cr) override { summons.Summon(cr); }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 7s);
            events.ScheduleEvent(EVENT_SPELL_STEAL_FLESH, 11s);
            events.ScheduleEvent(EVENT_SPELL_SUMMON_GHOULS, 16s);
            events.ScheduleEvent(EVENT_EXPLODE_GHOUL, 22s);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_CURSE, 25s);
        }

        void JustDied(Unit* /*killer*/) override
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (!urand(0, 1))
                return;

            Talk(SAY_SLAY);
        }

        void ExplodeGhoul()
        {
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (Creature* cr = ObjectAccessor::GetCreature(*me, (*itr)))
                    if (cr->IsAlive())
                    {
                        me->CastSpell(cr, SPELL_EXPLODE_GHOUL, false);
                        return;
                    }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_SHADOW_BOLT:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.Repeat(10s);
                    break;
                case EVENT_SPELL_STEAL_FLESH:
                    if (!urand(0, 2))
                        Talk(SAY_STEAL_FLESH);
                    me->CastSpell(me->GetVictim(), SPELL_STEAL_FLESH_CHANNEL, false);
                    events.Repeat(12s);
                    break;
                case EVENT_SPELL_SUMMON_GHOULS:
                    if (!urand(0, 2))
                        Talk(SAY_SUMMON_GHOULS);
                    me->CastSpell(me, SPELL_SUMMON_GHOULS, false);
                    events.Repeat(10s);
                    break;
                case EVENT_EXPLODE_GHOUL:
                    if (!urand(0, 2))
                        Talk(SAY_EXPLODE_GHOUL);
                    ExplodeGhoul();
                    events.Repeat(15s);
                    break;
                case EVENT_SPELL_CURSE:
                    me->CastSpell(me->GetVictim(), SPELL_CURSE_OF_TWISTED_FAITH, false);
                    events.Repeat(30s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_boss_salramm_steal_flesh_aura : public AuraScript
{
    PrepareAuraScript(spell_boss_salramm_steal_flesh_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_STEAL_FLESH_CASTER, SPELL_STEAL_FLESH_TARGET });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetUnitOwner();
        if (caster)
        {
            caster->CastSpell(caster, SPELL_STEAL_FLESH_CASTER, true);
            caster->CastSpell(target, SPELL_STEAL_FLESH_TARGET, true);
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_boss_salramm_steal_flesh_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_salramm()
{
    new boss_salramm();
    RegisterSpellScript(spell_boss_salramm_steal_flesh_aura);
}
