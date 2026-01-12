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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ahnkahet.h"

enum Spells
{
    SPELL_BLOODTHIRST                       = 55968, //Trigger Spell + add aura
    SPELL_CONJURE_FLAME_SPHERE              = 55931,
    SPELL_FLAME_SPHERE_SPAWN_EFFECT         = 55891,
    SPELL_FLAME_SPHERE_SUMMON_1             = 55895, // 1x 30106
    SPELL_FLAME_SPHERE_SUMMON_2             = 59511, // 1x 31686
    SPELL_FLAME_SPHERE_SUMMON_3             = 59512, // 1x 31687
    SPELL_FLAME_SPHERE_VISUAL               = 55928,
    SPELL_FLAME_SPHERE_PERIODIC             = 55926,
    SPELL_FLAME_SPHERE_DEATH_EFFECT         = 55947,
    SPELL_BEAM_VISUAL                       = 60342,
    SPELL_VANISH                            = 55964,
    SPELL_SHADOWSTEP                        = 55966,
    SPELL_HOVER_FALL                        = 60425,
    SPELL_EMBRACE_OF_THE_VAMPYR             = 55959,
};

enum Spheres
{
    NPC_FLAME_SPHERE_1                      = 30106,
    NPC_FLAME_SPHERE_2                      = 31686,
    NPC_FLAME_SPHERE_3                      = 31687,
};

enum Misc
{
    MAX_EMBRACE_DMG                         = 20000,
    MAX_EMBRACE_DMG_H                       = 40000,

    SUMMON_GROUP_TRIGGERS                   = 0,

    GROUP_COMBAT_ABILITIES                  = 1,
};

enum Actions
{
    ACTION_REMOVE_PRISON_AT_RESET           = 1,
    ACTION_SPHERE,
};

enum Yells
{
    //SAY_SPHERE_ACTIVATED                    = 0,
    SAY_REMOVE_PRISON                       = 1,
    SAY_AGGRO                               = 2,
    SAY_SLAY                                = 3,
    SAY_DEATH                               = 4,
    SAY_FEED                                = 5,
    SAY_VANISH                              = 6,
};

enum Points
{
    POINT_LAND                              = 1,
    POINT_ORB,
};

constexpr float DATA_SPHERE_DISTANCE       = 25.0f;
#define DATA_SPHERE_ANGLE_OFFSET            float(M_PI) / 2.0f

struct npc_taldaram_flamesphere : public NullCreatureAI
{
    npc_taldaram_flamesphere(Creature *pCreature) : NullCreatureAI(pCreature),
        instance(pCreature->GetInstanceScript()),
        moveTimer(0)
    {
        pCreature->SetReactState(REACT_PASSIVE);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_SPHERE)
        {
            moveTimer = 3000;
        }
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        // Replace sphere instantly if sphere is summoned after prince death
        if (instance->GetBossState(DATA_PRINCE_TALDARAM) != IN_PROGRESS)
        {
            me->DespawnOrUnsummon();
            return;
        }

        DoCastSelf(SPELL_FLAME_SPHERE_SPAWN_EFFECT);
        DoCastSelf(SPELL_FLAME_SPHERE_VISUAL);
    }

    void JustDied(Unit* /*who*/) override
    {
        DoCastSelf(SPELL_FLAME_SPHERE_DEATH_EFFECT);
    }

    void UpdateAI(uint32 diff) override
    {
        if (moveTimer)
        {
            if (moveTimer <= diff)
            {
                DoCastSelf(SPELL_FLAME_SPHERE_PERIODIC);
                float angleOffset = 0.0f;

                switch (me->GetEntry())
                {
                    case NPC_FLAME_SPHERE_1:
                        break;
                    case NPC_FLAME_SPHERE_2:
                        angleOffset = DATA_SPHERE_ANGLE_OFFSET;
                        break;
                    case NPC_FLAME_SPHERE_3:
                        angleOffset = -DATA_SPHERE_ANGLE_OFFSET;
                        break;
                    default:
                        return;
                }

                float angle = me->GetAngle(&victimPos) + angleOffset;
                float x = me->GetPositionX() + DATA_SPHERE_DISTANCE * cos(angle);
                float y = me->GetPositionY() + DATA_SPHERE_DISTANCE * std::sin(angle);
                me->GetMotionMaster()->MovePoint(POINT_ORB, x, y, me->GetPositionZ());

                moveTimer = 0;
            }
            else
            {
                moveTimer -= diff;
            }
        }
    }

    void SetVictimPos(Position const& pos)
    {
        victimPos.Relocate(pos);
    }

private:
    Position victimPos;
    InstanceScript* instance;
    uint32 moveTimer;
};

struct boss_taldaram : public BossAI
{
    boss_taldaram(Creature* pCreature) : BossAI(pCreature, DATA_PRINCE_TALDARAM), vanishDamage(0)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void InitializeAI() override
    {
        BossAI::InitializeAI();

        // Event not started
        if (instance->GetPersistentData(DATA_TELDRAM_SPHERE1) != DONE || instance->GetPersistentData(DATA_TELDRAM_SPHERE2) != DONE)
        {
            me->SetImmuneToAll(true);
            me->SetDisableGravity(true);
            me->SetHover(true);

            if (!me->HasAura(SPELL_BEAM_VISUAL))
                DoCastSelf(SPELL_BEAM_VISUAL, true);

            me->SummonCreatureGroup(SUMMON_GROUP_TRIGGERS);
            return;
        }

        if (instance->GetPersistentData(DATA_TELDRAM_SPHERE1) == DONE && instance->GetPersistentData(DATA_TELDRAM_SPHERE2) == DONE)
            DoAction(ACTION_REMOVE_PRISON_AT_RESET);
    }

    void Reset() override
    {
        _Reset();

        vanishDamage = 0;

        me->SetReactState(REACT_AGGRESSIVE);

        ScheduleHealthCheckEvent({ 75, 50, 25 }, [&] {
            scheduler.Schedule(1s, [this](TaskContext)
            {
                Talk(SAY_VANISH);
                DoCastSelf(SPELL_VANISH);
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->Clear();
                DoStopAttack();
                scheduler.CancelGroup(GROUP_COMBAT_ABILITIES);
            });
        });
    }

    void OnAuraRemove(AuraApplication* auraApp, AuraRemoveMode mode) override
    {
        if (auraApp->GetBase()->GetId() == SPELL_VANISH && mode == AURA_REMOVE_BY_EXPIRE)
        {
            scheduler.Schedule(2500ms, [this](TaskContext)
            {
                if (Unit* vanishTarget = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                {
                    vanishDamage = 0;
                    DoCast(vanishTarget, SPELL_SHADOWSTEP);
                    DoCast(vanishTarget, SPELL_EMBRACE_OF_THE_VAMPYR);
                }

                me->m_Events.AddEventAtOffset([&] {
                    if (!scheduler.IsGroupScheduled(GROUP_COMBAT_ABILITIES))
                    {
                        ScheduleCombatEvents();
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->ResumeChasingVictim();
                    }
                }, 20s);
            });
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_REMOVE_PRISON || action == ACTION_REMOVE_PRISON_AT_RESET)
        {
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetMapWaterOrGroundLevel(me->GetPosition()), me->GetOrientation());
            instance->HandleGameObject(instance->GetGuidData(DATA_PRINCE_TALDARAM_PLATFORM), true);

            if (action == ACTION_REMOVE_PRISON)
            {
                DoCastSelf(SPELL_HOVER_FALL);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveLand(POINT_LAND, me->GetHomePosition(), 8.0f);
                Talk(SAY_REMOVE_PRISON);
            }
            // Teleport instantly
            else
            {
                me->SetDisableGravity(false);
                me->SetHover(false);
                me->RemoveAllAuras();
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE| UNIT_FLAG_NOT_SELECTABLE);
                me->SetImmuneToAll(false);
                me->UpdatePosition(me->GetHomePosition(), true);
            }
            summons.DespawnEntry(NPC_JEDOGA_CONTROLLER);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == EFFECT_MOTION_TYPE && id == POINT_LAND)
        {
            me->SetDisableGravity(false);
            me->SetHover(false);
            me->RemoveAllAuras();
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE| UNIT_FLAG_NOT_SELECTABLE);
            me->SetImmuneToAll(false);
        }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damageType, SpellSchoolMask school) override
    {
        BossAI::DamageTaken(attacker, damage, damageType, school);

        if (me->FindCurrentSpellBySpellId(sSpellMgr->GetSpellIdForDifficulty(SPELL_EMBRACE_OF_THE_VAMPYR, me)))
        {
            vanishDamage += damage;
            if (vanishDamage >= DUNGEON_MODE<uint32>(MAX_EMBRACE_DMG, MAX_EMBRACE_DMG_H))
            {
                ScheduleCombatEvents();
                me->CastStop();
                me->ResumeChasingVictim();
                me->SetReactState(REACT_AGGRESSIVE);
                vanishDamage = 0;
            }
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        Talk(SAY_SLAY);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        ScheduleCombatEvents();

        me->RemoveAllAuras();
        me->InterruptNonMeleeSpells(true);
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_CONJURE_FLAME_SPHERE)
            summons.DoAction(ACTION_SPHERE);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        switch (summon->GetEntry())
        {
            case NPC_FLAME_SPHERE_1:
            case NPC_FLAME_SPHERE_2:
            case NPC_FLAME_SPHERE_3:
            {
                if (npc_taldaram_flamesphere* summonAI = dynamic_cast<npc_taldaram_flamesphere*>(summon->AI()))
                    summonAI->SetVictimPos(victimSperePos);

                break;
            }
            case NPC_JEDOGA_CONTROLLER:
            {
                summon->CastSpell(nullptr, SPELL_BEAM_VISUAL);
                break;
            }
        }
    }

private:
    Position victimSperePos;
    uint32 vanishDamage;

    void ScheduleCombatEvents()
    {
        scheduler.Schedule(10s, GROUP_COMBAT_ABILITIES, [this](TaskContext context)
        {
            DoCastVictim(SPELL_BLOODTHIRST);
            context.Repeat(15s);
        }).Schedule(10s, GROUP_COMBAT_ABILITIES, [this](TaskContext context)
        {
            if (Unit* victim = me->GetVictim())
            {
                DoCast(victim, SPELL_CONJURE_FLAME_SPHERE);
                victimSperePos = victim->GetPosition();
            }

            context.Repeat(15s);
        });

        vanishDamage = 0;
    }
};

// 55931 - Conjure Flame Sphere
class spell_prince_taldaram_conjure_flame_sphere : public SpellScript
{
    PrepareSpellScript(spell_prince_taldaram_conjure_flame_sphere);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({SPELL_FLAME_SPHERE_SUMMON_1, SPELL_FLAME_SPHERE_SUMMON_2, SPELL_FLAME_SPHERE_SUMMON_3});
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster || caster->isDead())
        {
            return;
        }

        caster->CastSpell(caster, SPELL_FLAME_SPHERE_SUMMON_1, false, nullptr, nullptr, caster->GetGUID());

        if (caster->GetMap()->IsHeroic())
        {
            caster->CastSpell(caster, SPELL_FLAME_SPHERE_SUMMON_2, false, nullptr, nullptr, caster->GetGUID());
            caster->CastSpell(caster, SPELL_FLAME_SPHERE_SUMMON_3, false, nullptr, nullptr, caster->GetGUID());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_prince_taldaram_conjure_flame_sphere::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 55895, 59511, 59512 - Flame Sphere Summon
class spell_prince_taldaram_flame_sphere_summon : public SpellScript
{
    PrepareSpellScript(spell_prince_taldaram_flame_sphere_summon);

    void SetDest(SpellDestination& dest)
    {
        dest._position.m_positionZ = GetCaster()->GetPositionZ() + 5.5f;
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_prince_taldaram_flame_sphere_summon::SetDest, EFFECT_0, TARGET_DEST_CASTER);
    }
};

void AddSC_boss_taldaram()
{
    RegisterAhnKahetCreatureAI(npc_taldaram_flamesphere);
    RegisterAhnKahetCreatureAI(boss_taldaram);

    // Spells
    RegisterSpellScript(spell_prince_taldaram_conjure_flame_sphere);
    RegisterSpellScript(spell_prince_taldaram_flame_sphere_summon);
}
