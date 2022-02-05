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
#include "SpellScript.h"
#include "ruins_of_ahnqiraj.h"

enum Yells
{
    // The time of our retribution is at hand! Let darkness reign in the hearts of our enemies! Sound: 8645 Emote: 35
    SAY_ANDOROV_INTRO         = 0,   // Before for the first wave
    SAY_ANDOROV_ATTACK        = 1,   // Beginning the event

    SAY_WAVE3                 = 0,
    SAY_WAVE4                 = 1,
    SAY_WAVE5                 = 2,
    SAY_WAVE6                 = 3,
    SAY_WAVE7                 = 4,
    SAY_INTRO                 = 5,
    SAY_UNK1                  = 6,
    SAY_UNK2                  = 7,
    SAY_UNK3                  = 8,
    SAY_DEATH                 = 9,
    SAY_CHANGEAGGRO           = 10,
    SAY_KILLS_ANDOROV         = 11,
    SAY_COMPLETE_QUEST        = 12    // Yell when realm complete quest 8743 for world event
                                // Warriors, Captains, continue the fight! Sound: 8640
};

enum Spells
{
    SPELL_DISARM            = 6713,
    SPELL_FRENZY            = 8269,
    SPELL_THUNDERCRASH      = 25599
};

enum Events
{
    EVENT_DISARM            = 1,        // 03:58:27, 03:58:49
    EVENT_THUNDERCRASH      = 2,        // 03:58:29, 03:58:50
    EVENT_CHANGE_AGGRO      = 3,
};

class boss_rajaxx : public CreatureScript
{
public:
    boss_rajaxx() : CreatureScript("boss_rajaxx") { }

    struct boss_rajaxxAI : public BossAI
    {
        boss_rajaxxAI(Creature* creature) : BossAI(creature, DATA_RAJAXX)
        {
        }

        void Reset() override
        {
            _Reset();
            enraged = false;
            events.ScheduleEvent(EVENT_DISARM, 10000);
            events.ScheduleEvent(EVENT_THUNDERCRASH, 12000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            //SAY_DEATH
            _JustDied();
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
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
                    case EVENT_DISARM:
                        DoCastVictim(SPELL_DISARM);
                        events.ScheduleEvent(EVENT_DISARM, 22000);
                        break;
                    case EVENT_THUNDERCRASH:
                        DoCast(me, SPELL_THUNDERCRASH);
                        events.ScheduleEvent(EVENT_THUNDERCRASH, 21000);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    private:
        bool enraged;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRuinsOfAhnQirajAI<boss_rajaxxAI>(creature);
    }
};

class spell_rajaxx_thundercrash : public SpellScript
{
    PrepareSpellScript(spell_rajaxx_thundercrash);

    void HandleDamageCalc(SpellEffIndex /*effIndex*/)
    {
        int32 damage = GetHitUnit()->GetHealth() / 2;
        if (damage < 200)
        {
            damage = 200;
        }

        SetHitDamage(damage);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_rajaxx_thundercrash::HandleDamageCalc, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_boss_rajaxx()
{
    new boss_rajaxx();
    RegisterSpellScript(spell_rajaxx_thundercrash);
}
