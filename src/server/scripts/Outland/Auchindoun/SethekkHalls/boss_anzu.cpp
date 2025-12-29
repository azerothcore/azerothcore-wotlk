/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "Unit.h"
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
    NPC_BROOD_OF_ANZU           = 23132,
    NPC_HAWK_SPIRIT             = 23134,
    NPC_FALCON_SPIRIT           = 23135,
    NPC_EAGLE_SPIRIT            = 23136
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
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    const Position AnzuSpiritPos[3] =
    {
        {-96.4816f, 304.236f, 26.5135f, 5.23599f},    // Hawk Spirit
        {-72.3434f, 290.861f, 26.4851f, 3.29867f},    // Falcon Spirit
        {-99.5906f, 276.661f, 26.8467f, 0.750492f},   // Eagle Spirit
    };

    uint32 talkTimer;

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (summon->GetEntry() == NPC_BROOD_OF_ANZU)
        {
            summons.Despawn(summon);
            summons.RemoveNotExisting();
            if (!summons.HasEntry(NPC_BROOD_OF_ANZU))
            {
                me->RemoveAurasDueToSpell(SPELL_BANISH_SELF);
            }
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
        SummonSpirits();
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
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 9, 45.0f, true, false))
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
            Position spawnPos = me->GetNearPosition(20.0f, (float)i);
            spawnPos.m_positionZ += 25.0f;
            spawnPos.m_orientation = 0.0f;
            me->SummonCreature(NPC_BROOD_OF_ANZU, spawnPos, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }
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

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
            return;

        DoMeleeAttackIfReady();
    }
};

struct npc_anzu_spirit : public ScriptedAI
{
    npc_anzu_spirit(Creature* creature) : ScriptedAI(creature) { }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        _scheduler.Schedule(1ms, [this](TaskContext task)
            {
                // Check for Druid HoTs every 2400ms
                if (me->GetAuraEffect(SPELL_AURA_PERIODIC_HEAL, SPELLFAMILY_DRUID, 64, 0))
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
