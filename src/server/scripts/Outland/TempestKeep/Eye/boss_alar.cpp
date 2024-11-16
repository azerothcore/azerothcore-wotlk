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
#include <cmath>

#include "Player.h"
#include "SpellScript.h"

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
    SPELL_DIVE_BOMB                 = 35181,

    SPELL_MODEL_VISIBILITY          = 24401 // Might not be accurate
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

    EVENT_MOVE_TO_PHASE_2       = 3,
    EVENT_FINISH_DIVE           = 4,
    EVENT_INVISIBLE             = 5
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

const float INNER_CIRCLE_RADIUS = 60.0f;

struct boss_alar : public BossAI
{

    boss_alar(Creature* creature) : BossAI(creature, DATA_ALAR)
    {
        me->SetCombatMovement(false);
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        _canAttackCooldown = true;
        _baseAttackOverride = false;
        _spawnPhoenixes = false;
        _hasPretendedToDie = false;
        _transitionScheduler.CancelAll();
        _platform = 0;
        _noMelee = false;
        _platformRoll = 0;
        _noQuillTimes = 0;
        _platformMoveRepeatTimer = 16s;
        me->SetModelVisible(true);
        me->SetReactState(REACT_AGGRESSIVE);
        ConstructWaypointsAndMove();
        me->m_Events.KillAllEvents(false);
    }

    void JustReachedHome() override
    {
        BossAI::JustReachedHome();
        if (me->IsEngaged())
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

    bool CanAIAttack(Unit const* victim) const override
    {
        if (me->isMoving())
            return true;

        return _hasPretendedToDie || me->IsWithinMeleeRange(victim);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (why == EVADE_REASON_BOUNDARY)
            BossAI::EnterEvadeMode(why);
        else if (me->GetThreatMgr().GetThreatList().empty())
            BossAI::EnterEvadeMode(why);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        me->SetModelVisible(true);

        me->GetMap()->DoForAllPlayers([&](Player* player)
        {
            if (player->GetQuestStatus(QUEST_RUSE_OF_THE_ASHTONGUE) == QUEST_STATUS_INCOMPLETE && player->HasAura(SPELL_ASHTONGUE_RUSE))
                player->AreaExploredOrEventHappens(QUEST_RUSE_OF_THE_ASHTONGUE);
        });
    }

    void MoveInLineOfSight(Unit* /*who*/) override { }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth() && _platform < POINT_MIDDLE)
        {
            damage = 0;
            if (!_hasPretendedToDie)
            {
                _hasPretendedToDie = true;
                DoCastSelf(SPELL_EMBER_BLAST, true);
                PretendToDie(me);
                _transitionScheduler.Schedule(1s, [this](TaskContext)
                {
                    me->SetVisible(false);
                }).Schedule(8s, [this](TaskContext)
                {
                    me->SetPosition(alarPoints[POINT_MIDDLE]);
                }).Schedule(12s, [this](TaskContext)
                {
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetVisible(true);
                    DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                    DoCastSelf(SPELL_REBIRTH_PHASE2);
                }).Schedule(16001ms, [this](TaskContext)
                {
                    me->SetHealth(me->GetMaxHealth());
                    me->SetReactState(REACT_AGGRESSIVE);
                    _noMelee = false;
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    _platform = POINT_MIDDLE;
                    me->ResumeChasingVictim();
                    ScheduleAbilities();
                });
            }
        }
    }

    void PretendToDie(Creature* creature)
    {
        _noMelee = true;
        scheduler.CancelAll();
        creature->InterruptNonMeleeSpells(true);
        creature->RemoveAllAuras();
        creature->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        creature->SetReactState(REACT_PASSIVE);
        creature->GetMotionMaster()->MovementExpired(false);
        creature->GetMotionMaster()->MoveIdle();
        creature->SetStandState(UNIT_STAND_STATE_DEAD);
    }

    void ScheduleAbilities()
    {
        _transitionScheduler.CancelAll();
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
                me->SummonCreature(NPC_FLAME_PATCH, *target, TEMPSUMMON_TIMED_DESPAWN, 2 * MINUTE * IN_MILLISECONDS);
        }, 30s);
        ScheduleTimedEvent(34s, [&]
        {
            me->GetMotionMaster()->MovePoint(POINT_DIVE, alarPoints[POINT_DIVE], false, true);
            scheduler.DelayAll(15s);
        }, 57s);

        me->m_Events.AddEventAtOffset([&] {
            DoCastSelf(SPELL_BERSERK, true);
        }, 10min);

        ScheduleMainSpellAttack(0s);
    }

    void SpawnPhoenixes(uint8 count, Unit* targetToSpawnAt)
    {
        if (targetToSpawnAt)
        {
            Position spawnPosition = DeterminePhoenixPosition(targetToSpawnAt->GetPosition());
            for (uint8 i = 0; i < count; ++i)
            {
                me->SummonCreature(NPC_EMBER_OF_ALAR, spawnPosition, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
            }
        }
    }

    void DoDiveBomb()
    {
        _noMelee = true;
        scheduler.Schedule(2s, [this](TaskContext)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 110.0f, true))
                SpawnPhoenixes(2, target);
        }).Schedule(6s, [this](TaskContext)
        {
            me->SetModelVisible(true);
            DoCastSelf(SPELL_REBIRTH_DIVE);
        }).Schedule(10s, [this](TaskContext)
        {
            me->ResumeChasingVictim();
            _noMelee = false;
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
                ConstructWaypointsAndMove();

            return;
        }

        switch (id)
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
            if (!me->SelectNearestTarget(me->GetCombatReach()) && !me->isMoving())
                DoCastVictim(SPELL_FLAME_BUFFET);

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

    void UpdateAI(uint32 diff) override
    {
        _transitionScheduler.Update(diff);

        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (!_noMelee)
            DoMeleeAttackIfReady();
    }

    Position DeterminePhoenixPosition(Position playerPosition)
    {
        // set finalPosition to playerPosition in case the fraction fails
        Position finalPosition = playerPosition;
        float playerXPosition = playerPosition.GetPositionX();
        float playerYPosition = playerPosition.GetPositionY();
        float centreXPosition = alarPoints[POINT_MIDDLE].GetPositionX();
        float centreYPosition = alarPoints[POINT_MIDDLE].GetPositionY();
        float deltaX = std::abs(playerXPosition-centreXPosition);
        float deltaY = std::abs(playerYPosition-centreYPosition);
        int8 signMultiplier[2] = {1, 1};
        // if fraction has x position 0.0f we get nan as a result
        if (float playerFraction = deltaX/deltaY)
        {
            // player angle based on delta X and delta Y
            float playerAngle = std::atan(playerFraction);
            float phoenixDeltaYPosition = std::cos(playerAngle)*INNER_CIRCLE_RADIUS;
            float phoenixDeltaXPosition = std::sin(playerAngle)*INNER_CIRCLE_RADIUS;
            // as calculations are absolute values we have to multiply in the end
            // should be negative if player position was further down than centre
            if (playerXPosition < centreXPosition)
                signMultiplier[0] = -1;
            if (playerYPosition < centreYPosition)
                signMultiplier[1] = -1;
            // phoenix position based on set distance
            finalPosition = {centreXPosition+signMultiplier[0]*phoenixDeltaXPosition, centreYPosition+signMultiplier[1]*phoenixDeltaYPosition, 0.0f, 0.0f};
        }
        return finalPosition;
    }

private:
    bool _hasPretendedToDie;
    bool _canAttackCooldown;
    bool _baseAttackOverride;
    bool _spawnPhoenixes;
    bool _noMelee;
    uint8 _platform;
    uint8 _platformRoll;
    uint8 _noQuillTimes;
    std::chrono::seconds _platformMoveRepeatTimer;
    TaskScheduler _transitionScheduler;
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

    void HandleCast()
    {
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            if (Creature* alar = instance->GetCreature(DATA_ALAR))
                if (!alar->HasAura(SPELL_MODEL_VISIBILITY))
                    Unit::DealDamage(GetCaster(), alar, alar->CountPctFromMaxHealth(2));
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_alar_ember_blast::HandleCast);
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
    RegisterSpellScript(spell_alar_dive_bomb);
}
