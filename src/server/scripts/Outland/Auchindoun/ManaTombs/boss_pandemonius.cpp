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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "mana_tombs.h"

enum Text
{
    SAY_AGGRO           = 0,
    SAY_KILL            = 1,
    SAY_DEATH           = 2,
    EMOTE_DARK_SHELL    = 3
};

enum Spells
{
    SPELL_VOID_BLAST    = 32325,
    SPELL_DARK_SHELL    = 32358
};

enum GroupPhase
{
    GROUP_PHASE_1       = 0,
    GROUP_PHASE_2       = 1
};

struct boss_pandemonius : public BossAI
{
    boss_pandemonius(Creature* creature) : BossAI(creature, DATA_PANDEMONIUS)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        VoidBlastCounter = 0;
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        scheduler.Schedule(20s, GROUP_PHASE_1, [this](TaskContext context)
        {
            if (me->IsNonMeleeSpellCast(false))
            {
                me->InterruptNonMeleeSpells(true);
            }
            Talk(EMOTE_DARK_SHELL);
            DoCastSelf(SPELL_DARK_SHELL);
            context.Repeat(20s);
        }).Schedule(8s, 23s, GROUP_PHASE_2, [this](TaskContext /*context*/)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
            {
                DoCast(target, SPELL_VOID_BLAST);
                ++VoidBlastCounter;
            }

            if (VoidBlastCounter == 5)
            {
                VoidBlastCounter = 0;
                scheduler.RescheduleGroup(GROUP_PHASE_2, 15s, 25s);
            }
            else
            {
                scheduler.RescheduleGroup(GROUP_PHASE_2, 500ms);
                scheduler.DelayGroup(GROUP_PHASE_1, 500ms);
            }
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->GetTypeId() == TYPEID_PLAYER)
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
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
    uint32 VoidBlastCounter;
};

void AddSC_boss_pandemonius()
{
    RegisterManaTombsCreatureAI(boss_pandemonius);
}
