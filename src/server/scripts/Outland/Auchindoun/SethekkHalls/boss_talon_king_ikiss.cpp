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

enum TailonkingIkiss
{
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3,
    EMOTE_ARCANE_EXP            = 4,
};

enum Spells
{
    SPELL_BLINK                 = 38194,
    SPELL_BLINK_TELEPORT        = 38203,
    SPELL_MANA_SHIELD           = 38151,
    SPELL_ARCANE_BUBBLE         = 9438,
    SPELL_SLOW                  = 35032,
    SPELL_POLYMORPH             = 38245,
    SPELL_ARCANE_VOLLEY         = 35059,
    SPELL_ARCANE_EXPLOSION      = 38197,
};

struct boss_talon_king_ikiss : public BossAI
{
    boss_talon_king_ikiss(Creature* creature) : BossAI(creature, DATA_IKISS), _spoken(false), _manaShield(false)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        _spoken = false;
        _manaShield = false;
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_spoken && who->IsPlayer())
        {
            Talk(SAY_INTRO);
            _spoken = true;
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(35s, [this](TaskContext context)
        {
            me->InterruptNonMeleeSpells(false);
            DoCastAOE(SPELL_BLINK);
            Talk(EMOTE_ARCANE_EXP);
            context.Repeat(35s, 40s);

            scheduler.Schedule(1s, [this](TaskContext)
            {
                DoCastAOE(SPELL_ARCANE_EXPLOSION);
                DoCastSelf(SPELL_ARCANE_BUBBLE, true);
            });
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ARCANE_VOLLEY);
            context.Repeat(7s, 12s);
        }).Schedule(8s, [this](TaskContext context)
        {
            IsHeroic() ? DoCastRandomTarget(SPELL_POLYMORPH) : DoCastMaxThreat(SPELL_POLYMORPH);
            context.Repeat(15s, 17500ms);
        });

        if (IsHeroic())
        {
            scheduler.Schedule(15s, 25s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SLOW);
                context.Repeat(15s, 30s);
            });
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);

        if (GameObject* coffer = instance->GetGameObject(DATA_GO_TALON_KING_COFFER))
        {
            coffer->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE | GO_FLAG_INTERACT_COND);
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (!_manaShield && me->HealthBelowPctDamaged(20, damage))
        {
            DoCast(me, SPELL_MANA_SHIELD);
            _manaShield = true;
        }
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (urand(0, 1))
            Talk(SAY_SLAY);
    }

    private:
        bool _spoken;
        bool _manaShield;
};

// 38194 - Blink
class spell_talon_king_ikiss_blink : public SpellScript
{
    PrepareSpellScript(spell_talon_king_ikiss_blink);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return sSpellMgr->GetSpellInfo(SPELL_BLINK);
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        uint8 maxSize = 1;
        if (targets.size() > maxSize)
        {
            Acore::Containers::RandomResize(targets, maxSize);
        }
    }

    void HandleDummyHitTarget(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->CastSpell(GetCaster(), SPELL_BLINK_TELEPORT, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_talon_king_ikiss_blink::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_talon_king_ikiss_blink::HandleDummyHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

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

struct boss_anzu : public BossAI
{
    boss_anzu(Creature* creature) : BossAI(creature, DATA_ANZU)
    {
        talkTimer = 1;
        me->ReplaceAllUnitFlags(UNIT_FLAG_NON_ATTACKABLE);
        me->AddAura(SPELL_SHADOWFORM, me);
    }

    uint32 talkTimer;

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);
        summons.RemoveNotExisting();
        if (summons.empty())
            me->RemoveAurasDueToSpell(SPELL_BANISH_SELF);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
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
            me->SummonCreature(23132 /*NPC_BROOD_OF_ANZU*/, me->GetPositionX() + 20 * cos((float)i), me->GetPositionY() + 20 * std::sin((float)i), me->GetPositionZ() + 25.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
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

void AddSC_boss_talon_king_ikiss()
{
    RegisterSethekkHallsCreatureAI(boss_talon_king_ikiss);
    RegisterSpellScript(spell_talon_king_ikiss_blink);
    RegisterSethekkHallsCreatureAI(boss_anzu);
}
