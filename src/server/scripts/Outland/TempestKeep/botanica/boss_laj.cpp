/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_botanica.h"

enum Spells
{
    SPELL_ALLERGIC_REACTION    = 34697,
    SPELL_TELEPORT_SELF        = 34673,

    SPELL_SUMMON_LASHER_1      = 34681,
    SPELL_SUMMON_FLAYER_1      = 34682,
    SPELL_SUMMON_LASHER_2      = 34684,
    SPELL_SUMMON_FLAYER_2      = 34685,
    SPELL_SUMMON_LASHER_3      = 34686,
    SPELL_SUMMON_FLAYER_4      = 34687,
    SPELL_SUMMON_LASHER_4      = 34688,
    SPELL_SUMMON_FLAYER_3      = 34690,

    SPELL_DAMAGE_IMMUNE_ARCANE  = 34304,
    SPELL_DAMAGE_IMMUNE_FIRE    = 34305,
    SPELL_DAMAGE_IMMUNE_FROST   = 34306,
    SPELL_DAMAGE_IMMUNE_NATURE  = 34308,
    SPELL_DAMAGE_IMMUNE_SHADOW  = 34309
};

enum Misc
{
    EMOTE_SUMMON               = 0,
    MODEL_DEFAULT              = 13109,
    MODEL_ARCANE               = 14213,
    MODEL_FIRE                 = 13110,
    MODEL_FROST                = 14112,
    MODEL_NATURE               = 14214,

    EVENT_ALERGIC_REACTION      = 1,
    EVENT_TRANSFORM             = 2,
    EVENT_TELEPORT              = 3,
    EVENT_SUMMON                = 4
};

class boss_laj : public CreatureScript
{
    public:

        boss_laj() : CreatureScript("boss_laj") { }

        struct boss_lajAI : public BossAI
        {
            boss_lajAI(Creature* creature) : BossAI(creature, DATA_LAJ) { }

            void Reset()
            {
                _Reset();
                me->SetDisplayId(MODEL_DEFAULT);
                _lastTransform = SPELL_DAMAGE_IMMUNE_SHADOW;
                me->CastSpell(me, SPELL_DAMAGE_IMMUNE_SHADOW, true);
            }

            void DoTransform()
            {
                me->RemoveAurasDueToSpell(_lastTransform);

                switch (_lastTransform = RAND(SPELL_DAMAGE_IMMUNE_SHADOW, SPELL_DAMAGE_IMMUNE_FIRE, SPELL_DAMAGE_IMMUNE_FROST, SPELL_DAMAGE_IMMUNE_NATURE, SPELL_DAMAGE_IMMUNE_ARCANE))
                {
                    case SPELL_DAMAGE_IMMUNE_SHADOW: me->SetDisplayId(MODEL_DEFAULT); break;
                    case SPELL_DAMAGE_IMMUNE_ARCANE: me->SetDisplayId(MODEL_ARCANE); break;
                    case SPELL_DAMAGE_IMMUNE_FIRE: me->SetDisplayId(MODEL_FIRE); break;
                    case SPELL_DAMAGE_IMMUNE_FROST: me->SetDisplayId(MODEL_FROST); break;
                    case SPELL_DAMAGE_IMMUNE_NATURE: me->SetDisplayId(MODEL_NATURE); break;
                }

                me->CastSpell(me, _lastTransform, true);
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();

                events.ScheduleEvent(EVENT_ALERGIC_REACTION, 5000);
                events.ScheduleEvent(EVENT_TRANSFORM, 30000);
                events.ScheduleEvent(EVENT_TELEPORT, 20000);
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
                    case EVENT_ALERGIC_REACTION:
                        me->CastSpell(me->GetVictim(), SPELL_ALLERGIC_REACTION, false);
                        events.ScheduleEvent(EVENT_ALERGIC_REACTION, 25000);
                        break;
                    case EVENT_TELEPORT:
                        me->CastSpell(me, SPELL_TELEPORT_SELF, false);
                        events.ScheduleEvent(EVENT_SUMMON, 2500);
                        events.ScheduleEvent(EVENT_TELEPORT, 30000);
                        break;
                    case EVENT_SUMMON:
                        Talk(EMOTE_SUMMON);
                        me->CastSpell(me, SPELL_SUMMON_LASHER_1, true);
                        me->CastSpell(me, SPELL_SUMMON_FLAYER_1, true);
                        break;
                    case EVENT_TRANSFORM:
                        DoTransform();
                        events.ScheduleEvent(EVENT_TRANSFORM, 35000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
            private:
                uint32 _lastTransform;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_lajAI(creature);
        }
};

void AddSC_boss_laj()
{
    new boss_laj();
}

