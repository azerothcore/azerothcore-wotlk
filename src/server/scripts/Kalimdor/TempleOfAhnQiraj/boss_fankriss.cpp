/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Fankriss
SD%Complete: 100
SDComment: sound not implemented
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

#define SOUND_SENTENCE_YOU 8588
#define SOUND_SERVE_TO     8589
#define SOUND_LAWS         8590
#define SOUND_TRESPASS     8591
#define SOUND_WILL_BE      8592

enum Spells
{
    SPELL_MORTAL_WOUND      = 28467,
    SPELL_ROOT              = 28858,

    // Enrage for his spawns
    SPELL_ENRAGE            = 28798
};

enum Events
{
    EVENT_MORTALWOUND       = 1,
    EVENT_SUMMON_HATCHLINGS = 2,
    EVENT_SUMMON_SPAWN      = 3
};

//TODO: Voice lines haven't been implemented
class boss_fankriss : public CreatureScript
{
public:
    boss_fankriss() : CreatureScript("boss_fankriss") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_fankrissAI(creature);
    }

    struct boss_fankrissAI : public ScriptedAI
    {
        boss_fankrissAI(Creature* creature) : ScriptedAI(creature), summoned(me) { }

        void Reset()
        {
            events.Reset();
            summoned.DespawnAll();
        }

        void SummonSpawn(Unit* victim)
        {
            if (!victim)
                return;

            int Rand = 10 + (rand()%10);
            int RandX = 0.0f;
            int RandY = 0.0f;

            switch (rand()%2)
            {
                case 0: RandX -= Rand; break;
                case 1: RandX = Rand; break;
            }

            Rand = 10 + (rand()%10);
            switch (rand()%2)
            {
                case 0: RandY -= Rand; break;
                case 1: RandY = Rand; break;
            }

            if (Creature* pCreature = me->SummonCreature(15630, RandX, RandY, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
            {
                pCreature->AI()->AttackStart(victim);
                summoned.Summon(pCreature);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_MORTALWOUND, urand(10000, 15000));
            events.ScheduleEvent(EVENT_SUMMON_HATCHLINGS, urand(6000, 12000));
            events.ScheduleEvent(EVENT_SUMMON_SPAWN, urand(15000, 45000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_MORTALWOUND:
                    DoCastVictim(SPELL_MORTAL_WOUND);
                    events.RepeatEvent(urand(10000, 20000));
                    break;
                case EVENT_SUMMON_SPAWN:
                    for (int i = 0; i <= urand(0, 2); i++)
                        SummonSpawn(SelectTarget(SELECT_TARGET_RANDOM, 0));
                    events.RepeatEvent(urand(30000, 60000));
                    break;
                case EVENT_SUMMON_HATCHLINGS:
                {
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    {
                        DoCast(pUnit, SPELL_ROOT);

                        if (DoGetThreat(pUnit))
                            DoModifyThreatPercent(pUnit, -100);

                        switch (urand(0, 2))
                        {
                        case 0:
                            DoTeleportPlayer(pUnit, -8106.0142f, 1289.2900f, -74.419533f, 5.112f);
                            break;
                        case 1:
                            DoTeleportPlayer(pUnit, -7990.135354f, 1155.1907f, -78.849319f, 2.608f);
                            break;
                        case 2:
                            DoTeleportPlayer(pUnit, -8159.7753f, 1127.9064f, -76.868660f, 0.675f);
                        }
                        if (Creature* pCreature = me->SummonCreature(15962, pUnit->GetPositionX() - 3, pUnit->GetPositionY() - 3, pUnit->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                        {
                            summoned.Summon(pCreature);
                            pCreature->AI()->AttackStart(pUnit);
                        }
                        if (Creature* pCreature = me->SummonCreature(15962, pUnit->GetPositionX() - 3, pUnit->GetPositionY() + 3, pUnit->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                        {
                            summoned.Summon(pCreature);
                            pCreature->AI()->AttackStart(pUnit);
                        }
                        if (Creature* pCreature = me->SummonCreature(15962, pUnit->GetPositionX() - 5, pUnit->GetPositionY() - 5, pUnit->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                        {
                            summoned.Summon(pCreature);
                            pCreature->AI()->AttackStart(pUnit);
                        }
                        if (Creature* pCreature = me->SummonCreature(15962, pUnit->GetPositionX() - 5, pUnit->GetPositionY() + 5, pUnit->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                        {
                            summoned.Summon(pCreature);
                            pCreature->AI()->AttackStart(pUnit);
                        }
                        break;
                    }
                    events.RepeatEvent(urand(45000, 60000));
                    break;
                }
                }
            }

            DoMeleeAttackIfReady();
        }
        private:
            EventMap events;
            SummonList summoned;
    };

};

void AddSC_boss_fankriss()
{
    new boss_fankriss();
}
