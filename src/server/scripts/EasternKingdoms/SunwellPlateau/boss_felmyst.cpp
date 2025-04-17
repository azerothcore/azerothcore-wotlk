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

#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "sunwell_plateau.h"

enum Yells
{
    YELL_BIRTH                                  = 0, // Glory to Kil'jaeden! Death to all who oppose!
    YELL_KILL                                   = 1, // I kill for the master! OR The end has come!
    YELL_BREATH                                 = 2, // Choke on your final breath
    YELL_TAKEOFF                                = 3, // I am stronger than ever before!
    YELL_BERSERK                                = 4, // No more hesitation! Your fates are written!
    YELL_DEATH                                  = 5, // Kil'jaeden will... prevail!  AND Kalecgos line
    EMOTE_BREATH                                = 6  // Felmyst takes a deep breath...
};

enum Spells
{
    //Aura
    SPELL_NOXIOUS_FUMES                         = 47002,

    //Land phase
    SPELL_BERSERK                               = 45078,
    SPELL_CLEAVE                                = 19983,
    SPELL_CORROSION                             = 45866,
    SPELL_GAS_NOVA                              = 45855,
    SPELL_ENCAPSULATE_CHANNEL                   = 45661,

    //Flight phase
    SPELL_TRIGGER_TOP_STRAFE                    = 45586,
    SPELL_TRIGGER_MIDDLE_STRAFE                 = 45622,
    SPELL_TRIGGER_BOTTOM_STRAFE                 = 45623,
    SPELL_STRAFE_TOP                            = 45585,
    SPELL_STRAFE_MIDDLE                         = 45633,
    SPELL_STRAFE_BOTTOM                         = 45635,
    SPELL_SUMMON_DEMONIC_VAPOR                  = 45391,
    SPELL_DEMONIC_VAPOR_SPAWN_TRIGGER           = 45388, // Triggers visual beam
    SPELL_DEMONIC_VAPOR_PERIODIC                = 45411, // Spawns cloud and deals damage
    SPELL_DEMONIC_VAPOR_TRAIL_PERIODIC          = 45399, // periodic of cloud
    SPELL_DEMONIC_VAPOR                         = 45402, // cloud dot
    SPELL_SUMMON_BLAZING_DEAD                   = 45400, // spawns skeletons
    SPELL_FELMYST_SPEED_BURST                   = 45495, // speed burst and breath animation
    SPELL_FOG_OF_CORRUPTION                     = 45582, // trigger cast
    SPELL_FOG_OF_CORRUPTION_CHARM               = 45717, // charm 1
    SPELL_FOG_OF_CORRUPTION_CHARM2              = 45726, // charm 2
};

enum Misc
{
    // Misc
    ACTION_START_EVENT          = 1,
    POINT_GROUND                = 1,
    POINT_TAKEOFF               = 2,
    POINT_AIR                   = 3,
    POINT_AIR_UP                = 4,
    POINT_LANE                  = 5,
    POINT_AIR_BREATH_START1     = 6,
    POINT_AIR_BREATH_END        = 7,
    POINT_AIR_BREATH_START2     = 8,
    POINT_MISC                  = 9,

    POINT_KALECGOS              = 1,

    GROUP_START_INTRO           = 0,
    GROUP_BREATH                = 1,
    GROUP_TAKEOFF               = 2,

    NPC_FOG_TRIGGER             = 23472,
    NPC_KALECGOS_FELMYST        = 24844, // Same as Magister's Terrace
    NPC_WORLD_TRIGGER_RIGHT     = 25358
};

const Position LeftSideLanes[3] =
{
    { 1494.745f,  704.0001f,  50.084652f, 4.7472f }, // top
    { 1469.923f,  703.23914f, 50.08592f,  4.7472f }, // middle
    { 1446.5154f, 701.5184f,  50.085438f, 4.7472f } // bottom
};

const Position RightSideLanes[3] =
{
    { 1492.82f,   515.668f,  50.0833f,   1.4486f }, // top
    { 1466.7322f, 515.5953f, 50.571518f, 1.4486f }, // middle
    { 1441.64f,   520.52f,   50.0833f,   1.4486f } // bottom
};

const Position RightSide = { 1458.5555f, 502.1995f, 59.899513f, 1.605702f };
const Position LeftSide = { 1469.0642f, 729.5854f, 59.823853f, 4.6774f };
const Position LandingRightPos = { 1476.77f, 665.094f, 20.6423f };
const Position LandingLeftPos = { 1469.93f, 557.009f, 22.631699f };

class CorruptTriggers : public BasicEvent
{
public:
    CorruptTriggers(Unit* caster, uint8 currentLane) : _caster(caster), _currentLane(currentLane) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        switch (_currentLane)
        {
            case 0: // top
                _caster->CastSpell(_caster, SPELL_STRAFE_TOP, true);
                break;
            case 1: // middle
                _caster->CastSpell(_caster, SPELL_STRAFE_MIDDLE, true);
                break;
            case 2: // bottom
                _caster->CastSpell(_caster, SPELL_STRAFE_BOTTOM, true);
                break;
        }
        return true;
    }

private:
    Unit* _caster;
    uint8 _currentLane;
};

struct boss_felmyst : public BossAI
{
    boss_felmyst(Creature* creature) : BossAI(creature, DATA_FELMYST), _currentLane(0), _strafeCount(0) { }

    void InitializeAI() override
    {
        me->SetReactState(REACT_PASSIVE);

        if (instance->GetBossState(DATA_FELMYST) == TO_BE_DECIDED)
        {
            me->SetStandState(UNIT_STAND_STATE_SLEEP);
            me->SetImmuneToPC(true);
            StartIntro();
        }
        else
        {
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            me->SendMovementFlagUpdate();
            me->GetMotionMaster()->MovePath(me->GetEntry() * 10, true);
        }
    }

    void Reset() override
    {
        BossAI::Reset();
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FOG_OF_CORRUPTION_CHARM);
        _currentLane = 0;
        _strafeCount = 0;
        me->SetCombatMovement(false);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        ScheduleEnrageTimer(SPELL_BERSERK, 10min, YELL_BERSERK);

        me->GetMotionMaster()->Clear();

        Position landPos = who->GetPosition();
        me->m_Events.AddEventAtOffset([&, landPos] {
            me->GetMotionMaster()->MoveLand(POINT_GROUND, landPos);
        }, 1s);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && roll_chance_i(50))
            Talk(YELL_KILL);
    }

    void SpellHitTarget(Unit* target, const SpellInfo* spell) override
    {
        if (spell->Id == SPELL_STRAFE_TOP || spell->Id == SPELL_STRAFE_MIDDLE || spell->Id == SPELL_STRAFE_BOTTOM)
            target->CastSpell(target, SPELL_FOG_OF_CORRUPTION, true);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        me->m_Events.KillAllEvents(false);
        Talk(YELL_DEATH);
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FOG_OF_CORRUPTION_CHARM);

        // Summon Kalecgos (human form of kalecgos fight)
        if (Creature* kalec = me->SummonCreature(NPC_KALECGOS_FELMYST, 1573.1461f, 755.20245f, 99.524956f, 3.595378f))
            kalec->GetMotionMaster()->MovePoint(POINT_KALECGOS, 1474.2347f, 624.0703f, 29.32589f, false, true);
    }

    void ScheduleGroundAbilities()
    {
        ScheduleTimedEvent(7500ms, [&] {
            DoCastVictim(SPELL_CLEAVE);
        }, 7500ms);

        ScheduleTimedEvent(13s, 30s, [&] {
            if (scheduler.GetNextGroupOccurrence(GROUP_TAKEOFF) > 2s)
            {
                Talk(YELL_BREATH);
                DoCastVictim(SPELL_CORROSION);
            }
        }, 30s, 39s);

        ScheduleTimedEvent(18s, 43s, [&] {
            if (scheduler.GetNextGroupOccurrence(GROUP_TAKEOFF) > 2s)
                DoCastSelf(SPELL_GAS_NOVA);
        }, 18s, 43s);

        ScheduleTimedEvent(26s, 53s, [&] {
            if (scheduler.GetNextGroupOccurrence(GROUP_TAKEOFF) > 9s)
                DoCastRandomTarget(SPELL_ENCAPSULATE_CHANNEL, 0, 50.0f);
        }, 26s, 53s);

        scheduler.Schedule(1min, GROUP_TAKEOFF, [&](TaskContext)
        {
            Talk(YELL_TAKEOFF);
            scheduler.CancelAll();
            me->SetReactState(REACT_PASSIVE);
            me->SetTarget();
            me->AttackStop();
            me->SetCombatMovement(false);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            me->SendMovementFlagUpdate();
            SetInvincibility(true);
            me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            me->GetMotionMaster()->MovePoint(POINT_TAKEOFF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 20.0f);
        });
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type != EFFECT_MOTION_TYPE && type != POINT_MOTION_TYPE)
            return;

        switch (point)
        {
            case POINT_GROUND:

                if (!me->HasAura(SPELL_NOXIOUS_FUMES))
                    DoCastSelf(SPELL_NOXIOUS_FUMES, true);

                me->GetMotionMaster()->MoveIdle();
                me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SendMovementFlagUpdate();
                SetInvincibility(false);

                me->m_Events.AddEventAtOffset([&] {
                    me->SetReactState(REACT_AGGRESSIVE);

                    if (me->GetVictim())
                        me->SetTarget(me->GetVictim()->GetGUID());

                    me->ResumeChasingVictim();
                    me->SetCombatMovement(true);
                }, 5s);

                ScheduleGroundAbilities();
                break;
            case POINT_TAKEOFF:
                me->m_Events.AddEventAtOffset([&] {
                    me->CastCustomSpell(SPELL_SUMMON_DEMONIC_VAPOR, SPELLVALUE_MAX_TARGETS, 1, me, true);
                }, 5s);

                me->m_Events.AddEventAtOffset([&] {
                    me->CastCustomSpell(SPELL_SUMMON_DEMONIC_VAPOR, SPELLVALUE_MAX_TARGETS, 1, me, true);
                }, 17s);

                scheduler.Schedule(27s, GROUP_BREATH, [this](TaskContext)
                {
                    if (me->GetDistance(LeftSide) < me->GetDistance(RightSide))
                        me->GetMotionMaster()->MovePoint(POINT_AIR_UP, LeftSide);
                    else
                        me->GetMotionMaster()->MovePoint(POINT_AIR_UP, RightSide);
                });
                break;
            case POINT_AIR_UP:
                me->m_Events.AddEventAtOffset([&] {
                    bool isRightSide = me->FindNearestCreature(NPC_WORLD_TRIGGER_RIGHT, 30.0f);
                    if (_strafeCount >= 3)
                    {
                        _strafeCount = 0;
                        me->GetMotionMaster()->MoveLand(POINT_GROUND, isRightSide ? LandingRightPos : LandingLeftPos);
                        return;
                    }

                    ++_strafeCount;
                    _currentLane = urand(0, 2);
                    if (isRightSide)
                        me->GetMotionMaster()->MovePoint(POINT_LANE, RightSideLanes[_currentLane], false);
                    else
                        me->GetMotionMaster()->MovePoint(POINT_LANE, LeftSideLanes[_currentLane], false);
                }, 5s);
                break;
            case POINT_LANE:
                Talk(EMOTE_BREATH);
                me->m_Events.AddEventAtOffset([&] {
                    for (uint8 i = 0; i < 16; ++i)
                        me->m_Events.AddEvent(new CorruptTriggers(me, _currentLane), me->m_Events.CalculateTime(i*250));
                }, 5s);

                me->m_Events.AddEventAtOffset([&] {
                    DoCastSelf(SPELL_FELMYST_SPEED_BURST, true);

                    if (me->FindNearestCreature(NPC_WORLD_TRIGGER_RIGHT, 30.0f))
                        me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_END, LeftSideLanes[_currentLane], false);
                    else
                        me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_END, RightSideLanes[_currentLane], false);
                }, 5s);
                break;
            case POINT_AIR_BREATH_END:
                me->RemoveAurasDueToSpell(SPELL_FELMYST_SPEED_BURST);

                me->m_Events.AddEventAtOffset([&] {
                    if (me->FindNearestCreature(NPC_WORLD_TRIGGER_RIGHT, 30.0f))
                        me->GetMotionMaster()->MovePoint(POINT_AIR_UP, RightSide, false);
                    else
                        me->GetMotionMaster()->MovePoint(POINT_AIR_UP, LeftSide, false);
                }, 2s);
                break;
        }
    }

    void StartIntro()
    {
        scheduler.Schedule(3s, GROUP_START_INTRO, [this](TaskContext /*context*/)
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);

            me->m_Events.AddEventAtOffset([&] {
                Talk(YELL_BIRTH);
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->SendMovementFlagUpdate();
                me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            }, 7s);

            me->m_Events.AddEventAtOffset([&] {
                me->SetImmuneToPC(false);
                me->GetMotionMaster()->MovePath(me->GetEntry() * 10, true);
            }, 8500ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        if (!me->HasUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY))
            DoMeleeAttackIfReady();
    }

    private:
        uint8 _currentLane = 0;
        uint8 _strafeCount = 0;
};

struct npc_demonic_vapor : public NullCreatureAI
{
    npc_demonic_vapor(Creature* creature) : NullCreatureAI(creature), _timer{1} { }

    void Reset() override
    {
        me->CastSpell(me, SPELL_DEMONIC_VAPOR_SPAWN_TRIGGER, true);
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (!summoner || !summoner->ToUnit())
            return;

        me->m_Events.AddEventAtOffset([this, summoner] {
            me->GetMotionMaster()->MoveFollow(summoner->ToUnit(), 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
        }, 2s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_timer)
        {
            _timer += diff;
            if (_timer >= 2000)
            {
                me->CastSpell(me, SPELL_DEMONIC_VAPOR_PERIODIC, true);
                _timer = 0;
            }
        }
    }
private:
    uint32 _timer;
};

struct npc_demonic_vapor_trail : public NullCreatureAI
{
    npc_demonic_vapor_trail(Creature* creature) : NullCreatureAI(creature), _timer{1} { }

    void Reset() override
    {
        me->CastSpell(me, SPELL_DEMONIC_VAPOR_TRAIL_PERIODIC, true);
        me->DespawnOrUnsummon(20000);
    }

    void SpellHitTarget(Unit* /*unit*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_DEMONIC_VAPOR && !_timer)
            _timer = 1;
    }

    void UpdateAI(uint32 diff) override
    {
        if (_timer)
        {
            _timer += diff;
            if (_timer >= 5000)
            {
                _timer = 0;
                me->CastSpell(me, SPELL_SUMMON_BLAZING_DEAD, true);
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summon->SetInCombatWithZone();
        summon->AI()->AttackStart(summon->AI()->SelectTarget(SelectTargetMethod::Random, 0, 100.0f));
    }
private:
    uint32 _timer;
};

class spell_felmyst_fog_of_corruption : public SpellScript
{
    PrepareSpellScript(spell_felmyst_fog_of_corruption);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FOG_OF_CORRUPTION_CHARM });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), SPELL_FOG_OF_CORRUPTION_CHARM, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_felmyst_fog_of_corruption::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_felmyst_fog_of_corruption_charm_aura : public AuraScript
{
    PrepareAuraScript(spell_felmyst_fog_of_corruption_charm_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FOG_OF_CORRUPTION_CHARM2, SPELL_FOG_OF_CORRUPTION_CHARM });
    }

    void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_FOG_OF_CORRUPTION_CHARM2, true);
    }

    void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_FOG_OF_CORRUPTION_CHARM);
        GetTarget()->RemoveAurasDueToSpell(SPELL_FOG_OF_CORRUPTION_CHARM2);
        Unit::Kill(GetCaster(), GetTarget(), false);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_felmyst_fog_of_corruption_charm_aura::HandleApply, EFFECT_0, SPELL_AURA_AOE_CHARM, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_felmyst_fog_of_corruption_charm_aura::HandleRemove, EFFECT_0, SPELL_AURA_AOE_CHARM, AURA_EFFECT_HANDLE_REAL);
    }
};

class DoorsGuidCheck
{
public:
    bool operator()(WorldObject* object) const
    {
        if (!object->IsCreature())
            return true;

        Creature* cr = object->ToCreature();
        return cr->GetSpawnId() != 54780 && cr->GetSpawnId() != 54787 && cr->GetSpawnId() != 54801;
    }
};

class spell_felmyst_open_brutallus_back_doors : public SpellScript
{
    PrepareSpellScript(spell_felmyst_open_brutallus_back_doors);

    bool Load() override
    {
        return GetCaster()->GetInstanceScript();
    }

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove_if(DoorsGuidCheck());
    }

    void HandleAfterCast()
    {
        GetCaster()->GetInstanceScript()->SetBossState(DATA_FELMYST_DOORS, NOT_STARTED);
        GetCaster()->GetInstanceScript()->SetBossState(DATA_FELMYST_DOORS, DONE);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_felmyst_open_brutallus_back_doors::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        AfterCast += SpellCastFn(spell_felmyst_open_brutallus_back_doors::HandleAfterCast);
    }
};

void AddSC_boss_felmyst()
{
    RegisterSunwellPlateauCreatureAI(boss_felmyst);
    RegisterSunwellPlateauCreatureAI(npc_demonic_vapor);
    RegisterSunwellPlateauCreatureAI(npc_demonic_vapor_trail);
    RegisterSpellScript(spell_felmyst_fog_of_corruption);
    RegisterSpellScript(spell_felmyst_fog_of_corruption_charm_aura);
    RegisterSpellScript(spell_felmyst_open_brutallus_back_doors);
}
