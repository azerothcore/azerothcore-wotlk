/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "mechanar.h"

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
    SPELL_SUMMON_RAGIN_FLAMES      = 35275,
    SPELL_FROST_ATTACK             = 35263,
    SPELL_ARCANE_BLAST             = 35314,
    SPELL_DRAGONS_BREATH           = 35250,
};

enum Events
{
    EVENT_FROST_ATTACK             = 1,
    EVENT_ARCANE_BLAST             = 2,
    EVENT_DRAGONS_BREATH           = 3,
};

class boss_nethermancer_sepethrea : public CreatureScript
{
    public: boss_nethermancer_sepethrea(): CreatureScript("boss_nethermancer_sepethrea") { }

        struct boss_nethermancer_sepethreaAI : public BossAI
        {
            boss_nethermancer_sepethreaAI(Creature* creature) : BossAI(creature, DATA_NETHERMANCER_SEPRETHREA) { }

            void EnterCombat(Unit*  /*who*/)
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_FROST_ATTACK, 6000);
                events.ScheduleEvent(EVENT_ARCANE_BLAST, 14000);
                events.ScheduleEvent(EVENT_DRAGONS_BREATH, 18000);

                Talk(SAY_AGGRO);
                me->CastSpell(me, SPELL_SUMMON_RAGIN_FLAMES, true);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (Unit* victim = me->GetVictim())
                {
                    summon->AI()->AttackStart(victim);
                    summon->AddThreat(victim, 1000.0f);
                    summon->SetInCombatWithZone();
                }
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
            }

            void JustDied(Unit* /*killer*/)
            {
                events.Reset();
                if (instance)
                {
                    instance->SetBossState(DATA_NETHERMANCER_SEPRETHREA, DONE);
                    instance->SaveToDB();
                }
                Talk(SAY_DEATH);

                for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        Unit::Kill(summon, summon);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_FROST_ATTACK:
                        me->CastSpell(me->GetVictim(), SPELL_FROST_ATTACK, false);
                        events.ScheduleEvent(EVENT_FROST_ATTACK, 8000);
                        break;
                    case EVENT_ARCANE_BLAST:
                        me->CastSpell(me->GetVictim(), SPELL_ARCANE_BLAST, false);
                        events.ScheduleEvent(EVENT_ARCANE_BLAST, 12000);
                        break;
                    case EVENT_DRAGONS_BREATH:
                        me->CastSpell(me->GetVictim(), SPELL_DRAGONS_BREATH, true);
                        events.ScheduleEvent(EVENT_DRAGONS_BREATH, 16000);
                        if (roll_chance_i(50))
                            Talk(SAY_DRAGONS_BREATH);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_nethermancer_sepethreaAI(creature);
        }
};

enum raginFlames
{
    SPELL_INFERNO                   = 35268,
    SPELL_FIRE_TAIL                 = 35278,
    SPELL_INFERNO_DAMAGE            = 35283,

    EVENT_SPELL_FIRE_TAIL           = 1,
    EVENT_SPELL_INFERNO             = 2
};

class npc_ragin_flames : public CreatureScript
{
    public:
        npc_ragin_flames() : CreatureScript("npc_ragin_flames") { }

            struct npc_ragin_flamesAI : public ScriptedAI
            {
                npc_ragin_flamesAI(Creature* creature) : ScriptedAI(creature) { }

                EventMap events;

                void Reset()
                {
                    me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_ALL, true);
                }

                void EnterCombat(Unit*)
                {
                    events.ScheduleEvent(EVENT_SPELL_FIRE_TAIL, 500);
                    events.ScheduleEvent(EVENT_SPELL_INFERNO, urand(10000, 20000));
                }

                void UpdateAI(uint32 diff)
                {
                    if (!UpdateVictim())
                        return;

                    events.Update(diff);
                    switch (events.ExecuteEvent())
                    {
                        case EVENT_SPELL_INFERNO:
                            if (me->IsWithinCombatRange(me->GetVictim(), 5.0f))
                            {
                                me->CastSpell(me, SPELL_INFERNO, true);
                                events.ScheduleEvent(EVENT_SPELL_INFERNO, 20000);
                            }
                            else
                                events.ScheduleEvent(EVENT_SPELL_INFERNO, 1000);
                            break;
                        case EVENT_SPELL_FIRE_TAIL:
                            me->CastSpell(me, SPELL_FIRE_TAIL, true);
                            events.ScheduleEvent(EVENT_SPELL_FIRE_TAIL, 500);
                            break;
                    }

                    DoMeleeAttackIfReady();
                }

            };
            CreatureAI* GetAI(Creature* creature) const
            {
                return new npc_ragin_flamesAI(creature);
            }
};

class spell_ragin_flames_inferno : public SpellScriptLoader
{
    public:
        spell_ragin_flames_inferno() : SpellScriptLoader("spell_ragin_flames_inferno") { }

        class spell_ragin_flames_inferno_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ragin_flames_inferno_AuraScript);

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                GetUnitOwner()->CastCustomSpell(SPELL_INFERNO_DAMAGE, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetUnitOwner(), TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_ragin_flames_inferno_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ragin_flames_inferno_AuraScript();
        }
};

void AddSC_boss_nethermancer_sepethrea()
{
    new boss_nethermancer_sepethrea();
    new npc_ragin_flames();
    new spell_ragin_flames_inferno();
}
