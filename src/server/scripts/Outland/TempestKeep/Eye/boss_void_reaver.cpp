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
#include "the_eye.h"

enum voidReaver
{
    SAY_AGGRO                   = 0,
    SAY_SLAY                    = 1,
    SAY_DEATH                   = 2,
    SAY_POUNDING                = 3,

    SPELL_POUNDING              = 34162,
    SPELL_ARCANE_ORB            = 34172,
    SPELL_KNOCK_AWAY            = 25778,
    SPELL_BERSERK               = 26662
};

enum Groups
{
    GROUP_ARCANE_ORB            = 1
};

struct boss_void_reaver : public BossAI
{
    boss_void_reaver(Creature* creature) : BossAI(creature, DATA_REAVER)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        me->ApplySpellImmune(0, IMMUNITY_DISPEL, DISPEL_POISON, true);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEALTH_LEECH, true);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_POWER_DRAIN, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_LEECH, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_MANA_LEECH, true);
    }

    void Reset() override
    {
        BossAI::Reset();
        _recentlySpoken = false;
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;
            scheduler.Schedule(5s, [this](TaskContext)
            {
                _recentlySpoken = false;
            });
        }
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        me->CallForHelp(105.0f);

        scheduler.Schedule(10min, [this](TaskContext)
        {
            DoCastSelf(SPELL_BERSERK);
        }).Schedule(8300ms, [this](TaskContext context)
        {
            Talk(SAY_POUNDING);
            DoCastSelf(SPELL_POUNDING);
            scheduler.DelayGroup(GROUP_ARCANE_ORB, 3s);
            context.Repeat(12100ms, 15800ms);
        }).Schedule(3450ms, GROUP_ARCANE_ORB, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, -18.0f, true))
                me->CastSpell(target, SPELL_ARCANE_ORB, false);
            else if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 20.0f, true))
                me->CastSpell(target, SPELL_ARCANE_ORB, false);
            context.Repeat(2400ms, 6300ms);
        }).Schedule(14350ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_KNOCK_AWAY);
            context.Repeat(20550ms, 22550ms);
        });
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->GetDistance2d(432.59f, 371.93f) > 105.0f;
    }

    private:
        bool _recentlySpoken;
};

void AddSC_boss_void_reaver()
{
    RegisterTheEyeAI(boss_void_reaver);
}
