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
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"

enum Say
{
    SAY_TELEPORT = 0,
    SAY_AGGRO,
    SAY_KILL,
};

enum Spells
{
    SPELL_MARK_OF_FROST       = 23182,
    SPELL_MARK_OF_FROST_AURA  = 23184,
    SPELL_AURA_OF_FROST       = 23186,
    SPELL_MANA_STORM          = 21097,
    SPELL_CHILL               = 21098,
    SPELL_FROST_BREATH        = 21099,
    SPELL_REFLECT             = 22067,
    SPELL_CLEAVE              = 19983,
    SPELL_ARCANE_VACUUM       = 21147,
    SPELL_ARCANE_VACUUM_TP    = 21150
};

class boss_azuregos : public CreatureScript
{
public:

    boss_azuregos() : CreatureScript("boss_azuregos") { }

    struct boss_azuregosAI : public ScriptedAI
    {
        boss_azuregosAI(Creature* creature) : ScriptedAI(creature)
        {
            scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void Reset() override
        {
            scheduler.CancelAll();
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->RestoreFaction();
            me->GetMap()->DoForAllPlayers([&](Player* p)
                {
                    if (p->GetZoneId() == me->GetZoneId())
                    {
                        p->RemoveAurasDueToSpell(SPELL_CHILL);
                        p->RemoveAurasDueToSpell(SPELL_FROST_BREATH);
                    }
                });
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_KILL);
                victim->CastSpell(victim, SPELL_MARK_OF_FROST, true);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoCastSelf(SPELL_MARK_OF_FROST_AURA);
            Talk(SAY_AGGRO);

            scheduler
                .Schedule(7s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_CLEAVE);
                    context.Repeat(7s);
                })
                .Schedule(5s, 17s, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_MANA_STORM);
                    context.Repeat(7s, 13s);
                })
                .Schedule(10s, 30s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_CHILL);
                    context.Repeat(13s, 25s);
                })
                .Schedule(2s, 8s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_FROST_BREATH);
                    context.Repeat(10s, 15s);
                })
                .Schedule(30s, [this](TaskContext context)
                {
                    Talk(SAY_TELEPORT);
                    DoCastAOE(SPELL_ARCANE_VACUUM);
                    context.Repeat(30s);
                })
                .Schedule(15s, 30s, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_REFLECT);
                    context.Repeat(20s, 35s);
                });
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->RemoveAurasDueToSpell(SPELL_MARK_OF_FROST);
            me->GetMap()->DoForAllPlayers([&](Player* p)
                {
                    if (p->GetZoneId() == me->GetZoneId())
                    {

                        p->RemoveAurasDueToSpell(SPELL_MARK_OF_FROST);
                        p->RemoveAurasDueToSpell(SPELL_AURA_OF_FROST);
                        p->RemoveAurasDueToSpell(SPELL_CHILL);
                        p->RemoveAurasDueToSpell(SPELL_FROST_BREATH);
                    }
                });

            me->SetRespawnTime(urand(2 * DAY, 3 * DAY));
            me->SaveRespawnTime();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->SetFaction(FACTION_ENEMY);
        creature->AI()->AttackStart(player);
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_azuregosAI(creature);
    }
};

// Arcane Vacuum: 21147
class spell_arcane_vacuum : public SpellScript
{
    PrepareSpellScript(spell_arcane_vacuum);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ARCANE_VACUUM_TP });
    }

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        Unit* hitUnit = GetHitUnit();
        if (caster && hitUnit)
        {
            caster->GetThreatMgr().ModifyThreatByPercent(hitUnit, -100);
            caster->CastSpell(hitUnit, SPELL_ARCANE_VACUUM_TP, true);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_arcane_vacuum::HandleOnHit);
    }
};

// Mark of Frost - Triggered Spell
class spell_mark_of_frost_freeze : public SpellScript
{
    PrepareSpellScript(spell_mark_of_frost_freeze);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MARK_OF_FROST, SPELL_AURA_OF_FROST });
    }

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        Unit* hitUnit = GetHitUnit();
        if (caster && hitUnit && hitUnit->HasAura(SPELL_MARK_OF_FROST) && !hitUnit->HasAura(SPELL_AURA_OF_FROST))
        {
            hitUnit->CastSpell(hitUnit, SPELL_AURA_OF_FROST, true);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_mark_of_frost_freeze::HandleOnHit);
    }
};

void AddSC_boss_azuregos()
{
    new boss_azuregos();
    RegisterSpellScript(spell_arcane_vacuum);
    RegisterSpellScript(spell_mark_of_frost_freeze);
}

