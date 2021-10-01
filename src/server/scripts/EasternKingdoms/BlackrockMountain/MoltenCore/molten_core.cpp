/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_SMOLDERING        = 0,
    EMOTE_IGNITE            = 1,
};

enum Spells
{
    SPELL_SERRATED_BITE     = 19771,
    SPELL_PLAY_DEAD         = 19822,
};

enum Events
{
    EVENT_SERRATED_BITE     = 1,
    EVENT_IGNITE,
};

enum Actions
{
    ACTION_HOUND_IGNITE     = 1,
};

// Serrated Bites timer may be wrong
class npc_mc_core_hound : public CreatureScript
{
public:
    npc_mc_core_hound() : CreatureScript("npc_mc_core_hound") {}

    struct npc_mc_core_houndAI : public CreatureAI
    {
        npc_mc_core_houndAI(Creature* creature) : CreatureAI(creature) {}

        void Reset() override
        {
            killerGUID.Clear();
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            events.ScheduleEvent(EVENT_SERRATED_BITE, 3000);
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            // Prevent receiving any extra damage if Hound is playing dead
            if (me->HasAura(SPELL_PLAY_DEAD))
            {
                damage = 0;
                return;
            }

            if (me->HealthBelowPctDamaged(0, damage) && !me->HasAura(SPELL_PLAY_DEAD))
            {
                damage = 0;
                killerGUID = attacker->GetGUID();
                Talk(EMOTE_SMOLDERING);
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_HOUND_IGNITE && me->IsInCombat())
            {


                killerGUID.Clear();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && !smoldering)
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            if (events.ExecuteEvent() == EVENT_SERRATED_BITE)
            {
                DoCastVictim(SPELL_SERRATED_BITE);
                events.RepeatEvent(urand(5000, 6000));
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        ObjectGuid killerGUID;
        bool smoldering;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_mc_core_houndAI>(creature);
    }
};

// 19822 Play Dead
class spell_mc_play_dead : public SpellScriptLoader
{
public:
    spell_mc_play_dead() : SpellScriptLoader("spell_mc_play_dead") { }

    class spell_mc_play_dead_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mc_play_dead_AuraScript);

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* target = GetTarget()->ToCreature())
            {
                target->SetReactState(REACT_PASSIVE);
            }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Creature* target = GetTarget()->ToCreature();
            if (target)
            {
                target->SetReactState(REACT_AGGRESSIVE);

                if (target->IsInCombat())
                {
                    bool shouldDie = true;
                    std::list<Creature*> hounds;
                    target->GetCreaturesWithEntryInRange(hounds, 80, NPC_CORE_HOUND);
                    if (!hounds.empty())
                    {
                        // Alive hound been found within 80 yards -> cancel suicide
                        if (std::find_if(hounds.begin(), hounds.end(), [](Creature const* hound)
                        {
                            return hound->IsAlive() && !hound->HasAura(SPELL_PLAY_DEAD);
                        }) != hounds.end())
                        {
                            shouldDie = false;
                        }
                    }

                    if (!shouldDie)
                    {
                        target->AI()->DoAction(target->GetEntry() * 10);
                        target->SetFullHealth();
                    }
                    else
                    {
                        Unit::Kill(target, target);
                    }
                }
            }
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_mc_play_dead_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectApplyFn(spell_mc_play_dead_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_mc_play_dead_AuraScript();
    }
};

void AddSC_molten_core()
{
    new npc_mc_core_hound();
    new spell_mc_play_dead();
}
