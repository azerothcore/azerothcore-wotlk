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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "azjol_nerub.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Spells
{
    // World Trigger
    SPELL_SUMMON_ANUBAR_CHAMPION            = 53064,
    SPELL_SUMMON_ANUBAR_CRYPT_FIEND         = 53065,
    SPELL_SUMMON_ANUBAR_NECROMANCER         = 53066,
    SPELL_SUMMON_ANUBAR_CHAMPION_PERIODIC   = 53035,
    SPELL_SUMMON_ANUBAR_NECROMANCER_PERIODIC = 53036,
    SPELL_SUMMON_ANUBAR_CRYPT_FIEND_PERIODIC = 53037,

    // Hadronox
    SPELL_WEB_FRONT_DOORS                   = 53177,
    SPELL_WEB_SIDE_DOORS                    = 53185,
    SPELL_ACID_CLOUD                        = 53400,
    SPELL_LEECH_POISON                      = 53030,
    SPELL_LEECH_POISON_HEAL                 = 53800,
    SPELL_WEB_GRAB                          = 53406,
    SPELL_PIERCE_ARMOR                      = 53418,

    // Anub'ar Crusher
    SPELL_SMASH                             = 53318,
    SPELL_FRENZY                            = 53801,

    // Anub'ar Champion
    SPELL_REND                              = 59343,
    SPELL_PUMMEL                            = 59344,

    // Anub'ar Crypt Guard
    SPELL_CRUSHING_WEBS                     = 59347,
    SPELL_INFECTED_WOUND                    = 59348,

    // Anub'ar Necromancer
    SPELL_SHADOW_BOLT                       = 53333,
    SPELL_ANIMATE_BONES_1                   = 53334,
    SPELL_ANIMATE_BONES_2                   = 53336,
};

enum Events
{
    EVENT_HADRONOX_MOVE1        = 1,
    EVENT_HADRONOX_MOVE2        = 2,
    EVENT_HADRONOX_MOVE3        = 3,
    EVENT_HADRONOX_MOVE4        = 4,
    EVENT_HADRONOX_ACID         = 5,
    EVENT_HADRONOX_LEECH        = 6,
    EVENT_HADRONOX_PIERCE       = 7,
    EVENT_HADRONOX_GRAB         = 8,
    EVENT_HADRONOX_SUMMON       = 9,

    EVENT_CRUSHER_SMASH         = 20,
    EVENT_CHECK_HEALTH          = 21,
    EVENT_CHECK_EVADE           = 22,

    // Anub'ar Champion
    EVENT_REND,
    EVENT_PUMMEL,

    // Anub'ar Crypt Guard
    EVENT_CRUSHING_WEBS,
    EVENT_INFECTED_WOUND,

    // Anub'ar Necromancer
    EVENT_SHADOW_BOLT,
    EVENT_ANIMATE_BONES
};

enum NPCs
{
    NPC_ANUB_AR_CRUSHER           = 28922,
    NPC_ANUB_AR_CHAMPION_PACK     = 29117,
    NPC_ANUB_AR_CRYPT_FIEND_PACK  = 29118,
    NPC_ANUB_AR_NECROMANCER_PACK  = 29119,
};

enum SummonGroups : uint32
{
    SUMMON_GROUP_CRUSHER_NONE   = 0,
    SUMMON_GROUP_CRUSHER_1      = 1,
    SUMMON_GROUP_CRUSHER_2      = 2,
    SUMMON_GROUP_CRUSHER_3      = 3,
    SUMMON_GROUP_WORLD_TRIGGERS = 4,
};

enum Data
{
    DATA_CRUSHER_PACK_ID        = 1,
};

enum Misc
{
    SAY_CRUSHER_AGGRO           = 1,
    SAY_CRUSHER_EMOTE           = 2,
    SAY_HADRONOX_EMOTE          = 0,

    ACTION_CRUSHER_ENGAGED      = 1,
    ACTION_CRUSHER_DIED         = 2,
    ACTION_PACK_WALK            = 3,
};

static const std::array<Position, 3> hadronoxSteps =
{{
    { 562.191f, 514.068f, 696.50710f },
    { 615.802f, 517.418f, 695.68066f },
    { 530.420f, 560.003f, 733.22473f },
}};

struct boss_hadronox : public BossAI
{
    explicit boss_hadronox(Creature* creature) : BossAI(creature, DATA_HADRONOX), _crushersLeft(0), _doorsWebbed(false), _lastPlayerCombatState(false) { }

    void Reset() override
    {
        BossAI::Reset();
        SummonCrusherPack(SUMMON_GROUP_CRUSHER_1);
        me->SummonCreatureGroup(SUMMON_GROUP_WORLD_TRIGGERS);
        _doorsWebbed = false;
        _lastPlayerCombatState = false;
    }

    void SummonedCreatureEvade(Creature* summon) override
    {
        switch (summon->GetEntry())
        {
            case NPC_ANUB_AR_CRUSHER:
            case NPC_ANUB_AR_CHAMPION_PACK:
            case NPC_ANUB_AR_CRYPT_FIEND_PACK:
            case NPC_ANUB_AR_NECROMANCER_PACK:
                EnterEvadeMode(EVADE_REASON_OTHER);
                break;
            default:
                break;
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_CRUSHER_DIED)
            --_crushersLeft;
        else if (param == ACTION_CRUSHER_ENGAGED)
        {
            if (instance->GetBossState(DATA_HADRONOX) == IN_PROGRESS)
                return;
            instance->SetBossState(DATA_HADRONOX, IN_PROGRESS);
            events.ScheduleEvent(EVENT_CHECK_EVADE, 5s);
            SummonCrusherPack(SUMMON_GROUP_CRUSHER_2);
            SummonCrusherPack(SUMMON_GROUP_CRUSHER_3);
            events.ScheduleEvent(EVENT_HADRONOX_MOVE1, 0s);
            events.ScheduleEvent(EVENT_HADRONOX_MOVE2, 45s);
            events.ScheduleEvent(EVENT_HADRONOX_MOVE3, 70s);
        }
    }

    void SummonCrusherPack(const SummonGroups group)
    {
        std::list<TempSummon*> summoned;
        me->SummonCreatureGroup(group, &summoned);
        _crushersLeft = summoned.size();
        for (TempSummon* summon : summoned)
        {
            summon->AI()->SetData(DATA_CRUSHER_PACK_ID, group);
            summon->AI()->DoAction(ACTION_PACK_WALK);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        switch (summon->GetEntry())
        {
            case NPC_WORLD_TRIGGER_LAOI:
                summon->AddAura(SPELL_SUMMON_ANUBAR_CHAMPION_PERIODIC, summon);
                summon->AddAura(SPELL_SUMMON_ANUBAR_NECROMANCER_PERIODIC, summon);
                summon->AddAura(SPELL_SUMMON_ANUBAR_CRYPT_FIEND_PERIODIC, summon);
                break;
            case NPC_ANUB_AR_CHAMPION:
            case NPC_ANUB_AR_NECROMANCER:
            case NPC_ANUB_AR_CRYPTFIEND:
                // Xinef: cannot use pathfinding...
                if (summon->GetDistance(477.0f, 618.0f, 771.0f) < 5.0f)
                    summon->GetMotionMaster()->MoveWaypoint(3000012, false);
                else if (summon->GetDistance(583.0f, 617.0f, 771.0f) < 5.0f)
                    summon->GetMotionMaster()->MoveWaypoint(3000013, false);
                else if (summon->GetDistance(581.0f, 608.5f, 739.0f) < 5.0f)
                    summon->GetMotionMaster()->MoveWaypoint(3000014, false);
                break;
            default:
                break;
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (!me->IsAlive() || !victim->HasAura(SPELL_LEECH_POISON))
            return;

        me->ModifyHealth(static_cast<int32>(me->CountPctFromMaxHealth(10)));
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->setActive(true);
        events.RescheduleEvent(EVENT_HADRONOX_ACID, 10s);
        events.RescheduleEvent(EVENT_HADRONOX_LEECH, 4s);
        events.RescheduleEvent(EVENT_HADRONOX_PIERCE, 1s);
        events.RescheduleEvent(EVENT_HADRONOX_GRAB, 15s);
        events.RescheduleEvent(EVENT_CHECK_EVADE, 1s);
    }

    bool IsInCombatWithPlayer() const
    {
        return std::ranges::any_of(me->GetThreatMgr().GetThreatList(), [](auto const& ref) {
            return ref->getTarget()->IsControlledByPlayer();
        });
    }

    void DamageTaken(Unit* who, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if ((!who || !who->IsControlledByPlayer()) && me->HealthBelowPct(70))
        {
            if (me->HealthBelowPctDamaged(5, damage))
                damage = 0;
            else
                damage *= (me->GetHealthPct() - 5.0f) / 65.0f;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (uint32 eventId = events.ExecuteEvent())
        {
            case EVENT_HADRONOX_PIERCE:
                DoCastVictim(SPELL_PIERCE_ARMOR);
                events.Repeat(8s);
                break;
            case EVENT_HADRONOX_ACID:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, false))
                    DoCast(target, SPELL_ACID_CLOUD);
                events.Repeat(25s);
                break;
            case EVENT_HADRONOX_LEECH:
                DoCastSelf(SPELL_LEECH_POISON);
                events.Repeat(12s);
                break;
            case EVENT_HADRONOX_GRAB:
                DoCastSelf(SPELL_WEB_GRAB);
                events.Repeat(25s);
                break;
            case EVENT_HADRONOX_MOVE3:
                if (_crushersLeft > 0)
                {
                    events.Repeat(2s);
                    break;
                }
                [[fallthrough]];
            case EVENT_HADRONOX_MOVE1:
            case EVENT_HADRONOX_MOVE2:
                Talk(SAY_HADRONOX_EMOTE);
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->Clear();
                me->AttackStop();
                me->GetMotionMaster()->MovePoint(eventId, hadronoxSteps[eventId - 1]);
                break;
            case EVENT_CHECK_EVADE:
                if (IsInCombatWithPlayer() != _lastPlayerCombatState)
                {
                    _lastPlayerCombatState = !_lastPlayerCombatState;
                    if (_lastPlayerCombatState)
                    {
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == POINT_MOTION_TYPE)
                            me->GetMotionMaster()->Clear();
                    }
                    else
                        EnterEvadeMode(EVADE_REASON_NO_HOSTILES);
                }
                events.Repeat(1s);
                break;
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    void MovementInform(uint32 movementType, uint32 pointId) override
    {
        if (movementType != POINT_MOTION_TYPE)
            return;

        me->SetReactState(REACT_AGGRESSIVE);

        if (pointId == EVENT_HADRONOX_MOVE3)
        {
            DoCastSelf(SPELL_WEB_FRONT_DOORS, true);
            _doorsWebbed = true;
        }
    }

    uint32 GetData(uint32 data) const override
    {
         if (data == me->GetEntry()) // 'Hadronox Denied' achievement
             return _doorsWebbed ? 0 : 1;
        return 0;
    }

private:
    uint8 _crushersLeft;
    bool _doorsWebbed;
    bool _lastPlayerCombatState;
};

struct npc_hadronox_crusherPackAI : public ScriptedAI
{
    npc_hadronox_crusherPackAI(Creature* creature, Position const* positions) : ScriptedAI(creature), _instance(creature->GetInstanceScript()), _positions(positions), _myPack(SUMMON_GROUP_CRUSHER_NONE), _doFacing(false) { }

    virtual void DoEngagedWith() = 0;
    virtual void DoEvent(uint32 /*eventId*/) = 0;

    void DoAction(int32 action) override
    {
        if (action == ACTION_PACK_WALK)
        {
            switch (_myPack)
            {
                case SUMMON_GROUP_CRUSHER_1:
                case SUMMON_GROUP_CRUSHER_2:
                case SUMMON_GROUP_CRUSHER_3:
                    me->GetMotionMaster()->MovePoint(ACTION_PACK_WALK, _positions[_myPack - SUMMON_GROUP_CRUSHER_1]);
                    break;
                default:
                    break;
            }
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == ACTION_PACK_WALK)
            _doFacing = true;
    }

    uint32 GetData(uint32 data) const override
    {
        if (data == DATA_CRUSHER_PACK_ID)
            return _myPack;
        return 0;
    }

    void SetData(uint32 data, uint32 value) override
    {
        if (data == DATA_CRUSHER_PACK_ID)
        {
            _myPack = SummonGroups(value);
            me->SetReactState(_myPack ? REACT_PASSIVE : REACT_AGGRESSIVE);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        if (me->HasReactState(REACT_PASSIVE))
        {
            std::list<Creature*> creatures;

            me->GetCreatureListWithEntryInGrid(creatures, { NPC_ANUB_AR_CRUSHER, NPC_ANUB_AR_CHAMPION_PACK, NPC_ANUB_AR_NECROMANCER_PACK, NPC_ANUB_AR_CRYPT_FIEND_PACK }, 40.0f);
            for (Creature* creature : creatures)
                if (creature->AI()->GetData(DATA_CRUSHER_PACK_ID) == _myPack)
                {
                    creature->SetReactState(REACT_AGGRESSIVE);
                    creature->AI()->AttackStart(who);
                }
        }
        DoEngagedWith();
        ScriptedAI::JustEngagedWith(who);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!me->HasReactState(REACT_PASSIVE))
        {
            ScriptedAI::MoveInLineOfSight(who);
            return;
        }

        if (me->CanStartAttack(who) && me->IsWithinDistInMap(who, me->GetAttackDistance(who) + me->m_CombatDistance))
            JustEngagedWith(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_doFacing)
        {
            _doFacing = false;
            me->SetFacingTo(_positions[_myPack - SUMMON_GROUP_CRUSHER_1].GetOrientation());
        }

        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
            DoEvent(eventId);

        DoMeleeAttackIfReady();
    }

protected:
    InstanceScript* const _instance;
    Position const* const _positions;
    SummonGroups _myPack;
    bool _doFacing;
};

static const Position crusherWaypoints[] =
{
    { 529.6913f, 547.1257f, 731.9155f, 4.799650f },
    { 517.51f  , 561.439f , 734.0306f, 4.520403f },
    { 543.414f , 551.728f , 732.0522f, 3.996804f }
};

struct npc_anub_ar_crusher : public npc_hadronox_crusherPackAI
{
    explicit npc_anub_ar_crusher(Creature* creature) : npc_hadronox_crusherPackAI(creature, crusherWaypoints), _hadFrenzy(false) { }

    void DoEngagedWith() override
    {
        events.ScheduleEvent(EVENT_CRUSHER_SMASH, 8s, 12s);

        if (_myPack != SUMMON_GROUP_CRUSHER_1)
            return;

        if (_instance->GetBossState(DATA_HADRONOX) == IN_PROGRESS)
            return;

        if (Creature* hadronox = _instance->GetCreature(DATA_HADRONOX))
            hadronox->AI()->DoAction(ACTION_CRUSHER_ENGAGED);

        Talk(SAY_CRUSHER_AGGRO);
    }

    void DamageTaken(Unit* /*who*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (_hadFrenzy || !me->HealthBelowPctDamaged(25, damage))
            return;
        _hadFrenzy = true;
        Talk(SAY_CRUSHER_EMOTE);
        DoCastSelf(SPELL_FRENZY);
    }

    void DoEvent(uint32 eventId) override
    {
        if (eventId == EVENT_CRUSHER_SMASH)
        {
            DoCastVictim(SPELL_SMASH);
            events.Repeat(13s, 21s);
        }
    }

    void JustDied(Unit* killer) override
    {
        if (Creature* hadronox = _instance->GetCreature(DATA_HADRONOX))
            hadronox->AI()->DoAction(ACTION_CRUSHER_DIED);
        ScriptedAI::JustDied(killer);
    }

private:
    bool _hadFrenzy;
};

static const Position championWaypoints[] =
{
    { 539.2076f, 549.7539f, 732.8668f, 4.55531f  },
    { 527.3098f, 559.5197f, 732.9407f, 4.742493f },
    { }
};
struct npc_anub_ar_crusher_champion : public npc_hadronox_crusherPackAI
{
    explicit npc_anub_ar_crusher_champion(Creature* creature) : npc_hadronox_crusherPackAI(creature, championWaypoints) { }

    void DoEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_REND:
                DoCastVictim(SPELL_REND);
                events.Repeat(12s, 16s);
                break;
            case EVENT_PUMMEL:
                DoCastVictim(SPELL_PUMMEL);
                events.Repeat(12s, 17s);
                break;
            default:
                break;
        }
    }

    void DoEngagedWith() override
    {
        events.ScheduleEvent(EVENT_REND, 4s, 8s);
        events.ScheduleEvent(EVENT_PUMMEL, 15s, 19s);
    }
};

static const Position cryptFiendWaypoints[] =
{
    { 520.3911f, 548.7895f, 732.0118f, 5.0091f   },
    { },
    { 550.9611f, 545.1674f, 731.9031f, 3.996804f }
};
struct npc_anub_ar_crusher_crypt_fiend : public npc_hadronox_crusherPackAI
{
    explicit npc_anub_ar_crusher_crypt_fiend(Creature* creature) : npc_hadronox_crusherPackAI(creature, cryptFiendWaypoints) { }

    void DoEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_CRUSHING_WEBS:
                DoCastVictim(SPELL_CRUSHING_WEBS);
                events.Repeat(12s, 16s);
                break;
            case EVENT_INFECTED_WOUND:
                DoCastVictim(SPELL_INFECTED_WOUND);
                events.Repeat(16s, 25s);
                break;
            default:
                break;
        }
    }

    void DoEngagedWith() override
    {
        events.ScheduleEvent(EVENT_CRUSHING_WEBS, 4s, 8s);
        events.ScheduleEvent(EVENT_INFECTED_WOUND, 15s, 19s);
    }
};

static const Position necromancerWaypoints[] =
{
    { },
    { 507.6937f, 563.3471f, 734.8986f, 4.520403f },
    { 535.1049f, 552.8961f, 732.8441f, 3.996804f },
};
struct npc_anub_ar_crusher_necromancer : public npc_hadronox_crusherPackAI
{
    explicit npc_anub_ar_crusher_necromancer(Creature* creature) : npc_hadronox_crusherPackAI(creature, necromancerWaypoints) { }

    void DoEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SHADOW_BOLT:
                DoCastVictim(SPELL_SHADOW_BOLT);
                events.Repeat(2s, 5s);
                break;
            case EVENT_ANIMATE_BONES:
                DoCastVictim(RAND(SPELL_ANIMATE_BONES_2, SPELL_ANIMATE_BONES_1));
                events.Repeat(35s, 50s);
                break;
            default:
                break;
        }
    }

    void DoEngagedWith() override
    {
        events.ScheduleEvent(EVENT_SHADOW_BOLT, 2s, 4s);
        events.ScheduleEvent(EVENT_ANIMATE_BONES, 37s, 45s);
    }
};

class spell_hadronox_summon_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_hadronox_summon_periodic_aura);

public:
    spell_hadronox_summon_periodic_aura(int32 delay, uint32 spellEntry) : _delay(delay), _spellEntry(spellEntry) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WEB_FRONT_DOORS });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit* owner = GetUnitOwner();
        if (InstanceScript* instance = owner->GetInstanceScript())
            if (!instance->IsBossDone(DATA_HADRONOX) != NOT_STARTED)
            {
                if (!owner->HasAura(SPELL_WEB_FRONT_DOORS))
                    owner->CastSpell(owner, _spellEntry, true);
                else if (!instance->IsEncounterInProgress())
                    owner->RemoveAurasDueToSpell(SPELL_WEB_FRONT_DOORS);
            }
    }

    void OnApply(AuraEffect const* auraEffect, AuraEffectHandleModes)
    {
        GetAura()->GetEffect(auraEffect->GetEffIndex())->SetPeriodicTimer(_delay);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hadronox_summon_periodic_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectApplyFn(spell_hadronox_summon_periodic_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    int32 _delay;
    uint32 _spellEntry;
};

class spell_hadronox_leech_poison_aura : public AuraScript
{
    PrepareAuraScript(spell_hadronox_leech_poison_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LEECH_POISON_HEAL });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
            if (Unit* caster = GetCaster())
                caster->CastSpell(caster, SPELL_LEECH_POISON_HEAL, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hadronox_leech_poison_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_LEECH, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_hadronox_web_grab : public SpellScript
{
    PrepareSpellScript(spell_hadronox_web_grab);

    // hack to avoid pulling Anub'ar Crusher through the floor and causing Hadronox to evade
    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject* target) -> bool
        {
            return target->GetEntry() == NPC_ANUB_AR_CRUSHER;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hadronox_web_grab::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class achievement_hadronox_denied : public AchievementCriteriaScript
{
public:
    achievement_hadronox_denied() : AchievementCriteriaScript("achievement_hadronox_denied") { }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_hadronox()
{
    RegisterAzjolNerubCreatureAI(boss_hadronox);
    RegisterAzjolNerubCreatureAI(npc_anub_ar_crusher);
    RegisterAzjolNerubCreatureAI(npc_anub_ar_crusher_champion);
    RegisterAzjolNerubCreatureAI(npc_anub_ar_crusher_crypt_fiend);
    RegisterAzjolNerubCreatureAI(npc_anub_ar_crusher_necromancer);
    RegisterSpellScriptWithArgs(spell_hadronox_summon_periodic_aura, "spell_hadronox_summon_periodic_champion_aura", 15'000, SPELL_SUMMON_ANUBAR_CHAMPION);
    RegisterSpellScriptWithArgs(spell_hadronox_summon_periodic_aura, "spell_hadronox_summon_periodic_necromancer_aura", 10'000, SPELL_SUMMON_ANUBAR_NECROMANCER);
    RegisterSpellScriptWithArgs(spell_hadronox_summon_periodic_aura, "spell_hadronox_summon_periodic_crypt_fiend_aura", 5'000, SPELL_SUMMON_ANUBAR_CRYPT_FIEND);
    RegisterSpellScript(spell_hadronox_leech_poison_aura);
    RegisterSpellScript(spell_hadronox_web_grab);
    new achievement_hadronox_denied();
}
