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

enum Anzu
{
    SAY_ANZU_INTRO1             = 0,
    SAY_ANZU_INTRO2             = 1,
    SAY_SUMMON                  = 2,

    SPELL_PARALYZING_SCREECH    = 40184,
    SPELL_SPELL_BOMB            = 40303,
    SPELL_CYCLONE               = 40321,
    SPELL_BANISH_SELF           = 42354,
    SPELL_SHADOWFORM            = 40973,

    EVENT_SPELL_SCREECH         = 1,
    EVENT_SPELL_BOMB            = 2,
    EVENT_SPELL_CYCLONE         = 3,
    EVENT_ANZU_HEALTH1          = 4,
    EVENT_ANZU_HEALTH2          = 5
};

enum Spirits
{
    SPELL_HAWK                  = 40237,
    SPELL_FALCON                = 40241,
    SPELL_EAGLE                 = 40240,

    SPELL_DURATION              = 40250,

    SPELL_FREEZE_ANIM           = 16245,
    SPELL_STONEFORM             = 40308,

    SAY_STONED                  = 0,

    MAX_DRUID_SPELLS            = 27
};

struct boss_anzu : public BossAI
{
    boss_anzu(Creature* creature) : BossAI(creature, DATA_ANZU)
    {
        talkTimer = 1;
        me->ReplaceAllUnitFlags(UNIT_FLAG_NON_ATTACKABLE);
        me->AddAura(SPELL_SHADOWFORM, me);
    }

    std::vector<Position> const AnzuSpiritPos = 
    {
        {-96.4816f, 304.236f, 26.5135f, 5.23599f},    // Hawk Spirit
        {-72.3434f, 290.861f, 26.4851f, 3.29867f},    // Falcon Spirit
        {-99.5906f, 276.661f, 26.8467f, 0.750492f},   // Eagle Spirit
    };

    uint32 talkTimer;

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        if (summon->GetEntry() == NPC_BROOD_OF_ANZU)
        {
            summons.Despawn(summon);
            summons.RemoveNotExisting();
            if (summons.empty())
            {
                me->RemoveAurasDueToSpell(SPELL_BANISH_SELF);
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        SummonSpirits();
        events.Reset();
        events.ScheduleEvent(EVENT_SPELL_SCREECH, 14000);
        events.ScheduleEvent(EVENT_SPELL_BOMB, 5000);
        events.ScheduleEvent(EVENT_SPELL_CYCLONE, 8000);
        events.ScheduleEvent(EVENT_ANZU_HEALTH1, 2000);
        events.ScheduleEvent(EVENT_ANZU_HEALTH2, 2001);
    }

    void SummonBroods()
    {
        Talk(SAY_SUMMON);
        me->CastSpell(me, SPELL_BANISH_SELF, true);
        for (uint8 i = 0; i < 5; ++i)
            me->SummonCreature(NPC_BROOD_OF_ANZU, me->GetPositionX() + 20 * cos((float)i), me->GetPositionY() + 20 * std::sin((float)i), me->GetPositionZ() + 25.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
    }

    void SummonSpirits()
    {
        me->SummonCreature(NPC_HAWK_SPIRIT, AnzuSpiritPos[0], TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FALCON_SPIRIT, AnzuSpiritPos[1], TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_EAGLE_SPIRIT, AnzuSpiritPos[2], TEMPSUMMON_MANUAL_DESPAWN);
    }

    void UpdateAI(uint32 diff) override
    {
        if (talkTimer)
        {
            talkTimer += diff;
            if (talkTimer >= 1000 && talkTimer < 10000)
            {
                me->SetImmuneToAll(true);
                Talk(SAY_ANZU_INTRO1);
                talkTimer = 10000;
            }
            else if (talkTimer >= 16000)
            {
                me->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                me->RemoveAurasDueToSpell(SPELL_SHADOWFORM);
                Talk(SAY_ANZU_INTRO2);
                talkTimer = 0;
                me->SetInCombatWithZone();
            }
        }

        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_SCREECH:
            me->CastSpell(me, SPELL_PARALYZING_SCREECH, false);
            events.RepeatEvent(23000);
            events.DelayEvents(3000);
            break;
        case EVENT_SPELL_BOMB:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                me->CastSpell(target, SPELL_SPELL_BOMB, false);
            events.RepeatEvent(urand(16000, 24500));
            events.DelayEvents(3000);
            break;
        case EVENT_SPELL_CYCLONE:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 45.0f, true))
                me->CastSpell(target, SPELL_CYCLONE, false);
            events.RepeatEvent(urand(22000, 27000));
            events.DelayEvents(3000);
            break;
        case EVENT_ANZU_HEALTH1:
            if (me->HealthBelowPct(66))
            {
                SummonBroods();
                events.DelayEvents(10000);
                return;
            }
            events.RepeatEvent(1000);
            break;
        case EVENT_ANZU_HEALTH2:
            if (me->HealthBelowPct(33))
            {
                SummonBroods();
                events.DelayEvents(10000);
                return;
            }
            events.RepeatEvent(1000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_anzu_spirit : public ScriptedAI
{
    npc_anzu_spirit(Creature* creature) : ScriptedAI(creature) { }

    std::array<uint32, MAX_DRUID_SPELLS> const druidSpells =
    {
      774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 26981, 26982, 48440, 48441, /* Rejuvenation */
      8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 26980, 48442, 48443, /* Regrowth */
    };

    bool HasDruidHot()
    {
        for (uint32 spellId : druidSpells)
        {
            if (me->HasAura(spellId))
                return true;
        }
        return false;
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        _scheduler.Schedule(1ms, [this](TaskContext task)
            {
                // Check for Druid HoTs every 2400ms
                if (HasDruidHot())
                {
                    me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                    me->RemoveAurasDueToSpell(SPELL_STONEFORM);

                    switch (me->GetEntry())
                    {
                    case NPC_HAWK_SPIRIT:
                        DoCastSelf(SPELL_HAWK);
                        break;
                    case NPC_FALCON_SPIRIT:
                        DoCastSelf(SPELL_FALCON);
                        break;
                    case NPC_EAGLE_SPIRIT:
                        DoCastSelf(SPELL_EAGLE);
                        break;
                    default:
                        break;
                    }
                }
                else if (!me->HasAura(SPELL_STONEFORM))
                {
                    Talk(SAY_STONED);
                    DoCastSelf(SPELL_FREEZE_ANIM, true);
                    DoCastSelf(SPELL_STONEFORM, true);
                }

                task.Repeat(2400ms);
            });
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_boss_anzu()
{
    RegisterSethekkHallsCreatureAI(boss_anzu);
    RegisterSethekkHallsCreatureAI(npc_anzu_spirit);
}
