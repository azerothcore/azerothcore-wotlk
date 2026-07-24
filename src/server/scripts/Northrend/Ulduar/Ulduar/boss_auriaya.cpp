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
#include "CreatureGroups.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum AuriayaSpells
{
    // Auriaya
    SPELL_TERRIFYING_SCREECH            = 64386,
    SPELL_SENTINEL_BLAST                = 64389,
    SPELL_SONIC_SCREECH                 = 64422,
    SPELL_GUARDIAN_SWARM                = 64396,
    SPELL_ENRAGE                        = 47008,
    SPELL_ACTIVATE_FERAL_DEFENDER       = 64449,

    // Sanctum Sentry
    SPELL_SAVAGE_POUNCE                 = 64666,
    SPELL_RIP_FLESH                     = 64375,
    SPELL_STRENGTH_OF_THE_PACK          = 64369,

    // Feral Defender
    SPELL_FERAL_ESSENCE                 = 64455,
    SPELL_FERAL_ESSENCE_REMOVAL         = 64456,
    SPELL_SUMMON_ESSENCE                = 64457,
    SPELL_FERAL_POUNCE                  = 64478,
    SPELL_FERAL_RUSH                    = 64496,
    SPELL_FERAL_RUSH_2                  = 64489,
    SPELL_SHADOW_PAWS                   = 64479,
    SPELL_REDUCE_CRIT_CHANCE            = 64481,
    SPELL_RANDOM_AGGRO_PERIODIC         = 61906,
    SPELL_PERMANENT_FEIGN_DEATH         = 58951,
    SPELL_CLEAR_ALL_DEBUFFS             = 34098,
    SPELL_DROWNED_STATE                 = 64462,
    SPELL_FULL_HEAL                     = 64460,
    SPELL_SEEPING_FERAL_ESSENCE         = 64458,
};

enum AuriayaNPC
{
    NPC_FERAL_DEFENDER                  = 34035,
    NPC_SANCTUM_SENTRY                  = 34014,
    NPC_SEEPING_FERAL_ESSENCE           = 34098,
};

enum AuriayaEvents
{
    // Auriaya
    EVENT_SUMMON_FERAL_DEFENDER         = 1,
    EVENT_TERRIFYING_SCREECH            = 2,
    EVENT_SONIC_SCREECH                 = 3,
    EVENT_GUARDIAN_SWARM                = 4,
    EVENT_SENTINEL_BLAST                = 5,
    EVENT_REMOVE_IMMUNE                 = 6,

    // Sanctum Sentry
    EVENT_SAVAGE_POUNCE                 = 8,
    EVENT_RIP_FLESH                     = 9,

    // Feral Defender
    EVENT_FERAL_RUSH                    = 10,
    EVENT_FERAL_POUNCE                  = 11,
    EVENT_RESPAWN_DEFENDER              = 12,
    EVENT_RESPAWN_DEFENDER_2            = 13,
    EVENT_RESPAWN_DEFENDER_3            = 14,
};

enum Texts
{
    SAY_AGGRO       = 0,
    SAY_SLAY        = 1,
    SAY_BERSERK     = 2,
    EMOTE_DEATH     = 3,
    EMOTE_FEAR      = 4,
    EMOTE_DEFFENDER = 5,
};

enum Misc
{
    ACTION_FERAL_DEATH                  = 2,
    ACTION_DESPAWN_ADDS                 = 3,
    ACTION_SENTRY_DEATH                 = 5,

    DATA_CRAZY_CAT                      = 10,
    DATA_NINE_LIVES                     = 11,
};

struct boss_auriaya : public BossAI
{
    boss_auriaya(Creature* creature) : BossAI(creature, BOSS_AURIAYA) { }

    bool _feralDied{false};
    bool _nineLives{false};

    void DespawnFormationMembers(bool onEvade = false)
    {
        if (CreatureGroup* formation = me->GetFormation())
            for (auto const& [member, info] : formation->GetMembers())
                if (member && member != me)
                {
                    if (onEvade)
                        member->DespawnOnEvade();
                    else
                        member->DespawnOrUnsummon();
                }
    }

    void Reset() override
    {
        _feralDied = false;
        _nineLives = false;

        EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
        summons.DoAction(ACTION_DESPAWN_ADDS, pred);

        if (me->IsInEvadeMode())
            DespawnFormationMembers(true);

        BossAI::Reset();

        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
    }

    uint32 GetData(uint32 param) const override
    {
        if (param == DATA_CRAZY_CAT)
            return !_feralDied;
        if (param == DATA_NINE_LIVES)
            return _nineLives;

        return 0;
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);

        events.ScheduleEvent(EVENT_TERRIFYING_SCREECH, 35s);
        events.ScheduleEvent(EVENT_SONIC_SCREECH, 45s);
        events.ScheduleEvent(EVENT_GUARDIAN_SWARM, 70s);
        events.ScheduleEvent(EVENT_SUMMON_FERAL_DEFENDER, 60s);
        events.ScheduleEvent(EVENT_SENTINEL_BLAST, 36s);

        ScheduleEnrageTimer(SPELL_ENRAGE, 10min, SAY_BERSERK);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer() || urand(0, 2))
            return;

        Talk(SAY_SLAY);
    }

    void JustDied(Unit* killer) override
    {
        EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
        summons.DoAction(ACTION_DESPAWN_ADDS, pred);

        DespawnFormationMembers();

        BossAI::JustDied(killer);
        Talk(EMOTE_DEATH);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_FERAL_DEATH)
            _nineLives = true;
        else if (param == ACTION_SENTRY_DEATH)
            _feralDied = true;
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SUMMON_FERAL_DEFENDER:
                Talk(EMOTE_DEFFENDER);
                DoCastSelf(SPELL_ACTIVATE_FERAL_DEFENDER, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                events.ScheduleEvent(EVENT_REMOVE_IMMUNE, 3s);
                break;
            case EVENT_REMOVE_IMMUNE:
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                break;
            case EVENT_TERRIFYING_SCREECH:
                Talk(EMOTE_FEAR);
                DoCastSelf(SPELL_TERRIFYING_SCREECH);
                events.Repeat(35s);
                break;
            case EVENT_SONIC_SCREECH:
                DoCastSelf(SPELL_SONIC_SCREECH);
                events.Repeat(50s);
                break;
            case EVENT_GUARDIAN_SWARM:
                DoCastVictim(SPELL_GUARDIAN_SWARM);
                events.Repeat(40s);
                break;
            case EVENT_SENTINEL_BLAST:
                DoCastSelf(SPELL_SENTINEL_BLAST);
                events.Repeat(35s);
                events.DelayEvents(5s, 0);
                break;
        }
    }
};

struct npc_auriaya_sanctum_sentry : public ScriptedAI
{
    npc_auriaya_sanctum_sentry(Creature* creature) : ScriptedAI(creature) { }

    void JustDied(Unit*) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* auriaya = instance->GetCreature(BOSS_AURIAYA))
                auriaya->AI()->DoAction(ACTION_SENTRY_DEATH);
    }

    void JustEngagedWith(Unit*) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* cr = instance->GetCreature(BOSS_AURIAYA))
                cr->SetInCombatWithZone();

        events.ScheduleEvent(EVENT_SAVAGE_POUNCE, 5s);
        events.ScheduleEvent(EVENT_RIP_FLESH, 10s);
    }

    void Reset() override
    {
        events.Reset();
        DoCastSelf(SPELL_STRENGTH_OF_THE_PACK, true);
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
            case EVENT_SAVAGE_POUNCE:
            {
                float dist = me->GetDistance(me->GetVictim());
                if (dist >= 8 && dist < 25 && me->IsWithinLOSInMap(me->GetVictim()))
                {
                    me->CastSpell(me->GetVictim(), SPELL_SAVAGE_POUNCE, false);
                    events.Repeat(5s);
                    break;
                }
                events.Repeat(200ms);
                break;
            }
            case EVENT_RIP_FLESH:
                me->CastSpell(me->GetVictim(), SPELL_RIP_FLESH, false);
                events.Repeat(10s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

class CatsTargetSelector
{
public:
    CatsTargetSelector(Unit const* unit, float minDist, float maxDist) : _me(unit), _minDist(minDist), _maxDist(maxDist) { }

    bool operator()(Unit* unit) const
    {
        float dist = _me->GetDistance(unit);
        return unit->IsPlayer() && dist >= _minDist && dist < _maxDist && _me->IsWithinLOSInMap(unit);
    }

private:
    Unit const* _me;
    float _minDist;
    float _maxDist;
};

struct npc_auriaya_feral_defender : public ScriptedAI
{
    npc_auriaya_feral_defender(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    SummonList _summons;

    void Reset() override
    {
        events.Reset();
        _summons.DespawnAll();

        DoCastSelf(SPELL_SHADOW_PAWS, true);
        DoCastSelf(SPELL_REDUCE_CRIT_CHANCE, true);
        me->SetAuraStack(SPELL_FERAL_ESSENCE, me, 8);
        DoCastSelf(SPELL_RANDOM_AGGRO_PERIODIC, true);
    }

    void JustEngagedWith(Unit*) override
    {
        events.ScheduleEvent(EVENT_FERAL_RUSH, 3s);
        events.ScheduleEvent(EVENT_FERAL_POUNCE, 6s);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage >= me->GetHealth() && me->HasAura(SPELL_FERAL_ESSENCE))
        {
            damage = 0;
            if (!me->HasAura(SPELL_PERMANENT_FEIGN_DEATH))
            {
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAurasDueToSpell(SPELL_RANDOM_AGGRO_PERIODIC);
                DoCastSelf(SPELL_PERMANENT_FEIGN_DEATH, true);
                DoCastSelf(SPELL_FERAL_ESSENCE_REMOVAL, true);
                DoCastSelf(SPELL_SUMMON_ESSENCE, true);
                DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                DoResetThreatList();
                events.ScheduleEvent(EVENT_RESPAWN_DEFENDER, 30s);
                events.CancelEvent(EVENT_FERAL_RUSH);
            }
        }
    }

    void JustDied(Unit*) override
    {
        DoCastSelf(SPELL_SUMMON_ESSENCE, true);

        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* cr = instance->GetCreature(BOSS_AURIAYA))
                cr->AI()->DoAction(ACTION_FERAL_DEATH);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_DESPAWN_ADDS)
            _summons.DespawnAll();
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
            case EVENT_FERAL_RUSH:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, CatsTargetSelector(me, 10.0f, 11.0f)))
                {
                    DoCast(target, SPELL_FERAL_RUSH, true);
                    events.Repeat(5s);
                    break;
                }
                events.Repeat(1s);
                break;
            case EVENT_FERAL_POUNCE:
            {
                Unit* victim = me->GetVictim();
                if (me->GetReactState() != REACT_PASSIVE && victim)
                {
                    float distance = me->GetDistance2d(victim);
                    if (distance > 5.0f && distance <= 45.0f)
                    {
                        DoCastVictim(SPELL_FERAL_POUNCE);
                        events.Repeat(5s);
                        break;
                    }
                }
                events.Repeat(1s);
                break;
            }
            case EVENT_RESPAWN_DEFENDER:
                me->SetDisableGravity(true);
                me->SetHover(true);
                DoCastSelf(SPELL_DROWNED_STATE, true);
                events.ScheduleEvent(EVENT_RESPAWN_DEFENDER_2, 3s);
                events.ScheduleEvent(EVENT_RESPAWN_DEFENDER_3, 5s);
                break;
            case EVENT_RESPAWN_DEFENDER_2:
                me->RemoveAurasDueToSpell(SPELL_DROWNED_STATE);
                break;
            case EVENT_RESPAWN_DEFENDER_3:
                me->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                DoCastSelf(SPELL_FULL_HEAL, true);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetDisableGravity(false);
                me->SetHover(false);
                DoCastSelf(SPELL_RANDOM_AGGRO_PERIODIC, true);
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    AttackStart(target);
                events.ScheduleEvent(EVENT_FERAL_RUSH, 1s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

class spell_auriaya_sentinel_blast : public SpellScript
{
    PrepareSpellScript(spell_auriaya_sentinel_blast);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove_if(PlayerOrPetCheck());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_auriaya_sentinel_blast::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// 64456 - Feral Essence Application Removal
class spell_auriaya_feral_essence_removal : public SpellScript
{
    PrepareSpellScript(spell_auriaya_feral_essence_removal);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FERAL_ESSENCE });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Aura* essence = GetCaster()->GetAura(SPELL_FERAL_ESSENCE))
            essence->ModStackAmount(-1);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_auriaya_feral_essence_removal::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 64496, 64674 - Feral Rush
class spell_auriaya_feral_rush : public SpellScript
{
    PrepareSpellScript(spell_auriaya_feral_rush);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FERAL_RUSH_2 });
    }

    void HandleOnHit(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_FERAL_RUSH_2, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_auriaya_feral_rush::HandleOnHit, EFFECT_1, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class achievement_auriaya_crazy_cat_lady : public AchievementCriteriaScript
{
public:
    achievement_auriaya_crazy_cat_lady() : AchievementCriteriaScript("achievement_auriaya_crazy_cat_lady") {}

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (InstanceScript* instance = target->GetInstanceScript())
                if (Creature* auriaya = instance->GetCreature(BOSS_AURIAYA))
                    return auriaya->AI()->GetData(DATA_CRAZY_CAT);

        return false;
    }
};

class achievement_auriaya_nine_lives : public AchievementCriteriaScript
{
public:
    achievement_auriaya_nine_lives() : AchievementCriteriaScript("achievement_auriaya_nine_lives") {}

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (InstanceScript* instance = target->GetInstanceScript())
                if (Creature* cr = instance->GetCreature(BOSS_AURIAYA))
                    return cr->AI()->GetData(DATA_NINE_LIVES);

        return false;
    }
};

void AddSC_boss_auriaya()
{
    RegisterUlduarCreatureAI(boss_auriaya);
    RegisterUlduarCreatureAI(npc_auriaya_sanctum_sentry);
    RegisterUlduarCreatureAI(npc_auriaya_feral_defender);

    RegisterSpellScript(spell_auriaya_sentinel_blast);
    RegisterSpellScript(spell_auriaya_feral_essence_removal);
    RegisterSpellScript(spell_auriaya_feral_rush);

    new achievement_auriaya_crazy_cat_lady();
    new achievement_auriaya_nine_lives();
}
