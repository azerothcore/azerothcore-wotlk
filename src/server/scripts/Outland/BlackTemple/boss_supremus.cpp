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
#include "black_temple.h"

enum Supremus
{
    EMOTE_NEW_TARGET                = 0,
    EMOTE_PUNCH_GROUND              = 1,
    EMOTE_GROUND_CRACK              = 2,
    EMOTE_BERSERK                   = 3,

    SPELL_SNARE_SELF                = 41922,
    SPELL_MOLTEN_PUNCH              = 40126,
    SPELL_MOLTEN_FLAME              = 40980,
    SPELL_HATEFUL_STRIKE            = 41926,
    SPELL_VOLCANIC_ERUPTION         = 40276,
    SPELL_VOLCANIC_ERUPTION_TRIGGER = 40117,
    SPELL_VOLCANIC_GEYSER           = 42055,
    SPELL_BERSERK                   = 26662,
    SPELL_CHARGE                    = 41581,

    SPELL_SERVERSIDE_RANDOM_TARGET  = 41951,  // Found in 55261. Used for Fixate target

    NPC_SUPREMUS_VOLCANO            = 23085,

    GROUP_ABILITIES                 = 1,
    GROUP_MOLTEN_PUNCH              = 2,
    GROUP_PHASE_CHANGE              = 3
};

struct boss_supremus : public BossAI
{
    boss_supremus(Creature* creature) : BossAI(creature, DATA_SUPREMUS)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, false);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, false);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        SchedulePhase(true);

        ScheduleTimedEvent(15min, [&]
        {
            DoCastSelf(SPELL_BERSERK, true);
            Talk(EMOTE_BERSERK);
            scheduler.CancelGroup(GROUP_ABILITIES);  // Supremus stops all other abilities after berserking
            scheduler.CancelGroup(GROUP_MOLTEN_PUNCH);
            scheduler.CancelGroup(GROUP_PHASE_CHANGE);
        }, 5min);

        scheduler.Schedule(20s, [this](TaskContext context)
        {
            context.SetGroup(GROUP_MOLTEN_PUNCH);
            DoCastSelf(SPELL_MOLTEN_PUNCH);
            context.Repeat(15s, 20s);
        });
    }

    void SchedulePhase(bool isSnared)
    {
        scheduler.CancelGroup(GROUP_ABILITIES);

        scheduler.Schedule(1min, [this](TaskContext context)
        {
            context.SetGroup(GROUP_PHASE_CHANGE);
            SchedulePhase(me->HasAura(SPELL_SNARE_SELF));
        });

        DoResetThreatList();

        // Hateful Strike Phase
        if (isSnared)
        {
            scheduler.Schedule(8s, 15s, [this](TaskContext context)
            {
                context.SetGroup(GROUP_ABILITIES);

                if (Unit* target = FindHatefulStrikeTarget())
                    DoCast(target, SPELL_HATEFUL_STRIKE);

                context.Repeat(1500ms, 15s);
            });

            if (me->HasAura(SPELL_SNARE_SELF))
                Talk(EMOTE_PUNCH_GROUND);

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, false);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, false);
            me->RemoveAurasDueToSpell(SPELL_SNARE_SELF);
        }
        // Gaze Phase
        else
        {
            DoCastSelf(SPELL_SNARE_SELF, true);

            scheduler.Schedule(5s, [this](TaskContext context)
            {
                context.SetGroup(GROUP_ABILITIES);

                if (DoCastRandomTarget(SPELL_VOLCANIC_ERUPTION, 0, 100.f, true) == SPELL_CAST_OK)
                    Talk(EMOTE_GROUND_CRACK);

                context.Repeat(10s, 18s);
            }).Schedule(0s, [this](TaskContext context)
            {
                context.SetGroup(GROUP_ABILITIES);

                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                {
                    DoResetThreatList();
                    me->AddThreat(target, 5000000.0f);
                    Talk(EMOTE_NEW_TARGET);
                    if (target->IsWithinDist(me, 40))
                        DoCast(target, SPELL_CHARGE);
                }

                context.Repeat(10s);
            });

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_SUPREMUS_VOLCANO)
            summon->CastSpell(summon, SPELL_VOLCANIC_ERUPTION_TRIGGER, true);
        else
            summon->ToTempSummon()->InitStats(30000);
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        summons.Despawn(summon);
    }

    Unit* FindHatefulStrikeTarget()
    {
        Unit* target = nullptr;
        ThreatContainer::StorageType const& threatlist = me->GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator i = threatlist.begin(); i != threatlist.end(); ++i)
        {
            Unit* unit = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid());
            if (unit && me->IsWithinMeleeRange(unit))
                if (!target || unit->GetHealth() > target->GetHealth())
                    target = unit;
        }

        return target;
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->GetPositionX() < 565 || me->GetPositionX() > 865 || me->GetPositionY() < 545 || me->GetPositionY() > 1000;
    }
};

struct npc_supremus_punch_invisible_stalker : public ScriptedAI
{
    npc_supremus_punch_invisible_stalker(Creature* creature) : ScriptedAI(creature) { }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        me->SetInCombatWithZone();
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
            me->AddThreat(target, 10000.f);

        DoCastSelf(SPELL_MOLTEN_FLAME, true);

        scheduler.Schedule(6s, 10s, [this](TaskContext /*context*/)
        {
            me->CombatStop();
            me->SetReactState(REACT_PASSIVE);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;
    }
};

void AddSC_boss_supremus()
{
    RegisterBlackTempleCreatureAI(npc_supremus_punch_invisible_stalker);
    RegisterBlackTempleCreatureAI(boss_supremus);
}
