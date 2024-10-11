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
#include "InstanceScript.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "stratholme.h"

enum Spells
{
    SPELL_BANSHEEWAIL           = 16565,
    SPELL_BANSHEECURSE          = 16867,
    SPELL_SILENCE               = 18327,
    SPELL_POSSESS               = 17244,    // the charm on player
    SPELL_POSSESSED             = 17246,    // the damage debuff on player
    SPELL_POSSESS_INV           = 17250     // baroness becomes invisible while possessing a target
};

class boss_baroness_anastari : public CreatureScript
{
public:
    boss_baroness_anastari() : CreatureScript("boss_baroness_anastari") { }

    struct boss_baroness_anastariAI : public BossAI
    {
        boss_baroness_anastariAI(Creature* creature) : BossAI(creature, TYPE_ZIGGURAT1)
        {
        }

        void Reset() override
        {
            _possessedTargetGuid.Clear();

            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSSESS);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSSESSED);
            me->RemoveAurasDueToSpell(SPELL_POSSESS_INV);

            _scheduler.CancelAll();

            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _scheduler.Schedule(1s, [this](TaskContext context){
                DoCastVictim(SPELL_BANSHEEWAIL);
                context.Repeat(4s);
            })
            .Schedule(11s, [this](TaskContext context){
                DoCastVictim(SPELL_BANSHEECURSE);
                context.Repeat(18s);
            })
            .Schedule(13s, [this](TaskContext context){
                DoCastVictim(SPELL_SILENCE);
                context.Repeat(13s);
            });

            SchedulePossession();
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(TYPE_ZIGGURAT1, IN_PROGRESS);
        }

        void SchedulePossession()
        {
            _scheduler.Schedule(20s, 30s, [this](TaskContext context){
                if (Unit* possessTarget = SelectTarget(SelectTargetMethod::Random, 1, 0, true, false))
                {
                    DoCast(possessTarget, SPELL_POSSESS, true);
                    DoCast(possessTarget, SPELL_POSSESSED, true);
                    DoCastSelf(SPELL_POSSESS_INV, true);
                    _possessedTargetGuid = possessTarget->GetGUID();

                    // We must keep track of the possessed player, the aura falls off when their health drops below 50%.
                    // The encounter resumes when the aura falls off.
                    _scheduler.Schedule(1s, [this](TaskContext possessionContext) {
                        if (Player* possessedTarget = ObjectAccessor::GetPlayer(*me, _possessedTargetGuid))
                        {
                            if (!possessedTarget->HasAura(SPELL_POSSESSED) || possessedTarget->HealthBelowPct(50))
                            {
                                possessedTarget->RemoveAurasDueToSpell(SPELL_POSSESS);
                                possessedTarget->RemoveAurasDueToSpell(SPELL_POSSESSED);
                                me->RemoveAurasDueToSpell(SPELL_POSSESS_INV);
                                _possessedTargetGuid.Clear();
                                SchedulePossession();
                            }
                            else
                            {
                                possessionContext.Repeat(1s);
                            }
                        }
                    });
                }
                else
                {
                    // No valid possession targets found, retry.
                    context.Repeat(1s);
                }
            });
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            _scheduler.Update(diff,
                std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
        }

    private:
        ObjectGuid _possessedTargetGuid;
        TaskScheduler _scheduler;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetStratholmeAI<boss_baroness_anastariAI>(creature);
    }
};

void AddSC_boss_baroness_anastari()
{
    new boss_baroness_anastari;
}
