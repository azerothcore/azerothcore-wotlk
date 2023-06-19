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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "karazhan.h"

enum PrinceSay
{
    SAY_AGGRO     = 0,
    SAY_AXE_TOSS1 = 1,
    SAY_AXE_TOSS2 = 2,
    SAY_SLAY      = 6,
    SAY_SUMMON    = 7,
    SAY_DEATH     = 8,
};

enum Spells
{
    SPELL_ENFEEBLE         = 30843,
    SPELL_ENFEEBLE_EFFECT  = 41624,
    SPELL_SHADOW_NOVA      = 30852,
    SPELL_SHADOW_WORD_PAIN = 30854,
    SPELL_THRASH_PASSIVE   = 12787,
    SPELL_SUNDER_ARMOR     = 30901,
    SPELL_THRASH_AURA      = 12787,
    SPELL_EQUIP_AXES       = 30857,
    SPELL_AMPLIFY_DAMAGE   = 39095,
    SPELL_CLEAVE           = 30131,
    SPELL_HELLFIRE         = 30859,
};

enum creatures
{
    NPC_NETHERSPITE_INFERNAL     = 17646,
    NPC_MALCHEZARS_AXE           = 17650,
    INFERNAL_MODEL_INVISIBLE = 11686,
    SPELL_INFERNAL_RELAY     = 33814,   // 30835,
    EQUIP_ID_AXE             = 33542
};

enum EventGroups
{
    GROUP_ENFEEBLE,
    GROUP_SHADOW_NOVA,
    GROUP_SHADOW_WORD_PAIN,
};

enum Phases
{
    PHASE_ONE   = 1,
    PHASE_TWO   = 2,
    PHASE_THREE = 3
};

struct InfernalPoint
{
    float x, y;
};

#define INFERNAL_Z 275.5f

/*static InfernalPoint InfernalPoints[] =
{
    { -10922.8f, -1985.2f },
    { -10916.2f, -1996.2f },
    { -10932.2f, -2008.1f },
    { -10948.8f, -2022.1f },
    { -10958.7f, -1997.7f },
    { -10971.5f, -1997.5f },
    { -10990.8f, -1995.1f },
    { -10989.8f, -1976.5f },
    { -10971.6f, -1973.0f },
    { -10955.5f, -1974.0f },
    { -10939.6f, -1969.8f },
    { -10958.0f, -1952.2f },
    { -10941.7f, -1954.8f },
    { -10943.1f, -1988.5f },
    { -10948.8f, -2005.1f },
    { -10984.0f, -2019.3f },
    { -10932.8f, -1979.6f },
    { -10935.7f, -1996.0f }
};*/

struct boss_malchezaar : public BossAI
{
    boss_malchezaar(Creature* creature) : BossAI(creature, DATA_MALCHEZZAR) { }

    void Initialize()
    {
        _phase = 1;
        clearweapons();
        positions.clear();
        instance->HandleGameObject(instance->GetGuidData(DATA_GO_NETHER_DOOR), true);
    }

    void clearweapons()
    {
        SetEquipmentSlots(false, EQUIP_UNEQUIP, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
        me->SetCanDualWield(false);
    }

    void Reset() override
    {
        Initialize();
        _Reset();
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
        instance->HandleGameObject(instance->GetGuidData(DATA_GO_NETHER_DOOR), true);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();
        instance->HandleGameObject(instance->GetGuidData(DATA_GO_NETHER_DOOR), false);

        scheduler.Schedule(30s, [this](TaskContext context)
        {
            EnfeebleHealthEffect();

            scheduler.Schedule(9s, [this](TaskContext)
            {
                EnfeebleResetHealth();
            });

            context.SetGroup(GROUP_ENFEEBLE);
            scheduler.DelayGroup(GROUP_SHADOW_NOVA, 5s);
            context.Repeat();
        }).Schedule(35500ms, [this](TaskContext context)
        {
            DoCastAOE(SPELL_SHADOW_NOVA);
            context.SetGroup(GROUP_SHADOW_NOVA);
            context.Repeat();
        }).Schedule(40s, [this](TaskContext context)
        {
            Position pos =  me->GetRandomNearPosition(40.0);;

            if (Creature* RELAY = me->FindNearestCreature(NPC_RELAY, 100.0f))
            {
                if (Creature* infernal = RELAY->SummonCreature(NPC_NETHERSPITE_INFERNAL, pos, TEMPSUMMON_TIMED_DESPAWN, 180000))
                {
                    infernal->SetDisplayId(INFERNAL_MODEL_INVISIBLE);
                    infernal->SetFaction(me->GetFaction());
                    infernal->SetControlled(true, UNIT_STATE_ROOT);
                    RELAY->AI()->DoCast(infernal, SPELL_INFERNAL_RELAY);
                    summons.Summon(infernal);
                }
            }

            context.Repeat(_phase == PHASE_THREE ? 15s : 45s);

            Talk(SAY_SUMMON);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOW_WORD_PAIN);
            context.SetGroup(GROUP_SHADOW_WORD_PAIN);
            context.Repeat();
        });
    }

    void DamageTaken(Unit* /*done_by*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(60, damage) && _phase == PHASE_ONE)
        {
            me->InterruptNonMeleeSpells(false);
            _phase = 2;
            DoCastSelf( SPELL_EQUIP_AXES);
            Talk(SAY_AXE_TOSS1);
            DoCastSelf( SPELL_THRASH_AURA, true);
            SetEquipmentSlots(false, EQUIP_ID_AXE, EQUIP_ID_AXE, EQUIP_NO_CHANGE);
            me->SetCanDualWield(true);
            me->SetAttackTime(OFF_ATTACK, (me->GetAttackTime(BASE_ATTACK) * 150) / 100);

            scheduler.Schedule(5s, 10s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SUNDER_ARMOR);
                context.Repeat();
            });

            scheduler.CancelGroup(GROUP_SHADOW_WORD_PAIN);
        }
        else if (me->HealthBelowPctDamaged(30, damage) && _phase == PHASE_TWO)
        {
            me->RemoveAurasDueToSpell(SPELL_THRASH_AURA);
            Talk(SAY_AXE_TOSS2);
            _phase = PHASE_THREE;
            clearweapons();

            me->SummonCreature(NPC_MALCHEZARS_AXE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);

            scheduler.Schedule(20s, 30s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_AMPLIFY_DAMAGE, 1);
                context.Repeat();
            }).Schedule(20s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN);
                context.SetGroup(GROUP_SHADOW_WORD_PAIN);
                context.Repeat();
            });;
        }
    }

    void EnfeebleHealthEffect()
    {
        std::list<Unit*> targetList;
        SelectTargetList(targetList, 5, SelectTargetMethod::Random, 1, [&](Unit* u) { return u->IsAlive() && u->IsPlayer(); });

        if (targetList.empty())
            return;

        for (auto const& target : targetList)
        {
            if (target)
            {
                _enfeebleTargets[target->GetGUID()] = target->GetHealth();

                me->CastSpell(target, SPELL_ENFEEBLE, true);
                target->SetHealth(1);
            }
        }
    }

    void EnfeebleResetHealth()
    {
        for (auto& targets : _enfeebleTargets)
        {
            if (Unit* target = ObjectAccessor::GetUnit(*me, targets.first))
            {
                if (target->IsAlive())
                {
                    target->SetHealth(targets.second);
                }
            }
        }
    }

    private:
        uint32 _phase;
        std::map<ObjectGuid, uint32> _enfeebleTargets;
        std::vector<InfernalPoint*> positions;
};

struct npc_netherspite_infernal : public ScriptedAI
{
    npc_netherspite_infernal(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit* /*who*/) override { }
    void MoveInLineOfSight(Unit* /*who*/) override { }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

    void KilledUnit(Unit* who) override
    {
        if (me->ToTempSummon())
        {
            if (WorldObject* summoner = me->ToTempSummon()->GetSummoner())
            {
                if (Creature* creature = summoner->ToCreature())
                {
                    creature->AI()->KilledUnit(who);
                }
            }
        }
    }

    void SpellHit(Unit* /*who*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_INFERNAL_RELAY)
        {
            me->SetDisplayId(me->GetUInt32Value(UNIT_FIELD_NATIVEDISPLAYID));
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            _scheduler.Schedule(4s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_HELLFIRE);
            });
        }
    }

    void DamageTaken(Unit* /*done_by*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

    private:
        TaskScheduler _scheduler;
};

struct npc_malchezaar_axe : public ScriptedAI
{
    npc_malchezaar_axe(Creature* creature) : ScriptedAI(creature)
    {
        creature->SetCanDualWield(true);
    }

    void Initialize()
    {
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();
        _scheduler.Schedule(7500ms, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
            {
                if (me->GetVictim())
                {
                    DoModifyThreatByPercent(me->GetVictim(), -100);
                }

                me->AddThreat(target, 1000000.0f);
            }

            context.Repeat(7500ms, 20s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

    private:
        TaskScheduler _scheduler;
};

void AddSC_boss_malchezaar()
{
    RegisterKarazhanCreatureAI(boss_malchezaar);
    RegisterKarazhanCreatureAI(npc_malchezaar_axe);
    RegisterKarazhanCreatureAI(npc_netherspite_infernal);
}
