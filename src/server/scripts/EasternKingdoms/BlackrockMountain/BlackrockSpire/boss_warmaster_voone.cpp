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

#include "blackrock_spire.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_THRASH                    = 3391,
    SPELL_SNAPKICK                  = 15618,
    SPELL_CLEAVE                    = 15284,
    SPELL_UPPERCUT                  = 10966,
    SPELL_MORTALSTRIKE              = 16856,
    SPELL_PUMMEL                    = 15615,
    SPELL_THROWAXE                  = 16075
};

enum Events
{
    EVENT_SNAP_KICK                 = 1,
    EVENT_CLEAVE,
    EVENT_UPPERCUT,
    EVENT_MORTAL_STRIKE,
    EVENT_PUMMEL,
    EVENT_THROW_AXE,
    EVENT_THRASH
};

enum Phases
{
    PHASE_THRASHER,
    PHASE_BRAWLER,
    PHASE_WARMASTER,

    GROUP_NONE = 0
};

class boss_warmaster_voone : public CreatureScript
{
public:
    boss_warmaster_voone() : CreatureScript("boss_warmaster_voone") { }

    struct boss_warmastervooneAI : public BossAI
    {
        boss_warmastervooneAI(Creature* creature) : BossAI(creature, DATA_WARMASTER_VOONE) { }

        void Reset() override
        {
            _Reset();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();

            events.SetPhase(PHASE_BRAWLER);
            events.ScheduleEvent(EVENT_THRASH, 3 * IN_MILLISECONDS, GROUP_NONE, PHASE_BRAWLER);
            events.ScheduleEvent(EVENT_THROW_AXE, 1 * IN_MILLISECONDS, GROUP_NONE, PHASE_BRAWLER);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
        {
            if (me->HealthBelowPctDamaged(65, damage) && events.IsInPhase(PHASE_BRAWLER))
            {
                events.SetPhase(PHASE_THRASHER);
                events.ScheduleEvent(EVENT_CLEAVE, 14 * IN_MILLISECONDS, GROUP_NONE, PHASE_THRASHER);
                events.ScheduleEvent(EVENT_MORTAL_STRIKE, 12 * IN_MILLISECONDS, GROUP_NONE, PHASE_THRASHER);
            }
            else if (me->HealthBelowPctDamaged(40, damage) && events.IsInPhase(PHASE_THRASHER))
            {
                events.SetPhase(PHASE_WARMASTER);
                events.ScheduleEvent(EVENT_SNAP_KICK, 8 * IN_MILLISECONDS, GROUP_NONE, PHASE_WARMASTER);
                events.ScheduleEvent(EVENT_UPPERCUT, 20 * IN_MILLISECONDS, GROUP_NONE, PHASE_WARMASTER);
                events.ScheduleEvent(EVENT_PUMMEL, 32 * IN_MILLISECONDS, GROUP_NONE, PHASE_WARMASTER);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SNAP_KICK:
                        DoCastVictim(SPELL_SNAPKICK);
                        events.ScheduleEvent(EVENT_SNAP_KICK, 6 * IN_MILLISECONDS, GROUP_NONE, PHASE_WARMASTER);
                        break;
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 12 * IN_MILLISECONDS, GROUP_NONE, PHASE_THRASHER);
                        break;
                    case EVENT_UPPERCUT:
                        DoCastVictim(SPELL_UPPERCUT);
                        events.ScheduleEvent(EVENT_UPPERCUT, 14 * IN_MILLISECONDS, GROUP_NONE, PHASE_WARMASTER);
                        break;
                    case EVENT_MORTAL_STRIKE:
                        DoCastVictim(SPELL_MORTALSTRIKE);
                        events.ScheduleEvent(EVENT_MORTAL_STRIKE, 10 * IN_MILLISECONDS, GROUP_NONE, PHASE_THRASHER);
                        break;
                    case EVENT_PUMMEL:
                        DoCastVictim(SPELL_PUMMEL);
                        events.ScheduleEvent(EVENT_MORTAL_STRIKE, 16 * IN_MILLISECONDS, GROUP_NONE, PHASE_WARMASTER);
                        break;
                    case EVENT_THROW_AXE:
                        DoCastRandomTarget(SPELL_THROWAXE);
                        events.ScheduleEvent(EVENT_THROW_AXE, 8 * IN_MILLISECONDS, GROUP_NONE, PHASE_BRAWLER);
                        break;
                    case EVENT_THRASH:
                        DoCastSelf(SPELL_THRASH);
                        events.ScheduleEvent(EVENT_THRASH, 10 * IN_MILLISECONDS, GROUP_NONE, PHASE_BRAWLER);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_warmastervooneAI>(creature);
    }
};

void AddSC_boss_warmastervoone()
{
    new boss_warmaster_voone();
}
