/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "mechanar.h"
#include "Player.h"

enum Spells
{
    SPELL_HEADCRACK                 = 35161,
    SPELL_REFLECTIVE_MAGIC_SHIELD   = 35158,
    SPELL_REFLECTIVE_DAMAGE_SHIELD  = 35159,
    SPELL_POLARITY_SHIFT            = 39096,
    SPELL_BERSERK                   = 26662
};

enum Yells
{
    YELL_AGGRO                      = 0,
    YELL_REFLECTIVE_MAGIC_SHIELD    = 1,
    YELL_REFLECTIVE_DAMAGE_SHIELD   = 2,
    YELL_KILL                       = 3,
    YELL_DEATH                      = 4
};

enum Creatures
{
    NPC_NETHER_CHARGE               = 20405
};

enum Events
{
    EVENT_HEADCRACK                 = 1,
    EVENT_REFLECTIVE_DAMAGE_SHIELD  = 2,
    EVENT_REFLECTIVE_MAGIE_SHIELD   = 3,
    EVENT_POSITIVE_SHIFT            = 4,
    EVENT_SUMMON_NETHER_CHARGE      = 5,
    EVENT_BERSERK                   = 6
};

class boss_mechano_lord_capacitus : public CreatureScript
{
    public:
        boss_mechano_lord_capacitus() : CreatureScript("boss_mechano_lord_capacitus") { }

        struct boss_mechano_lord_capacitusAI : public BossAI
        {
            boss_mechano_lord_capacitusAI(Creature* creature) : BossAI(creature, DATA_MECHANOLORD_CAPACITUS) { }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                Talk(YELL_AGGRO);
                events.ScheduleEvent(EVENT_HEADCRACK, 6000);
                events.ScheduleEvent(EVENT_SUMMON_NETHER_CHARGE, 10000);
                events.ScheduleEvent(EVENT_BERSERK, 180000);
                events.ScheduleEvent(IsHeroic() ? EVENT_POSITIVE_SHIFT : EVENT_REFLECTIVE_DAMAGE_SHIELD, 15000);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(YELL_KILL);
            }

            void JustDied(Unit* /*victim*/)
            {
                _JustDied();
                Talk(YELL_DEATH);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->GetMotionMaster()->MoveRandom(30.0f);
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
                    case EVENT_HEADCRACK:
                        me->CastSpell(me->GetVictim(), SPELL_HEADCRACK, false);
                        events.ScheduleEvent(EVENT_HEADCRACK, 20000);
                        break;
                    case EVENT_REFLECTIVE_DAMAGE_SHIELD:
                        Talk(YELL_REFLECTIVE_DAMAGE_SHIELD);
                        me->CastSpell(me, SPELL_REFLECTIVE_DAMAGE_SHIELD, false);
                        events.ScheduleEvent(EVENT_REFLECTIVE_MAGIE_SHIELD, 20000);
                        break;
                    case EVENT_REFLECTIVE_MAGIE_SHIELD:
                        Talk(YELL_REFLECTIVE_MAGIC_SHIELD);
                        me->CastSpell(me, SPELL_REFLECTIVE_MAGIC_SHIELD, false);
                        events.ScheduleEvent(EVENT_REFLECTIVE_DAMAGE_SHIELD, 20000);
                        break;
                    case EVENT_SUMMON_NETHER_CHARGE:
                    {
                        Position pos;
                        me->GetRandomNearPosition(pos, 8.0f);
                        me->SummonCreature(NPC_NETHER_CHARGE, pos, TEMPSUMMON_TIMED_DESPAWN, 18000);
                        events.ScheduleEvent(EVENT_SUMMON_NETHER_CHARGE, 5000);
                        break;
                    }
                    case EVENT_POSITIVE_SHIFT:
                        me->CastSpell(me, SPELL_POLARITY_SHIFT, true);
                        events.ScheduleEvent(EVENT_POSITIVE_SHIFT, 30000);
                        break;
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_mechano_lord_capacitusAI(creature);
        }
};

enum polarityShift
{
    SPELL_POSITIVE_POLARITY         = 39088,
    SPELL_POSITIVE_CHARGE_STACK     = 39089,
    SPELL_POSITIVE_CHARGE           = 39090,

    SPELL_NEGATIVE_POLARITY         = 39091,
    SPELL_NEGATIVE_CHARGE_STACK     = 39092,
    SPELL_NEGATIVE_CHARGE           = 39093
};

class spell_capacitus_polarity_charge : public SpellScriptLoader
{
    public:
        spell_capacitus_polarity_charge() : SpellScriptLoader("spell_capacitus_polarity_charge") { }

        class spell_capacitus_polarity_charge_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_capacitus_polarity_charge_SpellScript);

            void HandleTargets(std::list<WorldObject*>& targetList)
            {
                uint8 count = 0;
                for (std::list<WorldObject*>::iterator ihit = targetList.begin(); ihit != targetList.end(); ++ihit)
                    if ((*ihit)->GetGUID() != GetCaster()->GetGUID())
                        if (Player* target = (*ihit)->ToPlayer())
                            if (target->HasAura(GetTriggeringSpell()->Id))
                                ++count;

                if (count)
                {
                    uint32 spellId = GetSpellInfo()->Id == SPELL_POSITIVE_CHARGE ? SPELL_POSITIVE_CHARGE_STACK : SPELL_NEGATIVE_CHARGE_STACK;
                    GetCaster()->SetAuraStack(spellId, GetCaster(), count);
                }
            }

            void HandleDamage(SpellEffIndex /*effIndex*/)
            {
                if (!GetTriggeringSpell())
                    return;

                Unit* target = GetHitUnit();
                if (target->HasAura(GetTriggeringSpell()->Id))
                    SetHitDamage(0);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_capacitus_polarity_charge_SpellScript::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_capacitus_polarity_charge_SpellScript::HandleTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_capacitus_polarity_charge_SpellScript();
        }
};

class spell_capacitus_polarity_shift : public SpellScriptLoader
{
    public:
        spell_capacitus_polarity_shift() : SpellScriptLoader("spell_capacitus_polarity_shift") { }

        class spell_capacitus_polarity_shift_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_capacitus_polarity_shift_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, roll_chance_i(50) ? SPELL_POSITIVE_POLARITY : SPELL_NEGATIVE_POLARITY, true, nullptr, nullptr, GetCaster()->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_capacitus_polarity_shift_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_capacitus_polarity_shift_SpellScript();
        }
};

void AddSC_boss_mechano_lord_capacitus()
{
    new boss_mechano_lord_capacitus();
    new spell_capacitus_polarity_charge();
    new spell_capacitus_polarity_shift();
}
