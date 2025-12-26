/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"

/*######
## npc_deathstalker_erland
######*/

enum Erland
{
    SAY_QUESTACCEPT     = 0,
    SAY_START           = 1,
    SAY_AGGRO           = 2,
    SAY_PROGRESS        = 3,
    SAY_LAST            = 4,

    SAY_RANE            = 0,
    SAY_RANE_ANSWER     = 5,
    SAY_MOVE_QUINN      = 6,

    SAY_QUINN           = 7,
    SAY_QUINN_ANSWER    = 0,
    SAY_BYE             = 8,

    QUEST_ESCORTING     = 435,
    NPC_RANE            = 1950,
    NPC_QUINN           = 1951
};

class npc_deathstalker_erland : public CreatureScript
{
public:
    npc_deathstalker_erland() : CreatureScript("npc_deathstalker_erland") { }

    struct npc_deathstalker_erlandAI : public npc_escortAI
    {
        npc_deathstalker_erlandAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    Talk(SAY_START, player);
                    break;
                case 10:
                    Talk(SAY_PROGRESS);
                    break;
                case 13:
                    Talk(SAY_LAST, player);
                    player->GroupEventHappens(QUEST_ESCORTING, me);
                    break;
                case 15:
                    if (Creature* rane = me->FindNearestCreature(NPC_RANE, 20.0f))
                        rane->AI()->Talk(SAY_RANE);
                    break;
                case 16:
                    Talk(SAY_RANE_ANSWER);
                    break;
                case 17:
                    Talk(SAY_MOVE_QUINN);
                    break;
                case 24:
                    Talk(SAY_QUINN);
                    break;
                case 25:
                    if (Creature* quinn = me->FindNearestCreature(NPC_QUINN, 20.0f))
                        quinn->AI()->Talk(SAY_QUINN_ANSWER);
                    break;
                case 26:
                    Talk(SAY_BYE);
                    break;
            }
        }

        void Reset() override { }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_AGGRO, who);
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ESCORTING)
        {
            creature->AI()->Talk(SAY_QUESTACCEPT, player);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_deathstalker_erland::npc_deathstalker_erlandAI, creature->AI()))
            {
                creature->SetWalk(true);
                pEscortAI->Start(true, player->GetGUID());
            }
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_deathstalker_erlandAI(creature);
    }
};

/*######
## pyrewood_ambush
#######*/

enum PyrewoodAmbush
{
    QUEST_PYREWOOD_AMBUSH = 452,
    NPCSAY_INIT = 0,
    NPCSAY_END = 1
};

static float PyrewoodSpawnPoints[3][4] =
{
    //pos_x   pos_y     pos_z    orien
    //outside
    /*
    {-400.85f, 1513.64f, 18.67f, 0},
    {-397.32f, 1514.12f, 18.67f, 0},
    {-397.44f, 1511.09f, 18.67f, 0},
    */
    //door
    {-397.018219f, 1510.208740f, 18.868748f, 4.731330f},
    {-397.018219f, 1510.208740f, 18.868748f, 4.731330f},
    {-397.018219f, 1510.208740f, 18.868748f, 4.731330f},
};

struct npc_deathstalker_fearleia : public ScriptedAI
{
    npc_deathstalker_fearleia(Creature* creature) : ScriptedAI(creature), _summons(me)
    {
        _questInProgress = false;
    }

    void Reset() override
    {
        if (!_questInProgress)
        {
            _playerGUID.Clear();
            _summons.DespawnAll();
            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        }
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_PYREWOOD_AMBUSH && !_questInProgress)
        {
            _questInProgress = true;
            _playerGUID = player->GetGUID();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        }

        Talk(NPCSAY_INIT, player);

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            switch (context.GetRepeatCounter())
            {
                case 0:
                    SummonCreatureWithRandomTarget(2060, 1);
                    break;
                case 2:
                    SummonCreatureWithRandomTarget(2061, 2);
                    SummonCreatureWithRandomTarget(2062, 0);
                    break;
                case 3:
                    SummonCreatureWithRandomTarget(2063, 1);
                    SummonCreatureWithRandomTarget(2064, 2);
                    SummonCreatureWithRandomTarget(2065, 0);
                    break;
                case 4:
                    SummonCreatureWithRandomTarget(2066, 1);
                    SummonCreatureWithRandomTarget(2067, 0);
                    SummonCreatureWithRandomTarget(2068, 2);
                    break;
                case 5: //end
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                    {
                        Talk(NPCSAY_END, player);
                        player->GroupEventHappens(QUEST_PYREWOOD_AMBUSH, me);
                    }
                    _questInProgress = false;
                    Reset();
                    break;
            }

            if (context.GetRepeatCounter() < 5)
                context.Repeat();
        });
    }

    void JustEngagedWith(Unit* /*who*/) override {}

    void JustSummoned(Creature* summoned) override
    {
        _summons.Summon(summoned);
    }

    void SummonedCreatureDespawn(Creature* summoned) override
    {
        _summons.Despawn(summoned);
    }

    void SummonCreatureWithRandomTarget(uint32 creatureId, int position)
    {
        if (Creature* summoned = me->SummonCreature(creatureId, PyrewoodSpawnPoints[position][0], PyrewoodSpawnPoints[position][1], PyrewoodSpawnPoints[position][2], PyrewoodSpawnPoints[position][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 15000))
        {
            Unit* target = nullptr;
            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                if (player->IsAlive() && RAND(0, 1))
                    target = player;

            if (!target)
                target = me;

            summoned->SetFaction(FACTION_STORMWIND);
            summoned->AddThreat(target, 32.0f);
            summoned->AI()->AttackStart(target);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
            if (player->GetQuestStatus(QUEST_PYREWOOD_AMBUSH) == QUEST_STATUS_INCOMPLETE)
                player->FailQuest(QUEST_PYREWOOD_AMBUSH);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_questInProgress && !_summons.IsAnyCreatureAlive())
            scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }

private:
    ObjectGuid _playerGUID;
    SummonList _summons;
    bool _questInProgress;
};

/**
 *
 * @todo: Actual emote and BroadcastTextId need to be sniffed. Probably the entire event to begin with....
 * There is a possibility that the unused texts are chosen by random for specific parts of the speech. (making it look like they are preset, when in fact, they are not)
 *
 */

enum ApparitionMisc
{
    // Crowd
    NPC_GNOLL_RUNNER        = 1772,
    NPC_GNOLL_MYSTIC        = 1773,
    EMOTE_CHEER             = 71,
    EMOTE_GNOLL_CHEER       = 1,

    // Apparition
    SAY_APPA_INTRO          = 0,
    SAY_APPA_OUTRO          = 14,

    // Variation 1
    SAY_APPA_OPTION_1_1     = 1,
    SAY_APPA_OPTION_1_2     = 5,
    SAY_APPA_OPTION_1_3     = 10,
    SAY_APPA_OPTION_1_4     = 13,

    // Variation 2
    SAY_APPA_OPTION_2_1     = 2,
    SAY_APPA_OPTION_2_2     = 5,
    SAY_APPA_OPTION_2_3     = 9,
    SAY_APPA_OPTION_2_4     = 12,
};

enum ApparitionEvents
{
    EVENT_APPA_INTRO        = 1,
    EVENT_APPA_SAY_1        = 2,
    EVENT_APPA_SAY_2        = 3,
    EVENT_APPA_SAY_3        = 4,
    EVENT_APPA_SAY_4        = 5,
    EVENT_APPA_OUTRO        = 6,
    EVENT_APPA_OUTRO_CROWD  = 7,
    EVENT_APPA_OUTRO_END    = 8,
};

class npc_ravenclaw_apparition : public CreatureScript
{
public:
    npc_ravenclaw_apparition() : CreatureScript("npc_ravenclaw_apparition") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ravenclaw_apparitionAI(creature);
    }

    struct npc_ravenclaw_apparitionAI : public NullCreatureAI
    {
        npc_ravenclaw_apparitionAI(Creature* creature) : NullCreatureAI(creature), summons(me)
        {
            HasEnded = false;
            TalkRNG = urand(0,1);
            events.ScheduleEvent(EVENT_APPA_INTRO, 2s);
            summons.DespawnAll();
        }

        EventMap events;
        SummonList summons;
        bool HasEnded;
        bool TalkRNG;

        void SummonCrowd()
        {
            for (uint8 i = 0; i < urand(3, 5); ++i)
            {
                float o = i * 10;
                me->SummonCreature(urand(NPC_GNOLL_RUNNER,NPC_GNOLL_MYSTIC), me->GetPositionX() + urand(3,5) * cos(o) , me->GetPositionY() + urand(3,5) * sin(o), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 35000);
            }
        }

        void EmoteCrowd()
        {
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
            {
                if (Creature* c = ObjectAccessor::GetCreature(*me, *itr))
                    {
                        if (urand(0,1))
                        {
                            c->HandleEmoteCommand(EMOTE_CHEER);
                            c->AI()->Talk(EMOTE_GNOLL_CHEER);
                        }
                    }
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            summon->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_PACIFIED);
            summon->SetFacingToObject(me);
        }

        // Should never die, just in case.
        void JustDied(Unit* /*killer*/) override
        {
            summons.DespawnAll();
            events.Reset();
        }

        void UpdateAI(uint32 diff) override
        {
            if (HasEnded || !me->IsVisible())
                return;

            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_APPA_INTRO:
                    Talk(SAY_APPA_INTRO);
                    SummonCrowd();
                    events.ScheduleEvent(EVENT_APPA_SAY_1, 3s);
                    break;
                case EVENT_APPA_SAY_1:
                    Talk(TalkRNG ? SAY_APPA_OPTION_1_1 : SAY_APPA_OPTION_2_1);
                    events.ScheduleEvent(EVENT_APPA_SAY_2, 5s);
                    break;
                case EVENT_APPA_SAY_2:
                    Talk(TalkRNG ? SAY_APPA_OPTION_1_2 : SAY_APPA_OPTION_2_2);
                    events.ScheduleEvent(EVENT_APPA_SAY_3, 5s);
                    break;
                case EVENT_APPA_SAY_3:
                    Talk(TalkRNG ? SAY_APPA_OPTION_1_3 : SAY_APPA_OPTION_2_3);
                    events.ScheduleEvent(EVENT_APPA_SAY_4, 5s);
                    break;
                case EVENT_APPA_SAY_4:
                    Talk(TalkRNG ? SAY_APPA_OPTION_1_4 : SAY_APPA_OPTION_2_4);
                    events.ScheduleEvent(EVENT_APPA_OUTRO, 5s);
                    break;
                case EVENT_APPA_OUTRO:
                    Talk(SAY_APPA_OUTRO);
                    events.ScheduleEvent(EVENT_APPA_OUTRO_CROWD, 3s);
                    break;
                case EVENT_APPA_OUTRO_CROWD:
                    EmoteCrowd();
                    events.ScheduleEvent(EVENT_APPA_OUTRO_END, 5s);
                    break;
                case EVENT_APPA_OUTRO_END: // Despawn for Apparition is handled via Areatrigger SAI (5m)
                    summons.DespawnAll();
                    me->SetVisible(false);
                    HasEnded = true;
                    events.Reset();
                    break;
            }
        }
    };
};

void AddSC_silverpine_forest()
{
    new npc_deathstalker_erland();
    RegisterCreatureAI(npc_deathstalker_fearleia);
    new npc_ravenclaw_apparition();
}
