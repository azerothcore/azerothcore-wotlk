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
#include "old_hillsbrad.h"

enum Text
{
    SAY_AGGRO                    = 5,
    SAY_SLAY                     = 6,
    SAY_BREATH                   = 7,
    SAY_DEATH                    = 8
};

enum Spells
{
    SPELL_SAND_BREATH            = 31914,
    SPELL_IMPENDING_DEATH        = 31916,
    SPELL_MAGIC_DISRUPTION_AURA  = 33834,
    SPELL_WING_BUFFET            = 31475
};

struct boss_epoch_hunter : public BossAI
{
    boss_epoch_hunter(Creature* creature) : BossAI(creature, DATA_EPOCH_HUNTER) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        scheduler.Schedule(8s, [this](TaskContext context)
        {
            if (roll_chance_i(50))
            {
                Talk(SAY_BREATH);
            }
            DoCastVictim(SPELL_SAND_BREATH);
            context.Repeat(20s);
        }).Schedule(2s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_IMPENDING_DEATH);
            context.Repeat(30s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_MAGIC_DISRUPTION_AURA);
            context.Repeat(30s);
        }).Schedule(14s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_WING_BUFFET);
            context.Repeat(30s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_SLAY);
    }

    void JustDied(Unit* killer) override
    {
        if (killer && killer == me)
            return;

        _JustDied();
        Talk(SAY_DEATH);
        me->GetInstanceScript()->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_EPOCH_KILLED);
        if (Creature* taretha = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(DATA_TARETHA_GUID)))
        {
            taretha->AI()->DoAction(me->GetEntry());
        }
    }
};

void AddSC_boss_epoch_hunter()
{
    RegisterOldHillsbradCreatureAI(boss_epoch_hunter);
}
