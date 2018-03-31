/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"
#include "Player.h"

enum Spells
{
    SPELL_CARRION_SWARM_N                       = 52720,
    SPELL_CARRION_SWARM_H                       = 58852,
    SPELL_MIND_BLAST_N                          = 52722,
    SPELL_MIND_BLAST_H                          = 58850,
    SPELL_SLEEP_N                               = 52721,
    SPELL_SLEEP_H                               = 58849,
    SPELL_VAMPIRIC_TOUCH                        = 52723,
};

enum Events
{
    EVENT_SPELL_CARRION_SWARM                   = 1,
    EVENT_SPELL_MIND_BLAST                      = 2,
    EVENT_SPELL_SLEEP                           = 3,
    EVENT_SPELL_VAMPIRIC_TOUCH                  = 4,
};

enum Yells
{
    SAY_AGGRO                                   = 2,
    SAY_KILL                                    = 3,
    SAY_SLAY                                    = 4,
    SAY_SLEEP                                   = 5,
    SAY_30HEALTH                                = 6,
    SAY_15HEALTH                                = 7,
    SAY_ESCAPE_SPEECH_1                         = 8,
    SAY_ESCAPE_SPEECH_2                         = 9,
    SAY_OUTRO                                   = 10
};

class boss_mal_ganis : public CreatureScript
{
public:
    boss_mal_ganis() : CreatureScript("boss_mal_ganis") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_mal_ganisAI (creature);
    }

    struct boss_mal_ganisAI : public ScriptedAI
    {
        boss_mal_ganisAI(Creature* c) : ScriptedAI(c)
        {
            finished = false;
        }

        EventMap events;
        bool finished;

        void Reset() 
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
            events.Reset();
            if (finished)
            {
                Talk(SAY_OUTRO);
                me->DespawnOrUnsummon(20000);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_CARRION_SWARM, 6000);
            events.ScheduleEvent(EVENT_SPELL_MIND_BLAST, 11000);
            events.ScheduleEvent(EVENT_SPELL_SLEEP, 20000);
            events.ScheduleEvent(EVENT_SPELL_VAMPIRIC_TOUCH, 15000);
        }

        void JustDied(Unit* /*killer*/)
        {
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            if (!urand(0,1))
                return;

            Talk(SAY_SLAY);
        }

        void DamageTaken(Unit* who, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (!finished && damage >= me->GetHealth())
            {
                damage = 0;
                finished = true;
                me->SetRegeneratingHealth(false);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_PASSIVE);
                if (InstanceScript* pInstance = me->GetInstanceScript())
                {
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_ARTHAS)))
                        cr->AI()->DoAction(ACTION_KILLED_MALGANIS);

                    // give credit to players
                    me->CastSpell(me, 58630, true);
                }

                // quest completion
                if (who)
                    if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
                        player->RewardPlayerAndGroupAtEvent(31006, player); // Royal Escort quest, Mal'ganis bunny

                EnterEvadeMode();
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
                case EVENT_SPELL_CARRION_SWARM:
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_CARRION_SWARM_N, SPELL_CARRION_SWARM_H), false);
                    events.RepeatEvent(7000);
                    break;
                case EVENT_SPELL_MIND_BLAST:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_MIND_BLAST_N, SPELL_MIND_BLAST_H), false);
                    events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_SLEEP:
                    Talk(SAY_SLEEP);
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_SLEEP_N, SPELL_SLEEP_H), false);
                    events.RepeatEvent(17000);
                    break;
                case EVENT_SPELL_VAMPIRIC_TOUCH:
                    me->CastSpell(me, SPELL_VAMPIRIC_TOUCH, true);
                    events.RepeatEvent(30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_mal_ganis()
{
    new boss_mal_ganis();
}
