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
    SPELL_ENFEEBLE        = 30843,
    SPELL_ENFEEBLE_EFFECT = 41624,
    SPELL_SHADOW_NOVA     = 30852,
    SPELL_SW_PAIN         = 30854,
    SPELL_THRASH_PASSIVE  = 12787,
    SPELL_SUNDER_ARMOR    = 30901,
    SPELL_THRASH_AURA     = 12787,
    SPELL_EQUIP_AXES      = 30857,
    SPELL_AMPLIFY_DAMAGE  = 39095,
    SPELL_CLEAVE          = 30131,
    SPELL_HELLFIRE        = 30859,
};

enum creatures
{
    NETHERSPITE_INFERNAL     = 17646,
    MALCHEZARS_AXE           = 17650,
    INFERNAL_MODEL_INVISIBLE = 11686,
    SPELL_INFERNAL_RELAY     = 33814,   // 30835,
    EQUIP_ID_AXE             = 33542
};

enum EventGroups
{
    GROUP_ENFEEBLE,
    GROUP_SHADOW_NOVA,
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
        EnfeebleTimer = 30000;
        EnfeebleResetTimer = 38000;
        SWPainTimer = 20000;
        InfernalCleanupTimer = 47000;
        AmplifyDamageTimer = 5000;
        SunderArmorTimer = urand(5000, 10000);
        InfernalTimer = 40000;
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
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        instance->HandleGameObject(instance->GetGuidData(DATA_GO_NETHER_DOOR), true);
        if (Creature* Axe = me->FindNearestCreature(MALCHEZARS_AXE, 100.0f))
        {
            Axe->DespawnOrUnsummon();
        }
    }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        DoZoneInCombat();
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
        });
    }

    void DamageTaken(Unit* /*done_by*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(60, damage) && _phase == PHASE_ONE)
        {
            Phase2();
        }
    }

    void SummonAxes()
    {
        me->SummonCreature(MALCHEZARS_AXE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
    }

    void EnfeebleHealthEffect()
    {
        SpellInfo const* info = sSpellMgr->GetSpellInfo(SPELL_ENFEEBLE_EFFECT);
        if (!info)
            return;

        ThreatContainer::StorageType const& t_list = me->GetThreatMgr().GetThreatList();
        std::vector<Unit*> targets;

        if (t_list.empty())
            return;

        //begin + 1, so we don't target the one with the highest threat
        ThreatContainer::StorageType::const_iterator itr = t_list.begin();
        std::advance(itr, 1);
        for (; itr != t_list.end(); ++itr) //store the threat list in a different container
            if (Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                if (target->IsAlive() && target->GetTypeId() == TYPEID_PLAYER)
                    targets.push_back(target);

        //cut down to size if we have more than 5 targets
        while (targets.size() > 5)
            targets.erase(targets.begin() + rand() % targets.size());

        uint32 i = 0;
        for (std::vector<Unit*>::const_iterator iter = targets.begin(); iter != targets.end(); ++iter, ++i)
            if (Unit* target = *iter)
            {
                enfeeble_targets[i] = target->GetGUID();
                enfeeble_health[i] = target->GetHealth();

                me->CastSpell(target, SPELL_ENFEEBLE, true, 0, 0, me->GetGUID());
                target->SetHealth(1);
            }
    }

    void EnfeebleResetHealth()
    {
        for (uint8 i = 0; i < 5; ++i)
        {
            Unit* target = ObjectAccessor::GetUnit(*me, enfeeble_targets[i]);
            if (target && target->IsAlive())
                target->SetHealth(enfeeble_health[i]);
            enfeeble_targets[i].Clear();
            enfeeble_health[i] = 0;
        }
    }

    void SummonInfernal()
    {
        Position pos;

        if ((me->GetMapId() == 532))
        {
            pos = me->GetRandomNearPosition(40.0);
        }
        else
        {
            InfernalPoint* point = Acore::Containers::SelectRandomContainerElement(positions);
            pos.Relocate(point->x, point->y, INFERNAL_Z, frand(0.0f, float(M_PI * 2)));
        }

        if (Creature* RELAY = me->FindNearestCreature(NPC_RELAY, 100.0f))
        {
            Creature* infernal = RELAY->SummonCreature(NETHERSPITE_INFERNAL, pos, TEMPSUMMON_TIMED_DESPAWN, 180000);

            if (infernal)
            {
                infernal->SetDisplayId(INFERNAL_MODEL_INVISIBLE);
                infernal->SetFaction(me->GetFaction());
                infernals.push_back(infernal->GetGUID());
                infernal->SetControlled(true, UNIT_STATE_ROOT);
                RELAY->AI()->DoCast(infernal, SPELL_INFERNAL_RELAY);
            }
        }
        Talk(SAY_SUMMON);
    }

    void Phase2()
    {
        me->InterruptNonMeleeSpells(false);
        _phase = 2;
        DoCast(me, SPELL_EQUIP_AXES);
        Talk(SAY_AXE_TOSS1);
        DoCast(me, SPELL_THRASH_AURA, true);
        SetEquipmentSlots(false, EQUIP_ID_AXE, EQUIP_ID_AXE, EQUIP_NO_CHANGE);
        me->SetCanDualWield(true);
        me->SetAttackTime(OFF_ATTACK, (me->GetAttackTime(BASE_ATTACK) * 150) / 100);
        SunderArmorTimer = urand(5000, 10000);
    }

    void Phase3()
    {
        me->RemoveAurasDueToSpell(SPELL_THRASH_AURA);
        Talk(SAY_AXE_TOSS2);
        _phase = 3;
        clearweapons();
        SummonAxes();
        AmplifyDamageTimer = urand(20000, 30000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (InfernalTimer <= diff)
        {
            SummonInfernal();
            InfernalTimer = _phase == 3 ? 14500 : 44500;    // 15 secs in phase 3, 45 otherwise
        }
        else InfernalTimer -= diff;

        if (_phase != 2)
        {
            if (SWPainTimer <= diff)
            {

                // if phase == 1 target the tank, otherwise anyone but the tank
                Unit* target = _phase == 1
                    ? me->GetVictim()
                    : SelectTarget(SelectTargetMethod::Random, 1, 100, true);

                if (target)
                {
                    DoCast(target, SPELL_SW_PAIN);
                }

                SWPainTimer = 20000;
            }
            else
                SWPainTimer -= diff;
        }

        if (_phase == 1)
        {
            if (HealthBelowPct(60))
            {
                Phase2();
            }
        }

        if (_phase == 2)
        {
            if (SunderArmorTimer <= diff)
            {
                DoCast(SPELL_SUNDER_ARMOR);
                SunderArmorTimer = urand(5000, 10000);
            }
            else
                SunderArmorTimer -= diff;

            if (HealthBelowPct(30))
            {
                Phase3();
            }
        }

        if (_phase == 3)
        {
            if (AmplifyDamageTimer <= diff)
            {
                Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100, true);

                if (target)
                {
                    DoCast(target, SPELL_AMPLIFY_DAMAGE);
                    AmplifyDamageTimer = urand(20000, 30000);
                }
            }
            else
            {
                AmplifyDamageTimer -= diff;
            }
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

    private:
        uint32 EnfeebleTimer;
        uint32 EnfeebleResetTimer;
        uint32 SWPainTimer;
        uint32 SunderArmorTimer;
        uint32 AmplifyDamageTimer;
        uint32 InfernalTimer;
        uint32 InfernalCleanupTimer;
        uint32 _phase;
        uint32 enfeeble_health[5];
        ObjectGuid enfeeble_targets[5];

        GuidVector infernals;
        std::vector<InfernalPoint*> positions;
};

struct npc_netherspite_infernal : public ScriptedAI
{
    npc_netherspite_infernal(Creature* creature) : ScriptedAI(creature), point(nullptr) { }

    void EnterCombat(Unit* /*who*/) override { }
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
        InfernalPoint* point;
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

    void EnterCombat(Unit* /*who*/) override
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
