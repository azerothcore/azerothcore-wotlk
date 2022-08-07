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

#include "CreatureTextMgr.h"
#include "GameObjectAI.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "ruins_of_ahnqiraj.h"

enum Spells
{
    SPELL_MORTAL_WOUND      = 25646,
    SPELL_SAND_TRAP         = 25648,
    SPELL_ENRAGE            = 26527,
    SPELL_SUMMON_PLAYER     = 26446,
    SPELL_WIDE_SLASH        = 25814
};

enum Events
{
    EVENT_MORTAL_WOUND      = 1,
    EVENT_SAND_TRAP         = 2,
    EVENT_WIDE_SLASH        = 3
};

enum Texts
{
    SAY_KURINNAXX_DEATH     = 5 // Yell by 'Ossirian the Unscarred'
};

struct boss_kurinnaxx : public BossAI
{
    boss_kurinnaxx(Creature* creature) : BossAI(creature, DATA_KURINNAXX) {}

    void Reset() override
    {
        BossAI::Reset();
        _enraged = false;
        events.ScheduleEvent(EVENT_MORTAL_WOUND, 8s, 10s);
        events.ScheduleEvent(EVENT_SAND_TRAP, 5s, 15s);
        events.ScheduleEvent(EVENT_WIDE_SLASH, 10s, 15s);
    }

    void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
    {
        if (!_enraged && HealthBelowPct(30))
        {
            DoCastSelf(SPELL_ENRAGE);
            _enraged = true;
        }
    }

    void JustDied(Unit* killer) override
    {
        if (killer)
        {
            killer->GetMap()->LoadGrid(-9502.80f, 2042.65f); // Ossirian grid

            if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                player->SummonCreature(NPC_ANDOROV, -8877.254883f, 1645.267578f, 21.386303f, 4.669808f, TEMPSUMMON_CORPSE_DESPAWN, 600000000);
            }
        }

        if (Creature* ossirian = instance->GetCreature(DATA_OSSIRIAN))
        {
            ossirian->setActive(true);
            if (ossirian->GetAI())
                ossirian->AI()->Talk(SAY_KURINNAXX_DEATH);
        }
        BossAI::JustDied(killer);
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
                case EVENT_MORTAL_WOUND:
                    DoCastVictim(SPELL_MORTAL_WOUND);
                    events.ScheduleEvent(EVENT_MORTAL_WOUND, 8s, 10s);
                    break;
                case EVENT_SAND_TRAP:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.f, true))
                    {
                        target->CastSpell(target, SPELL_SAND_TRAP, true, nullptr, nullptr, me->GetGUID());
                    }
                    events.ScheduleEvent(EVENT_SAND_TRAP, 5s, 15s);
                    break;
                case EVENT_WIDE_SLASH:
                    DoCastSelf(SPELL_WIDE_SLASH);
                    events.ScheduleEvent(EVENT_WIDE_SLASH, 12s, 15s);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
private:
    bool _enraged;
};

struct go_sand_trap : public GameObjectAI
{
    go_sand_trap(GameObject* go) : GameObjectAI(go) { }

    void Reset() override
    {
        _scheduler.Schedule(5s, [this](TaskContext /*context*/)
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* kurinnaxx = instance->GetCreature(DATA_KURINNAXX))
                    me->Use(kurinnaxx);
        });
    }

    void UpdateAI(uint32 const diff) override
    {
        _scheduler.Update(diff);
    }

protected:
    TaskScheduler _scheduler;
};

void AddSC_boss_kurinnaxx()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_kurinnaxx);
    RegisterGameObjectAI(go_sand_trap);
}
