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
#include "MoveSplineInit.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "WaypointMgr.h"
#include "the_eye.h"

enum Spells
{
    SPELL_BERSERK                   = 45078,
    SPELL_FLAME_QUILLS              = 34229,
    SPELL_QUILL_MISSILE_1           = 34269, // 21
    SPELL_QUILL_MISSILE_2           = 34314, // 3
    SPELL_CLEAR_ALL_DEBUFFS         = 34098,
    SPELL_FLAME_BUFFET              = 34121,
    SPELL_EMBER_BLAST               = 34341,
    SPELL_REBIRTH_PHASE2            = 34342,
    SPELL_MELT_ARMOR                = 35410,
    SPELL_CHARGE                    = 35412,
    SPELL_REBIRTH_DIVE              = 35369,
    SPELL_DIVE_BOMB_VISUAL          = 35367,
    SPELL_DIVE_BOMB                 = 35181
};

// @todo: Alar doesnt seem to move to waypoints but instead to the triggers in p1
const Position alarPoints[9] =
{
    {335.638f, 59.4879f, 17.9319f, 4.60f}, //first platform
    {388.751007f, 31.731199f, 20.263599f, 1.61f},
    {388.790985f, -33.105900f, 20.263599f, 0.52f},
    {332.722992f, -61.159f, 17.979099f, 5.71f},
    {258.959015f, -38.687099f, 20.262899f, 5.21f}, //pre-nerf only
    {259.2277997, 35.879002f, 20.263f, 4.81f}, //pre-nerf only
    {332.0f, 0.01f, 43.0f, 0.0f}, //quill
    {331.0f, 0.01f, -2.38f, 0.0f}, //middle (p2)
    {332.0f, 0.01f, 43.0f, 0.0f} // dive
};

enum Misc
{
    DISPLAYID_INVISIBLE         = 23377,
    NPC_EMBER_OF_ALAR           = 19551,
    NPC_FLAME_PATCH             = 20602,

    POINT_PLATFORM              = 0,
    POINT_QUILL                 = 6,
    POINT_MIDDLE                = 7,
    POINT_DIVE                  = 8,

    EVENT_RELOCATE_MIDDLE       = 1,
    EVENT_REBIRTH               = 2,
    EVENT_SPELL_BERSERK         = 3,

    EVENT_MOVE_TO_PHASE_2       = 4,
    EVENT_FINISH_DIVE           = 5
};

enum GroupAlar
{
    GROUP_FLAME_BUFFET          = 1
};

// Xinef: Ruse of the Ashtongue (10946)
enum qruseoftheAshtongue
{
    SPELL_ASHTONGUE_RUSE        = 42090,
    QUEST_RUSE_OF_THE_ASHTONGUE = 10946,
};

struct boss_alar : public BossAI
{

    boss_alar(Creature* creature) : BossAI(creature, DATA_ALAR)
    {
        SetCombatMovement(false);
    }

    void JustReachedHome() override
    {
        BossAI::JustReachedHome();
        if (me->IsEngaged())
        {
            ConstructWaypointsAndMove();
        }
    }

    void Reset() override
    {
        BossAI::Reset();
        _canAttackCooldown = true;
        _baseAttackOverride = false;
        _spawnPhoenixes = false;
        _platform = 0;
        _platformRoll = 0;
        _noQuillTimes = 0;
        _platformMoveRepeatTimer = 16s;
        me->SetModelVisible(true);
        me->SetReactState(REACT_AGGRESSIVE);
        ConstructWaypointsAndMove();
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        scheduler.Schedule(0s, [this](TaskContext context)
        {
            if (roll_chance_i(20 * _noQuillTimes))
            {
                _noQuillTimes = 0;
                _platformRoll = RAND(0, 1);
                _platform = _platformRoll ? 0 : 3;
                me->GetMotionMaster()->MovePoint(POINT_QUILL, alarPoints[POINT_QUILL], false, true);
                _platformMoveRepeatTimer = 16s;
            }
            else
            {
                if (_noQuillTimes++ > 0)
                {
                    me->SetOrientation(alarPoints[_platform].GetOrientation());
                    SpawnPhoenixes(1, me);
                }
                me->GetMotionMaster()->MovePoint(POINT_PLATFORM, alarPoints[_platform], false, true);
                _platform = (_platform+1)%4;
                _platformMoveRepeatTimer = 30s;
            }
            context.Repeat(_platformMoveRepeatTimer);
        });
        ScheduleMainSpellAttack(0s);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        me->SetModelVisible(true);

        if (Map* map = me->GetMap())
        {
            map->DoForAllPlayers([&](Player* player)
            {
                if (player->GetQuestStatus(QUEST_RUSE_OF_THE_ASHTONGUE) == QUEST_STATUS_INCOMPLETE)
                {
                    if (player->HasAura(SPELL_ASHTONGUE_RUSE))
                    {
                        player->AreaExploredOrEventHappens(QUEST_RUSE_OF_THE_ASHTONGUE);
                    }
                }
            });
        }
    }

    void MoveInLineOfSight(Unit* /*who*/) override { }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth() && _platform < POINT_MIDDLE)
        {
            damage = 0;
            me->SetReactState(REACT_PASSIVE);
            scheduler.CancelAll();
            me->CastStop();
            me->SetHealth(me->GetMaxHealth());
            DoCastSelf(SPELL_EMBER_BLAST, true); //spellscript doesn't trigger

            ScheduleUniqueTimedEvent(8s, [&]{
                me->SetPosition(alarPoints[POINT_MIDDLE]);
            }, EVENT_RELOCATE_MIDDLE);
            ScheduleUniqueTimedEvent(12s, [&]
            {
                DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                DoCastSelf(SPELL_REBIRTH_PHASE2);
            }, EVENT_MOVE_TO_PHASE_2);
            ScheduleUniqueTimedEvent(16001ms, [&]{
                me->SetReactState(REACT_AGGRESSIVE);
                _platform = POINT_MIDDLE;
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                ScheduleAbilities();
            }, EVENT_REBIRTH);
        }
    }

    void ScheduleAbilities()
    {
        ScheduleTimedEvent(57s, [&]
        {
            DoCastVictim(SPELL_MELT_ARMOR);
        }, 60s);
        ScheduleTimedEvent(10s, [&]
        {
            DoCastRandomTarget(SPELL_CHARGE, 0, 50.0f);
        }, 30s);
        ScheduleTimedEvent(20s, [&]
        {
            // find spell from sniffs?
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
            {
                me->SummonCreature(NPC_FLAME_PATCH, *target, TEMPSUMMON_TIMED_DESPAWN, 2 * MINUTE * IN_MILLISECONDS);
            }
        }, 30s);
        ScheduleTimedEvent(30s, [&]
        {
            me->GetMotionMaster()->MovePoint(POINT_DIVE, alarPoints[POINT_DIVE], false, true);
            scheduler.DelayAll(15s);
        }, 30s);
        ScheduleUniqueTimedEvent(10min, [&]
        {
            DoCastSelf(SPELL_BERSERK);
        }, EVENT_SPELL_BERSERK);
        ScheduleMainSpellAttack(0s);
    }

    void SpawnPhoenixes(uint8 count, Unit* targetToSpawnAt)
    {
        if (targetToSpawnAt)
        {
            for (uint8 i = 0; i < count; ++i)
            {
                me->SummonCreature(NPC_EMBER_OF_ALAR, *targetToSpawnAt, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
            }
        }
    }

    void DoDiveBomb()
    {
        scheduler.Schedule(2s, [this](TaskContext)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 10.0f, true))
            {
                SpawnPhoenixes(2, target);
            }
        }).Schedule(6s, [this](TaskContext)
        {
            me->SetModelVisible(true);
            DoCastSelf(SPELL_REBIRTH_DIVE);
        }).Schedule(10s, [this](TaskContext)
        {
            me->GetMotionMaster()->MoveChase(me->GetVictim());
        });
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 90.0f, true))
        {
            DoCast(target, SPELL_DIVE_BOMB);
            me->SetPosition(*target);
            me->StopMovingOnCurrentPos();
        }
        me->RemoveAurasDueToSpell(SPELL_DIVE_BOMB_VISUAL);

    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
        {
            if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized() && !me->IsInCombat())
            {
                ConstructWaypointsAndMove();
            }
            return;
        }

        switch(id)
        {
            case POINT_QUILL:
                scheduler.CancelGroup(GROUP_FLAME_BUFFET);
                scheduler.Schedule(1s, [this](TaskContext)
                {
                    DoCastSelf(SPELL_FLAME_QUILLS);
                });
                ScheduleMainSpellAttack(13s);
                break;
            case POINT_DIVE:
                scheduler.Schedule(1s, [this](TaskContext)
                {
                    DoCastSelf(SPELL_DIVE_BOMB_VISUAL);
                }).Schedule(5s, [this](TaskContext)
                {
                    DoDiveBomb();
                });
                break;
            default:
                return;
        }
    }

    void ScheduleMainSpellAttack(std::chrono::seconds timer)
    {
        scheduler.Schedule(timer, GROUP_FLAME_BUFFET, [this](TaskContext context)
        {
            if (!me->IsWithinMeleeRange(me->GetVictim()) && !me->isMoving())
            {
                DoCastVictim(SPELL_FLAME_BUFFET);
            }
            context.Repeat(2s);
        });
    }

    void ConstructWaypointsAndMove()
    {
        me->StopMoving();
        if (WaypointPath const* i_path = sWaypointMgr->GetPath(me->GetWaypointPath()))
        {
            Movement::PointsArray pathPoints;
            pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            for (uint8 i = 0; i < i_path->size(); ++i)
            {
                WaypointData const* node = i_path->at(i);
                pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
            }
            me->GetMotionMaster()->MoveSplinePath(&pathPoints);
        }
    }

private:
    bool _canAttackCooldown;
    bool _baseAttackOverride;
    bool _spawnPhoenixes;
    uint8 _platform;
    uint8 _platformRoll;
    uint8 _noQuillTimes;
    std::chrono::seconds _platformMoveRepeatTimer;
};

class CastQuill : public BasicEvent
{
public:
    CastQuill(Unit* caster, uint32 spellId) : _caster(caster), _spellId(spellId){ }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        _caster->CastSpell(_caster, _spellId, true);
        return true;
    }
private:
    Unit* _caster;
    uint32 _spellId;
};

class spell_alar_flame_quills : public AuraScript
{
    PrepareAuraScript(spell_alar_flame_quills);

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        PreventDefaultAction();

        // 24 spells in total
        for (uint8 i = 0; i < 21; ++i)
            GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_1 + i), GetUnitOwner()->m_Events.CalculateTime(i * 40));
        GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_2 + 0), GetUnitOwner()->m_Events.CalculateTime(22 * 40));
        GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_2 + 1), GetUnitOwner()->m_Events.CalculateTime(23 * 40));
        GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_2 + 2), GetUnitOwner()->m_Events.CalculateTime(24 * 40));
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_alar_flame_quills::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_alar_ember_blast : public SpellScript
{
    PrepareSpellScript(spell_alar_ember_blast);

    void HandleForceCast(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
        {
            if (Creature* alar = instance->GetCreature(DATA_ALAR))
            {
                Unit::DealDamage(GetCaster(), alar, alar->CountPctFromMaxHealth(2));
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_alar_ember_blast::HandleForceCast, EFFECT_2, SPELL_EFFECT_FORCE_CAST);
    }
};

class spell_alar_ember_blast_death : public AuraScript
{
    PrepareAuraScript(spell_alar_ember_blast_death);

    void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        PreventDefaultAction(); // xinef: prevent default action after change that invisibility in instances is executed instantly even for creatures
        Unit* target = GetTarget();
        InvisibilityType type = InvisibilityType(aurEff->GetMiscValue());
        target->m_invisibility.AddFlag(type);
        target->m_invisibility.AddValue(type, aurEff->GetAmount());

        GetUnitOwner()->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        GetUnitOwner()->SetStandState(UNIT_STAND_STATE_DEAD);
        GetUnitOwner()->m_last_notify_position.Relocate(0.0f, 0.0f, 0.0f);
        GetUnitOwner()->m_delayed_unit_relocation_timer = 1000;
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        GetUnitOwner()->SetStandState(UNIT_STAND_STATE_STAND);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_alar_ember_blast_death::OnApply, EFFECT_2, SPELL_AURA_MOD_INVISIBILITY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_alar_ember_blast_death::OnRemove, EFFECT_2, SPELL_AURA_MOD_INVISIBILITY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_alar_dive_bomb : public AuraScript
{
    PrepareAuraScript(spell_alar_dive_bomb);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->SetModelVisible(false);
        GetUnitOwner()->SetDisplayId(DISPLAYID_INVISIBLE);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_alar_dive_bomb::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_alar()
{
    RegisterTheEyeAI(boss_alar);
    RegisterSpellScript(spell_alar_flame_quills);
    RegisterSpellScript(spell_alar_ember_blast);
    RegisterSpellScript(spell_alar_ember_blast_death);
    RegisterSpellScript(spell_alar_dive_bomb);
}

