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
#include "GameEventMgr.h"
#include "GridNotifiers.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "nexus.h"
#include "SpellInfo.h"
#include "SpellScript.h"

enum Spells
{
    // Main
    SPELL_ICE_NOVA                  = 47772,
    SPELL_FIREBOMB                  = 47773,

    SPELL_GRAVITY_WELL              = 47756,
    SPELL_TELESTRA_BACK             = 47714,
    SPELL_BURNING_WINDS             = 46308,
    SPELL_START_SUMMON_CLONES       = 47710,

    SPELL_FIRE_MAGUS_SUMMON         = 47707,
    SPELL_FROST_MAGUS_SUMMON        = 47709,
    SPELL_ARCANE_MAGUS_SUMMON       = 47708,

    SPELL_FIRE_MAGUS_DEATH          = 47711,
    SPELL_ARCANE_MAGUS_DEATH        = 47713,

    SPELL_WEAR_CHRISTMAS_HAT        = 61400
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_KILL                        = 1,
    SAY_DEATH                       = 2,
    SAY_MERGE                       = 3,
    SAY_SPLIT                       = 4
};

enum Misc
{
    NPC_FIRE_MAGUS                  = 26928,
    NPC_FROST_MAGUS                 = 26930,
    NPC_ARCANE_MAGUS                = 26929,

    ACHIEVEMENT_SPLIT_PERSONALITY   = 2150,

    GAME_EVENT_WINTER_VEIL          = 2,
};

enum Events
{
    EVENT_MAGUS_ICE_NOVA            = 1,
    EVENT_MAGUS_FIREBOMB            = 2,
    EVENT_MAGUS_GRAVITY_WELL        = 3,
    EVENT_MAGUS_HEALTH1             = 4,
    EVENT_MAGUS_HEALTH2             = 5,
    EVENT_MAGUS_FAIL_ACHIEVEMENT    = 6,
    EVENT_MAGUS_MERGED              = 7,
    EVENT_MAGUS_RELOCATE            = 8,
    EVENT_KILL_TALK                 = 9
};

struct boss_magus_telestra : public BossAI
{
    boss_magus_telestra(Creature* creature) : BossAI(creature, DATA_MAGUS_TELESTRA_EVENT) { }

    uint8 copiesDied;
    bool achievement;

    void Reset() override
    {
        BossAI::Reset();
        copiesDied = 0;
        achievement = true;

        if (IsHeroic() && sGameEventMgr->IsActiveEvent(GAME_EVENT_WINTER_VEIL) && !me->HasAura(SPELL_WEAR_CHRISTMAS_HAT))
            me->AddAura(SPELL_WEAR_CHRISTMAS_HAT, me);
    }

    uint32 GetData(uint32 data) const override
    {
        if (data == me->GetEntry())
            return achievement;
        return 0;
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);

        events.ScheduleEvent(EVENT_MAGUS_ICE_NOVA, 10s);
        events.ScheduleEvent(EVENT_MAGUS_FIREBOMB, 0ms);
        events.ScheduleEvent(EVENT_MAGUS_GRAVITY_WELL, 20s);
        events.ScheduleEvent(EVENT_MAGUS_HEALTH1, 1s);
        if (IsHeroic())
            events.ScheduleEvent(EVENT_MAGUS_HEALTH2, 1s);
    }

    void AttackStart(Unit* who) override
    {
        if (who && me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 20.0f);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit*) override
    {
        if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
        {
            Talk(SAY_KILL);
            events.ScheduleEvent(EVENT_KILL_TALK, 6s);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        summon->SetInCombatWithZone();
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id >= SPELL_FIRE_MAGUS_DEATH && spellInfo->Id <= SPELL_ARCANE_MAGUS_DEATH && caster->ToCreature())
        {
            events.ScheduleEvent(EVENT_MAGUS_FAIL_ACHIEVEMENT, 5s);
            caster->ToCreature()->DespawnOrUnsummon(1000);

            if (++copiesDied >= 3)
            {
                copiesDied = 0;
                events.CancelEvent(EVENT_MAGUS_FAIL_ACHIEVEMENT);
                events.ScheduleEvent(EVENT_MAGUS_MERGED, 5s);
                me->CastSpell(me, SPELL_BURNING_WINDS, true);
            }
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
        case EVENT_MAGUS_HEALTH1:
            if (me->HealthBelowPct(51))
            {
                me->CastSpell(me, SPELL_START_SUMMON_CLONES, false);
                events.ScheduleEvent(EVENT_MAGUS_RELOCATE, 3500ms);
                Talk(SAY_SPLIT);
                break;
            }
            events.ScheduleEvent(EVENT_MAGUS_HEALTH1, 1s);
            break;
        case EVENT_MAGUS_HEALTH2:
            if (me->HealthBelowPct(11))
            {
                me->CastSpell(me, SPELL_START_SUMMON_CLONES, false);
                events.ScheduleEvent(EVENT_MAGUS_RELOCATE, 3500ms);
                Talk(SAY_SPLIT);
                break;
            }
            events.ScheduleEvent(EVENT_MAGUS_HEALTH2, 1s);
            break;
        case EVENT_MAGUS_FIREBOMB:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                me->CastSpell(target, SPELL_FIREBOMB, false);
            events.ScheduleEvent(EVENT_MAGUS_FIREBOMB, 3s);
            break;
        case EVENT_MAGUS_ICE_NOVA:
            me->CastSpell(me, SPELL_ICE_NOVA, false);
            events.ScheduleEvent(EVENT_MAGUS_ICE_NOVA, 15s);
            break;
        case EVENT_MAGUS_GRAVITY_WELL:
            me->CastSpell(me, SPELL_GRAVITY_WELL, false);
            events.ScheduleEvent(EVENT_MAGUS_GRAVITY_WELL, 15s);
            break;
        case EVENT_MAGUS_FAIL_ACHIEVEMENT:
            achievement = false;
            break;
        case EVENT_MAGUS_RELOCATE:
            me->NearTeleportTo(505.04f, 88.915f, -16.13f, 2.98f);
            break;
        case EVENT_MAGUS_MERGED:
            me->CastSpell(me, SPELL_TELESTRA_BACK, true);
            me->RemoveAllAuras();
            Talk(SAY_MERGE);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

class spell_boss_magus_telestra_summon_telestra_clones_aura : public AuraScript
{
    PrepareAuraScript(spell_boss_magus_telestra_summon_telestra_clones_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FIRE_MAGUS_SUMMON, SPELL_FROST_MAGUS_SUMMON, SPELL_ARCANE_MAGUS_SUMMON });
    }

    bool Load() override
    {
        return GetUnitOwner()->IsCreature();
    }

    void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FIRE_MAGUS_SUMMON, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FROST_MAGUS_SUMMON, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_ARCANE_MAGUS_SUMMON, true);

        GetUnitOwner()->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        GetUnitOwner()->SetControlled(true, UNIT_STATE_STUNNED);
        GetUnitOwner()->ToCreature()->LoadEquipment(0, true);
    }

    void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        GetUnitOwner()->SetControlled(false, UNIT_STATE_STUNNED);
        GetUnitOwner()->ToCreature()->LoadEquipment(1, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_boss_magus_telestra_summon_telestra_clones_aura::HandleApply, EFFECT_1, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_boss_magus_telestra_summon_telestra_clones_aura::HandleRemove, EFFECT_1, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_boss_magus_telestra_gravity_well : public SpellScript
{
    PrepareSpellScript(spell_boss_magus_telestra_gravity_well);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::RandomCheck(50));
    }

    void HandlePull(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* target = GetHitUnit();
        if (!target)
            return;

        Position pos;
        if (target->GetDistance(GetCaster()) < 5.0f)
        {
            pos.Relocate(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ() + 1.0f);
            float o = frand(0, 2 * M_PI);
            target->MovePositionToFirstCollision(pos, 20.0f, o);
            pos.m_positionZ += frand(5.0f, 15.0f);
        }
        else
            pos.Relocate(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ() + 1.0f);

        float speedXY = float(GetSpellInfo()->Effects[effIndex].MiscValue) * 0.1f;
        float speedZ = target->GetDistance(pos) / speedXY * 0.5f * Movement::gravity;

        target->GetMotionMaster()->MoveJump(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), speedXY, speedZ);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_boss_magus_telestra_gravity_well::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_boss_magus_telestra_gravity_well::HandlePull, EFFECT_0, SPELL_EFFECT_PULL_TOWARDS_DEST);
    }
};

class achievement_split_personality : public AchievementCriteriaScript
{
public:
    achievement_split_personality() : AchievementCriteriaScript("achievement_split_personality")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_magus_telestra()
{
    RegisterNexusCreatureAI(boss_magus_telestra);
    RegisterSpellScript(spell_boss_magus_telestra_summon_telestra_clones_aura);
    RegisterSpellScript(spell_boss_magus_telestra_gravity_well);
    new achievement_split_personality();
}
