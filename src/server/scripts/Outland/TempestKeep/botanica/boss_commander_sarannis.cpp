/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_botanica.h"
#include "SpellScript.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_ARCANE_RESONANCE        = 2,
    SAY_ARCANE_DEVASTATION      = 3,
    EMOTE_SUMMON                = 4,
    SAY_SUMMON                  = 5,
    SAY_DEATH                   = 6
};

enum Spells
{
    SPELL_ARCANE_RESONANCE      = 34794,
    SPELL_ARCANE_DEVASTATION    = 34799,
    SPELL_SUMMON_REINFORCEMENTS = 34803
};

enum Events
{
    EVENT_ARCANE_RESONANCE      = 1,
    EVENT_ARCANE_DEVASTATION    = 2,
    EVENT_HEALTH_CHECK          = 3
};

class boss_commander_sarannis : public CreatureScript
{
    public: boss_commander_sarannis() : CreatureScript("boss_commander_sarannis") { }

        struct boss_commander_sarannisAI : public BossAI
        {
            boss_commander_sarannisAI(Creature* creature) : BossAI(creature, DATA_COMMANDER_SARANNIS) { }

            void Reset()
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                Talk(SAY_AGGRO);
                events.ScheduleEvent(EVENT_ARCANE_RESONANCE, 20000);
                events.ScheduleEvent(EVENT_ARCANE_DEVASTATION, 10000);
                events.ScheduleEvent(EVENT_HEALTH_CHECK, 500);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                Talk(SAY_DEATH);
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
                    case EVENT_ARCANE_RESONANCE:
                        if (roll_chance_i(50))
                            Talk(SAY_ARCANE_RESONANCE);
                        me->CastSpell(me->GetVictim(), SPELL_ARCANE_RESONANCE, false);
                        events.ScheduleEvent(EVENT_ARCANE_RESONANCE, 27000);
                        break;
                    case EVENT_ARCANE_DEVASTATION:
                        if (roll_chance_i(50))
                            Talk(SAY_ARCANE_DEVASTATION);
                        me->CastSpell(me->GetVictim(), SPELL_ARCANE_DEVASTATION, false);
                        events.ScheduleEvent(EVENT_ARCANE_DEVASTATION, 17000);
                        break;
                    case EVENT_HEALTH_CHECK:
                        if (me->HealthBelowPct(50))
                        {
                            Talk(EMOTE_SUMMON);
                            Talk(SAY_SUMMON);
                            me->CastSpell(me, SPELL_SUMMON_REINFORCEMENTS, true);
                            break;
                        }
                        events.ScheduleEvent(EVENT_HEALTH_CHECK, 500);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_commander_sarannisAI(creature);
        }
};

Position const PosSummonReinforcements[4] =
{
    { 160.4483f, 287.6435f, -3.887904f, 2.3841f },
    { 153.4406f, 289.9929f, -4.736916f, 2.3841f },
    { 154.4137f, 292.8956f, -4.683603f, 2.3841f },
    { 157.1544f, 294.2599f, -4.726504f, 2.3841f }
};

enum Creatures
{
    NPC_SUMMONED_BLOODWARDER_MENDER     = 20083,
    NPC_SUMMONED_BLOODWARDER_RESERVIST  = 20078
};

class spell_commander_sarannis_summon_reinforcements : public SpellScriptLoader
{
    public:
        spell_commander_sarannis_summon_reinforcements() : SpellScriptLoader("spell_commander_sarannis_summon_reinforcements") { }

        class spell_commander_sarannis_summon_reinforcements_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_commander_sarannis_summon_reinforcements_SpellScript);

            void HandleCast(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->SummonCreature(NPC_SUMMONED_BLOODWARDER_MENDER, PosSummonReinforcements[0], TEMPSUMMON_CORPSE_DESPAWN);
                GetCaster()->SummonCreature(NPC_SUMMONED_BLOODWARDER_RESERVIST, PosSummonReinforcements[1], TEMPSUMMON_CORPSE_DESPAWN);
                GetCaster()->SummonCreature(NPC_SUMMONED_BLOODWARDER_RESERVIST, PosSummonReinforcements[2], TEMPSUMMON_CORPSE_DESPAWN);
                if (GetCaster()->GetMap()->IsHeroic())
                    GetCaster()->SummonCreature(NPC_SUMMONED_BLOODWARDER_RESERVIST, PosSummonReinforcements[3], TEMPSUMMON_CORPSE_DESPAWN);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_commander_sarannis_summon_reinforcements_SpellScript::HandleCast, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_commander_sarannis_summon_reinforcements_SpellScript();
        }
};

void AddSC_boss_commander_sarannis()
{
    new boss_commander_sarannis();
    new spell_commander_sarannis_summon_reinforcements();
}
