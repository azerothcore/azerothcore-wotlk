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
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
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
    NPC_NETHERSPITE_INFERNAL    = 17646,
    NPC_MALCHEZAARS_AXE         = 17650,
    INFERNAL_MODEL_INVISIBLE    = 11686,
    SPELL_INFERNAL_RELAY        = 33814,   // 30835,
    SPELL_INFERNAL_RELAY_ONE    = 30834,
    SPELL_INFERNAL_RELAY_TWO    = 30835,
    EQUIP_ID_AXE                = 33542
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

struct boss_malchezaar : public BossAI
{
    boss_malchezaar(Creature* creature) : BossAI(creature, DATA_MALCHEZAAR) { }

    std::list<Creature*> relays;
    std::list<Creature*> infernalTargets;

    void Initialize()
    {
        _phase = 1;
        clearweapons();
        relays.clear();
        infernalTargets.clear();
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

        ScheduleHealthCheckEvent(60, [&] {
            me->InterruptNonMeleeSpells(false);
            _phase = 2;
            DoCastSelf(SPELL_EQUIP_AXES);
            Talk(SAY_AXE_TOSS1);
            DoCastSelf(SPELL_THRASH_AURA, true);
            SetEquipmentSlots(false, EQUIP_ID_AXE, EQUIP_ID_AXE, EQUIP_NO_CHANGE);
            me->SetCanDualWield(true);
            me->SetAttackTime(OFF_ATTACK, (me->GetAttackTime(BASE_ATTACK) * 150) / 100);

            scheduler.Schedule(5s, 10s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SUNDER_ARMOR);
                context.Repeat();
            });

            scheduler.CancelGroup(GROUP_SHADOW_WORD_PAIN);
        });

        ScheduleHealthCheckEvent(30, [&] {
            me->RemoveAurasDueToSpell(SPELL_THRASH_AURA);
            Talk(SAY_AXE_TOSS2);
            _phase = PHASE_THREE;
            clearweapons();

            me->SummonCreature(NPC_MALCHEZAARS_AXE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);

            scheduler.Schedule(20s, 30s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_AMPLIFY_DAMAGE, 1);
                context.Repeat();
            }).Schedule(20s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN);
                context.SetGroup(GROUP_SHADOW_WORD_PAIN);
                context.Repeat();
            });

            scheduler.CancelGroup(GROUP_ENFEEBLE);
        });
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void SpawnInfernal(Creature* relay, Creature* target)
    {
        if (Creature* infernal = relay->SummonCreature(NPC_NETHERSPITE_INFERNAL, target->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 180000))
        {
            infernal->SetDisplayId(INFERNAL_MODEL_INVISIBLE);
            relay->CastSpell(infernal, SPELL_INFERNAL_RELAY);
            infernal->SetFaction(me->GetFaction());
            infernal->SetControlled(true, UNIT_STATE_ROOT);
            relay->CastSpell(infernal, SPELL_INFERNAL_RELAY);
            summons.Summon(infernal);
        }
    }

    bool MaxSpawns(std::list<Creature*> spawns)
    {
        return spawns.size() == 0;
    }

    Creature* PickTarget(std::list<Creature*> pickList)
    {
        uint8 index = urand(0, pickList.size()-1);
        uint8 counter = 0;
        for (Creature* creature : pickList)
        {
            if (counter == index)
            {
                return creature;
            }
            counter++;
        }
        return nullptr;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();

        me->GetCreaturesWithEntryInRange(relays, 250.0f, NPC_INFERNAL_RELAY);
        me->GetCreaturesWithEntryInRange(infernalTargets, 100.0f, NPC_INFERNAL_TARGET);

        scheduler.Schedule(30s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ENFEEBLE);

            scheduler.Schedule(9s, [this](TaskContext)
            {
                EnfeebleResetHealth();
            });

            context.SetGroup(GROUP_ENFEEBLE);
            context.Repeat();
        }).Schedule(35500ms, [this](TaskContext context)
        {
            DoCastAOE(SPELL_SHADOW_NOVA);
            context.SetGroup(GROUP_SHADOW_NOVA);
            context.Repeat(30s);
        }).Schedule(40s, [this](TaskContext context)
        {
            if (!MaxSpawns(infernalTargets)) // only spawn infernal when the area is not full
            {
                Talk(SAY_SUMMON);
                if (Creature* infernalRelayOne = relays.back())
                {
                    if (Creature* infernalRelayTwo = relays.front())
                    {
                        infernalRelayOne->CastSpell(infernalRelayTwo, SPELL_INFERNAL_RELAY_ONE, true);

                        if (Creature* infernalTarget = PickTarget(infernalTargets))
                        {
                            infernalTargets.remove(infernalTarget);
                            SpawnInfernal(infernalRelayTwo, infernalTarget);

                            scheduler.Schedule(3min, [this, infernalTarget](TaskContext)
                            {
                                infernalTargets.push_back(infernalTarget); //adds to list again
                            });

                        }
                    }
                }
            }
            context.Repeat(_phase == PHASE_THREE ? 15s : 45s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOW_WORD_PAIN);
            context.SetGroup(GROUP_SHADOW_WORD_PAIN);
            context.Repeat();
        });
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_ENFEEBLE)
        {
            _enfeebleTargets[target->GetGUID()] = target->GetHealth();
            target->SetHealth(1);
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
};

struct npc_netherspite_infernal : public ScriptedAI
{
    npc_netherspite_infernal(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit* /*who*/) override { }
    void MoveInLineOfSight(Unit* /*who*/) override { }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
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

            scheduler.Schedule(4s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_HELLFIRE);
            });
        }
    }

    void DamageTaken(Unit* /*done_by*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }
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
        scheduler.Schedule(7500ms, [this](TaskContext context)
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

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }
};

// 30843 - Enfeeble
class spell_malchezaar_enfeeble : public SpellScript
{
    PrepareSpellScript(spell_malchezaar_enfeeble);

    bool Load() override
    {
        return GetCaster()->ToCreature();
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        uint8 maxSize = 5;
        Unit* caster = GetCaster();

        targets.remove_if([caster](WorldObject const* target) -> bool
        {
            // Should not target current victim.
            return caster->GetVictim() == target;
        });

        if (targets.size() > maxSize)
        {
            Acore::Containers::RandomResize(targets, maxSize);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_malchezaar_enfeeble::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_malchezaar()
{
    RegisterKarazhanCreatureAI(boss_malchezaar);
    RegisterKarazhanCreatureAI(npc_malchezaar_axe);
    RegisterKarazhanCreatureAI(npc_netherspite_infernal);
    RegisterSpellScript(spell_malchezaar_enfeeble);
}
