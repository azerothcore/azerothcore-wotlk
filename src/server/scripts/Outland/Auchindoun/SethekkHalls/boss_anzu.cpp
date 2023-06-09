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
#include "sethekk_halls.h"

enum Text
{
    SAY_ANZU_INTRO1             = 0,
    SAY_ANZU_INTRO2             = 1,
    SAY_SUMMON                  = 2
};

enum Spells
{
    SPELL_PARALYZING_SCREECH    = 40184,
    SPELL_SPELL_BOMB            = 40303,
    SPELL_CYCLONE               = 40321,
    SPELL_BANISH_SELF           = 42354,
    SPELL_SHADOWFORM            = 40973
};

enum Npc
{
    NPC_BROOD_OF_ANZU           = 23132
};

struct boss_anzu : public BossAI
{
    boss_anzu(Creature* creature) : BossAI(creature, DATA_ANZU)
    {
        talkTimer = 1;
        me->ReplaceAllUnitFlags(UNIT_FLAG_NON_ATTACKABLE);
        me->AddAura(SPELL_SHADOWFORM, me);
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    uint32 talkTimer;

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);
        summons.RemoveNotExisting();
        if (summons.empty())
        {
            me->RemoveAurasDueToSpell(SPELL_BANISH_SELF);
        }
    }

    void Reset() override
    {
        _Reset();
        ScheduleHealthCheckEvent({ 66, 33 }, [&] {
            SummonBroods();
            scheduler.DelayAll(10s);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        scheduler.Schedule(14s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_PARALYZING_SCREECH);
            context.Repeat(23s);
            scheduler.DelayAll(3s);
        }).Schedule(5s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
            {
                DoCast(target, SPELL_SPELL_BOMB);
            }
            context.Repeat(16s, 24500ms);
            scheduler.DelayAll(3s);
        }).Schedule(8s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 45.0f, true))
            {
                DoCast(target, SPELL_CYCLONE);
            }
            context.Repeat(22s, 27s);
            scheduler.DelayAll(3s);
        });
    }

    void SummonBroods()
    {
        Talk(SAY_SUMMON);
        me->CastSpell(me, SPELL_BANISH_SELF, true);
        for (uint8 i = 0; i < 5; ++i)
        {
            me->SummonCreature(NPC_BROOD_OF_ANZU, me->GetPositionX() + 20 * cos((float)i), me->GetPositionY() + 20 * std::sin((float)i), me->GetPositionZ() + 25.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (talkTimer)
        {
            talkTimer += diff;
            if (talkTimer >= 1000 && talkTimer < 10000)
            {
                Talk(SAY_ANZU_INTRO1);
                talkTimer = 10000;
            }
            else if (talkTimer >= 16000)
            {
                me->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                me->RemoveAurasDueToSpell(SPELL_SHADOWFORM);
                Talk(SAY_ANZU_INTRO2);
                talkTimer = 0;
            }
        }

        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
            return;

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_anzu()
{
    RegisterSethekkHallsCreatureAI(boss_anzu);
}
