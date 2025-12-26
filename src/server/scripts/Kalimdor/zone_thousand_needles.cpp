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
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

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

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_FREE_AT_LAST)
        {
            creature->AI()->Talk(SAY_LAKO_START, player);
            creature->SetFaction(FACTION_ESCORTEE_H_NEUTRAL_ACTIVE); //guessed

            if (npc_lakota_windsongAI* pEscortAI = CAST_AI(npc_lakota_windsong::npc_lakota_windsongAI, creature->AI()))
            {
                creature->SetWalk(true);
                pEscortAI->Start(false, player->GetGUID(), quest);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lakota_windsongAI(creature);
    }

    struct npc_lakota_windsongAI : public npc_escortAI
    {
        npc_lakota_windsongAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override { }

        void WaypointReached(uint32 waypointId) override
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
                    Talk(SAY_LAKO_END);
                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_FREE_AT_LAST, me);
                    break;
            }
        }

        void DoSpawnBandits(int AmbushId)
        {
            for (int i = 0; i < 2; ++i)
                me->SummonCreature(NPC_GRIM_BANDIT, BanditLoc[i + AmbushId], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
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
    NPC_WYVERN          = 4107
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

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_HOMEWARD)
        {
            creature->AI()->Talk(SAY_START, player);
            creature->SetFaction(FACTION_ESCORTEE_H_NEUTRAL_ACTIVE); // guessed

            if (npc_paoka_swiftmountainAI* pEscortAI = CAST_AI(npc_paoka_swiftmountain::npc_paoka_swiftmountainAI, creature->AI()))
            {
                creature->SetWalk(true);
                pEscortAI->Start(false, player->GetGUID(), quest);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_paoka_swiftmountainAI(creature);
    }

    struct npc_paoka_swiftmountainAI : public npc_escortAI
    {
        npc_paoka_swiftmountainAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override { }

        void WaypointReached(uint32 waypointId) override
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
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_P, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, 738, creature->GetGUID());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pluckyAI(creature);
    }

    struct npc_pluckyAI : public ScriptedAI
    {
        npc_pluckyAI(Creature* creature) : ScriptedAI(creature) { NormFaction = creature->GetFaction(); }

        uint32 NormFaction;
        uint32 ResetTimer;

        void Reset() override
        {
            ResetTimer = 120000;

            if (me->GetFaction() != NormFaction)
                me->SetFaction(NormFaction);

            if (me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            DoCast(me, SPELL_PLUCKY_CHICKEN, false);
        }

        void ReceiveEmote(Player* player, uint32 TextEmote) override
        {
            if (player->GetQuestStatus(QUEST_SCOOP) == QUEST_STATUS_INCOMPLETE)
            {
                if (TextEmote == TEXT_EMOTE_BECKON)
                {
                    me->SetFaction(FACTION_FRIENDLY);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    DoCast(me, SPELL_PLUCKY_HUMAN, false);
                }
            }

            if (TextEmote == TEXT_EMOTE_CHICKEN)
            {
                if (me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                    return;
                else
                {
                    me->SetFaction(FACTION_FRIENDLY);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    DoCast(me, SPELL_PLUCKY_HUMAN, false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                }
            }
        }

        void UpdateAI(uint32 Diff) override
        {
            if (me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            {
                if (ResetTimer <= Diff)
                {
                    if (!me->GetVictim())
                        EnterEvadeMode();
                    else
                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

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
    NPC_ENRAGED_PANTHER        = 10992,
    QUEST_HYPERCAPACITOR_GIZMO = 5151
};

class spell_panther_cage_key : public SpellScript
{
    PrepareSpellScript(spell_panther_cage_key);

    void HandleDummy()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (player->GetQuestStatus(QUEST_HYPERCAPACITOR_GIZMO) == QUEST_STATUS_INCOMPLETE)
            {
                if (Creature* panther = player->FindNearestCreature(NPC_ENRAGED_PANTHER, 5.0f, true))
                {
                    panther->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    panther->SetReactState(REACT_AGGRESSIVE);
                    panther->AI()->AttackStart(GetCaster());
                }
            }
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_panther_cage_key::HandleDummy);
    }
};

void AddSC_thousand_needles()
{
    new npc_lakota_windsong();
    new npc_paoka_swiftmountain();
    new npc_plucky();
    RegisterSpellScript(spell_panther_cage_key);
}
