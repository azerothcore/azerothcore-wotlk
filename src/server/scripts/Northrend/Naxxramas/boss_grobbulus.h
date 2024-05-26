#ifndef BOSSGROBBULUS_H_
#define BOSSGROBBULUS_H_

#include "PassiveAI.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "naxxramas.h"

namespace Grobbulus {
    
enum GrobbulusSpells
{
    GROBBULUS_SPELL_POISON_CLOUD                      = 28240,
    GROBBULUS_SPELL_MUTATING_INJECTION                = 28169,
    GROBBULUS_SPELL_MUTATING_EXPLOSION                = 28206,
    GROBBULUS_SPELL_SLIME_SPRAY_10                    = 28157,
    GROBBULUS_SPELL_SLIME_SPRAY_25                    = 54364,
    GROBBULUS_SPELL_POISON_CLOUD_DAMAGE_AURA_10       = 28158,
    GROBBULUS_SPELL_POISON_CLOUD_DAMAGE_AURA_25       = 54362,
    GROBBULUS_SPELL_BERSERK                           = 26662,
    GROBBULUS_SPELL_BOMBARD_SLIME                     = 28280
};

enum GrobbulusEmotes
{
    GROBBULUS_EMOTE_SLIME                             = 0
};

enum GrobbulusEvents
{
    GROBBULUS_EVENT_BERSERK                           = 1,
    GROBBULUS_EVENT_POISON_CLOUD                      = 2,
    GROBBULUS_EVENT_SLIME_SPRAY                       = 3,
    GROBBULUS_EVENT_MUTATING_INJECTION                = 4
};

enum GrobbulusMisc
{
    GROBBULUS_NPC_FALLOUT_SLIME                       = 16290,
    GROBBULUS_NPC_SEWAGE_SLIME                        = 16375,
    GROBBULUS_NPC_STICHED_GIANT                       = 16025
};

class boss_grobbulus : public CreatureScript
{
public:
    boss_grobbulus() : CreatureScript("boss_grobbulus") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_grobbulusAI>(pCreature);
    }

    struct boss_grobbulusAI : public BossAI
    {
        explicit boss_grobbulusAI(Creature* c) : BossAI(c, BOSS_GROBBULUS), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        uint32 dropSludgeTimer{};

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            dropSludgeTimer = 0;
        }

        void PullChamberAdds()
        {
            std::list<Creature*> StichedGiants;
            me->GetCreaturesWithEntryInRange(StichedGiants, 300.0f, GROBBULUS_NPC_STICHED_GIANT);
            for (std::list<Creature*>::const_iterator itr = StichedGiants.begin(); itr != StichedGiants.end(); ++itr)
            {
                (*itr)->ToCreature()->AI()->AttackStart(me->GetVictim());
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            PullChamberAdds();
            me->SetInCombatWithZone();
            events.ScheduleEvent(GROBBULUS_EVENT_POISON_CLOUD, 15s);
            events.ScheduleEvent(GROBBULUS_EVENT_MUTATING_INJECTION, 20s);
            events.ScheduleEvent(GROBBULUS_EVENT_SLIME_SPRAY, 10s);
            events.ScheduleEvent(GROBBULUS_EVENT_BERSERK, RAID_MODE(720000, 540000));
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == RAID_MODE(GROBBULUS_SPELL_SLIME_SPRAY_10, GROBBULUS_SPELL_SLIME_SPRAY_25) && target->GetTypeId() == TYPEID_PLAYER)
            {
                me->SummonCreature(GROBBULUS_NPC_FALLOUT_SLIME, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == GROBBULUS_NPC_FALLOUT_SLIME)
            {
                cr->SetInCombatWithZone();
            }
            summons.Summon(cr);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            dropSludgeTimer += diff;
            if (!me->IsInCombat() && dropSludgeTimer >= 5000)
            {
                if (me->IsWithinDist3d(3178, -3305, 319, 5.0f) && !summons.HasEntry(GROBBULUS_NPC_SEWAGE_SLIME))
                {
                    me->CastSpell(3128.96f + irand(-20, 20), -3312.96f + irand(-20, 20), 293.25f, GROBBULUS_SPELL_BOMBARD_SLIME, false);
                }
                dropSludgeTimer = 0;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case GROBBULUS_EVENT_POISON_CLOUD:
                    me->CastSpell(me, GROBBULUS_SPELL_POISON_CLOUD, true);
                    events.Repeat(15s);
                    break;
                case GROBBULUS_EVENT_BERSERK:
                    me->CastSpell(me, GROBBULUS_SPELL_BERSERK, true);
                    break;
                case GROBBULUS_EVENT_SLIME_SPRAY:
                    Talk(GROBBULUS_EMOTE_SLIME);
                    me->CastSpell(me->GetVictim(), RAID_MODE(GROBBULUS_SPELL_SLIME_SPRAY_10, GROBBULUS_SPELL_SLIME_SPRAY_25), false);
                    events.Repeat(20s);
                    break;
                case GROBBULUS_EVENT_MUTATING_INJECTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true, true, -GROBBULUS_SPELL_MUTATING_INJECTION))
                    {
                        me->CastSpell(target, GROBBULUS_SPELL_MUTATING_INJECTION, false);
                    }
                    events.RepeatEvent(6000 + uint32(120 * me->GetHealthPct()));
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_grobbulus_poison_cloud : public CreatureScript
{
public:
    boss_grobbulus_poison_cloud() : CreatureScript("boss_grobbulus_poison_cloud") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_grobbulus_poison_cloudAI>(pCreature);
    }

    struct boss_grobbulus_poison_cloudAI : public NullCreatureAI
    {
        explicit boss_grobbulus_poison_cloudAI(Creature* pCreature) : NullCreatureAI(pCreature) { }

        uint32 sizeTimer{};
        uint32 auraVisualTimer{};

        void Reset() override
        {
            sizeTimer = 0;
            auraVisualTimer = 1;
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 2.0f);
            me->SetFaction(FACTION_BOOTY_BAY);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetInstanceScript())
            {
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (auraVisualTimer) // this has to be delayed to be visible
            {
                auraVisualTimer += diff;
                if (auraVisualTimer >= 1000)
                {
                    me->CastSpell(me, (me->GetMap()->Is25ManRaid() ? GROBBULUS_SPELL_POISON_CLOUD_DAMAGE_AURA_25 : GROBBULUS_SPELL_POISON_CLOUD_DAMAGE_AURA_10), true);
                    auraVisualTimer = 0;
                }
            }
            sizeTimer += diff; // increase size to 15yd in 60 seconds, 0.00025 is the growth of size in 1ms
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 2.0f + (0.00025f * sizeTimer));
        }
    };
};

class spell_grobbulus_poison : public SpellScriptLoader
{
public:
    spell_grobbulus_poison() : SpellScriptLoader("spell_grobbulus_poison") { }

    class spell_grobbulus_poison_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_grobbulus_poison_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            std::list<WorldObject*> tmplist;
            for (auto& target : targets)
            {
                if (GetCaster()->IsWithinDist3d(target, 0.0f))
                {
                    tmplist.push_back(target);
                }
            }
            targets.clear();
            for (auto& itr : tmplist)
            {
                targets.push_back(itr);
            }
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_grobbulus_poison_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_grobbulus_poison_SpellScript();
    }
};

class spell_grobbulus_mutating_injection : public SpellScriptLoader
{
    public:
        spell_grobbulus_mutating_injection() : SpellScriptLoader("spell_grobbulus_mutating_injection") { }

        class spell_grobbulus_mutating_injection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_grobbulus_mutating_injection_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) override
            {
                return ValidateSpellInfo({ GROBBULUS_SPELL_MUTATING_EXPLOSION });
            }

            void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                switch (GetTargetApplication()->GetRemoveMode())
                {
                    case AURA_REMOVE_BY_ENEMY_SPELL:
                    case AURA_REMOVE_BY_EXPIRE:
                        if (auto caster = GetCaster())
                        {
                            caster->CastSpell(GetTarget(), GROBBULUS_SPELL_MUTATING_EXPLOSION, true);
                        }
                        break;
                    default:
                        return;
                }
            }

            void Register() override
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_grobbulus_mutating_injection_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_grobbulus_mutating_injection_AuraScript();
        }
};

}

#endif