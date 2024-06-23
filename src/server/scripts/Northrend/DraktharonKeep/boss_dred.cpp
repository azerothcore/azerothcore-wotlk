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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "drak_tharon_keep.h"

enum Spells
{
    SPELL_BELLOWING_ROAR                = 22686,
    SPELL_GRIEVOUS_BITE                 = 48920,
    SPELL_MANGLING_SLASH                = 48873,
    SPELL_FEARSOME_ROAR                 = 48849,
    SPELL_PIERCING_SLASH                = 48878,
    SPELL_RAPTOR_CALL                   = 59416
};

enum Misc
{
    NPC_DRAKKARI_SCYTHECLAW             = 26628,
    NPC_DRAKKARI_GUTRIPPER              = 26641,

    SAY_CLAW_EMOTE                      = 0,

    EVENT_SPELL_BELLOWING_ROAR          = 1,
    EVENT_SPELL_GRIEVOUS_BITE           = 2,
    EVENT_SPELL_MANGLING_SLASH          = 3,
    EVENT_SPELL_FEARSOME_ROAR           = 4,
    EVENT_SPELL_PIERCING_SLASH          = 5,
    EVENT_SPELL_RAPTOR_CALL             = 6,
    EVENT_MENACING_CLAW                 = 7
};

class boss_dred : public CreatureScript
{
public:
    boss_dred() : CreatureScript("boss_dred") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetDraktharonKeepAI<boss_dredAI>(creature);
    }

    struct boss_dredAI : public BossAI
    {
        boss_dredAI(Creature* creature) : BossAI(creature, DATA_DRED)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            _raptorCount = 0;
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == me->GetEntry())
                return uint32(_raptorCount);
            return 0;
        }

        void SetData(uint32 type, uint32) override
        {
            if (type == me->GetEntry())
                ++_raptorCount;
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            _raptorCount = 0;

            events.ScheduleEvent(EVENT_SPELL_BELLOWING_ROAR, 33s);
            events.ScheduleEvent(EVENT_SPELL_GRIEVOUS_BITE, 20s);
            events.ScheduleEvent(EVENT_SPELL_MANGLING_SLASH, 18s + 500ms);
            events.ScheduleEvent(EVENT_SPELL_FEARSOME_ROAR, 10s, 20s);
            events.ScheduleEvent(EVENT_SPELL_PIERCING_SLASH, 17s);
            if (IsHeroic())
            {
                events.ScheduleEvent(EVENT_MENACING_CLAW, 21s);
                events.ScheduleEvent(EVENT_SPELL_RAPTOR_CALL, 20s, 25s);
            }
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
                case EVENT_SPELL_BELLOWING_ROAR:
                    me->CastSpell(me, SPELL_BELLOWING_ROAR, false);
                    events.ScheduleEvent(EVENT_SPELL_BELLOWING_ROAR, 40s);
                    break;
                case EVENT_SPELL_GRIEVOUS_BITE:
                    me->CastSpell(me->GetVictim(), SPELL_GRIEVOUS_BITE, false);
                    events.ScheduleEvent(EVENT_SPELL_GRIEVOUS_BITE, 20s);
                    break;
                case EVENT_SPELL_MANGLING_SLASH:
                    me->CastSpell(me->GetVictim(), SPELL_MANGLING_SLASH, false);
                    events.ScheduleEvent(EVENT_SPELL_MANGLING_SLASH, 20s);
                    break;
                case EVENT_SPELL_FEARSOME_ROAR:
                    me->CastSpell(me, SPELL_FEARSOME_ROAR, false);
                    events.ScheduleEvent(EVENT_SPELL_FEARSOME_ROAR, 17s);
                    break;
                case EVENT_SPELL_PIERCING_SLASH:
                    me->CastSpell(me->GetVictim(), SPELL_PIERCING_SLASH, false);
                    events.ScheduleEvent(EVENT_SPELL_PIERCING_SLASH, 20s);
                    break;
                case EVENT_SPELL_RAPTOR_CALL:
                    me->CastSpell(me, SPELL_RAPTOR_CALL, false);
                    events.ScheduleEvent(EVENT_SPELL_RAPTOR_CALL, 20s);
                    break;
                case EVENT_MENACING_CLAW:
                    Talk(SAY_CLAW_EMOTE);
                    me->setAttackTimer(BASE_ATTACK, 2000);
                    me->AttackerStateUpdate(me->GetVictim());
                    if (me->GetVictim())
                        me->AttackerStateUpdate(me->GetVictim());
                    if (me->GetVictim())
                        me->AttackerStateUpdate(me->GetVictim());
                    events.ScheduleEvent(EVENT_MENACING_CLAW, 20s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint8 _raptorCount;
    };
};

class spell_dred_grievious_bite_aura : public AuraScript
{
    PrepareAuraScript(spell_dred_grievious_bite_aura);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* target = GetTarget())
            if (target->GetHealth() == target->GetMaxHealth())
            {
                PreventDefaultAction();
                SetDuration(0);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dred_grievious_bite_aura::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_dred_raptor_call : public SpellScript
{
    PrepareSpellScript(spell_dred_raptor_call);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->SummonCreature(RAND(NPC_DRAKKARI_GUTRIPPER, NPC_DRAKKARI_SCYTHECLAW), -522.02f, -718.89f, 30.26f, 2.41f);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dred_raptor_call::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class achievement_better_off_dred : public AchievementCriteriaScript
{
public:
    achievement_better_off_dred() : AchievementCriteriaScript("achievement_better_off_dred")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_dred()
{
    new boss_dred();
    RegisterSpellScript(spell_dred_grievious_bite_aura);
    RegisterSpellScript(spell_dred_raptor_call);
    new achievement_better_off_dred();
}
