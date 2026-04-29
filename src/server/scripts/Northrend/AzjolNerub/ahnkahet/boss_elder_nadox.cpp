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
#include "Containers.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ahnkahet.h"

enum Misc
{
    // ACTIONS
    DATA_RESPECT_YOUR_ELDERS        = 1,
};

enum Spells
{
    // NADOX
    SPELL_BROOD_PLAGUE              = 56130,
    SPELL_BROOD_RAGE_H              = 59465,    // Only in heroic
    SPELL_ENRAGE                    = 26662,    // Enraged if too far away from home
    SPELL_SUMMON_SWARMERS           = 56119,    // 2x NPC_AHNKAHAR_SWARMER
    SPELL_SUMMON_SWARM_GUARD        = 56120,    // 1x NPC_AHNKAHAR_GUARDIAN_ENTRY  -- at 50%hp
    SPELL_SWARM                     = 56281,

    // ADDS
    SPELL_SPRINT                    = 56354,
    SPELL_GUARDIAN_AURA             = 56151,
    SPELL_SWARMER_AURA              = 56158,
};

enum Creatures
{
    NPC_AHNKAHAR_SWARMER            = 30178,
    NPC_AHNKAHAR_GUARDIAN           = 30176,
    NPC_AHNKAHAR_SWARM_EGG          = 30172,
    NPC_AHNKAHAR_GUARDIAN_EGG       = 30173,
};

enum Events
{
    EVENT_CHECK_HOME                = 1,
    EVENT_PLAGUE,
    EVENT_BROOD_RAGE,
    EVENT_SWARMER,
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_DEATH                       = 2,
    SAY_EGG_SAC                     = 3,
    EMOTE_HATCHES                   = 4
};

struct boss_elder_nadox : public BossAI
{
    boss_elder_nadox(Creature* creature) : BossAI(creature, DATA_ELDER_NADOX),
        guardianSummoned(false),
        respectYourElders(true)
    {
    }

    void Reset() override
    {
        _Reset();

        // Clear eggs data
        swarmEggs.clear();
        guardianEggs.clear();
        previousSwarmEgg_GUID.Clear();
        guardianSummoned = false;
        respectYourElders = true;
    }

    void JustEngagedWith(Unit * /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        events.ScheduleEvent(EVENT_SWARMER, 10s);
        events.ScheduleEvent(EVENT_CHECK_HOME, 2s);
        events.ScheduleEvent(EVENT_PLAGUE, 5s, 8s);

        if (IsHeroic())
            events.ScheduleEvent(EVENT_BROOD_RAGE, 5s);

        // Cache eggs
        std::list<Creature*> eggs;
        // Swarm eggs
        me->GetCreatureListWithEntryInGrid(eggs, NPC_AHNKAHAR_SWARM_EGG, 250.0f);
        if (!eggs.empty())
        {
            for (Creature* const egg : eggs)
            {
                if (egg)
                {
                    swarmEggs.push_back(egg->GetGUID());
                }
            }
        }

        eggs.clear();

        // Guardian eggs
        me->GetCreatureListWithEntryInGrid(eggs, NPC_AHNKAHAR_GUARDIAN_EGG, 250.0f);
        if (!eggs.empty())
        {
            for (Creature* const egg : eggs)
            {
                if (egg)
                {
                    guardianEggs.push_back(egg->GetGUID());
                }
            }
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (summon->GetEntry() == NPC_AHNKAHAR_GUARDIAN)
            respectYourElders = false;
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*school*/) override
    {
        if (!guardianSummoned && me->HealthBelowPctDamaged(50, damage))
        {
            SummonHelpers(false);
            guardianSummoned = true;
        }
    }

    uint32 GetData(uint32 type) const override
    {
        if (type == DATA_RESPECT_YOUR_ELDERS)
            return respectYourElders ? 1 : 0;

        return 0;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 const eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_BROOD_RAGE:
                {
                    if (Creature* pSwarmer = me->FindNearestCreature(NPC_AHNKAHAR_SWARMER, 40, true))
                        DoCast(pSwarmer, SPELL_BROOD_RAGE_H, true);

                    events.Repeat(10s);
                    break;
                }
                case EVENT_PLAGUE:
                {
                    DoCastVictim(SPELL_BROOD_PLAGUE, false);
                    events.Repeat(12s, 17s);
                    break;
                }
                case EVENT_SWARMER:
                {
                    SummonHelpers(true);
                    events.Repeat(10s);
                    break;
                }
                case EVENT_CHECK_HOME:
                {
                    if (!me->HasAura(SPELL_ENRAGE) && (me->GetPositionZ() < 24.0f || !me->GetHomePosition().IsInDist(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 110.0f)))
                        DoCastSelf(SPELL_ENRAGE, true);
                    events.Repeat(1s);
                    break;
                }
            }
        }

        DoMeleeAttackIfReady();
    }

private:
    GuidList swarmEggs;
    GuidList guardianEggs;
    ObjectGuid previousSwarmEgg_GUID;   // This will prevent casting summoning spells on same egg twice
    bool guardianSummoned;
    bool respectYourElders;

    void SummonHelpers(bool swarm)
    {
        if (swarm)
        {
            if (swarmEggs.empty())
                return;

            // Make a copy of guid list
            GuidList swarmEggs2 = swarmEggs;

            // Remove previous egg
            if (previousSwarmEgg_GUID)
            {
                std::list<ObjectGuid>::iterator itr = std::find(swarmEggs2.begin(), swarmEggs2.end(), previousSwarmEgg_GUID);
                if (itr != swarmEggs2.end())
                {
                    swarmEggs2.erase(itr);
                }
            }

            if (swarmEggs2.empty())
                return;

            previousSwarmEgg_GUID = Acore::Containers::SelectRandomContainerElement(swarmEggs2);

            if (Creature* egg = ObjectAccessor::GetCreature(*me, previousSwarmEgg_GUID))
                egg->CastSpell(egg, SPELL_SUMMON_SWARMERS, true, nullptr, nullptr, me->GetGUID());

            if (roll_chance_f(33))
                Talk(SAY_EGG_SAC);
        }
        else
        {
            if (guardianEggs.empty())
                return;

            ObjectGuid const& guardianEggGUID = Acore::Containers::SelectRandomContainerElement(guardianEggs);
            if (Creature* egg = ObjectAccessor::GetCreature(*me, guardianEggGUID))
                egg->CastSpell(egg, SPELL_SUMMON_SWARM_GUARD, true, nullptr, nullptr, me->GetGUID());

            Talk(EMOTE_HATCHES, me);

            if (roll_chance_f(33))
                Talk(SAY_EGG_SAC);
        }
    }
};

struct npc_ahnkahar_nerubian : public ScriptedAI
{
    npc_ahnkahar_nerubian(Creature* c) : ScriptedAI(c) { }

    void Reset() override
    {
        DoCastSelf(me->GetEntry() == NPC_AHNKAHAR_GUARDIAN ? SPELL_GUARDIAN_AURA : SPELL_SWARMER_AURA, true);
        uiSprintTimer = 10000;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (uiSprintTimer <= diff)
        {
            DoCastSelf(SPELL_SPRINT, false);
            uiSprintTimer = 15000;
        }
        else
            uiSprintTimer -= diff;

        DoMeleeAttackIfReady();
    }

private:
    uint32 uiSprintTimer;
};

class spell_ahn_kahet_swarmer_aura : public SpellScript
{
    PrepareSpellScript(spell_ahn_kahet_swarmer_aura)

    void CountTargets(std::list<WorldObject*>& targets)
    {
        _targetCount = static_cast<uint32>(targets.size());
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (_targetCount)
        {
            if (Aura *aur = caster->GetAura(SPELL_SWARM))
            {
                aur->SetStackAmount(static_cast<uint8>(_targetCount));
            }
            else if (_targetCount)
            {
                /// @todo: move spell id to enum
                caster->CastCustomSpell(SPELL_SWARM, SPELLVALUE_AURA_STACK, _targetCount, caster, true);
                if (Aura *aur = caster->GetAura(SPELL_SWARM))
                {
                    aur->SetStackAmount(static_cast<uint8>(_targetCount));
                }
            }
        }
        else
        {
            caster->RemoveAurasDueToSpell(SPELL_SWARM);
        }
    }

    uint32 _targetCount;

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_ahn_kahet_swarmer_aura::CountTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
        OnEffectHitTarget += SpellEffectFn(spell_ahn_kahet_swarmer_aura::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 7317 - Respect Your Elders (2038)
class achievement_respect_your_elders : public AchievementCriteriaScript
{
    public:
        achievement_respect_your_elders() : AchievementCriteriaScript("achievement_respect_your_elders") { }

        bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
        {
            return target && target->GetAI()->GetData(DATA_RESPECT_YOUR_ELDERS);
        }
};

void AddSC_boss_elder_nadox()
{
    // Creatures
    RegisterAhnKahetCreatureAI(boss_elder_nadox);
    RegisterAhnKahetCreatureAI(npc_ahnkahar_nerubian);

    // Spells
    RegisterSpellScript(spell_ahn_kahet_swarmer_aura);

    // Achievements
    new achievement_respect_your_elders();
}
