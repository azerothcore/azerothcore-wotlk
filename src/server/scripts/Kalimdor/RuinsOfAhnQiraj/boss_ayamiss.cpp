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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ruins_of_ahnqiraj.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_STINGER_SPRAY       = 25749,
    SPELL_POISON_STINGER      = 25748,
    SPELL_PARALYZE            = 25725,
    SPELL_FRENZY              = 8269,
    SPELL_LASH                = 25852,
    SPELL_FEED                = 25721,

    // Server-side spells
    SPELL_SUMMON_LARVA_A                    = 26538,
    SPELL_SUMMON_LARVA_B                    = 26539,
    SPELL_LARVA_AGGRO_EFFECT                = 25724, // Unknown purpose
    SPELL_LARVA_FEAR_EFFECT                 = 25726, // Unknown purpose
    SPELL_SUMMON_HIVEZARA_SWARMER           = 25708,
    SPELL_HIVEZARA_SWARMER_TELEPORT_1       = 25709,
    SPELL_HIVEZARA_SWARMER_TELEPORT_2       = 25825,
    SPELL_HIVEZARA_SWARMER_TELEPORT_3       = 25826,
    SPELL_HIVEZARA_SWARMER_TELEPORT_4       = 25827,
    SPELL_HIVEZARA_SWARMER_TELEPORT_5       = 25828,
    SPELL_HIVEZARA_SWARMER_TELEPORT_TRIGGER = 25830,
    SPELL_HIVEZARA_SWARMER_START_LOOP       = 25711,
    SPELL_HIVEZARA_SWARMER_LOOP_1           = 25833,
    SPELL_HIVEZARA_SWARMER_LOOP_2           = 25834,
    SPELL_HIVEZARA_SWARMER_LOOP_3           = 25835,
    SPELL_HIVEZARA_SWARMER_SWARM            = 25844
};

enum Misc
{
    MAX_SWARMER_COUNT    = 28,
    ACTION_SWARMER_SWARM = 1,
};

enum Emotes
{
    EMOTE_FRENZY              =  0
};

enum Phases
{
    PHASE_AIR                 = 0,
    PHASE_GROUND              = 1
};

enum Points
{
    POINT_AIR                 = 0,
    POINT_GROUND              = 2,
    POINT_PARALYZE            = 2
};

const Position AyamissAirPos  = { -9689.292f, 1547.912f, 48.02729f, 0.0f };
const Position AltarPos       = { -9717.18f, 1517.72f, 27.4677f, 0.0f };

struct boss_ayamiss : public BossAI
{
    boss_ayamiss(Creature* creature) : BossAI(creature, DATA_AYAMISS) { homePos = creature->GetHomePosition(); }

    void Reset() override
    {
        BossAI::Reset();
        _phase = PHASE_AIR;
        _enraged = false;
        SetCombatMovement(false);
    }

    void JustSummoned(Creature* who) override
    {
        switch (who->GetEntry())
        {
            case NPC_HIVEZARA_SWARMER:
                who->CastSpell(who, SPELL_HIVEZARA_SWARMER_TELEPORT_TRIGGER, true);
                _swarmers.push_back(who->GetGUID());
                break;
            case NPC_HIVEZARA_LARVA:
                who->GetMotionMaster()->MovePoint(POINT_PARALYZE, AltarPos);
                break;
        }
        summons.Summon(who);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_AIR)
        {
            me->AddUnitState(UNIT_STATE_ROOT);
        }
        else if (type == WAYPOINT_MOTION_TYPE && id == POINT_GROUND)
        {
            SetCombatMovement(true);
            me->m_Events.AddEventAtOffset([this]()
            {
                if (me->GetVictim())
                {
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                }

            }, 1s);
        }
    }

    void ScheduleTasks()
    {
        _scheduler.Schedule(20s, 30s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_STINGER_SPRAY);
            context.Repeat(15s, 20s);
        }).Schedule(5s, [this](TaskContext context) {
            DoCastVictim(SPELL_POISON_STINGER);
            context.SetGroup(PHASE_AIR);
            context.Repeat(2s, 3s);
        }).Schedule(5s, [this](TaskContext context) {
            DoCastAOE(SPELL_SUMMON_HIVEZARA_SWARMER, true);

            if (_swarmers.size() >= MAX_SWARMER_COUNT)
            {
                DoCastAOE(SPELL_HIVEZARA_SWARMER_SWARM, true);
            }

            context.Repeat(RAND(2400ms, 3600ms));
        }).Schedule(15s, [this](TaskContext context) {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0, true))
            {
                DoCast(target, SPELL_PARALYZE, true);
                instance->SetGuidData(DATA_PARALYZED, target->GetGUID());
                DoCastAOE(RAND(SPELL_SUMMON_LARVA_A, SPELL_SUMMON_LARVA_B), true);
            }
            context.Repeat();
        });
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_SWARMER_SWARM)
        {
            for (ObjectGuid const& guid : _swarmers)
            {
                if (Creature* swarmer = me->GetMap()->GetCreature(guid))
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                    {
                        swarmer->AI()->AttackStart(target);
                    }
                }
            }

            _swarmers.clear();
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->ClearUnitState(UNIT_STATE_ROOT);
        me->SetHomePosition(homePos);
        BossAI::EnterEvadeMode(why);
    }

    void EnterCombat(Unit* attacker) override
    {
        BossAI::EnterCombat(attacker);
        me->SetCanFly(true);
        me->SetDisableGravity(true);
        me->GetMotionMaster()->MovePoint(POINT_AIR, AyamissAirPos);
        ScheduleTasks();
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (_phase == PHASE_AIR && me->HealthBelowPctDamaged(70, damage))
        {
            _phase = PHASE_GROUND;
            me->ClearUnitState(UNIT_STATE_ROOT);
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
            DoResetThreat();

            _scheduler.Schedule(5s, 8s, [this](TaskContext context) {
                DoCastVictim(SPELL_LASH);
                context.Repeat(8s, 15s);
            });

            _scheduler.CancelGroup(PHASE_AIR);
        }

        if (!_enraged && me->HealthBelowPctDamaged(20, damage))
        {
            DoCastSelf(SPELL_FRENZY);
            Talk(EMOTE_FRENZY);
            _enraged = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }
private:
    GuidList _swarmers;
    uint8 _phase;
    bool _enraged;
    TaskScheduler _scheduler;
    Position homePos;
};

struct npc_hive_zara_larva : public ScriptedAI
{
    npc_hive_zara_larva(Creature* creature) : ScriptedAI(creature)
    {
        _instance = me->GetInstanceScript();
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_PARALYZE)
        {
            if (Player* target = ObjectAccessor::GetPlayer(*me, _instance->GetGuidData(DATA_PARALYZED)))
            {
                DoCast(target, SPELL_FEED);
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        if (Creature* ayamiss = _instance->GetCreature(DATA_AYAMISS))
        {
            ayamiss->AI()->JustSummoned(summon);
        }
    }

    void MoveInLineOfSight(Unit* who) override

    {
        if (_instance->GetBossState(DATA_AYAMISS) == IN_PROGRESS)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void AttackStart(Unit* victim) override
    {
        if (_instance->GetBossState(DATA_AYAMISS) == IN_PROGRESS)
            return;

        ScriptedAI::AttackStart(victim);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_instance->GetBossState(DATA_AYAMISS) == IN_PROGRESS)
            return;

        ScriptedAI::UpdateAI(diff);
    }
private:
    InstanceScript* _instance;
};

struct WaspTeleportData
{
    uint32 spellId;
    uint32 pathId;
};

class spell_ayamiss_swarmer_teleport_trigger : public SpellScript
{
    PrepareSpellScript(spell_ayamiss_swarmer_teleport_trigger);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        WaspTeleportData telData[5] =
        {
            { SPELL_HIVEZARA_SWARMER_TELEPORT_1, NPC_HIVEZARA_SWARMER * 10 },
            { SPELL_HIVEZARA_SWARMER_TELEPORT_2, (NPC_HIVEZARA_SWARMER + 1) * 10 },
            { SPELL_HIVEZARA_SWARMER_TELEPORT_3, (NPC_HIVEZARA_SWARMER + 2) * 10 },
            { SPELL_HIVEZARA_SWARMER_TELEPORT_4, (NPC_HIVEZARA_SWARMER + 3) * 10 },
            { SPELL_HIVEZARA_SWARMER_TELEPORT_5, (NPC_HIVEZARA_SWARMER + 4) * 10 }
        };

        WaspTeleportData data = Acore::Containers::SelectRandomContainerElement(telData);
        caster->CastSpell((Unit*)nullptr, data.spellId, true);

        uint32 pathId = data.pathId;
        caster->m_Events.AddEventAtOffset([caster, pathId]()
        {
            caster->GetMotionMaster()->MovePath(pathId, false);
        }, 1s);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ayamiss_swarmer_teleport_trigger::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_ayamiss_swarmer_swarm : public SpellScript
{
    PrepareSpellScript(spell_ayamiss_swarmer_swarm);

    bool Load() override
    {
        return GetCaster()->GetEntry() == NPC_AYAMISS;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->ToCreature()->AI()->DoAction(ACTION_SWARMER_SWARM);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ayamiss_swarmer_swarm::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_ayamiss()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_ayamiss);
    RegisterRuinsOfAhnQirajCreatureAI(npc_hive_zara_larva);
    RegisterSpellScript(spell_ayamiss_swarmer_teleport_trigger);
    RegisterSpellScript(spell_ayamiss_swarmer_swarm);
}
