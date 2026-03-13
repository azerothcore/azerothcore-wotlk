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
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "shattered_halls.h"

enum Spells
{
    SPELL_CLEAR_ALL          = 28471,
    SPELL_SUMMON_ZEALOTS     = 30976,
    SPELL_SHOOT_FLAME_ARROW  = 30952,
    SPELL_CLEAVE             = 15496
};

enum Says
{
    SAY_INVADERS_BREACHED    = 0,

    SAY_PORUNG_ARCHERS       = 0,
    SAY_PORUNG_READY         = 1,
    SAY_PORUNG_AIM           = 2,
    SAY_PORUNG_FIRE          = 3,
    SAY_PORUNG_AGGRO         = 4
};

enum Misc
{
    POINT_SCOUT_WP_END       = 4,

    SET_DATA_ARBITRARY_VALUE = 1,
    SET_DATA_ENCOUNTER_DONE  = 2
};

struct boss_porung : public BossAI
{
    boss_porung(Creature* creature) : BossAI(creature, DATA_PORUNG) { }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        Talk(SAY_PORUNG_AGGRO);
        scheduler.Schedule(2s, 4s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_CLEAVE);
                context.Repeat(8s, 10s);
            });
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);

        if (Creature* scout = me->FindNearestCreature(NPC_SH_SCOUT, 250.f))
            scout->AI()->SetData(SET_DATA_ENCOUNTER_DONE, 0);
    }
};

struct npc_shattered_hand_scout : public ScriptedAI
{
    npc_shattered_hand_scout(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
    }

    void SetData(uint32 type, uint32 /*data*/) override
    {
        if (type != SET_DATA_ENCOUNTER_DONE)
            return;

        _scheduler.CancelAll();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) && me->IsWithinDist2d(who, 50.0f) && who->GetPositionZ() > -3.0f
            && who->IsPlayer())
        {
            me->SetReactState(REACT_PASSIVE);
            DoCastSelf(SPELL_CLEAR_ALL);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            Talk(SAY_INVADERS_BREACHED);
            me->GetMotionMaster()->MoveWaypoint(me->GetEntry() * 10, false);

            _firstZealots.clear();
            std::list<Creature*> creatureList;
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SH_ZEALOT, 15.0f);
            for (Creature* creature : creatureList)
            {
                if (creature)
                {
                    _firstZealots.insert(creature->GetGUID());
                }
            }
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
    {
        if (damage >= me->GetHealth())
        {
            // Let creature fall to 1 HP but prevent it from dying.
            damage = me->GetHealth() - 1;
        }
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == WAYPOINT_MOTION_TYPE && point == POINT_SCOUT_WP_END)
        {
            me->SetVisible(false);

            if (Creature* porung = GetPorung())
            {
                porung->setActive(true);
                porung->AI()->DoCastAOE(SPELL_SUMMON_ZEALOTS);
                porung->AI()->Talk(SAY_PORUNG_ARCHERS);

                _scheduler.Schedule(45s, [this](TaskContext context)
                {
                    if (Creature* porung = GetPorung())
                    {
                        porung->AI()->DoCastAOE(SPELL_SUMMON_ZEALOTS);
                    }

                    context.Repeat();
                });
            }

            _scheduler.Schedule(1s, [this](TaskContext /*context*/)
            {
                _zealotGUIDs.clear();
                std::list<Creature*> creatureList;
                GetCreatureListWithEntryInGrid(creatureList, me, NPC_SH_ZEALOT, 100.0f);
                for (Creature* creature : creatureList)
                {
                    if (creature)
                    {
                        creature->AI()->SetData(SET_DATA_ARBITRARY_VALUE, SET_DATA_ARBITRARY_VALUE);
                        _zealotGUIDs.insert(creature->GetGUID());
                    }
                }

                for (auto const& guid : _firstZealots)
                {
                    if (Creature* zealot = ObjectAccessor::GetCreature(*me, guid))
                    {
                        zealot->SetInCombatWithZone();
                    }
                }

                if (Creature* porung = GetPorung())
                {
                    porung->AI()->Talk(SAY_PORUNG_READY, 3600ms);
                    porung->AI()->Talk(SAY_PORUNG_AIM, 4800ms);
                }

                _scheduler.Schedule(5800ms, [this](TaskContext /*context*/)
                {
                    std::list<Creature*> creatureList;
                    GetCreatureListWithEntryInGrid(creatureList, me, NPC_SH_ARCHER, 100.0f);
                    for (Creature* creature : creatureList)
                    {
                        if (creature)
                        {
                            creature->AI()->DoCastAOE(SPELL_SHOOT_FLAME_ARROW);
                        }
                    }

                    if (Creature* porung = GetPorung())
                    {
                        porung->AI()->Talk(SAY_PORUNG_FIRE, 200ms);
                    }

                    _scheduler.Schedule(2s, 9750ms, [this](TaskContext context)
                    {
                        if (FireArrows())
                        {
                            context.Repeat();
                        }

                        if (!me->SelectNearestPlayer(250.0f))
                        {
                            me->SetVisible(true);
                            me->DespawnOrUnsummon(5s, 5s);

                            for (auto const& guid : _zealotGUIDs)
                            {
                                if (Creature* zealot = ObjectAccessor::GetCreature(*me, guid))
                                {
                                    if (zealot->IsAlive())
                                    {
                                        zealot->DespawnOrUnsummon(5s, 5s);
                                    }
                                    else
                                    {
                                        zealot->Respawn(true);
                                    }
                                }
                            }

                            for (auto const& guid : _firstZealots)
                            {
                                if (Creature* zealot = ObjectAccessor::GetCreature(*me, guid))
                                {
                                    if (zealot->IsAlive())
                                    {
                                        zealot->DespawnOrUnsummon(5s, 5s);
                                    }
                                    else
                                    {
                                        zealot->Respawn(true);
                                    }
                                }
                            }

                            _scheduler.CancelAll();
                        }
                    });
                });
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

    bool FireArrows()
    {
        std::list<Creature*> creatureList;
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_SH_ARCHER, 100.0f);

        if (creatureList.empty())
        {
            return false;
        }

        for (Creature* creature : creatureList)
        {
            if (creature)
            {
                creature->AI()->DoCastAOE(SPELL_SHOOT_FLAME_ARROW);
            }
        }

        return true;
    }

    Creature* GetPorung()
    {
        return me->FindNearestCreature(IsHeroic() ? NPC_PORUNG : NPC_BLOOD_GUARD, 100.0f);
    }

private:
    TaskScheduler _scheduler;
    GuidSet _zealotGUIDs;
    GuidSet _firstZealots;
};

class spell_tsh_shoot_flame_arrow : public SpellScript
{
    PrepareSpellScript(spell_tsh_shoot_flame_arrow);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        unitList.remove_if([&](WorldObject* target) -> bool
            {
                if (!target)
                    return true;

                if (!target->SelectNearestPlayer(15.0f))
                    return true;

                if (target->FindNearestGameObject(GO_BLAZE, 6.0f))
                    return true;

                // Don't stack arrows on the same target
                if (InstanceScript* instance = caster->GetInstanceScript())
                    if (target->GetGUID() == instance->GetGuidData(DATA_LAST_FLAME_ARROW))
                        return true;

                return false;
            });

        Acore::Containers::RandomResize(unitList, 1);

        // Replace last arrow GUID
        if (!unitList.empty())
            if (InstanceScript* instance = caster->GetInstanceScript())
                instance->SetGuidData(DATA_LAST_FLAME_ARROW, unitList.front()->GetGUID());
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, 30953, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_tsh_shoot_flame_arrow::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_tsh_shoot_flame_arrow::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_porung()
{
    RegisterShatteredHallsCreatureAI(boss_porung);
    RegisterShatteredHallsCreatureAI(npc_shattered_hand_scout);
    RegisterSpellScript(spell_tsh_shoot_flame_arrow);
}
