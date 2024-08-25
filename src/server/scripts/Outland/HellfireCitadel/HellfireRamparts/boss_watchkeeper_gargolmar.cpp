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
#include "SpellScriptLoader.h"
#include "hellfire_ramparts.h"
#include "SpellScript.h"

enum Says
{
    SAY_TAUNT               = 0,
    SAY_HEAL                = 1,
    SAY_SURGE               = 2,
    SAY_AGGRO               = 3,
    SAY_KILL                = 4,
    SAY_DIE                 = 5
};

enum Spells
{
    SPELL_MORTAL_WOUND      = 30641,
    SPELL_SURGE             = 34645,
    SPELL_RETALIATION       = 22857
};

enum Misc
{
    NPC_HELLFIRE_WATCHER    = 17309
};

struct boss_watchkeeper_gargolmar : public BossAI
{
    boss_watchkeeper_gargolmar(Creature* creature) : BossAI(creature, DATA_WATCHKEEPER_GARGOLMAR)
    {
        _taunted = false;
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        ScheduleHealthCheckEvent(50, [&]{
            Talk(SAY_HEAL);
            std::list<Creature*> clist;
            me->GetCreaturesWithEntryInRange(clist, 100.0f, NPC_HELLFIRE_WATCHER);
            for (std::list<Creature*>::const_iterator itr = clist.begin(); itr != clist.end(); ++itr)
            {
                (*itr)->AI()->SetData(NPC_HELLFIRE_WATCHER, 0);
            }
        });

        ScheduleHealthCheckEvent(20, [&]{
            DoCastSelf(SPELL_RETALIATION);
            scheduler.Schedule(30s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_RETALIATION);
                context.Repeat(30s);
            });
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();
        scheduler.Schedule(5s, [this] (TaskContext context)
        {
            DoCastVictim(SPELL_MORTAL_WOUND);
            context.Repeat(8s);
        }).Schedule(3s, [this](TaskContext context)
        {
            Talk(SAY_SURGE);
            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0))
            {
                me->CastSpell(target, SPELL_SURGE);
            }
            context.Repeat(11s);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_taunted)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                _taunted = true;
                Talk(SAY_TAUNT);
            }
        }
        BossAI::MoveInLineOfSight(who);
    }

    void KilledUnit(Unit*) override
    {
        if (!_hasSpoken)
        {
            _hasSpoken = true;
            Talk(SAY_KILL);
        }
        scheduler.Schedule(6s, [this](TaskContext /*context*/)
        {
            _hasSpoken = false;
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DIE);
        _JustDied();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

private:
    bool _taunted;
    bool _hasSpoken;

};

class spell_gargolmar_retalliation : public AuraScript
{
    PrepareAuraScript(spell_gargolmar_retalliation);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetProcTarget())
        {
            return false;
        }

        return GetTarget()->isInFront(eventInfo.GetActor(), M_PI);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gargolmar_retalliation::CheckProc);
    }
};

void AddSC_boss_watchkeeper_gargolmar()
{
    RegisterHellfireRampartsCreatureAI(boss_watchkeeper_gargolmar);
    RegisterSpellScript(spell_gargolmar_retalliation);
}
