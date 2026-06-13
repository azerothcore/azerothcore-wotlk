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
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "temple_of_ahnqiraj.h"

enum Emotes
{
    EMOTE_FRENZY_KILL           = 0,
    EMOTE_BERSERK               = 1
};

enum Spells
{
    SPELL_FRENZY                = 26051, // triggers SPELL_POISON_BOLT
    SPELL_BERSERK               = 26068, // triggers SPELL_POISON_BOLT
    SPELL_NOXIOUS_POISON        = 26053,
    SPELL_WYVERN_STING          = 26180,
    SPELL_ACID_SPIT             = 26050,
    SPELL_WYVERN_STING_DAMAGE   = 26233,
    SPELL_POISON_BOLT           = 26052
};

enum Events
{
    EVENT_FRENZY                = 1,
    EVENT_WYVERN_STING          = 2,
    EVENT_ACID_SPIT             = 3,
    EVENT_NOXIOUS_POISON        = 4,
    EVENT_HARD_ENRAGE           = 5
};

struct boss_huhuran : public BossAI
{
    boss_huhuran(Creature* creature) : BossAI(creature, DATA_HUHURAN)
    {
        me->m_CombatDistance = 90.f;
    }

    void Reset() override
    {
        BossAI::Reset();
        _berserk = false;
        _hardEnrage = false;
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_FRENZY, 12s, 21s);
        events.ScheduleEvent(EVENT_WYVERN_STING, 25s, 43s);
        events.ScheduleEvent(EVENT_ACID_SPIT, 1s, 20s);
        events.ScheduleEvent(EVENT_NOXIOUS_POISON, 10s, 22s);
        events.ScheduleEvent(EVENT_HARD_ENRAGE, 5min);
    }

    void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
    {
        if (!_berserk && HealthBelowPct(30))
        {
            DoCastSelf(SPELL_BERSERK, true);
            me->TextEmote(EMOTE_BERSERK);
            events.CancelEvent(EVENT_FRENZY);
            _berserk = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        while (uint32 eventid = events.ExecuteEvent())
        {
            switch (eventid)
            {
                case EVENT_FRENZY:
                    DoCastSelf(SPELL_FRENZY, true);
                    Talk(EMOTE_FRENZY_KILL);
                    events.Repeat(12s, 21s);
                    break;
                case EVENT_WYVERN_STING:
                    me->CastCustomSpell(SPELL_WYVERN_STING, SPELLVALUE_MAX_TARGETS, 10, me, true);
                    events.Repeat(25s, 43s);
                    break;
                case EVENT_ACID_SPIT:
                    DoCastVictim(SPELL_ACID_SPIT);
                    events.Repeat(1s, 20s);
                    break;
                case EVENT_NOXIOUS_POISON:
                    DoCastRandomTarget(SPELL_NOXIOUS_POISON, 0, 100.f, true);
                    events.Repeat(10s, 22s);
                    break;
                case EVENT_HARD_ENRAGE:
                    if (!_hardEnrage)
                    {
                        DoCastSelf(SPELL_BERSERK, true);
                        events.CancelEvent(EVENT_FRENZY);
                        _hardEnrage = true;
                    }
                    else
                    {
                        DoCastAOE(SPELL_POISON_BOLT);
                    }
                    events.Repeat(2s);
                    break;
                default:
                    break;
            }
        }
        DoMeleeAttackIfReady();
    }

private:
    bool _berserk;
    bool _hardEnrage;
};

// 26180 - Wyvern Sting
class spell_huhuran_wyvern_sting : public AuraScript
{
    PrepareAuraScript(spell_huhuran_wyvern_sting);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_ENEMY_SPELL) // dispelled
        {
            if (Unit* caster = GetCaster())
            {
                caster->CastCustomSpell(SPELL_WYVERN_STING_DAMAGE, SPELLVALUE_BASE_POINT0, 3000, GetUnitOwner(), true);
            }
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_huhuran_wyvern_sting::OnRemove, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

// 26052 - Poison Bolt
// 26180 - Wyvern Sting
class spell_huhuran_poison_bolt : public SpellScript
{
    PrepareSpellScript(spell_huhuran_poison_bolt);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        uint32 const maxTargets = GetSpellInfo()->MaxAffectedTargets;
        if (targets.size() > maxTargets)
        {
            targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
            targets.resize(maxTargets);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_huhuran_poison_bolt::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_huhuran()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_huhuran);
    RegisterSpellScript(spell_huhuran_wyvern_sting);
    RegisterSpellScript(spell_huhuran_poison_bolt);
}
