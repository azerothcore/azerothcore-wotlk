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
    POINT_AIR                   = 2,
    POINT_AIR_BREATH_START1     = 3,
    POINT_AIR_BREATH_END1       = 4,
    POINT_AIR_BREATH_START2     = 5,
    POINT_AIR_BREATH_END2       = 6,
    POINT_MISC                  = 7,

    POINT_KALECGOS              = 1,

    GROUP_START_INTRO           = 0,
    GROUP_BREATH                = 1,

    NPC_FOG_TRIGGER             = 23472,
    NPC_KALECGOS_FELMYST        = 24844 // Same as Magister's Terrace
};

class CorruptTriggers : public BasicEvent
{
public:
    CorruptTriggers(Unit* caster) : _caster(caster) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        std::list<Creature*> creatureList;
        _caster->GetCreaturesWithEntryInRange(creatureList, 70.0f, NPC_FOG_TRIGGER);
        for (auto const& creature : creatureList)
            if (_caster->GetExactDist2d(creature) <= 11.0f)
                creature->CastSpell(creature, SPELL_FOG_OF_CORRUPTION, true);
        return true;
    }

private:
    Unit* _caster;
};

struct boss_felmyst : public BossAI
{
    boss_felmyst(Creature* creature) : BossAI(creature, DATA_FELMYST) { }

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
        me->m_Events.KillAllEvents(false);
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FOG_OF_CORRUPTION_CHARM);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        me->m_Events.AddEventAtOffset([&] {
            Talk(YELL_BERSERK);
            DoCastSelf(SPELL_BERSERK, true);
        }, 10min);

        me->GetMotionMaster()->Clear();

        Position landPos = who->GetPosition();
        me->m_Events.AddEventAtOffset([&, landPos] {
            me->GetMotionMaster()->MoveLand(POINT_GROUND, landPos);
        }, 2s);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && roll_chance_i(50))
            Talk(YELL_KILL);
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

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type != EFFECT_MOTION_TYPE && type != POINT_MOTION_TYPE)
            return;

        if (point == POINT_GROUND)
        {
            if (!me->HasAura(SPELL_NOXIOUS_FUMES))
                DoCastSelf(SPELL_NOXIOUS_FUMES, true);

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
            }, 2s);

            ScheduleTimedEvent(7500ms, [&] {
                DoCastVictim(SPELL_CLEAVE);
            }, 7500ms);

            ScheduleTimedEvent(12s, [&] {
                DoCastVictim(SPELL_CORROSION);
            }, 20s);

            ScheduleTimedEvent(18s, [&] {
                DoCastSelf(SPELL_GAS_NOVA);
            }, 20s);

            ScheduleTimedEvent(25s, [&] {
                DoCastRandomTarget(SPELL_ENCAPSULATE_CHANNEL, 0, 50.0f);
            }, 25s);

            me->m_Events.AddEventAtOffset([&] {
                scheduler.CancelAll();
                me->SetReactState(REACT_PASSIVE);
                me->StopMoving();
                me->GetMotionMaster()->Clear();

                me->m_Events.AddEventAtOffset([&] {
                    ScheduleFlightSequence();
                }, 1s);
            }, 1min);
        }
        else if (point == POINT_AIR_BREATH_START1)
        {
            me->SetTarget();
            me->SetFacingTo(4.71f);
            ScheduleFlightAbilities(point);
        }
        else if (point == POINT_AIR_BREATH_END1)
        {
            me->RemoveAurasDueToSpell(SPELL_FELMYST_SPEED_BURST);
            me->SetFacingTo(1.57f);
            if (!scheduler.IsGroupScheduled(GROUP_BREATH))
            {
                me->m_Events.AddEventAtOffset([&] {
                    Position pos = { 1447.0f + urand(0, 2) * 25.0f, 515.0f, 50.0f, 1.57f };
                    me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_START2, pos, false, true);
                }, 2s);
            }
        }
        else if (point == POINT_AIR_BREATH_START2)
        {
            me->SetTarget();
            me->SetFacingTo(1.57f);
            ScheduleFlightAbilities(point);
        }
        else if (point == POINT_AIR_BREATH_END2)
        {
            me->RemoveAurasDueToSpell(SPELL_FELMYST_SPEED_BURST);
            me->SetFacingTo(4.71f);
        }
    }

    void ScheduleFlightSequence()
    {
        Talk(YELL_TAKEOFF);
        me->SetTarget();
        me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
        me->SetDisableGravity(true);
        me->SendMovementFlagUpdate();
        SetInvincibility(true);

        me->m_Events.AddEventAtOffset([&] {
            me->GetMotionMaster()->MovePoint(POINT_AIR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 15.0f, false, true);
        }, 2s);

        me->m_Events.AddEventAtOffset([&] {
            me->CastCustomSpell(SPELL_SUMMON_DEMONIC_VAPOR, SPELLVALUE_MAX_TARGETS, 1, me, true);
        }, 8s);

        me->m_Events.AddEventAtOffset([&] {
            me->CastCustomSpell(SPELL_SUMMON_DEMONIC_VAPOR, SPELLVALUE_MAX_TARGETS, 1, me, true);
        }, 21s);

        scheduler.Schedule(35s, GROUP_BREATH, [this](TaskContext)
        {
            Position pos = { 1447.0f + urand(0, 2) * 25.0f, 705.0f, 50.0f, 4.71f };
            me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_START1, pos, false, true);
        });

        scheduler.Schedule(72s, GROUP_BREATH, [this](TaskContext)
        {
            Position pos = { 1447.0f + urand(0, 2) * 25.0f, 705.0f, 50.0f, 4.71f };
            me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_START1, pos, false, true);
        });

        me->m_Events.AddEventAtOffset([&] {
            me->GetMotionMaster()->MovePoint(POINT_GROUND, 1500.0f, 552.8f, 26.52f, false, true);
        }, 86s);
    }

    void ScheduleFlightAbilities(uint8 point)
    {
        me->m_Events.AddEventAtOffset([&] {
            Talk(EMOTE_BREATH);
        }, 2s);

        me->m_Events.AddEventAtOffset([&] {
            Talk(YELL_BREATH);
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(0));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(500));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(1000));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(1500));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(2000));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(2500));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(3000));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(3500));
            me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(4000));
        }, 5s);

        me->m_Events.AddEventAtOffset([this, point] {
            DoCastSelf(SPELL_FELMYST_SPEED_BURST, true);
            if (point == POINT_AIR_BREATH_START1)
                me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_END1, me->GetPositionX(), me->GetPositionY() - 200.0f, me->GetPositionZ() + 5.0f, false, true);
            else if (point == POINT_AIR_BREATH_START2)
                me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_END2, me->GetPositionX(), me->GetPositionY() + 200.0f, me->GetPositionZ() + 5.0f, false, true);
        }, 5s);
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
};

struct npc_demonic_vapor : public NullCreatureAI
{
    npc_demonic_vapor(Creature* creature) : NullCreatureAI(creature) { }

    void Reset() override
    {
        me->CastSpell(me, SPELL_DEMONIC_VAPOR_SPAWN_TRIGGER, true);
        me->CastSpell(me, SPELL_DEMONIC_VAPOR_PERIODIC, true);
    }

    void UpdateAI(uint32  /*diff*/) override
    {
        if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE)
        {
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                if (me->GetDistance2d(itr->GetSource()) < 20.0f && itr->GetSource()->IsAlive())
                {
                    me->GetMotionMaster()->MoveFollow(itr->GetSource(), 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
                    break;
                }
        }
    }
};

struct npc_demonic_vapor_trail : public NullCreatureAI
{
    npc_demonic_vapor_trail(Creature* creature) : NullCreatureAI(creature)
    {
        timer = 1;
    }

    uint32 timer;
    void Reset() override
    {
        me->CastSpell(me, SPELL_DEMONIC_VAPOR_TRAIL_PERIODIC, true);
    }

    void SpellHitTarget(Unit*, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_DEMONIC_VAPOR)
            me->CastSpell(me, SPELL_SUMMON_BLAZING_DEAD, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (timer)
        {
            timer += diff;
            if (timer >= 6000)
            {
                timer = 0;
                me->CastSpell(me, SPELL_SUMMON_BLAZING_DEAD, true);
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summon->SetInCombatWithZone();
        summon->AI()->AttackStart(summon->AI()->SelectTarget(SelectTargetMethod::Random, 0, 100.0f));
    }
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
