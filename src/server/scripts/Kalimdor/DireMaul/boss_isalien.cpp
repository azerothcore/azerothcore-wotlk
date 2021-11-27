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
#include "dire_maul.h"
#include "TaskScheduler.h"

enum Texts
{
    SAY_DEATH = 0
};

enum Spells
{
    SPELL_CALL_EMPYREAN = 27639,
    SPELL_SHOOT         = 22907,
    SPELL_MULTI_SHOT    = 14443,
    SPELL_NET           = 12024,
    SPELL_STARSHARDS    = 27636,
    SPELL_REGROWTH      = 27637
};

enum Phases
{
    PHASE_NONE = 0,
    PHASE_REGROWTH
};

class boss_isalien : public CreatureScript
{
public:
    boss_isalien() : CreatureScript("boss_isalien") { }

    struct boss_isalienAI : public BossAI
    {
        boss_isalienAI(Creature* creature) : BossAI(creature, DATA_ISALIEN) { }

        void Reset() override
        {
            _Reset();
            _scheduler.CancelAll();
            summons.DespawnAll();
            _phase = PHASE_NONE;

            _scheduler.SetValidator([this]
                {
                    return me->HasUnitState(UNIT_STATE_CASTING);
                });
        }

        void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
        {
            if (_phase != PHASE_REGROWTH && me->HealthBelowPct(80.f))
            {
                _phase = PHASE_REGROWTH;
                _scheduler.Schedule(25s, 30s, [this](TaskContext context)
                    {
                        DoCastSelf(SPELL_REGROWTH);
                        context.Repeat(25s, 30s);
                    });
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            _scheduler.Schedule(3s, 4s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_SHOOT);
                    context.Repeat(3s, 4s);
                })
            .Schedule(7s, 12s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_MULTI_SHOT);
                    context.Repeat(7s, 12s);
                })
            .Schedule(4s, 5s, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_NET);
                    context.Repeat(12s, 15s);
                })
            .Schedule(20s, 30s, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_STARSHARDS);
                    context.Repeat(20s, 30s);
                })
            .Schedule(8s, 10s, [this](TaskContext /*context*/)
                {
                    DoCastAOE(SPELL_CALL_EMPYREAN);
                }
            );
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            _scheduler.Update(diff, [this]
                {
                    DoMeleeAttackIfReady();
                });
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        protected:
            TaskScheduler _scheduler;
            uint8 _phase;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetDireMaulAI<boss_isalienAI>(creature);
    }
};

void AddSC_boss_isalien()
{
    new boss_isalien();
}
