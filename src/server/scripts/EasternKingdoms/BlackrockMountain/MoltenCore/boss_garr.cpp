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
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_MASS_ERRUPTION                = 0,
};

enum Spells
{
    // Garr
    SPELL_ANTIMAGIC_PULSE               = 19492,    // Dispels magic on nearby enemies, removing 1 beneficial spell
    SPELL_MAGMA_SHACKLES                = 19496,    // Reduces the movement speed of nearby enemies by 60%
    SPELL_SEPARATION_ANXIETY            = 23487,    // Aura cast on himself by Garr, if adds move out of range, they will cast spell 23492 on themselves (server side)
    SPELL_FRENZY                        = 19516,    // Increases the caster's attack speed by 9 + scale. Stacks up to 10 times

    // Fireworn
    SPELL_SEPARATION_ANXIETY_MINION     = 23492,    // Increases damage done by 300% and applied banish immunity
    SPELL_ERUPTION                      = 19497,    // Deals fire aoe damage and knockbacks nearby enemies
    SPELL_MASSIVE_ERUPTION              = 20483,    // Deals fire aoe damage, knockbacks nearby enemies and kills caster
    SPELL_ERUPTION_TRIGGER              = 20482,    // Removes banish auras and applied immunity to banish (server side)
    SPELL_ENRAGE_TRIGGER                = 19515,    // Server side. Triggers 19516 on hit
};

enum Events
{
    EVENT_ANTIMAGIC_PULSE               = 1,
    EVENT_MAGMA_SHACKLES,
};

class boss_garr : public CreatureScript
{
public:
    boss_garr() : CreatureScript("boss_garr") {}

    struct boss_garrAI : public BossAI
    {
        boss_garrAI(Creature* creature) : BossAI(creature, DATA_GARR),
            massEruptionTimer(600000)   // 10 mins
        {
        }

        void Reset() override
        {
            _Reset();
            massEruptionTimer = 600000;
        }

        void JustEngagedWith(Unit* /*attacker*/) override
        {
            _JustEngagedWith();
            DoCastSelf(SPELL_SEPARATION_ANXIETY, true);
            events.ScheduleEvent(EVENT_ANTIMAGIC_PULSE, 15s);
            events.ScheduleEvent(EVENT_MAGMA_SHACKLES, 10s);
            massEruptionTimer = 600000; // 10 mins
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            // This should always process
            if (massEruptionTimer <= diff)
            {
                Talk(EMOTE_MASS_ERRUPTION, me);
                DoCastAOE(SPELL_ERUPTION_TRIGGER, true);
                massEruptionTimer = 20000;
            }
            else
            {
                massEruptionTimer -= diff;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ANTIMAGIC_PULSE:
                    {
                        DoCastSelf(SPELL_ANTIMAGIC_PULSE);
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_MAGMA_SHACKLES:
                    {
                        DoCastSelf(SPELL_MAGMA_SHACKLES);
                        events.RepeatEvent(15000);
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 massEruptionTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_garrAI>(creature);
    }
};

class npc_garr_firesworn : public CreatureScript
{
public:
    npc_garr_firesworn() : CreatureScript("npc_garr_firesworn") {}

    struct npc_garr_fireswornAI : public ScriptedAI
    {
        npc_garr_fireswornAI(Creature* creature) : ScriptedAI(creature) {}

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/ ) override
        {
            if (damage >= me->GetHealth())
            {
                // Prevent double damage because Firesworn can kill himself with Massive Erruption
                if (me != attacker)
                {
                    DoCastSelf(SPELL_ERUPTION, true);
                }

                DoCastAOE(SPELL_ENRAGE_TRIGGER);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_garr_fireswornAI>(creature);
    }
};

// 23487 Separation Anxiety (server side)
class spell_garr_separation_anxiety_aura : public AuraScript
{
    PrepareAuraScript(spell_garr_separation_anxiety_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SEPARATION_ANXIETY_MINION });
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        Unit const* caster = GetCaster();
        Unit* target = GetTarget();
        if (caster && target && target->GetDistance(caster) > 40.0f && !target->HasAura(SPELL_SEPARATION_ANXIETY_MINION))
        {
            target->CastSpell(target, SPELL_SEPARATION_ANXIETY_MINION, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_garr_separation_anxiety_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

//19515 Frenzy (SERVERSIDE)
class spell_garr_frenzy : public SpellScript
{
    PrepareSpellScript(spell_garr_frenzy);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FRENZY });
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_FRENZY);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_garr_frenzy::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_garr()
{
    new boss_garr();
    new npc_garr_firesworn();

    // Spells
    RegisterSpellScript(spell_garr_separation_anxiety_aura);
    RegisterSpellScript(spell_garr_frenzy);
}
