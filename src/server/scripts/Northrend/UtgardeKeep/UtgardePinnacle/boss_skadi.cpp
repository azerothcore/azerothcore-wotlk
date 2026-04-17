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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "utgarde_pinnacle.h"

enum Spells
{
    // Skadi
    SPELL_CRUSH                         = 50234,
    SPELL_POISONED_SPEAR                = 50255,
    SPELL_POISONED_SPEAR_PERIODIC       = 50258,
    SPELL_WHIRLWIND                     = 50228,
    SPELL_LAUNCH_HARPOON                = 48642,
    SPELL_SKADI_TELEPORT                = 61790,

    // Grauf
    SPELL_FREEZING_CLOUD                = 47579,
    SPELL_FREEZING_CLOUD_RIGHT_PERIODIC = 47592,
    SPELL_FREEZING_CLOUD_LEFT_PERIODIC  = 47590,
    SPELL_FREEZING_CLOUD_RIGHT_AREA     = 47594,
    SPELL_FREEZING_CLOUD_LEFT_AREA      = 47574,

    // Gauntlet
    SPELL_SUMMON_GAUNTLET_MOBS_PERIODIC = 59275,
    SPELL_SUMMON_YMIRJAR_WARRIOR_W      = 48631,
    SPELL_SUMMON_YMIRJAR_WARRIOR_E      = 48632,
    SPELL_SUMMON_YMIRJAR_HARPOONER_W    = 48633,
    SPELL_SUMMON_YMIRJAR_HARPOONER_E    = 48634,
    SPELL_SUMMON_YMIRJAR_WITCH_DOCTOR_W = 48635,
    SPELL_SUMMON_YMIRJAR_WITCH_DOCTOR_E = 48636,
    SPELL_GAUNTLET_RESET_CHECK          = 49308,
    SPELL_GAUNTLET_EFFECT               = 47547,
};

enum Texts
{
    SAY_AGGRO                           = 0,
    SAY_KILL                            = 1,
    SAY_DEATH                           = 3,
    SAY_DRAKE_DEATH                     = 5,
    SAY_DRAKE_BREATH                    = 6,
    EMOTE_DEEP_BREATH                   = 0,
    EMOTE_ON_RANGE                      = 1,
};

enum Actions
{
    ACTION_START_ENCOUNTER              = 1,
    ACTION_DRAKE_BREATH                 = 2,
    ACTION_PHASE2                       = 3,
    ACTION_HARPOON_HIT                  = 4,
};

enum CombatPhase
{
    PHASE_FLYING                        = 0,
    PHASE_GROUND
};

enum MiscData
{
    NPC_GRAUF                           = 26893,
    NPC_TRIGGER_RESET                   = 23472,
    NPC_WORLD_TRIGGER                   = 22515,
    NPC_COMBAT_TRIGGER                  = 38667,

    ACHIEV_TIMED_LODI_DODI              = 17726,

    FIRST_WAVE_MAX_WARRIORS             = 10,
    FIRST_WAVE_SIZE                     = 13,
};

Position const GraufLoc  = { 341.741f, -516.955f, 104.670f, 3.12414f };
Position const SpawnLoc  = { 477.581f, -484.559f, 104.822f, 4.67748f };

Position const FirstWaveLocations[FIRST_WAVE_SIZE] =
{
    { 458.532f, -516.254f, 104.617f },
    { 429.424f, -517.562f, 104.894f },
    { 394.496f, -514.614f, 104.724f },
    { 362.286f, -515.877f, 104.754f },
    { 333.537f, -514.794f, 104.478f },
    { 457.611f, -508.836f, 104.401f },
    { 427.403f, -510.772f, 104.880f },
    { 392.511f, -507.943f, 104.743f },
    { 362.951f, -508.412f, 104.722f },
    { 333.536f, -506.081f, 104.426f },
    { 478.310f, -511.049f, 104.724f, 3.26377f },
    { 482.250f, -514.127f, 104.723f, 3.26377f },
    { 481.388f, -507.109f, 104.724f, 3.26377f },
};

enum GraufPoints
{
    POINT_BREACH                        = 0,
    POINT_LEFT                          = 1,
    POINT_RIGHT                         = 2,
};

enum GraufPaths
{
    PATH_INITIAL                        = 2689300,
    PATH_RIGHT                          = 2689301,
    PATH_LEFT                           = 2689302,
    PATH_BREACH_RIGHT                   = 2689303,
    PATH_BREACH_LEFT                    = 2689304,
    PATH_GAUNTLET_ADDS                  = 2669000,
};

float const BreachFacing      = 2.670354f;
float const BreathFacingRight = 3.124139f;
float const BreathFacingLeft  = 3.228859f;

enum Events
{
    // Skadi
    EVENT_SKADI_CRUSH                   = 1,
    EVENT_SKADI_SPEAR                   = 2,
    EVENT_SKADI_WHIRLWIND               = 3,
    EVENT_SKADI_RESET_CHECK             = 4,

    // Grauf
    EVENT_GRAUF_START                   = 10,
    EVENT_GRAUF_LEAVE_BREACH            = 11,
    EVENT_GRAUF_BREATH_START            = 12,
    EVENT_GRAUF_REMOVE_AURA             = 13,
};

class boss_skadi : public CreatureScript
{
public:
    boss_skadi() : CreatureScript("boss_skadi") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUtgardePinnacleAI<boss_skadiAI>(creature);
    }

    struct boss_skadiAI : public ScriptedAI
    {
        boss_skadiAI(Creature* creature) : ScriptedAI(creature), _summons(me)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            _events.Reset();
            _summons.DespawnAll();
            _phase = PHASE_GROUND;
            _harpoonHit = 0;
            _loveSkadi = 0;
            _firstWaveSummoned = false;
            _encounterStarted = false;

            me->SetReactState(REACT_PASSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetImmuneToPC(false);

            if (_instance)
            {
                _instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_LODI_DODI);
                _instance->SetData(DATA_SKADI_THE_RUTHLESS, NOT_STARTED);
                _instance->SetData(DATA_SKADI_ACHIEVEMENT, false);
            }

            if (!_instance || !_instance->GetCreature(DATA_GRAUF))
                if (Creature* grauf = me->SummonCreature(NPC_GRAUF, GraufLoc))
                    _summons.Summon(grauf);
        }

        void JustSummoned(Creature* summon) override
        {
            switch (summon->GetEntry())
            {
                case NPC_YMIRJAR_WARRIOR:
                case NPC_YMIRJAR_WITCH_DOCTOR:
                case NPC_YMIRJAR_HARPOONER:
                    if (_firstWaveSummoned)
                    {
                        summon->LoadPath(PATH_GAUNTLET_ADDS);
                        summon->GetMotionMaster()->MoveWaypoint(PATH_GAUNTLET_ADDS, false);
                    }
                    break;
                default:
                    break;
            }
            _summons.Summon(summon);
        }

        void SpawnFirstWave()
        {
            for (uint8 i = 0; i < FIRST_WAVE_MAX_WARRIORS; ++i)
                if (Creature* summon = me->SummonCreature(NPC_YMIRJAR_WARRIOR, SpawnLoc, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                    summon->GetMotionMaster()->MovePoint(0, FirstWaveLocations[i]);

            if (Creature* crea = me->SummonCreature(NPC_YMIRJAR_WITCH_DOCTOR, SpawnLoc, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                crea->GetMotionMaster()->MovePoint(0, FirstWaveLocations[10]);
            if (Creature* crea = me->SummonCreature(NPC_YMIRJAR_HARPOONER, SpawnLoc, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                crea->GetMotionMaster()->MovePoint(0, FirstWaveLocations[11]);
            if (Creature* crea = me->SummonCreature(NPC_YMIRJAR_HARPOONER, SpawnLoc, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                crea->GetMotionMaster()->MovePoint(0, FirstWaveLocations[12]);

            _firstWaveSummoned = true;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoAction(ACTION_START_ENCOUNTER);
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case ACTION_START_ENCOUNTER:
                    if (_encounterStarted)
                        return;

                    _encounterStarted = true;
                    _phase = PHASE_FLYING;
                    Talk(SAY_AGGRO);

                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->setActive(true);

                    SpawnFirstWave();

                    if (_instance)
                    {
                        if (IsHeroic())
                            _instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_LODI_DODI);
                        _instance->SetData(DATA_SKADI_THE_RUTHLESS, IN_PROGRESS);
                    }

                    if (Creature* summonTrigger = me->SummonCreature(NPC_WORLD_TRIGGER, SpawnLoc))
                        summonTrigger->CastSpell(summonTrigger, SPELL_SUMMON_GAUNTLET_MOBS_PERIODIC, true);

                    if (Creature* combatTrigger = me->SummonCreature(NPC_COMBAT_TRIGGER, SpawnLoc))
                        combatTrigger->AI()->DoZoneInCombat();

                    _events.ScheduleEvent(EVENT_GRAUF_START, 2s);
                    _events.ScheduleEvent(EVENT_SKADI_RESET_CHECK, 6s);
                    break;
                case ACTION_DRAKE_BREATH:
                    if (_loveSkadi == 1)
                        ++_loveSkadi;
                    Talk(SAY_DRAKE_BREATH);
                    break;
                case ACTION_PHASE2:
                    Talk(SAY_DRAKE_DEATH);
                    DoCastSelf(SPELL_SKADI_TELEPORT);
                    _summons.DespawnEntry(NPC_WORLD_TRIGGER);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->SetImmuneToPC(false);
                    me->SetReactState(REACT_AGGRESSIVE);
                    _phase = PHASE_GROUND;

                    _events.ScheduleEvent(EVENT_SKADI_CRUSH, 8s);
                    _events.ScheduleEvent(EVENT_SKADI_SPEAR, 11s);
                    _events.ScheduleEvent(EVENT_SKADI_WHIRLWIND, 23s);
                    break;
                case ACTION_HARPOON_HIT:
                    ++_harpoonHit;
                    if (_harpoonHit == 1)
                        _loveSkadi = 1;
                    break;
            }
        }

        uint32 GetData(uint32 id) const override
        {
            if (id == DATA_LOVE_TO_SKADI)
                return _loveSkadi;
            return 0;
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (_phase == PHASE_FLYING)
            {
                switch (_events.ExecuteEvent())
                {
                    case EVENT_GRAUF_START:
                    {
                        if (Creature* grauf = _instance->GetCreature(DATA_GRAUF))
                        {
                            me->EnterVehicleUnattackable(grauf, 0);
                            grauf->AI()->DoAction(ACTION_START_ENCOUNTER);
                        }
                        else
                            EnterEvadeMode();
                        break;
                    }
                    case EVENT_SKADI_RESET_CHECK:
                    {
                        if (Creature* resetTrigger = me->FindNearestCreature(NPC_TRIGGER_RESET, 200.0f))
                            resetTrigger->CastSpell(resetTrigger, SPELL_GAUNTLET_RESET_CHECK, true);
                        _events.Repeat(6s);
                        break;
                    }
                }
                return;
            }

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_SKADI_CRUSH:
                    DoCastVictim(SPELL_CRUSH);
                    _events.Repeat(8s);
                    break;
                case EVENT_SKADI_SPEAR:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        DoCast(target, SPELL_POISONED_SPEAR);
                    _events.Repeat(10s);
                    break;
                case EVENT_SKADI_WHIRLWIND:
                    DoCast(me, SPELL_WHIRLWIND);
                    _events.Repeat(15s, 20s);
                    _events.DelayEvents(10s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _summons.DespawnAll();
            Talk(SAY_DEATH);

            if (_instance)
            {
                _instance->SetData(DATA_SKADI_THE_RUTHLESS, DONE);
                _instance->HandleGameObject(_instance->GetGuidData(SKADI_DOOR), true);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(SAY_KILL);
        }

        void EnterEvadeMode(EvadeReason /*why*/ = EVADE_REASON_OTHER) override
        {
            _summons.DespawnAll();
            ScriptedAI::EnterEvadeMode();
        }

    private:
        InstanceScript* _instance;
        EventMap _events;
        SummonList _summons;
        CombatPhase _phase;
        uint8 _harpoonHit;
        uint8 _loveSkadi;
        bool _firstWaveSummoned;
        bool _encounterStarted;
    };
};

class boss_skadi_grauf : public CreatureScript
{
public:
    boss_skadi_grauf() : CreatureScript("boss_skadi_grauf") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUtgardePinnacleAI<boss_skadi_graufAI>(creature);
    }

    struct boss_skadi_graufAI : public VehicleAI
    {
        boss_skadi_graufAI(Creature* creature) : VehicleAI(creature), _summons(me)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            _events.Reset();
            _summons.DespawnAll();
            me->SetReactState(REACT_PASSIVE);
            me->SetSpeedRate(MOVE_RUN, 2.5f);
            _flyingToSide = false;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_ENCOUNTER)
            {
                me->setActive(true);
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->GetMotionMaster()->Clear(true);
                me->SetAnimTier(AnimTier::Fly);
                me->GetMotionMaster()->MovePath(PATH_INITIAL, FORCED_MOVEMENT_RUN);
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_LAUNCH_HARPOON)
                if (Creature* skadi = _instance->GetCreature(DATA_SKADI_THE_RUTHLESS))
                    skadi->AI()->DoAction(ACTION_HARPOON_HIT);
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized())
            {
                if (_flyingToSide)
                {
                    _flyingToSide = false;
                    me->SetFacingTo(_lastSide == POINT_LEFT ? BreathFacingLeft : BreathFacingRight);
                    Talk(EMOTE_DEEP_BREATH);
                    _events.ScheduleEvent(EVENT_GRAUF_BREATH_START, 2s);
                }
                else
                {
                    me->SetFacingTo(BreachFacing);
                    Talk(EMOTE_ON_RANGE);
                    _events.ScheduleEvent(EVENT_GRAUF_LEAVE_BREACH, 10s);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case EVENT_GRAUF_LEAVE_BREACH:
                    _lastSide = RAND(POINT_LEFT, POINT_RIGHT);
                    _flyingToSide = true;
                    me->GetMotionMaster()->MovePath(
                        _lastSide == POINT_LEFT ? PATH_BREACH_LEFT : PATH_BREACH_RIGHT,
                        FORCED_MOVEMENT_RUN);
                    break;
                case EVENT_GRAUF_BREATH_START:
                    me->GetMotionMaster()->MovePath(
                        _lastSide == POINT_LEFT ? PATH_LEFT : PATH_RIGHT,
                        FORCED_MOVEMENT_RUN);
                    DoCast(me, _lastSide == POINT_LEFT
                        ? SPELL_FREEZING_CLOUD_LEFT_PERIODIC
                        : SPELL_FREEZING_CLOUD_RIGHT_PERIODIC);
                    if (Creature* skadi = _instance->GetCreature(DATA_SKADI_THE_RUTHLESS))
                        skadi->AI()->DoAction(ACTION_DRAKE_BREATH);
                    _events.ScheduleEvent(EVENT_GRAUF_REMOVE_AURA, 10s);
                    break;
                case EVENT_GRAUF_REMOVE_AURA:
                    me->RemoveAurasDueToSpell(SPELL_FREEZING_CLOUD_LEFT_PERIODIC);
                    me->RemoveAurasDueToSpell(SPELL_FREEZING_CLOUD_RIGHT_PERIODIC);
                    break;
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* skadi = _instance->GetCreature(DATA_SKADI_THE_RUTHLESS))
            {
                skadi->ExitVehicle();
                skadi->AI()->DoAction(ACTION_PHASE2);

                if (skadi->AI()->GetData(DATA_LOVE_TO_SKADI) == 1)
                    _instance->SetData(DATA_SKADI_ACHIEVEMENT, true);
            }
            me->DespawnOrUnsummon(6s);
        }

    private:
        InstanceScript* _instance;
        EventMap _events;
        SummonList _summons;
        uint8 _lastSide = POINT_LEFT;
        bool _flyingToSide = false;
    };
};

// 48642 - Launch Harpoon
class spell_skadi_launch_harpoon : public SpellScript
{
    PrepareSpellScript(spell_skadi_launch_harpoon);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.size() >= 2)
            targets.remove_if([](WorldObject* obj) { return obj->GetEntry() != NPC_GRAUF; });
    }

    void HandleDamageCalc()
    {
        if (Unit* target = GetHitUnit())
            SetHitDamage(target->CountPctFromMaxHealth(35));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_skadi_launch_harpoon::FilterTargets, EFFECT_0, TARGET_UNIT_CONE_ENTRY);
        OnHit += SpellHitFn(spell_skadi_launch_harpoon::HandleDamageCalc);
    }
};

// 50255, 59331 - Poisoned Spear
class spell_skadi_poisoned_spear : public SpellScript
{
    PrepareSpellScript(spell_skadi_poisoned_spear);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_POISONED_SPEAR_PERIODIC });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_POISONED_SPEAR_PERIODIC, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_skadi_poisoned_spear::HandleScript, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 47594 - Freezing Cloud (right side)
class spell_freezing_cloud_area_right : public SpellScript
{
    PrepareSpellScript(spell_freezing_cloud_area_right);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FREEZING_CLOUD });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([](WorldObject* obj) { return obj->GetPositionY() > -511.0f; });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_FREEZING_CLOUD, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_freezing_cloud_area_right::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_freezing_cloud_area_right::HandleScript, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

// 47574 - Freezing Cloud (left side)
class spell_freezing_cloud_area_left : public SpellScript
{
    PrepareSpellScript(spell_freezing_cloud_area_left);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FREEZING_CLOUD });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([](WorldObject* obj) { return obj->GetPositionY() < -511.0f; });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_FREEZING_CLOUD, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_freezing_cloud_area_left::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_freezing_cloud_area_left::HandleScript, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

// 47579, 60020 - Freezing Cloud (damage aura)
class spell_freezing_cloud_damage : public AuraScript
{
    PrepareAuraScript(spell_freezing_cloud_damage);

    bool CanBeAppliedOn(Unit* target)
    {
        if (Aura* aur = target->GetAura(GetId()))
            if (aur->GetOwner() != GetOwner())
                return false;
        return true;
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_freezing_cloud_damage::CanBeAppliedOn);
    }
};

// 59275 - Summon Gauntlet Mobs Periodic
class spell_summon_gauntlet_mobs_periodic : public AuraScript
{
    PrepareAuraScript(spell_summon_gauntlet_mobs_periodic);

    void CastTheNextTwoSpells()
    {
        for (uint8 i = 0; i < 2; ++i)
        {
            uint32 spellId = _summonSpells.front();
            GetTarget()->CastSpell((Unit*)nullptr, spellId, true);
            _summonSpells.push_back(spellId);
            _summonSpells.pop_front();
        }
    }

    void PushBackTheNextTwoSpells()
    {
        for (uint8 j = 0; j < 2; ++j)
        {
            _summonSpells.push_back(_summonSpells.front());
            _summonSpells.pop_front();
        }
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (RAND(0, 1))
        {
            CastTheNextTwoSpells();
            PushBackTheNextTwoSpells();
        }
        else
        {
            PushBackTheNextTwoSpells();
            CastTheNextTwoSpells();
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_summon_gauntlet_mobs_periodic::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }

private:
    std::deque<uint32> _summonSpells =
    {
        SPELL_SUMMON_YMIRJAR_WARRIOR_E,
        SPELL_SUMMON_YMIRJAR_HARPOONER_W,
        SPELL_SUMMON_YMIRJAR_WARRIOR_W,
        SPELL_SUMMON_YMIRJAR_HARPOONER_E,
        SPELL_SUMMON_YMIRJAR_WARRIOR_W,
        SPELL_SUMMON_YMIRJAR_WITCH_DOCTOR_E,
        SPELL_SUMMON_YMIRJAR_WARRIOR_E,
        SPELL_SUMMON_YMIRJAR_WITCH_DOCTOR_W
    };
};

// 49308 - Utgarde Pinnacle Gauntlet Reset Check
class spell_skadi_reset_check : public SpellScript
{
    PrepareSpellScript(spell_skadi_reset_check);

    void CountTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(false, SPELL_GAUNTLET_EFFECT));
        _targetCount = targets.size();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (_targetCount)
            return;

        Creature* target = GetHitCreature();
        if (!target)
            return;

        if (InstanceScript* instance = target->GetInstanceScript())
            if (instance->GetData(DATA_SKADI_THE_RUTHLESS) == IN_PROGRESS)
                if (Creature* skadi = instance->GetCreature(DATA_SKADI_THE_RUTHLESS))
                    skadi->AI()->EnterEvadeMode();
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_skadi_reset_check::CountTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_skadi_reset_check::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }

private:
    uint32 _targetCount = 0;
};

void AddSC_boss_skadi()
{
    new boss_skadi();
    new boss_skadi_grauf();
    RegisterSpellScript(spell_skadi_launch_harpoon);
    RegisterSpellScript(spell_skadi_poisoned_spear);
    RegisterSpellScript(spell_freezing_cloud_area_left);
    RegisterSpellScript(spell_freezing_cloud_area_right);
    RegisterSpellScript(spell_freezing_cloud_damage);
    RegisterSpellScript(spell_summon_gauntlet_mobs_periodic);
    RegisterSpellScript(spell_skadi_reset_check);
}
