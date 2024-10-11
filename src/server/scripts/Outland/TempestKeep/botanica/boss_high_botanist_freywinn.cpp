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
#include "the_botanica.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_TREE                    = 2,
    SAY_SUMMON                  = 3,
    SAY_DEATH                   = 4,
    SAY_OOC_RANDOM              = 5
};

enum Spells
{
    SPELL_TRANQUILITY           = 34550,
    SPELL_TREE_FORM             = 34551,
    SPELL_SUMMON_FRAYER         = 34557,
    SPELL_PLANT_WHITE           = 34759,
    SPELL_PLANT_GREEN           = 34761,
    SPELL_PLANT_BLUE            = 34762,
    SPELL_PLANT_RED             = 34763
};

enum Npcs
{
    NPC_FRAYER                  = 19953
};

struct boss_high_botanist_freywinn : public BossAI
{
    boss_high_botanist_freywinn(Creature* creature) : BossAI(creature, DATA_HIGH_BOTANIST_FREYWINN) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.ClearValidator();

        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            if (roll_chance_i(20))
            {
                Talk(SAY_OOC_RANDOM);
            }

            DoCastAOE(RAND(SPELL_PLANT_WHITE, SPELL_PLANT_GREEN, SPELL_PLANT_BLUE, SPELL_PLANT_RED));
            context.Repeat();
        }).Schedule(30s, [this](TaskContext context)
        {
            scheduler.CancelAll();

            Talk(SAY_TREE);
            me->RemoveAllAuras();
            me->GetMotionMaster()->MoveIdle();
            me->GetMotionMaster()->Clear(false);

            DoCastSelf(SPELL_SUMMON_FRAYER, true);
            DoCastSelf(SPELL_TRANQUILITY, true);
            DoCastSelf(SPELL_TREE_FORM, true);

            scheduler.Schedule(45s, [this](TaskContext)
            {
                ResumeEncounter();
            });

            context.Repeat(75s);
        });
    }

    void ResumeEncounter()
    {
        me->GetMotionMaster()->MoveChase(me->GetVictim());
        me->RemoveAurasDueToSpell(SPELL_TREE_FORM);
        me->InterruptNonMeleeSpells(false);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);

        if (!summons.HasEntry(NPC_FRAYER))
        {
            ResumeEncounter();
        }
    }
};

void AddSC_boss_high_botanist_freywinn()
{
    RegisterTheBotanicaCreatureAI(boss_high_botanist_freywinn);
}
