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
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "vault_of_archavon.h"

enum Archavon
{
    SPELL_ROCK_SHARDS                   = 58678,
    SPELL_ROCK_SHARDS_LEFT_HAND_VISUAL  = 58689,
    SPELL_ROCK_SHARDS_RIGHT_HAND_VISUAL = 58692,
    SPELL_ROCK_SHARDS_DAMAGE_10         = 58695,
    SPELL_ROCK_SHARDS_DAMAGE_25         = 60883,
    SPELL_CRUSHING_LEAP_10              = 58960,
    SPELL_CRUSHING_LEAP_25              = 60894, // Instant (10-80yr range) -- Leaps at an enemy, inflicting 8000 Physical damage, knocking all nearby enemies away, and creating a cloud of choking debris.
    SPELL_STOMP_10                      = 58663,
    SPELL_STOMP_25                      = 60880,
    SPELL_IMPALE_10                     = 58666,
    SPELL_IMPALE_25                     = 60882, // Lifts an enemy off the ground with a spiked fist, inflicting 47125 to 52875 Physical damage and 9425 to 10575 additional damage each second for 8 sec.
    SPELL_BERSERK                       = 47008
};

enum
{
    EMOTE_BERSERK           = 0,
    EMOTE_LEAP              = 1 // Not in use
};

enum Events
{
    EVENT_ROCK_SHARDS       = 1,
    EVENT_CHOKING_CLOUD     = 2,
    EVENT_STOMP             = 3,
    EVENT_IMPALE            = 4,
    EVENT_BERSERK           = 5
};

// 31125 - Archavon the Stone Watcher
class boss_archavon : public CreatureScript
{
    public:
        boss_archavon() : CreatureScript("boss_archavon") { }

        struct boss_archavonAI : public ScriptedAI
        {
            boss_archavonAI(Creature* creature) : ScriptedAI(creature)
            {
                pInstance = me->GetInstanceScript();
            }

            InstanceScript* pInstance;
            EventMap events;

            void Reset() override
            {
                events.Reset();
                if (pInstance)
                {
                    if (pInstance->GetData(DATA_STONED))
                    {
                        if (Aura* aur = me->AddAura(SPELL_STONED_AURA, me))
                        {
                            aur->SetMaxDuration(60 * MINUTE* IN_MILLISECONDS);
                            aur->SetDuration(60 * MINUTE* IN_MILLISECONDS);
                        }
                    }

                    pInstance->SetData(EVENT_ARCHAVON, NOT_STARTED);
                }
            }

            void AttackStart(Unit* who) override
            {
                if (me->HasAura(SPELL_STONED_AURA))
                {
                    return;
                }

                ScriptedAI::AttackStart(who);
            }

            void JustEngagedWith(Unit* /*who*/) override
            {
                events.ScheduleEvent(EVENT_ROCK_SHARDS, 15s);
                events.ScheduleEvent(EVENT_CHOKING_CLOUD, 30s);
                events.ScheduleEvent(EVENT_STOMP, 45s);
                events.ScheduleEvent(EVENT_BERSERK, 5min);

                if (pInstance)
                {
                    pInstance->SetData(EVENT_ARCHAVON, IN_PROGRESS);
                }
            }

            void JustDied(Unit*) override
            {
                if (pInstance)
                {
                    pInstance->SetData(EVENT_ARCHAVON, DONE);
                }
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                {
                    return;
                }

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }

                switch (events.ExecuteEvent())
                {
                    case EVENT_ROCK_SHARDS:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            DoCast(target, SPELL_ROCK_SHARDS);
                        }

                        events.Repeat(15s);
                        break;
                    case EVENT_CHOKING_CLOUD:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                        {
                            DoCast(target, RAID_MODE(SPELL_CRUSHING_LEAP_10, SPELL_CRUSHING_LEAP_25), true); //10y ~ 80y, ignore range
                        }

                        events.Repeat(30s);
                        break;
                    case EVENT_STOMP:
                    {
                        char buffer[100];
                        snprintf(buffer, sizeof(buffer), "Archavon the Stone Watcher lunges for %s!", me->GetVictim()->GetName().c_str());
                        me->TextEmote(buffer);

                        DoCastVictim(RAID_MODE(SPELL_STOMP_10, SPELL_STOMP_25));

                        events.Repeat(45s);
                        events.ScheduleEvent(EVENT_IMPALE, 3s);
                        break;
                    }
                    case EVENT_IMPALE:
                        DoCastVictim(RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25));
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK, true);
                        Talk(EMOTE_BERSERK);
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetVaultOfArchavonAI<boss_archavonAI>(creature);
        }
};

// 58941 - Rock Shards
class spell_archavon_rock_shards : public SpellScriptLoader
{
    public:
        spell_archavon_rock_shards() : SpellScriptLoader("spell_archavon_rock_shards") { }

        class spell_archavon_rock_shards_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_archavon_rock_shards_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                Unit* caster = GetCaster();
                Unit* target = GetHitUnit();

                if (!caster || !target)
                {
                    return;
                }

                Map* map = caster->GetMap();
                if (!map)
                {
                    return;
                }

                caster->CastSpell(target, SPELL_ROCK_SHARDS_LEFT_HAND_VISUAL, true);
                caster->CastSpell(target, SPELL_ROCK_SHARDS_RIGHT_HAND_VISUAL, true);

                uint32 spellId = map->Is25ManRaid() ? SPELL_ROCK_SHARDS_DAMAGE_25 : SPELL_ROCK_SHARDS_DAMAGE_10;
                caster->CastSpell(target, spellId, true);
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_archavon_rock_shards_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_archavon_rock_shards_SpellScript();
        }
};

void AddSC_boss_archavon()
{
    new boss_archavon();
    new spell_archavon_rock_shards();
}
