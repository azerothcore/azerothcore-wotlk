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

#include "MapReference.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "temple_of_ahnqiraj.h"
#include "TaskScheduler.h"

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
    SPELL_EXPLODE                       = 25699,
    SPELL_SUMMON_WARRIOR                = 17431,
    SPELL_SUMMON_SWARMGUARD             = 17430,

    SPELL_FEAR                          = 26070,
    SPELL_ENTAGLING_ROOTS               = 26071,
    SPELL_SILENCE                       = 26069,
    SPELL_DUST_CLOUD                    = 26072,
    SPELL_FIRE_NOVA                     = 26073,

    SPELL_SUMMON_LARGE_OBSIDIAN_CHUNK   = 27630, // Server-side

    SPELL_SHOCK_BLAST                   = 26458,
    SPELL_DRAIN_MANA                    = 25671,
    SPELL_DRAIN_MANA_VISUAL             = 26639,

    TALK_ENRAGE                         = 0,

    // Vekniss Stinger
    SPELL_VEKNISS_CATALYST              = 26078,
    SPELL_STINGER_CHARGE_NORMAL         = 26081,
    SPELL_STINGER_CHARGE_BUFFED         = 26082,
};

struct npc_anubisath_defender : public ScriptedAI
{
    npc_anubisath_defender(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        _enraged = false;
    }

    void EnterCombat(Unit* /*who*/) override
    {
        DoCastSelf(urand(0, 1) ? SPELL_SHADOW_FROST_REFLECT : SPELL_FIRE_ARCANE_REFLECT, true);

        if (urand(0, 1))
        {
            _scheduler.Schedule(6s, 10s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1))
                    DoCast(target, SPELL_METEOR, true);
                context.Repeat(6s, 10s);
            });
        }
        else
        {
            _scheduler.Schedule(6s, 10s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1))
                    DoCast(target, SPELL_PLAGUE, true);
                context.Repeat(6s, 10s);
            });
        }

        if (urand(0, 1))
        {
            _scheduler.Schedule(5s, 8s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_THUNDERCLAP, true);
                context.Repeat(5s, 8s);
            });
        }
        else
        {
            _scheduler.Schedule(5s, 8s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SHADOW_STORM, true);
                context.Repeat(5s, 8s);
            });
        }

        if (urand(0, 1))
        {
            _scheduler.Schedule(3s, 5s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_SUMMON_WARRIOR, true);
                context.Repeat(12s, 16s);
            });
        }
        else
        {
            _scheduler.Schedule(3s, 5s, [this](TaskContext context)
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

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    TaskScheduler _scheduler;
    bool _enraged;
};

struct npc_vekniss_stinger : public ScriptedAI
{
    npc_vekniss_stinger(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* who) override
    {
        DoCast(who ,who->HasAura(SPELL_VEKNISS_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);

        _scheduler.Schedule(6s, [this](TaskContext context)
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

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    TaskScheduler _scheduler;
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

struct npc_obsidian_eradicator : public ScriptedAI
{
    npc_obsidian_eradicator(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        me->SetPower(POWER_MANA, 0);
        _targets.clear();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _scheduler.Schedule(3500ms, [this](TaskContext context)
        {
            if (_targets.empty())
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    if (Player* player = itr->GetSource())
                    {
                        if (player->IsAlive() && !player->IsGameMaster() && !player->IsSpectator() && player->GetPower(POWER_MANA) > 0)
                        {
                            _targets.push_back(player);
                        }
                    }
                }

                Acore::Containers::RandomResize(_targets, 10);
            }

            for (Unit* target : _targets)
            {
                DoCast(target, SPELL_DRAIN_MANA, true);
            }

            if (me->GetPowerPct(POWER_MANA) >= 100.f)
            {
                DoCastAOE(SPELL_SHOCK_BLAST, true);
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

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    TaskScheduler _scheduler;
    std::list<Player*> _targets;
};

class spell_drain_mana : public SpellScript
{
    PrepareSpellScript(spell_drain_mana);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetHitUnit())
            {
                target->CastSpell(caster, SPELL_DRAIN_MANA_VISUAL, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_drain_mana::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

struct npc_anubisath_warder : public ScriptedAI
{
    npc_anubisath_warder(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        if (urand(0, 1))
        {
            _scheduler.Schedule(5s, 5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_FEAR, true);
                context.Repeat(20s, 20s);
            });
        }
        else
        {
            _scheduler.Schedule(5s, 5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_ENTAGLING_ROOTS, true);
                context.Repeat(20s, 20s);
            });
        }

        if (urand(0, 1))
        {
            _scheduler.Schedule(4s, 4s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SILENCE, true);
                context.Repeat(15s, 15s);
            });
        }
        else
        {
            _scheduler.Schedule(4s, 4s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_DUST_CLOUD, true);
                context.Repeat(15s, 15s);
            });
        }

        _scheduler.Schedule(2s, 2s, [this](TaskContext context)
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

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_temple_of_ahnqiraj()
{
    RegisterTempleOfAhnQirajCreatureAI(npc_anubisath_defender);
    RegisterTempleOfAhnQirajCreatureAI(npc_vekniss_stinger);
    RegisterSpellScript(spell_aggro_drones);
    RegisterTempleOfAhnQirajCreatureAI(npc_obsidian_eradicator);
    RegisterSpellScript(spell_drain_mana);
    RegisterTempleOfAhnQirajCreatureAI(npc_anubisath_warder);
}
