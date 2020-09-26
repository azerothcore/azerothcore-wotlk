/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Thousand Needles
SD%Complete: 100
SDComment: Support for Quest: 1950, 4770, 4904, 4966, 5151.
SDCategory: Thousand Needles
EndScriptData */

/* ContentData
npc_lakota_windsong
npc_swiftmountain
npc_plucky
npc_enraged_panther
go_panther_cage
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

/*######
# npc_lakota_windsong
######*/

enum Lakota
{
    SAY_LAKO_START              = 0,
    SAY_LAKO_LOOK_OUT           = 1,
    SAY_LAKO_HERE_COME          = 2,
    SAY_LAKO_MORE               = 3,
    SAY_LAKO_END                = 4,

    QUEST_FREE_AT_LAST          = 4904,
    NPC_GRIM_BANDIT             = 10758,
    FACTION_ESCORTEE_LAKO       = 232,                      //guessed

    ID_AMBUSH_1                 = 0,
    ID_AMBUSH_2                 = 2,
    ID_AMBUSH_3                 = 4
};

Position const BanditLoc[6] =
{
    {-4905.479492f, -2062.732666f, 84.352f, 0.0f},
    {-4915.201172f, -2073.528320f, 84.733f, 0.0f},
    {-4878.883301f, -1986.947876f, 91.966f, 0.0f},
    {-4877.503906f, -1966.113403f, 91.859f, 0.0f},
    {-4767.985352f, -1873.169189f, 90.192f, 0.0f},
    {-4788.861328f, -1888.007813f, 89.888f, 0.0f}
};

class npc_lakota_windsong : public CreatureScript
{
public:
    npc_lakota_windsong() : CreatureScript("npc_lakota_windsong") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_FREE_AT_LAST)
        {
            creature->AI()->Talk(SAY_LAKO_START, player);
            creature->setFaction(FACTION_ESCORTEE_LAKO);

            if (npc_lakota_windsongAI* pEscortAI = CAST_AI(npc_lakota_windsong::npc_lakota_windsongAI, creature->AI()))
                pEscortAI->Start(false, false, player->GetGUID(), quest);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lakota_windsongAI(creature);
    }

    struct npc_lakota_windsongAI : public npc_escortAI
    {
        npc_lakota_windsongAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() { }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 8:
                    Talk(SAY_LAKO_LOOK_OUT);
                    DoSpawnBandits(ID_AMBUSH_1);
                    break;
                case 14:
                    Talk(SAY_LAKO_HERE_COME);
                    DoSpawnBandits(ID_AMBUSH_2);
                    break;
                case 21:
                    Talk(SAY_LAKO_MORE);
                    DoSpawnBandits(ID_AMBUSH_3);
                    break;
                case 45:
                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_FREE_AT_LAST, me);
                    break;
            }
        }

        void DoSpawnBandits(int AmbushId)
        {
            for (int i = 0; i < 2; ++i)
                me->SummonCreature(NPC_GRIM_BANDIT, BanditLoc[i+AmbushId], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
        }
    };

};

/*######
# npc_paoka_swiftmountain
######*/

enum Packa
{
    SAY_START           = 0,
    SAY_WYVERN          = 1,
    SAY_COMPLETE        = 2,

    QUEST_HOMEWARD      = 4770,
    NPC_WYVERN          = 4107,
    FACTION_ESCORTEE    = 232                               //guessed
};

Position const WyvernLoc[3] =
{
    {-4990.606f, -906.057f, -5.343f, 0.0f},
    {-4970.241f, -927.378f, -4.951f, 0.0f},
    {-4985.364f, -952.528f, -5.199f, 0.0f}
};

class npc_paoka_swiftmountain : public CreatureScript
{
public:
    npc_paoka_swiftmountain() : CreatureScript("npc_paoka_swiftmountain") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_HOMEWARD)
        {
            creature->AI()->Talk(SAY_START, player);
            creature->setFaction(FACTION_ESCORTEE);

            if (npc_paoka_swiftmountainAI* pEscortAI = CAST_AI(npc_paoka_swiftmountain::npc_paoka_swiftmountainAI, creature->AI()))
                pEscortAI->Start(false, false, player->GetGUID(), quest);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_paoka_swiftmountainAI(creature);
    }

    struct npc_paoka_swiftmountainAI : public npc_escortAI
    {
        npc_paoka_swiftmountainAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() { }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 15:
                    Talk(SAY_WYVERN);
                    DoSpawnWyvern();
                    break;
                case 26:
                    Talk(SAY_COMPLETE);
                    break;
                case 27:
                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_HOMEWARD, me);
                    break;
            }
        }

        void DoSpawnWyvern()
        {
            for (int i = 0; i < 3; ++i)
                me->SummonCreature(NPC_WYVERN, WyvernLoc[i], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
        }
    };
};

/*#####
# npc_plucky
######*/

#define GOSSIP_P    "Please tell me the Phrase.."

enum Plucky
{
    FACTION_FRIENDLY        = 35,
    QUEST_SCOOP             = 1950,
    SPELL_PLUCKY_HUMAN      = 9192,
    SPELL_PLUCKY_CHICKEN    = 9220
};

class npc_plucky : public CreatureScript
{
public:
    npc_plucky() : CreatureScript("npc_plucky") { }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                CloseGossipMenuFor(player);
                player->CompleteQuest(QUEST_SCOOP);
            break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_SCOOP) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_P, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        SendGossipMenuFor(player, 738, creature->GetGUID());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pluckyAI(creature);
    }

    struct npc_pluckyAI : public ScriptedAI
    {
        npc_pluckyAI(Creature* creature) : ScriptedAI(creature) { NormFaction = creature->getFaction(); }

        uint32 NormFaction;
        uint32 ResetTimer;

        void Reset() override
        {
            ResetTimer = 120000;

            if (me->getFaction() != NormFaction)
                me->setFaction(NormFaction);

            if (me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            DoCast(me, SPELL_PLUCKY_CHICKEN, false);
        }

        void ReceiveEmote(Player* player, uint32 TextEmote) override
        {
            if (player->GetQuestStatus(QUEST_SCOOP) == QUEST_STATUS_INCOMPLETE)
            {
                if (TextEmote == TEXT_EMOTE_BECKON)
                {
                    me->setFaction(FACTION_FRIENDLY);
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    DoCast(me, SPELL_PLUCKY_HUMAN, false);
                }
            }

            if (TextEmote == TEXT_EMOTE_CHICKEN)
            {
                if (me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                    return;
                else
                {
                    me->setFaction(FACTION_FRIENDLY);
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    DoCast(me, SPELL_PLUCKY_HUMAN, false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                }
            }
        }

        void UpdateAI(uint32 Diff) override
        {
            if (me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            {
                if (ResetTimer <= Diff)
                {
                    if (!me->GetVictim())
                        EnterEvadeMode();
                    else
                        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                    return;
                }
                else
                    ResetTimer -= Diff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};

enum PantherCage
{
    ENRAGED_PANTHER = 10992
};

class go_panther_cage : public GameObjectScript
{
public:
    go_panther_cage() : GameObjectScript("go_panther_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        if (player->GetQuestStatus(5151) == QUEST_STATUS_INCOMPLETE)
        {
            if (Creature* panther = go->FindNearestCreature(ENRAGED_PANTHER, 5, true))
            {
                panther->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                panther->SetReactState(REACT_AGGRESSIVE);
                panther->AI()->AttackStart(player);
            }
        }

        return true;
    }
};

class npc_enraged_panther : public CreatureScript
{
public:
    npc_enraged_panther() : CreatureScript("npc_enraged_panther") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_enraged_pantherAI(creature);
    }

    struct npc_enraged_pantherAI : public ScriptedAI
    {
        npc_enraged_pantherAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(uint32 /*diff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_thousand_needles()
{
    new npc_lakota_windsong();
    new npc_paoka_swiftmountain();
    new npc_plucky();
    new npc_enraged_panther();
    new go_panther_cage();
}
