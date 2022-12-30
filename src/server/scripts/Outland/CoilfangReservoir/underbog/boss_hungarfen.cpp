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
#include "TaskScheduler.h"
#include "the_underbog.h"

enum Spells
{
    // Hungarfen
    SPELL_SPAWN_MUSHROOMS   = 31692,
    SPELL_DESPAWN_MUSHROOMS = 34874,
    SPELL_FOUL_SPORES       = 31673,

    // Underbog Mushroom
    SPELL_SHRINK            = 31691,
    SPELL_GROW              = 31698,
    SPELL_SPORE_CLOUD       = 34168
};

enum Misc
{
    MAX_GROW_REPEAT         = 9
};

struct boss_hungarfen : public BossAI
{
    boss_hungarfen(Creature* creature) : BossAI(creature, DATA_HUNGARFEN), _foul_spores(false) { }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(20, damage) && !_foul_spores)
        {
            _foul_spores = true;
            me->AddUnitState(UNIT_STATE_ROOT);
            DoCastSelf(SPELL_FOUL_SPORES);
            _scheduler.DelayAll(11s);
            _scheduler.Schedule(11s, [this](TaskContext /*context*/)
                {
                    me->ClearUnitState(UNIT_STATE_ROOT);
                });
        }
    }

    void Reset() override
    {
        BossAI::Reset();
        _foul_spores = false;
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* who) override
    {
        // Placeholder
        BossAI::EnterCombat(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

private:
    TaskScheduler _scheduler;
    bool _foul_spores;
};

struct npc_underbog_mushroom : public ScriptedAI
{
    npc_underbog_mushroom(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        DoCastSelf(SPELL_SHRINK, true);

        _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_GROW, true);

                if (context.GetRepeatCounter() == MAX_GROW_REPEAT)
                {
                    DoCastSelf(SPELL_SPORE_CLOUD);

                    context.Schedule(4s, [this](TaskContext /*context*/)
                        {
                            me->RemoveAurasDueToSpell(SPELL_GROW);
                            me->DespawnOrUnsummon(2000);
                        });
                }
                else
                    context.Repeat();
            });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

protected:
    TaskScheduler _scheduler;
};

void AddSC_boss_hungarfen()
{
    RegisterUnderbogCreatureAI(boss_hungarfen);
    RegisterUnderbogCreatureAI(npc_underbog_mushroom);
}
