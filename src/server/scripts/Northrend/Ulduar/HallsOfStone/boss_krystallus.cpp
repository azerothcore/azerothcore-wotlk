/* Xinef
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "halls_of_stone.h"
#include "Player.h"

enum spells
{
    GROUND_SPIKE_H              = 59750,
    BOULDER_TOSS                = 50843,
    BOULDER_TOSS_H              = 59742,
    SHATTER                     = 50810,
    SHATTER_H                   = 61546,
    STOMP                       = 50868,
    STOMP_H                     = 59744,
    GROUND_SLAM                 = 50827,
    GROUND_SLAM_STONED_EFFECT   = 50812,
    SPELL_SHATTER_EFFECT        = 50811,
};

enum events
{
    EVENT_NONE,
    EVENT_BOULDER,
    EVENT_STOMP,
    EVENT_GROUND_SLAM,
    EVENT_GROUND_SPIKE,
    EVENT_SHATTER,
    EVENT_REMOVE_STONED,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_KILL                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SHATTER                                 = 3
};

class boss_krystallus : public CreatureScript
{
public:
    boss_krystallus() : CreatureScript("boss_krystallus") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_krystallusAI (pCreature);
    }

    struct boss_krystallusAI : public ScriptedAI
    {
        boss_krystallusAI(Creature *c) : ScriptedAI(c) 
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* pInstance;

        void Reset() 
        {
            events.Reset();
            if (pInstance)
                pInstance->SetData(BOSS_KRYSTALLUS, NOT_STARTED);
        }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.RescheduleEvent(EVENT_BOULDER, 8000);
            events.RescheduleEvent(EVENT_STOMP, 5000);
            events.RescheduleEvent(EVENT_GROUND_SLAM, 15000);
            if (me->GetMap()->IsHeroic())
                events.RescheduleEvent(EVENT_GROUND_SPIKE, 10000);

            if (pInstance)
                pInstance->SetData(BOSS_KRYSTALLUS, IN_PROGRESS);

            Talk(SAY_AGGRO);
        }

        void RemoveStonedEffect()
        {
            Map* map = me->GetMap();
            if (map->IsDungeon())
            {
                Map::PlayerList const &players = map->GetPlayers();
                for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if (itr->GetSource()->IsAlive())
                        itr->GetSource()->RemoveAura(GROUND_SLAM_STONED_EFFECT);
            }
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
                case EVENT_BOULDER:
                {
                    if (Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true, 0)) 
                        me->CastSpell(target, DUNGEON_MODE(BOULDER_TOSS, BOULDER_TOSS_H), false);

                    events.RepeatEvent(5000 + rand()%2000);
                    break;
                }
                case EVENT_GROUND_SPIKE:
                {
                    me->CastSpell(me->GetVictim(), GROUND_SPIKE_H, false); // current enemy target
                    events.RepeatEvent(8000 + rand()%3000);
                    break;
                }
                case EVENT_STOMP:
                {
                    me->CastSpell(me, DUNGEON_MODE(STOMP, STOMP_H), false);
                    events.RepeatEvent(13000 + rand()% 5000);
                    break;
                }
                case EVENT_GROUND_SLAM:
                {
                    events.RepeatEvent(10000 + rand()%3000);
                    me->CastSpell(me->GetVictim(), GROUND_SLAM, true);
                    events.DelayEvents(10000);
                    events.RescheduleEvent(EVENT_SHATTER, 8000);
                    break;
                }
                case EVENT_SHATTER:
                {
                    me->CastSpell((Unit*)NULL, DUNGEON_MODE(SHATTER, SHATTER_H), false);
                    Talk(SAY_SHATTER);
                    events.RescheduleEvent(EVENT_REMOVE_STONED, 1500);
                    events.PopEvent();
                    break;
                }
                case EVENT_REMOVE_STONED:
                {
                    RemoveStonedEffect();
                    events.PopEvent();
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(BOSS_KRYSTALLUS, DONE);
        }

        void KilledUnit(Unit * /*victim*/)
        {
            Talk(SAY_KILL);
        }
    };
};


class spell_krystallus_shatter : public SpellScriptLoader
{
    public:
        spell_krystallus_shatter() : SpellScriptLoader("spell_krystallus_shatter") { }

        class spell_krystallus_shatter_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_krystallus_shatter_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    target->RemoveAurasDueToSpell(GROUND_SLAM_STONED_EFFECT);
                    target->CastSpell((Unit*)NULL, SPELL_SHATTER_EFFECT, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_krystallus_shatter_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_krystallus_shatter_SpellScript();
        }
};

class spell_krystallus_shatter_effect : public SpellScriptLoader
{
    public:
        spell_krystallus_shatter_effect() : SpellScriptLoader("spell_krystallus_shatter_effect") { }

        class spell_krystallus_shatter_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_krystallus_shatter_effect_SpellScript);

            void CalculateDamage()
            {
                if (!GetHitUnit())
                    return;

                float radius = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster());
                if (!radius)
                    return;

                float distance = GetCaster()->GetDistance2d(GetHitUnit());
                if (distance > 1.0f)
                    SetHitDamage(int32(GetHitDamage() * ((radius - distance) / radius)));
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_krystallus_shatter_effect_SpellScript::CalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_krystallus_shatter_effect_SpellScript();
        }
};

void AddSC_boss_krystallus()
{
    new boss_krystallus();
    new spell_krystallus_shatter();
    new spell_krystallus_shatter_effect();
}