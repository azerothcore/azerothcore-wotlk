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
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "vault_of_archavon.h"

enum Archavon
{
    SPELL_ROCK_SHARDS                   = 58678,
    SPELL_ROCK_SHARDS_LEFT_HAND_VISUAL  = 58689,
    SPELL_ROCK_SHARDS_RIGHT_HAND_VISUAL = 58692,
    SPELL_ROCK_SHARDS_DAMAGE            = 58695,
    SPELL_CRUSHING_LEAP                 = 58960,
    SPELL_STOMP                         = 58663,
    SPELL_IMPALE                        = 58666,
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
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, false, false))
                        {
                            DoCast(target, SPELL_CRUSHING_LEAP, true); //10y ~ 80y, ignore range
                        }

                        events.Repeat(30s);
                        break;
                    case EVENT_STOMP:
                    {
                        char buffer[100];
                        snprintf(buffer, sizeof(buffer), "Archavon the Stone Watcher lunges for %s!", me->GetVictim()->GetName().c_str());
                        me->TextEmote(buffer);

                        DoCastVictim(SPELL_STOMP);

                        events.Repeat(45s);
                        events.ScheduleEvent(EVENT_IMPALE, 3s);
                        break;
                    }
                    case EVENT_IMPALE:
                        DoCastVictim(SPELL_IMPALE);
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
class spell_archavon_rock_shards : public SpellScript
{
    PrepareSpellScript(spell_archavon_rock_shards);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROCK_SHARDS_LEFT_HAND_VISUAL, SPELL_ROCK_SHARDS_RIGHT_HAND_VISUAL });
    }

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            Unit* caster = GetCaster();
            Unit* target = GetHitUnit();

            if (!caster || !target)
            {
                return;
            }

            caster->CastSpell(target, SPELL_ROCK_SHARDS_LEFT_HAND_VISUAL, true);
            caster->CastSpell(target, SPELL_ROCK_SHARDS_RIGHT_HAND_VISUAL, true);

            caster->CastSpell(target, SPELL_ROCK_SHARDS_DAMAGE, true);
        }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_archavon_rock_shards::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_archavon()
{
    new boss_archavon();
    RegisterSpellScript(spell_archavon_rock_shards);
}
