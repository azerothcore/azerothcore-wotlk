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
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "blood_furnace.h"

enum Says
{
    SAY_WAKE                    = 0,
    SAY_ADD_AGGRO               = 1,
    SAY_KILL                    = 2,
    SAY_NOVA                    = 3,
    SAY_DIE                     = 4
};

enum Spells
{
    SPELL_CORRUPTION            = 30938,
    SPELL_EVOCATION             = 30935,
    SPELL_FIRE_NOVA             = 33132,
    SPELL_SHADOW_BOLT_VOLLEY    = 28599,
    SPELL_BURNING_NOVA          = 30940,
    SPELL_VORTEX                = 37370
};

enum Misc
{
    NPC_SHADOWMOON_CHANNELER    = 17653
};

enum Actions
{
    ACTION_CHANNELER_DIED       = 1,
    ACTION_CHANNELER_AGGRO      = 2
};

struct boss_kelidan_the_breaker : public BossAI
{
    boss_kelidan_the_breaker(Creature* creature) : BossAI(creature, DATA_KELIDAN)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        ApplyImmunities(true);
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        DoCastSelf(SPELL_EVOCATION);
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        Talk(SAY_WAKE);
        _JustEngagedWith();
        me->InterruptNonMeleeSpells(false);

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_SHADOW_BOLT_VOLLEY);
            context.Repeat(8s, 13s);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_CORRUPTION);
            context.Repeat(30s, 50s);
        }).Schedule(15s, [this](TaskContext context)
        {
            Talk(SAY_NOVA);
            ApplyImmunities(false);
            me->AddAura(SPELL_BURNING_NOVA, me);
            ApplyImmunities(true);
            if (IsHeroic())
                DoCastAOE(SPELL_VORTEX);
            scheduler.DelayGroup(0, 6s);
            scheduler.Schedule(5s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_FIRE_NOVA, true);
            });
            context.Repeat(25s, 32s);
        });
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (urand(0, 1))
            Talk(SAY_KILL);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_CHANNELER_DIED)
        {
            if (!me->FindNearestCreature(NPC_SHADOWMOON_CHANNELER, 100.0f))
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
            }
        }
        else if (param == ACTION_CHANNELER_AGGRO)
            Talk(SAY_ADD_AGGRO);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DIE);
        _JustDied();
    }

    void ApplyImmunities(bool apply)
    {
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISTRACT, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SILENCE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_BANISH, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SHACKLE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DAZE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
    }

};

void AddSC_boss_kelidan_the_breaker()
{
    RegisterBloodFurnaceCreatureAI(boss_kelidan_the_breaker);
}
