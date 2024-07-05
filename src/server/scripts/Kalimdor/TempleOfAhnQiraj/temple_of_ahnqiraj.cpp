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

#include "temple_of_ahnqiraj.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "MapReference.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Spells
{
    // Anubisath Defender
    SPELL_SHADOW_FROST_REFLECT          = 19595,
    SPELL_FIRE_ARCANE_REFLECT           = 13022,
    SPELL_METEOR                        = 26558,
    SPELL_PLAGUE                        = 26556,
    SPELL_SHADOW_STORM                  = 26555,
    SPELL_THUNDERCLAP                   = 26554,
    SPELL_ENRAGE                        = 14204,
    SPELL_EXPLODE                       = 25698,
    SPELL_SUMMON_WARRIOR                = 17431,
    SPELL_SUMMON_SWARMGUARD             = 17430,
    SPELL_SUMMON_LARGE_OBSIDIAN_CHUNK   = 27630, // Server-side

    TALK_ENRAGE                         = 0,

    // Vekniss Stinger
    SPELL_VEKNISS_CATALYST              = 26078,
    SPELL_STINGER_CHARGE_NORMAL         = 26081,
    SPELL_STINGER_CHARGE_BUFFED         = 26082,

    // Obsidian Eradicator
    SPELL_SHOCK_BLAST                   = 26458,
    SPELL_DRAIN_MANA_ERADICATOR         = 25755,
    SPELL_DRAIN_MANA_VISUAL             = 26639,

    // Anubisath Warder
    SPELL_FEAR                          = 26070,
    SPELL_ENTAGLING_ROOTS               = 26071,
    SPELL_SILENCE                       = 26069,
    SPELL_DUST_CLOUD                    = 26072,
    SPELL_FIRE_NOVA                     = 26073,

    // Obsidian Nullifier
    SPELL_NULLIFY                       = 26552,
    SPELL_DRAIN_MANA_NULLIFIER          = 25671,
    SPELL_CLEAVE                        = 40504,

    // Qiraji Scorpion
    // Qiraji Scarab
    SPELL_PIERCE_ARMOR                  = 6016,
    SPELL_ACID_SPIT                     = 26050,

    NPC_QIRAJI_SCORPION                 = 15317
};

struct npc_anubisath_defender : public ScriptedAI
{
    npc_anubisath_defender(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        _enraged = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoCastSelf(urand(0, 1) ? SPELL_SHADOW_FROST_REFLECT : SPELL_FIRE_ARCANE_REFLECT, true);

        if (urand(0, 1))
        {
            scheduler.Schedule(6s, 10s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1))
                    DoCast(target, SPELL_METEOR, true);
                context.Repeat(6s, 10s);
            });
        }
        else
        {
            scheduler.Schedule(6s, 10s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1))
                    DoCast(target, SPELL_PLAGUE, true);
                context.Repeat(6s, 10s);
            });
        }

        if (urand(0, 1))
        {
            scheduler.Schedule(5s, 8s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_THUNDERCLAP, true);
                context.Repeat(5s, 8s);
            });
        }
        else
        {
            scheduler.Schedule(5s, 8s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SHADOW_STORM, true);
                context.Repeat(5s, 8s);
            });
        }

        if (urand(0, 1))
        {
            scheduler.Schedule(3s, 5s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_SUMMON_WARRIOR, true);
                context.Repeat(12s, 16s);
            });
        }
        else
        {
            scheduler.Schedule(3s, 5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SUMMON_SWARMGUARD, true);
                context.Repeat(12s, 16s);
            });
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SUMMON_LARGE_OBSIDIAN_CHUNK, true);
    }

    void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (!_enraged && me->HealthBelowPctDamaged(10, damage))
        {
            _enraged = true;
            damage = 0;

            if (urand(0, 1))
            {
                DoCastSelf(SPELL_ENRAGE, true);
                Talk(TALK_ENRAGE);
            }
            else
            {
                DoCastSelf(SPELL_EXPLODE, true);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    bool _enraged;
};

struct npc_vekniss_stinger : public ScriptedAI
{
    npc_vekniss_stinger(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* who) override
    {
        DoCast(who ,who->HasAura(SPELL_VEKNISS_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [&](Unit* u)
            {
                return u && !u->IsPet() && u->IsWithinDist2d(me, 20.f) && u->HasAura(SPELL_VEKNISS_CATALYST);
            });
            if (!target)
            {
                target = SelectTarget(SelectTargetMethod::Random, 0, [&](Unit* u)
                {
                    return u && !u->IsPet() && u->IsWithinDist2d(me, 20.f);
                });
            }

            if (target)
            {
                DoCast(target, target->HasAura(SPELL_VEKNISS_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);
            }

            context.Repeat(6s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }
};

struct npc_obsidian_eradicator : public ScriptedAI
{
    npc_obsidian_eradicator(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetPower(POWER_MANA, 0);
        _targetGUIDs.clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(3500ms, [this](TaskContext context)
        {
            if (_targetGUIDs.empty())
            {
                me->GetMap()->DoForAllPlayers([&](Player* player)
                {
                    if (player->IsAlive() && !player->IsGameMaster() && !player->IsSpectator() && player->GetPower(POWER_MANA) > 0)
                    {
                        _targetGUIDs.push_back(player->GetGUID());
                    }
                });

                Acore::Containers::RandomResize(_targetGUIDs, 10);
            }

            for (ObjectGuid guid : _targetGUIDs)
            {
                if (Unit* target = ObjectAccessor::GetUnit(*me, guid))
                {
                    DoCast(target, SPELL_DRAIN_MANA_ERADICATOR, true);
                }
            }

            if (me->GetPowerPct(POWER_MANA) >= 100.f)
            {
                DoCastAOE(SPELL_SHOCK_BLAST);
            }

            context.Repeat(3500ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    GuidList _targetGUIDs;
};

struct npc_anubisath_warder : public ScriptedAI
{
    npc_anubisath_warder(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (urand(0, 1))
        {
            scheduler.Schedule(5s, 5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_FEAR, true);
                context.Repeat(20s, 20s);
            });
        }
        else
        {
            scheduler.Schedule(5s, 5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_ENTAGLING_ROOTS, true);
                context.Repeat(20s, 20s);
            });
        }

        if (urand(0, 1))
        {
            scheduler.Schedule(4s, 4s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SILENCE, true);
                context.Repeat(15s, 15s);
            });
        }
        else
        {
            scheduler.Schedule(4s, 4s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_DUST_CLOUD, true);
                context.Repeat(15s, 15s);
            });
        }

        scheduler.Schedule(2s, 2s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_FIRE_NOVA, true);
            context.Repeat(8s, 15s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }
};

struct npc_obsidian_nullifier : public ScriptedAI
{
    npc_obsidian_nullifier(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetPower(POWER_MANA, 0);
        _targetGUIDs.clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(6s, [this](TaskContext context)
        {
            if (_targetGUIDs.empty())
            {
                me->GetMap()->DoForAllPlayers([&](Player* player)
                {
                    if (player->IsAlive() && !player->IsGameMaster() && !player->IsSpectator() && player->GetPower(POWER_MANA) > 0)
                    {
                        _targetGUIDs.push_back(player->GetGUID());
                    }
                });

                Acore::Containers::RandomResize(_targetGUIDs, 11);
            }

            for (ObjectGuid guid : _targetGUIDs)
            {
                if (Unit* target = ObjectAccessor::GetUnit(*me, guid))
                {
                    DoCast(target, SPELL_DRAIN_MANA_NULLIFIER, true);
                }
            }

            if (me->GetPowerPct(POWER_MANA) >= 100.f)
            {
                DoCastAOE(SPELL_NULLIFY);
            }

            context.Repeat(6s);
        })
        .Schedule(6000ms, 8400ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE, true);
            context.Repeat(6000ms, 8400ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    GuidList _targetGUIDs;
};

struct npc_ahnqiraji_critter : public ScriptedAI
{
    npc_ahnqiraji_critter(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        me->RestoreFaction();

        scheduler.CancelAll();

        // Don't attack nearby players randomly if they are the Twin's pet bugs.
        if (CreatureData const* crData = me->GetCreatureData())
        {
            ObjectGuid dbtableHighGuid = ObjectGuid::Create<HighGuid::Unit>(crData->id1, me->GetSpawnId());
            ObjectGuid targetGuid = sObjectMgr->GetLinkedRespawnGuid(dbtableHighGuid);

            if (targetGuid.GetEntry() == NPC_VEKLOR)
            {
                return;
            }
        }

        scheduler.Schedule(100ms, [this](TaskContext context)
        {
            if (Player* player = me->SelectNearestPlayer(10.f))
            {
                if (player->IsInCombat())
                {
                    AttackStart(player);
                }
            }

            context.Repeat(3500ms, 4000ms);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.CancelAll();

        if (me->GetEntry() == NPC_QIRAJI_SCORPION)
        {
            scheduler.Schedule(2s, 5s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_PIERCE_ARMOR, true);
                context.Repeat(5s, 9s);
            })
            .Schedule(5s, 9s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_ACID_SPIT, true);
                context.Repeat(6s, 12s);
            });
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (me->GetEntry() == NPC_QIRAJI_SCORPION)
        {
            me->DespawnOrUnsummon(5 * IN_MILLISECONDS);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
        {
            return;
        }

        DoMeleeAttackIfReady();
    }
};

enum NPCs
{
    NPC_VEKNISS_DRONE   = 15300
};

class spell_aggro_drones : public SpellScript
{
    PrepareSpellScript(spell_aggro_drones);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Creature* target = GetHitCreature())
            {
                if (target->GetEntry() == NPC_VEKNISS_DRONE)
                {
                    if (Unit* victim = caster->GetVictim())
                    {
                        target->AI()->AttackStart(victim);
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_aggro_drones::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_nullify : public AuraScript
{
    PrepareAuraScript(spell_nullify);

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->SetHealth(1);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_nullify::HandleApply, EFFECT_1, SPELL_AURA_SCHOOL_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 4052, At Battleguard Sartura
class at_battleguard_sartura : public AreaTriggerScript
{
public:
    at_battleguard_sartura() : AreaTriggerScript("at_battleguard_sartura") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* sartura = instance->GetCreature(DATA_SARTURA))
            {
                if (sartura->IsAlive())
                {
                    sartura->SetInCombatWith(player);
                }
            }
        }
        return true;
    }
};

void AddSC_temple_of_ahnqiraj()
{
    RegisterTempleOfAhnQirajCreatureAI(npc_anubisath_defender);
    RegisterTempleOfAhnQirajCreatureAI(npc_vekniss_stinger);
    RegisterTempleOfAhnQirajCreatureAI(npc_obsidian_eradicator);
    RegisterTempleOfAhnQirajCreatureAI(npc_anubisath_warder);
    RegisterTempleOfAhnQirajCreatureAI(npc_obsidian_nullifier);
    RegisterTempleOfAhnQirajCreatureAI(npc_ahnqiraji_critter);
    RegisterSpellScript(spell_aggro_drones);
    RegisterSpellScript(spell_nullify);
    new at_battleguard_sartura();
}

