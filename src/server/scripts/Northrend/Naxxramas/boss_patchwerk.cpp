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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "naxxramas.h"

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_DEATH                       = 2,
    EMOTE_BERSERK                   = 3,
    EMOTE_ENRAGE                    = 4
};

enum Spells
{
    SPELL_HATEFUL_STRIKE_PRIMER     = 28307,
    SPELL_HATEFUL_STRIKE            = 28308,
    SPELL_FRENZY                    = 28131,
    SPELL_BERSERK                   = 26662,
    SPELL_SLIME_BOLT                = 32309
};

enum Events
{
    EVENT_HEALTH_CHECK              = 1,
    EVENT_HATEFUL_STRIKE            = 2,
    EVENT_SLIME_BOLT                = 3,
    EVENT_BERSERK                   = 4
};

enum Misc
{
    ACHIEV_TIMED_START_EVENT        = 10286,
    HATEFUL_THREAT_AMT              = 500
};

class boss_patchwerk : public CreatureScript
{
public:
    boss_patchwerk() : CreatureScript("boss_patchwerk") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_patchwerkAI>(pCreature);
    }

    struct boss_patchwerkAI : public BossAI
    {
        explicit boss_patchwerkAI(Creature* c) : BossAI(c, BOSS_PATCHWERK)
        {}

        EventMap events;

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
        }

        void KilledUnit(Unit* who) override
        {
            if (!who->IsPlayer())
                return;

            if (!urand(0, 3))
                Talk(SAY_SLAY);

            instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_AGGRO);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_HATEFUL_STRIKE, 1500ms);
            events.ScheduleEvent(EVENT_BERSERK, 6min);
            events.ScheduleEvent(EVENT_HEALTH_CHECK, 1s);
            instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
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
                case EVENT_HATEFUL_STRIKE:
                    // target selection, threat and damage are handled by the primer spell script
                    DoCastSelf(SPELL_HATEFUL_STRIKE_PRIMER, true);
                    events.Repeat(1s);
                    break;
                case EVENT_BERSERK:
                    Talk(EMOTE_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.ScheduleEvent(EVENT_SLIME_BOLT, 3s);
                    break;
                case EVENT_SLIME_BOLT:
                    me->CastSpell(me, SPELL_SLIME_BOLT, false);
                    events.Repeat(3s);
                    break;
                case EVENT_HEALTH_CHECK:
                    if (me->GetHealthPct() <= 5)
                    {
                        Talk(EMOTE_ENRAGE);
                        me->CastSpell(me, SPELL_FRENZY, true);
                        break;
                    }
                    events.Repeat(1s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

// 28307 - Hateful Strike Primer
class spell_patchwerk_hateful_strike_primer : public SpellScript
{
    PrepareSpellScript(spell_patchwerk_hateful_strike_primer);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HATEFUL_STRIKE });
    }

    void SelectTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();

        uint32 targetLimit = caster->GetMap()->Is25ManRaid() ? 3 : 2;
        std::array<Unit*, 3> newTargets = { };
        auto newTargetsItr = newTargets.begin();
        auto newTargetsEnd = newTargetsItr + targetLimit;

        for (ThreatReference const* threatRef : caster->GetThreatMgr().GetSortedThreatList())
        {
            Unit* threatVictim = threatRef->GetVictim();
            if (!threatRef->IsOnline() || !threatVictim->IsPlayer() || !caster->IsWithinMeleeRange(threatVictim))
                continue;

            *newTargetsItr = threatVictim;
            if (++newTargetsItr == newTargetsEnd)
                break;
        }

        // Hateful Strike damages the higher HP target out of the two highest non-MT threats in melee range on 25man
        if (newTargets[1] && newTargets[2] && newTargets[1]->GetHealth() < newTargets[2]->GetHealth())
            std::swap(newTargets[1], newTargets[2]);

        targets.assign(newTargets.begin(), newTargetsItr);
    }

    void HandleEffect(SpellEffIndex effIndex)
    {
        Unit* caster = GetCaster();

        // all targets get threat increase
        caster->GetThreatMgr().AddThreat(GetHitUnit(), HATEFUL_THREAT_AMT, GetSpellInfo());

        // Hateful Strike damages the second unit on target list (not the MT)
        // or MT if it is the only target
        if (GetUnitTargetIndexForEffect(GetHitUnit()->GetGUID(), effIndex) == 1
            || GetUnitTargetCountForEffect(effIndex) == 1)
            caster->CastSpell(GetHitUnit(), SPELL_HATEFUL_STRIKE, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_patchwerk_hateful_strike_primer::SelectTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_patchwerk_hateful_strike_primer::HandleEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_patchwerk()
{
    new boss_patchwerk();
    RegisterSpellScript(spell_patchwerk_hateful_strike_primer);
}
