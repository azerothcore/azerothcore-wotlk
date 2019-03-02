/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "vault_of_archavon.h"
#include "SpellAuras.h"
#include "SpellScript.h"

enum Archavon
{
    SPELL_ROCK_SHARDS                   = 58678,
    SPELL_CRUSHING_LEAP_10              = 58960,
    SPELL_CRUSHING_LEAP_25              = 60894, //Instant (10-80yr range) -- Leaps at an enemy, inflicting 8000 Physical damage, knocking all nearby enemies away, and creating a cloud of choking debris.
    SPELL_STOMP_10                      = 58663,
    SPELL_STOMP_25                      = 60880,
    SPELL_IMPALE_10                     = 58666,
    SPELL_IMPALE_25                     = 60882, //Lifts an enemy off the ground with a spiked fist, inflicting 47125 to 52875 Physical damage and 9425 to 10575 additional damage each second for 8 sec.
    SPELL_BERSERK                       = 47008,
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
    EVENT_BERSERK           = 5,
};

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

            void Reset()
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

            void AttackStart(Unit* who)
            {
                if (me->HasAura(SPELL_STONED_AURA))
                    return;

                ScriptedAI::AttackStart(who);
            }

            void EnterCombat(Unit* /*who*/)
            {
                events.ScheduleEvent(EVENT_ROCK_SHARDS, 15000);
                events.ScheduleEvent(EVENT_CHOKING_CLOUD, 30000);
                events.ScheduleEvent(EVENT_STOMP, 45000);
                events.ScheduleEvent(EVENT_BERSERK, 300000);
                if (pInstance)
                    pInstance->SetData(EVENT_ARCHAVON, IN_PROGRESS);
            }

            void JustDied(Unit* )
            {
                if (pInstance)
                    pInstance->SetData(EVENT_ARCHAVON, DONE);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_ROCK_SHARDS:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_ROCK_SHARDS, false);
                        
                        events.RepeatEvent(15000);
                        break;
                    case EVENT_CHOKING_CLOUD:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                            me->CastSpell(target, RAID_MODE(SPELL_CRUSHING_LEAP_10, SPELL_CRUSHING_LEAP_25), true); //10y~80y, ignore range
                        
                        events.RepeatEvent(30000);
                        break;
                    case EVENT_STOMP:
                    {
                        char buffer[100];
                        sprintf(buffer, "Archavon the Stone Watcher lunges for %s!", me->GetVictim()->GetName().c_str());
                        me->MonsterTextEmote(buffer, 0);
                        me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_STOMP_10, SPELL_STOMP_25), false);
                        me->GetVictim()->KnockbackFrom(me->GetPositionX(), me->GetPositionY(), 3.0f, 40.0f);
                        events.RepeatEvent(45000);
                        events.ScheduleEvent(EVENT_IMPALE, 3000);
                        break;
                    }
                    case EVENT_IMPALE:
                        me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25), false);
                        events.PopEvent();
                        break;
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(EMOTE_BERSERK);
                        events.PopEvent();
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_archavonAI(creature);
        }
};

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
                Unit* target = GetHitUnit();
                Unit* caster = GetOriginalCaster();
                if (target && caster && caster->GetMap())
                {
                    for (uint32 i = 0; i < 3; ++i)
                    {
                        caster->CastSpell(target, 58689, true);
                        caster->CastSpell(target, 58692, true);
                    }

                    caster->CastSpell(target, caster->GetMap()->Is25ManRaid() ? 60883 : 58695, true); 
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_archavon_rock_shards_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_archavon_rock_shards_SpellScript();
        }
};


void AddSC_boss_archavon()
{
    new boss_archavon();
    new spell_archavon_rock_shards();
}
