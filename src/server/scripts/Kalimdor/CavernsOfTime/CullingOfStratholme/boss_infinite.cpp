/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CORRUPTING_BLIGHT                     = 60588,
    SPELL_VOID_STRIKE                           = 60590,
    SPELL_CORRUPTION_OF_TIME_AURA               = 60451,
    SPELL_CORRUPTION_OF_TIME_CHANNEL            = 60422,
};

enum Events
{
    EVENT_SPELL_CORRUPTING_BLIGHT               = 1,
    EVENT_SPELL_VOID_STRIKE                     = 2,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_DEATH                                   = 1,
    SAY_FAIL                                    = 2
};

class boss_infinite_corruptor : public CreatureScript
{
public:
    boss_infinite_corruptor() : CreatureScript("boss_infinite_corruptor") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_infinite_corruptorAI(creature);
    }

    struct boss_infinite_corruptorAI : public ScriptedAI
    {
        boss_infinite_corruptorAI(Creature* c) : ScriptedAI(c), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint32 beamTimer;

        void Reset() 
        { 
            events.Reset();
            summons.DespawnAll();
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (pInstance->GetData(DATA_GUARDIANTIME_EVENT) == 0)
                    me->DespawnOrUnsummon(500);

            me->SummonCreature(NPC_TIME_RIFT, 2337.6f, 1270.0f, 132.95f, 2.79f);
            me->SummonCreature(NPC_GUARDIAN_OF_TIME, 2319.3f, 1267.7f, 132.8f, 1.0f);
            beamTimer = 1;
        }

        void JustSummoned(Creature* cr) { summons.Summon(cr); }

        void EnterCombat(Unit* /*who*/)
        {
            me->InterruptNonMeleeSpells(false);
            events.ScheduleEvent(EVENT_SPELL_VOID_STRIKE, 8000);
            events.ScheduleEvent(EVENT_SPELL_CORRUPTING_BLIGHT, 12000);
            Talk(SAY_AGGRO);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (Creature* cr = ObjectAccessor::GetCreature(*me, (*itr)))
                {
                    if (cr->GetEntry() == NPC_TIME_RIFT)
                        cr->DespawnOrUnsummon(1000);
                    else
                    {
                        cr->DespawnOrUnsummon(5000);
                        cr->RemoveAllAuras();
                        cr->MonsterSay("You have my thanks for saving my existence in this timeline. Now i must report back to my superiors. They must know immediately of what i just experienced.", LANG_UNIVERSAL, 0);
                    }
                }

            if (InstanceScript* pInstance = me->GetInstanceScript())
                pInstance->SetData(DATA_SHOW_INFINITE_TIMER, 0);
        }

        void DoAction(int32 param)
        {
            if (!me->IsAlive())
                return;

            if (param == ACTION_RUN_OUT_OF_TIME)
            {
                Talk(SAY_FAIL);
                summons.DespawnAll();
                me->DespawnOrUnsummon(500);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (beamTimer)
            {
                beamTimer += diff;
                if (beamTimer >= 2000)
                {
                    me->CastSpell(me, SPELL_CORRUPTION_OF_TIME_CHANNEL, true);
                    beamTimer = 0;
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_VOID_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_VOID_STRIKE, false);
                    events.RepeatEvent(8000);
                    break;
                case EVENT_SPELL_CORRUPTING_BLIGHT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_CORRUPTING_BLIGHT, false);
                    events.RepeatEvent(12000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_infinite_corruptor()
{
    new boss_infinite_corruptor();
}
