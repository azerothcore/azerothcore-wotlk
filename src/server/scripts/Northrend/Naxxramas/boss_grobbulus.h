#ifndef BOSSGROBBULUS_H_
#define BOSSGROBBULUS_H_

#include "PassiveAI.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "naxxramas.h"



class boss_grobbulus : public CreatureScript
{
public:
    boss_grobbulus() : CreatureScript("boss_grobbulus") { }

    CreatureAI* GetAI(Creature* pCreature) const override;

    struct boss_grobbulusAI : public BossAI
    {
        explicit boss_grobbulusAI(Creature* c);

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        uint32 dropSludgeTimer{};

        void Reset() override;

        void PullChamberAdds();

        void JustEngagedWith(Unit* who) override;

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override;

        void JustSummoned(Creature* cr) override;

        void SummonedCreatureDespawn(Creature* summon) override;

        void JustDied(Unit*  killer) override;

        void KilledUnit(Unit* who) override;

        void UpdateAI(uint32 diff) override;
    };
};

class boss_grobbulus_poison_cloud : public CreatureScript
{
public:
    boss_grobbulus_poison_cloud() : CreatureScript("boss_grobbulus_poison_cloud") { }

    CreatureAI* GetAI(Creature* pCreature) const override;

    struct boss_grobbulus_poison_cloudAI : public NullCreatureAI
    {
        explicit boss_grobbulus_poison_cloudAI(Creature* pCreature) : NullCreatureAI(pCreature) { }

        uint32 sizeTimer{};
        uint32 auraVisualTimer{};

        void Reset() override;

        void KilledUnit(Unit* who) override;

        void UpdateAI(uint32 diff) override;
    };
};

class spell_grobbulus_poison : public SpellScriptLoader
{
public:
    spell_grobbulus_poison() : SpellScriptLoader("spell_grobbulus_poison") { }

    class spell_grobbulus_poison_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_grobbulus_poison_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets);

        void Register() override;
    };

    SpellScript* GetSpellScript() const override;
};

class spell_grobbulus_mutating_injection : public SpellScriptLoader
{
    public:
        spell_grobbulus_mutating_injection() : SpellScriptLoader("spell_grobbulus_mutating_injection") { }

        class spell_grobbulus_mutating_injection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_grobbulus_mutating_injection_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) override;

            void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/);

            void Register() override;
        };

        AuraScript* GetAuraScript() const override;
};

#endif