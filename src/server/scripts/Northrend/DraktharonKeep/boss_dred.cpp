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

    SAY_CLAW_EMOTE                      = 0
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
        boss_dredAI(Creature* creature) : BossAI(creature, DATA_DRED) { }

        void Reset() override
        {
            BossAI::Reset();
            _raptorCount = 0;

            ScheduleHealthCheckEvent({ 67, 34 }, [&] {
                DoCastAOE(SPELL_BELLOWING_ROAR);
            }, false);
        }

        void ScheduleTasks() override
        {
            ScheduleTimedEvent(20s, [&] {
                DoCastVictim(SPELL_GRIEVOUS_BITE);
            }, 20s);

            ScheduleTimedEvent(18s + 500ms, [&] {
                DoCastVictim(SPELL_MANGLING_SLASH);
            }, 20s);

            ScheduleTimedEvent(10s, 20s, [&] {
                DoCastAOE(SPELL_FEARSOME_ROAR);
            }, 17s);

            ScheduleTimedEvent(17s, [&] {
                DoCastVictim(SPELL_PIERCING_SLASH);
            }, 20s);

            if (IsHeroic())
            {
                ScheduleTimedEvent(16s, [&] {
                    DoCastSelf(SPELL_RAPTOR_CALL);
                }, 30s);

                ScheduleTimedEvent(21s, [&] {
                    Talk(SAY_CLAW_EMOTE);
                    me->setAttackTimer(BASE_ATTACK, 2000);
                    me->AttackerStateUpdate(me->GetVictim());
                    if (me->GetVictim())
                        me->AttackerStateUpdate(me->GetVictim());
                    if (me->GetVictim())
                        me->AttackerStateUpdate(me->GetVictim());
                }, 20s);
            }
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
        std::list<Creature*> raptors;
        GetCaster()->GetCreatureListWithEntryInGrid(raptors, { NPC_DRAKKARI_SCYTHECLAW, NPC_DRAKKARI_GUTRIPPER }, 100.0f);

        raptors.remove_if([](Creature* raptor)
        {
            return !raptor->IsAlive() || raptor->IsInCombat();
        });

        if (raptors.empty())
            return;

        Creature* raptor = Acore::Containers::SelectRandomContainerElement(raptors);
        if (!raptor)
            return;

        if (GetCaster()->GetVictim())
            raptor->AI()->AttackStart(GetCaster()->GetVictim());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dred_raptor_call::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class achievement_better_off_dred : public AchievementCriteriaScript
{
public:
    achievement_better_off_dred() : AchievementCriteriaScript("achievement_better_off_dred") { }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry()) >= 6;
    }
};

void AddSC_boss_dred()
{
    new boss_dred();
    RegisterSpellScript(spell_dred_grievious_bite_aura);
    RegisterSpellScript(spell_dred_raptor_call);
    new achievement_better_off_dred();
}
