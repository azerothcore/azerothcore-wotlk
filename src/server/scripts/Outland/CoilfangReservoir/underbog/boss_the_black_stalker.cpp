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
#include "the_underbog.h"

/*
How levitation sequence works: boss casts Levitate and it triggers a chain of spells, target(any target, player or pet, any position in
threat list) eventually gets pulled towards by randomly selected trigger. Then target becomes protected from Pull Towards by Suspension
aura which is triggered every 1 sec up to 4 times. Since it has stun mechanic, diminishing returns cuts off its duration every cast in
half (20 > 10 > 5 > 0). Eventually player becomes immune to Suspension and vulnerable to another pull towards.
Whole levitate sequence is designed to pull player towards up to 3 times. Usually it works like this: player gets pulled towards,
gets protected by Suspension from Pull Towards next 2 times. If player is unlucky, boss can cast Levitate on same player again, in that case
player can be pulled towards 2 times in a row without any protection from fall damage by Suspension(case from sniffs).
However currently diminishing returns affects Suspension after first cast, its duration is 10 instead of 20 seconds and player will be
immune to 4th cast. That allows to pull player towards when levitation sequence ends. Levitation sequence has sensetive design and looks
like lack of delays between packets makes it work differently too.
Of course as was said above player can be pulled towards 2 times in a row but that looks like a rare case.
*/

enum eBlackStalker
{
    SPELL_LEVITATE                  = 31704,
    SPELL_CHAIN_LIGHTNING           = 31717,
    SPELL_STATIC_CHARGE             = 31715,
    SPELL_SUMMON_SPORE_STRIDER      = 38755,

    SPELL_LEVITATION_PULSE          = 31701,
    SPELL_SOMEONE_GRAB_ME           = 31702,
    SPELL_MAGNETIC_PULL             = 31703,
    SPELL_SUSPENSION_PRIMER         = 31720,
    SPELL_SUSPENSION                = 31719,

    EVENT_LEVITATE                  = 1,
    EVENT_SPELL_CHAIN               = 2,
    EVENT_SPELL_STATIC              = 3,
    EVENT_SPELL_SPORES              = 4,
    EVENT_CHECK                     = 5,
    EVENT_LEVITATE_TARGET_1         = 6,
    EVENT_LEVITATE_TARGET_2         = 7,

    ENTRY_SPORE_STRIDER             = 22299
};

struct boss_the_black_stalker : public BossAI
{
    boss_the_black_stalker(Creature* creature) : BossAI(creature, DATA_BLACK_STALKER)
    {
    }

    void JustEngagedWith(Unit* who) override
    {
        events.ScheduleEvent(EVENT_LEVITATE, urand(8000, 12000));
        events.ScheduleEvent(EVENT_SPELL_CHAIN, 6000);
        events.ScheduleEvent(EVENT_SPELL_STATIC, 10000);
        events.ScheduleEvent(EVENT_CHECK, 5000);
        if (IsHeroic())
            events.ScheduleEvent(EVENT_SPELL_SPORES, urand(10000, 15000));

        BossAI::JustEngagedWith(who);
    }

    void JustSummoned(Creature* summon) override
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
            summon->AI()->AttackStart(target);
        else if (me->GetVictim())
            summon->AI()->AttackStart(me->GetVictim());

        BossAI::JustSummoned(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        summons.Despawn(summon);
        for (uint8 i = 0; i < 3; ++i)
            me->CastSpell(me, SPELL_SUMMON_SPORE_STRIDER, false);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_CHECK:
                float x, y, z, o;
                me->GetHomePosition(x, y, z, o);
                if (!me->IsWithinDist3d(x, y, z, 60))
                {
                    EnterEvadeMode();
                    return;
                }
                events.RepeatEvent(5000);
                break;
            case EVENT_SPELL_SPORES:
                me->CastSpell(me, SPELL_SUMMON_SPORE_STRIDER, false);
                events.RepeatEvent(urand(10000, 15000));
                break;
            case EVENT_SPELL_CHAIN:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);
                events.RepeatEvent(9000);
                break;
            case EVENT_SPELL_STATIC:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true))
                    me->CastSpell(target, SPELL_STATIC_CHARGE, false);
                events.RepeatEvent(10000);
                break;
            case EVENT_LEVITATE:
                DoCastSelf(SPELL_LEVITATE);
                events.RepeatEvent(urand(18000, 24000));
                break;
        }

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
};

// 31704 - Levitate
class spell_the_black_stalker_levitate : public SpellScript
{
    PrepareSpellScript(spell_the_black_stalker_levitate);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LEVITATION_PULSE });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_LEVITATION_PULSE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_black_stalker_levitate::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 31701 - Levitation Pulse
class spell_the_black_stalker_levitation_pulse : public SpellScript
{
    PrepareSpellScript(spell_the_black_stalker_levitation_pulse);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOMEONE_GRAB_ME });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_SOMEONE_GRAB_ME, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_the_black_stalker_levitation_pulse::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 31702 - Someone Grab Me
class spell_the_black_stalker_someone_grab_me : public SpellScript
{
    PrepareSpellScript(spell_the_black_stalker_someone_grab_me);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MAGNETIC_PULL, SPELL_SUSPENSION });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (!GetCaster()->HasAura(SPELL_SUSPENSION))
            GetHitUnit()->CastSpell(GetCaster(), SPELL_MAGNETIC_PULL);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_black_stalker_someone_grab_me::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 31703 - Magnetic Pull
class spell_the_black_stalker_magnetic_pull : public SpellScript
{
    PrepareSpellScript(spell_the_black_stalker_magnetic_pull);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUSPENSION_PRIMER });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_SUSPENSION_PRIMER, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_black_stalker_magnetic_pull::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_the_black_stalker()
{
    RegisterUnderbogCreatureAI(boss_the_black_stalker);
    RegisterSpellScript(spell_the_black_stalker_levitate);
    RegisterSpellScript(spell_the_black_stalker_levitation_pulse);
    RegisterSpellScript(spell_the_black_stalker_someone_grab_me);
    RegisterSpellScript(spell_the_black_stalker_magnetic_pull);
}
