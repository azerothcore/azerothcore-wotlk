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
#include "SpellScriptLoader.h"
#include "mechanar.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Says
{
    SAY_AGGRO                      = 0,
    SAY_SUMMON                     = 1,
    SAY_DRAGONS_BREATH             = 2,
    SAY_SLAY                       = 3,
    SAY_DEATH                      = 4
};

enum Spells
{
    SPELL_FROST_ATTACK             = 45196, // This is definitely spell added in TBC but did it replaced both 35264 and 39086 or only normal version?
    SPELL_SUMMON_RAGING_FLAMES     = 35275,
    SPELL_QUELL_RAGING_FLAMES      = 35277,
    SPELL_ARCANE_BLAST             = 35314,
    SPELL_DRAGONS_BREATH           = 35250,

    // Raging Flames
    SPELL_RAGING_FLAMES_DUMMY      = 35274, // NYI, no clue what it can do
    SPELL_RAGING_FLAMES_AREA_AURA  = 35281,
    SPELL_INVIS_STEALTH_DETECTION  = 18950,
    SPELL_INFERNO                  = 35268,
    SPELL_INFERNO_DAMAGE           = 35283
};

struct boss_nethermancer_sepethrea : public BossAI
{
    boss_nethermancer_sepethrea(Creature* creature) : BossAI(creature, DATA_NETHERMANCER_SEPRETHREA) { }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_FROST_ATTACK);
            context.Repeat(8s);
        }).Schedule(15s, 25s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ARCANE_BLAST);
            if (me->GetVictim())
            {
                DoModifyThreatByPercent(me->GetVictim(), -50);
            }
            context.Repeat();
        }).Schedule(20s, 30s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_DRAGONS_BREATH);
            context.Repeat(25s, 35s);
            if (roll_chance_i(50))
            {
                Talk(SAY_DRAGONS_BREATH);
            }
        });

        Talk(SAY_AGGRO);
        DoCastSelf(SPELL_SUMMON_RAGING_FLAMES, true);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        // Fails probably because target is in evade mode (yes, she kills them on evade too). We'll kill them directly in their script for now
        DoCastSelf(SPELL_QUELL_RAGING_FLAMES, true);
        ScriptedAI::EnterEvadeMode(why);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (Unit* victim = me->GetVictim())
        {
            summon->AI()->AttackStart(victim);
            summon->AddThreat(victim, 1000.0f);
            summon->SetInCombatWithZone();
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
        DoCastSelf(SPELL_QUELL_RAGING_FLAMES, true);
    }
};

struct npc_raging_flames : public ScriptedAI
{
    npc_raging_flames(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        me->SetCorpseDelay(20);
    }

    // It's more tricky actually
    void FixateRandomTarget()
    {
        me->GetThreatMgr().ClearAllThreat();

        if (TempSummon* summon = me->ToTempSummon())
            if (Creature* summoner = summon->GetSummonerCreatureBase())
                if (summoner->IsAIEnabled)
                {
                    if (Unit* target = summoner->AI()->SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false))
                        me->AddThreat(target, 1000000.0f);
                    else
                        me->KillSelf();
                }
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        DoZoneInCombat();
        DoCastSelf(SPELL_RAGING_FLAMES_AREA_AURA);
        DoCastSelf(SPELL_INVIS_STEALTH_DETECTION);

        FixateRandomTarget();

        scheduler.Schedule(15s, 25s, [this](TaskContext task)
        {
            DoCastSelf(SPELL_INFERNO);
            FixateRandomTarget();

            task.Repeat(20s, 30s);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        FixateRandomTarget();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
};

class spell_ragin_flames_inferno : public AuraScript
{
    PrepareAuraScript(spell_ragin_flames_inferno);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        GetUnitOwner()->CastCustomSpell(SPELL_INFERNO_DAMAGE, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetUnitOwner(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ragin_flames_inferno::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_nethermancer_sepethrea()
{
    RegisterMechanarCreatureAI(boss_nethermancer_sepethrea);
    RegisterMechanarCreatureAI(npc_raging_flames);
    RegisterSpellScript(spell_ragin_flames_inferno);
}
