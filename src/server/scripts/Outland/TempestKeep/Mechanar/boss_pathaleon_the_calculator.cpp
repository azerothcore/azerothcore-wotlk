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
#include "mechanar.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_DOMINATION                  = 1,
    SAY_SUMMON                      = 2,
    SAY_ENRAGE                      = 3,
    SAY_SLAY                        = 4,
    SAY_DEATH                       = 5,
    SAY_APPEAR                      = 6
};

enum Spells
{
    SPELL_ARCANE_EXPLOSION          = 15453,
    SPELL_DISGRUNTLED_ANGER         = 35289,
    SPELL_ARCANE_TORRENT            = 36022,
    SPELL_MANA_TAP                  = 36021,
    SPELL_DOMINATION                = 35280,
    SPELL_SUMMON_NETHER_WRAITH_1    = 35285,
    SPELL_SUMMON_NETHER_WRAITH_2    = 35286,
    SPELL_SUMMON_NETHER_WRAITH_3    = 35287,
    SPELL_SUMMON_NETHER_WRAITH_4    = 35288,
};

struct boss_pathaleon_the_calculator : public BossAI
{
    boss_pathaleon_the_calculator(Creature* creature) : BossAI(creature, DATA_PATHALEON_THE_CALCULATOR)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        ScheduleHealthCheckEvent(20, [&]()
        {
            summons.DespawnAll();
            DoCastSelf(SPELL_DISGRUNTLED_ANGER, true);
            Talk(SAY_ENRAGE);
        });

        scheduler.Schedule(30s, [this](TaskContext context)
        {
            for (uint8 i = 0; i < DUNGEON_MODE(3, 4); ++i)
                me->CastSpell(me, SPELL_SUMMON_NETHER_WRAITH_1 + i, true);

            Talk(SAY_SUMMON);
            context.Repeat(30s, 40s);
        }).Schedule(12s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
            {
                DoCast(target, SPELL_MANA_TAP);
            }
            context.Repeat(18s);
        }).Schedule(16s, [this](TaskContext context)
        {
            me->RemoveAurasDueToSpell(SPELL_MANA_TAP);
            me->ModifyPower(POWER_MANA, 5000);
            DoCastSelf(SPELL_ARCANE_TORRENT);
            context.Repeat(15s);
        }).Schedule(25s, [this](TaskContext context)
        {
            Talk(SAY_DOMINATION);
            DoCastRandomTarget(SPELL_DOMINATION, 1, 50.0f);
            context.Repeat(30s);
        }).Schedule(8s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ARCANE_EXPLOSION);
            context.Repeat(12s);
        });

        Talk(SAY_AGGRO);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_pathaleon_the_calculator()
{
    RegisterMechanarCreatureAI(boss_pathaleon_the_calculator);
}
