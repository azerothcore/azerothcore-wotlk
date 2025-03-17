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
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "naxxramas.h"

enum Spells
{
    SPELL_POISON_CLOUD                      = 28240,
    SPELL_MUTATING_INJECTION                = 28169,
    SPELL_MUTATING_EXPLOSION                = 28206,
    SPELL_SLIME_SPRAY_10                    = 28157,
    SPELL_SLIME_SPRAY_25                    = 54364,
    SPELL_POISON_CLOUD_DAMAGE_AURA_10       = 28158,
    SPELL_POISON_CLOUD_DAMAGE_AURA_25       = 54362,
    SPELL_BERSERK                           = 26662,
    SPELL_BOMBARD_SLIME                     = 28280
};

enum Emotes
{
    EMOTE_SLIME                             = 0
};

enum Events
{
    EVENT_BERSERK                           = 1,
    EVENT_POISON_CLOUD                      = 2,
    EVENT_SLIME_SPRAY                       = 3,
    EVENT_MUTATING_INJECTION                = 4
};

enum Misc
{
    NPC_FALLOUT_SLIME                       = 16290,
    NPC_SEWAGE_SLIME                        = 16375,
    NPC_STICHED_GIANT                       = 16025
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
        {}

        EventMap events;
        SummonList summons;
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
            me->GetCreaturesWithEntryInRange(StichedGiants, 300.0f, NPC_STICHED_GIANT);
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
            events.ScheduleEvent(EVENT_POISON_CLOUD, 15s);
            events.ScheduleEvent(EVENT_MUTATING_INJECTION, 20s);
            events.ScheduleEvent(EVENT_SLIME_SPRAY, 10s);
            events.ScheduleEvent(EVENT_BERSERK, RAID_MODE(720000, 540000));
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == RAID_MODE(SPELL_SLIME_SPRAY_10, SPELL_SLIME_SPRAY_25) && target->IsPlayer())
            {
                me->SummonCreature(NPC_FALLOUT_SLIME, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_FALLOUT_SLIME)
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
            if (who->IsPlayer())
                instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void UpdateAI(uint32 diff) override
        {
            dropSludgeTimer += diff;
            if (!me->IsInCombat() && dropSludgeTimer >= 5000)
            {
                if (me->IsWithinDist3d(3178, -3305, 319, 5.0f) && !summons.HasEntry(NPC_SEWAGE_SLIME))
                {
                    me->CastSpell(3128.96f + irand(-20, 20), -3312.96f + irand(-20, 20), 293.25f, SPELL_BOMBARD_SLIME, false);
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
                case EVENT_POISON_CLOUD:
                    me->CastSpell(me, SPELL_POISON_CLOUD, true);
                    events.Repeat(15s);
                    break;
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_SLIME_SPRAY:
                    Talk(EMOTE_SLIME);
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_SLIME_SPRAY_10, SPELL_SLIME_SPRAY_25), false);
                    events.Repeat(20s);
                    break;
                case EVENT_MUTATING_INJECTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true, true, -SPELL_MUTATING_INJECTION))
                    {
                        me->CastSpell(target, SPELL_MUTATING_INJECTION, false);
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
            if (who->IsPlayer())
                me->GetInstanceScript()->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void UpdateAI(uint32 diff) override
        {
            if (auraVisualTimer) // this has to be delayed to be visible
            {
                auraVisualTimer += diff;
                if (auraVisualTimer >= 1000)
                {
                    me->CastSpell(me, (me->GetMap()->Is25ManRaid() ? SPELL_POISON_CLOUD_DAMAGE_AURA_25 : SPELL_POISON_CLOUD_DAMAGE_AURA_10), true);
                    auraVisualTimer = 0;
                }
            }
            sizeTimer += diff; // increase size to 15yd in 60 seconds, 0.00025 is the growth of size in 1ms
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 2.0f + (0.00025f * sizeTimer));
        }
    };
};

class spell_grobbulus_poison : public SpellScript
{
    PrepareSpellScript(spell_grobbulus_poison);

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
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_grobbulus_poison::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_grobbulus_mutating_injection_aura : public AuraScript
{
    PrepareAuraScript(spell_grobbulus_mutating_injection_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MUTATING_EXPLOSION });
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        switch (GetTargetApplication()->GetRemoveMode())
        {
            case AURA_REMOVE_BY_ENEMY_SPELL:
            case AURA_REMOVE_BY_EXPIRE:
                if (auto caster = GetCaster())
                {
                    caster->CastSpell(GetTarget(), SPELL_MUTATING_EXPLOSION, true);
                }
                break;
            default:
                return;
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_grobbulus_mutating_injection_aura::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_grobbulus()
{
    new boss_grobbulus();
    new boss_grobbulus_poison_cloud();
    RegisterSpellScript(spell_grobbulus_mutating_injection_aura);
    RegisterSpellScript(spell_grobbulus_poison);
}
