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
#include "blackrock_depths.h"

enum Spells
{
    SPELL_HEAL              = 15586,
    SPELL_RENEW             = 8362,
    SPELL_MINDBLAST         = 15587,
    SPELL_SHADOWBOLT        = 15537,
    SPELL_WORDPAIN          = 15654,
};

enum SpellTimers
{
    TIMER_HEAL          = 12000,
    TIMER_MINDBLAST     = 16000,
    TIMER_RENEW         = 12000,
    TIMER_SHADOWBOLT    = 16000,
    TIMER_WORDPAIN      = 12000,
};

struct boss_moira_bronzebeardAI : public BossAI
{
    // use a default value so we can inherit for priestess
    boss_moira_bronzebeardAI(Creature* creature, uint32 data = DATA_MOIRA) : BossAI(creature, data) {}
    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.ScheduleEvent(SPELL_MINDBLAST, 0.5 * (int) TIMER_MINDBLAST);
        events.ScheduleEvent(SPELL_HEAL, 0.5 * (int) TIMER_HEAL);
        events.ScheduleEvent(SPELL_RENEW, 0.5 * (int) TIMER_RENEW);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }
        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case SPELL_MINDBLAST:
                    DoCastVictim(SPELL_MINDBLAST);
                    events.ScheduleEvent(SPELL_MINDBLAST, urand(TIMER_MINDBLAST - 2000, TIMER_MINDBLAST + 2000));
                    break;
                case SPELL_HEAL:
                    CastOnEmperorIfPossible(SPELL_HEAL, TIMER_HEAL);
                    break;
                case SPELL_RENEW:
                    CastOnEmperorIfPossible(SPELL_RENEW, TIMER_RENEW);
                    break;
                default:
                    break;
            }
        }
        DoMeleeAttackIfReady();
    }

    void CastOnEmperorIfPossible(uint32 spell, uint32 timer)
    {
        Creature* emperor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EMPEROR));
        if (emperor && emperor->HealthBelowPct(90))
        {
            DoCast(emperor, spell);
        }
        else if (HealthBelowPct(90))
        {
            DoCastSelf(spell);
        }
        events.ScheduleEvent(spell, urand(timer - 2000, timer + 2000));
    }
};

// high priestess should be fairly identical to Moira.
// Running away when emperor dies is handled through GUID from emperor, therefore not relevant here.
struct boss_high_priestess_thaurissanAI : public boss_moira_bronzebeardAI
{
    boss_high_priestess_thaurissanAI(Creature* creature) : boss_moira_bronzebeardAI(creature, DATA_PRIESTESS) {}

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        Talk(0);
        events.ScheduleEvent(SPELL_WORDPAIN, 0.5 * (int)TIMER_WORDPAIN);
        events.ScheduleEvent(SPELL_HEAL, 0.5 * (int) TIMER_HEAL);
        events.ScheduleEvent(SPELL_RENEW, 0.5 * (int) TIMER_RENEW);
        events.ScheduleEvent(SPELL_SHADOWBOLT, 0.5 * (int) TIMER_SHADOWBOLT);
    }

        void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }
        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case SPELL_WORDPAIN:
                DoCastVictim(SPELL_WORDPAIN);
                events.ScheduleEvent(SPELL_WORDPAIN, urand(TIMER_WORDPAIN - 2000, TIMER_WORDPAIN + 2000));
                break;
            case SPELL_HEAL:
                CastOnEmperorIfPossible(SPELL_HEAL, TIMER_HEAL);
                break;
            case SPELL_RENEW:
                CastOnEmperorIfPossible(SPELL_RENEW, TIMER_RENEW);
                break;
            case SPELL_SHADOWBOLT:
                DoCastVictim(SPELL_SHADOWBOLT);
                events.ScheduleEvent(SPELL_SHADOWBOLT, urand(TIMER_SHADOWBOLT - 2000, TIMER_SHADOWBOLT + 2000));
                break;
            default:
                break;
            }
        }
        DoMeleeAttackIfReady();
    }
};

class boss_moira_bronzebeard : public CreatureScript
{
public:
    boss_moira_bronzebeard() : CreatureScript("boss_moira_bronzebeard") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_moira_bronzebeardAI>(creature);
    }
};

class boss_high_priestess_thaurissan : public CreatureScript
{
public:
    boss_high_priestess_thaurissan() : CreatureScript("boss_high_priestess_thaurissan") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_high_priestess_thaurissanAI>(creature);
    }
};

void AddSC_boss_moira_bronzebeard()
{
    new boss_moira_bronzebeard();
}

void AddSC_boss_high_priestess_thaurissan()
{
    new boss_high_priestess_thaurissan();
}
