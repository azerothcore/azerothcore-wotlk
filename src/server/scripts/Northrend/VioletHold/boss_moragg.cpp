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
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "violet_hold.h"

enum eSpells
{
    SPELL_RAY_OF_SUFFERING                  = 54442,
    SPELL_RAY_OF_PAIN                       = 54438,
    SPELL_CORROSIVE_SALIVA                  = 54527,
    SPELL_OPTIC_LINK                        = 54396,
};

enum eEvents
{
    EVENT_SPELL_CORROSIVE_SALIVA = 1,
    EVENT_SPELL_OPTIC_LINK,
};

struct boss_moragg : public BossAI
{
    boss_moragg(Creature* c) : BossAI(c, BOSS_MORAGG) { }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        DoCastSelf(SPELL_RAY_OF_SUFFERING, true);
        DoCastSelf(SPELL_RAY_OF_PAIN, true);
        events.RescheduleEvent(EVENT_SPELL_CORROSIVE_SALIVA, 4s, 6s);
        events.RescheduleEvent(EVENT_SPELL_OPTIC_LINK, 10s, 11s);
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SPELL_CORROSIVE_SALIVA:
                DoCastVictim(SPELL_CORROSIVE_SALIVA);
                events.Repeat(8s, 10s);
                break;
            case EVENT_SPELL_OPTIC_LINK:
                if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, 40.0f, true))
                {
                    DoCast(target, SPELL_OPTIC_LINK);
                    events.Repeat(18s, 21s);
                }
                else
                    events.Repeat(5s);
                break;
        }
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        _EnterEvadeMode(why);
    }
};

class spell_optic_link_aura : public AuraScript
{
    PrepareAuraScript(spell_optic_link_aura);

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (Unit* target = GetTarget())
            if (Unit* caster = GetCaster())
                if (GetAura() && GetAura()->GetEffect(0))
                    GetAura()->GetEffect(0)->SetAmount(aurEff->GetSpellInfo()->Effects[EFFECT_0].BasePoints + (((int32)target->GetExactDist(caster)) * 25) + (aurEff->GetTickNumber() * 100));
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_optic_link_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

void AddSC_boss_moragg()
{
    RegisterVioletHoldCreatureAI(boss_moragg);
    RegisterSpellScript(spell_optic_link_aura);
}
