/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Duskwood
SD%Complete: 100
SDComment: Quest Support:8735
SDCategory: Duskwood
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"

enum TwilightCorrupter
{
    ITEM_FRAGMENT                   = 21149,
    NPC_TWILIGHT_CORRUPTER          = 15625,
    YELL_TWILIGHTCORRUPTOR_RESPAWN  = 0,
    YELL_TWILIGHTCORRUPTOR_AGGRO    = 1,
    YELL_TWILIGHTCORRUPTOR_KILL     = 2,
    SPELL_SOUL_CORRUPTION           = 25805,
    SPELL_CREATURE_OF_NIGHTMARE     = 25806,
    SPELL_LEVEL_UP                  = 24312,

    EVENT_SOUL_CORRUPTION           = 1,
    EVENT_CREATURE_OF_NIGHTMARE     = 2,
    FACTION_HOSTILE                 = 14
};

/*######
# boss_twilight_corrupter
######*/

class boss_twilight_corrupter : public CreatureScript
{
public:
    boss_twilight_corrupter() : CreatureScript("boss_twilight_corrupter") { }

    struct boss_twilight_corrupterAI : public ScriptedAI
    {
        boss_twilight_corrupterAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
        {
            KillCount                 = 0;
        }

        void InitializeAI()
        {
            // Xinef: check if copy is summoned
            std::list<Creature*> cList;
            me->GetCreatureListWithEntryInGrid(cList, me->GetEntry(), 50.0f);
            if (!cList.empty())
                for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr)
                    if ((*itr)->IsAlive() && me->GetGUID() != (*itr)->GetGUID())
                    {
                        me->DespawnOrUnsummon(1);
                        break;
                    }

            _introSpoken = false;
            ScriptedAI::InitializeAI();
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!_introSpoken && who->GetTypeId() == TYPEID_PLAYER)
            {
                _introSpoken = true;
                Talk(YELL_TWILIGHTCORRUPTOR_RESPAWN, who);
                me->setFaction(FACTION_HOSTILE);
            }
            ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(YELL_TWILIGHTCORRUPTOR_AGGRO);
            _events.Reset();
            _events.ScheduleEvent(EVENT_SOUL_CORRUPTION, 15000);
            _events.ScheduleEvent(EVENT_CREATURE_OF_NIGHTMARE, 30000);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
            {
                ++KillCount;
                Talk(YELL_TWILIGHTCORRUPTOR_KILL, victim);

                if (KillCount == 3)
                {
                    DoCast(me, SPELL_LEVEL_UP, true);
                    KillCount = 0;
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SOUL_CORRUPTION:
                        DoCastVictim(SPELL_SOUL_CORRUPTION);
                        _events.ScheduleEvent(EVENT_SOUL_CORRUPTION, rand()%4000+15000);
                        break;
                    case EVENT_CREATURE_OF_NIGHTMARE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                            DoCast(target, SPELL_CREATURE_OF_NIGHTMARE);
                        _events.ScheduleEvent(EVENT_CREATURE_OF_NIGHTMARE, 45000);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

        private:
            EventMap _events;
            uint8 KillCount;
            bool _introSpoken;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_twilight_corrupterAI(creature);
    }
};

/*######
# at_twilight_grove
######*/

class at_twilight_grove : public AreaTriggerScript
{
public:
    at_twilight_grove() : AreaTriggerScript("at_twilight_grove") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/)
    {
        if (player->HasQuestForItem(ITEM_FRAGMENT) && !player->HasItemCount(ITEM_FRAGMENT))
            player->SummonCreature(NPC_TWILIGHT_CORRUPTER, -10328.16f, -489.57f, 49.95f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 240000);

        return false;
    };
};

void AddSC_duskwood()
{
    new boss_twilight_corrupter();
    new at_twilight_grove();
}
