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

enum Texts
{
    SAY_AGGRO           = 0,
    SAY_KILL            = 1,
    SAY_DEATH           = 2,
    EMOTE_DARK_SHELL    = 3
};

enum Spells
{
    SPELL_VOID_BLAST = 32325,
    SPELL_DARK_SHELL = 32358
};

enum Groups
{
    GROUP_VOID_BLAST = 1
};

constexpr uint8 MAX_VOID_BLAST = 5;

struct boss_pandemonius : public BossAI
{
    boss_pandemonius(Creature* creature) : BossAI(creature, DATA_PANDEMONIUS)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);

        scheduler.
            Schedule(20s, GROUP_VOID_BLAST, [this](TaskContext context)
            {
                if (me->IsNonMeleeSpellCast(false))
                {
                    me->InterruptNonMeleeSpells(true);
                }

                Talk(EMOTE_DARK_SHELL);
                DoCastSelf(SPELL_DARK_SHELL);
                context.Repeat();
            })
            .Schedule(8s, 23s, [this](TaskContext context)
                {
                    if (!(context.GetRepeatCounter() % (MAX_VOID_BLAST + 1)))
                    {
                        context.Repeat(15s, 25s);
                    }
                    else
                    {
                        DoCastRandomTarget(SPELL_VOID_BLAST);
                        context.Repeat(500ms);
                        context.DelayGroup(GROUP_VOID_BLAST, 500ms);
                    }
                });

        BossAI::JustEngagedWith(who);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->GetTypeId() == TYPEID_PLAYER)
            Talk(SAY_KILL);
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }
};

void AddSC_boss_pandemonius()
{
    RegisterManaTombsCreatureAI(boss_pandemonius);
}
