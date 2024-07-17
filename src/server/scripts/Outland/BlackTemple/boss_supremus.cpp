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
#include "black_temple.h"

enum Supremus
{
    EMOTE_NEW_TARGET                = 0,
    EMOTE_PUNCH_GROUND              = 1,
    EMOTE_GROUND_CRACK              = 2,

    SPELL_SNARE_SELF                = 41922,
    SPELL_MOLTEN_PUNCH              = 40126,
    SPELL_HATEFUL_STRIKE            = 41926,
    SPELL_VOLCANIC_ERUPTION         = 40276,
    SPELL_VOLCANIC_ERUPTION_TRIGGER = 40117,
    SPELL_VOLCANIC_GEYSER           = 42055,
    SPELL_BERSERK                   = 45078,
    SPELL_CHARGE                    = 41581,

    NPC_SUPREMUS_PUNCH_STALKER      = 23095,

    EVENT_BERSERK                   = 1,
    EVENT_PHASE_CHANGE              = 2,

    GROUP_ABILITIES                 = 1,
    GROUP_MOLTEN_PUNCH              = 2
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

        ScheduleUniqueTimedEvent(15min, [&]
        {
            DoCastSelf(SPELL_BERSERK, true);
        }, EVENT_BERSERK);

        scheduler.Schedule(20s, [this](TaskContext context)
        {
            context.SetGroup(GROUP_MOLTEN_PUNCH);
            DoCastSelf(SPELL_MOLTEN_PUNCH);
            context.Repeat(15s, 20s);
        });
    }

    void SchedulePhase(bool IsSnared)
    {
        scheduler.CancelGroup(GROUP_ABILITIES);

        ScheduleUniqueTimedEvent(1min, [&]
        {
            SchedulePhase(me->HasAura(SPELL_SNARE_SELF));
        }, EVENT_PHASE_CHANGE);

        DoResetThreatList();

        // Hateful Strike Phase
        if (IsSnared)
        {
            scheduler.Schedule(8s, 15s, [this](TaskContext context)
            {
                context.SetGroup(GROUP_ABILITIES);

                if (Unit* target = FindHatefulStrikeTarget())
                    DoCast(target, SPELL_HATEFUL_STRIKE);

                context.Repeat(1500ms, 15s);
            });

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

                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100, true))
                {
                    DoResetThreatList();
                    me->AddThreat(target, 5000000.0f);
                    Talk(EMOTE_NEW_TARGET);

                    if (me->GetDistance(me->GetVictim()) < 35.0f)
                        DoCastVictim(SPELL_CHARGE);
                }

                context.Repeat(10s);
            }).Schedule(1s, [this](TaskContext context)
            {
                context.SetGroup(GROUP_ABILITIES);

                if (me->GetDistance(me->GetVictim()) > 100.0f)
                    if (DoCastVictim(SPELL_CHARGE) == SPELL_CAST_OK)
                        Talk(EMOTE_PUNCH_GROUND);

                context.Repeat(1s);
            });

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_SUPREMUS_PUNCH_STALKER)
        {
            summon->ToTempSummon()->InitStats(20000);
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                summon->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
        }
        else
            summon->CastSpell(summon, SPELL_VOLCANIC_ERUPTION_TRIGGER, true);
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

void AddSC_boss_supremus()
{
    RegisterBlackTempleCreatureAI(boss_supremus);
}
