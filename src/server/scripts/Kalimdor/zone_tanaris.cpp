/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Tanaris
SD%Complete: 80
SDComment: Quest support: 1560, 2954, 4005, 10277, 10279(Special flight path). Noggenfogger vendor
SDCategory: Tanaris
EndScriptData */

/* ContentData
npc_aquementas
npc_custodian_of_time
npc_steward_of_time
npc_stone_watcher_of_norgannon
npc_tooga
EndContentData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "ScriptedGossip.h"

/*######
## npc_aquementas
######*/

enum Aquementas
{
    AGGRO_YELL_AQUE     = 0,

    SPELL_AQUA_JET      = 13586,
    SPELL_FROST_SHOCK   = 15089
};

class npc_aquementas : public CreatureScript
{
public:
    npc_aquementas() : CreatureScript("npc_aquementas") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_aquementasAI(creature);
    }

    struct npc_aquementasAI : public ScriptedAI
    {
        npc_aquementasAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 SendItemTimer;
        uint32 SwitchFactionTimer;
        bool isFriendly;

        uint32 FrostShockTimer;
        uint32 AquaJetTimer;

        void Reset() override
        {
            SendItemTimer = 0;
            SwitchFactionTimer = 10000;
            me->SetFaction(FACTION_FRIENDLY);
            isFriendly = true;

            AquaJetTimer = 5000;
            FrostShockTimer = 1000;
        }

        void SendItem(Unit* receiver)
        {
            Player* player = receiver->ToPlayer();

            if (player && player->HasItemCount(11169, 1, false) &&
                    player->HasItemCount(11172, 11, false) &&
                    player->HasItemCount(11173, 1, false) &&
                    !player->HasItemCount(11522, 1, true))
            {
                ItemPosCountVec dest;
                uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 11522, 1, nullptr);
                if (msg == EQUIP_ERR_OK)
                    player->StoreNewItem(dest, 11522, true);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(AGGRO_YELL_AQUE, who);
        }

        void UpdateAI(uint32 diff) override
        {
            if (isFriendly)
            {
                if (SwitchFactionTimer <= diff)
                {
                    me->SetFaction(FACTION_ELEMENTAL);
                    isFriendly = false;
                }
                else SwitchFactionTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (!isFriendly)
            {
                if (SendItemTimer <= diff)
                {
                    if (me->GetVictim()->IsPlayer())
                        SendItem(me->GetVictim());
                    SendItemTimer = 5000;
                }
                else SendItemTimer -= diff;
            }

            if (FrostShockTimer <= diff)
            {
                DoCastVictim(SPELL_FROST_SHOCK);
                FrostShockTimer = 15000;
            }
            else FrostShockTimer -= diff;

            if (AquaJetTimer <= diff)
            {
                DoCast(me, SPELL_AQUA_JET);
                AquaJetTimer = 15000;
            }
            else AquaJetTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_custodian_of_time
######*/

enum CustodianOfTime
{
    WHISPER_CUSTODIAN_1     = 0,
    WHISPER_CUSTODIAN_2     = 1,
    WHISPER_CUSTODIAN_3     = 2,
    WHISPER_CUSTODIAN_4     = 3,
    WHISPER_CUSTODIAN_5     = 4,
    WHISPER_CUSTODIAN_6     = 5,
    WHISPER_CUSTODIAN_7     = 6,
    WHISPER_CUSTODIAN_8     = 7,
    WHISPER_CUSTODIAN_9     = 8,
    WHISPER_CUSTODIAN_10    = 9,
    WHISPER_CUSTODIAN_11    = 10,
    WHISPER_CUSTODIAN_12    = 11,
    WHISPER_CUSTODIAN_13    = 12,
    WHISPER_CUSTODIAN_14    = 13
};

class npc_custodian_of_time : public CreatureScript
{
public:
    npc_custodian_of_time() : CreatureScript("npc_custodian_of_time") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_custodian_of_timeAI(creature);
    }

    struct npc_custodian_of_timeAI : public npc_escortAI
    {
        npc_custodian_of_timeAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) override
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                    case 0:
                        Talk(WHISPER_CUSTODIAN_1, player);
                        break;
                    case 1:
                        Talk(WHISPER_CUSTODIAN_2, player);
                        break;
                    case 2:
                        Talk(WHISPER_CUSTODIAN_3, player);
                        break;
                    case 3:
                        Talk(WHISPER_CUSTODIAN_4, player);
                        break;
                    case 5:
                        Talk(WHISPER_CUSTODIAN_5, player);
                        break;
                    case 6:
                        Talk(WHISPER_CUSTODIAN_6, player);
                        break;
                    case 7:
                        Talk(WHISPER_CUSTODIAN_7, player);
                        break;
                    case 8:
                        Talk(WHISPER_CUSTODIAN_8, player);
                        break;
                    case 9:
                        Talk(WHISPER_CUSTODIAN_9, player);
                        break;
                    case 10:
                        Talk(WHISPER_CUSTODIAN_4, player);
                        break;
                    case 13:
                        Talk(WHISPER_CUSTODIAN_10, player);
                        break;
                    case 14:
                        Talk(WHISPER_CUSTODIAN_4, player);
                        break;
                    case 16:
                        Talk(WHISPER_CUSTODIAN_11, player);
                        break;
                    case 17:
                        Talk(WHISPER_CUSTODIAN_12, player);
                        break;
                    case 18:
                        Talk(WHISPER_CUSTODIAN_4, player);
                        break;
                    case 22:
                        Talk(WHISPER_CUSTODIAN_13, player);
                        break;
                    case 23:
                        Talk(WHISPER_CUSTODIAN_4, player);
                        break;
                    case 24:
                        Talk(WHISPER_CUSTODIAN_14, player);
                        if (Group* group = player->GetGroup())
                        {
                            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                            {
                                Player* player = itr->GetSource();

                                // for any leave or dead (with not released body) group member at appropriate distance
                                if (player && player->IsAtGroupRewardDistance(me) && !player->GetCorpse())
                                    DoCast(player, 34883); // QID 10277

                            }
                        }
                        else
                        {
                            DoCast(player, 34883); // QID 10277
                        }
                        break;
                }
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (Player* player = who->ToPlayer())
            {
                if (who->HasAura(34877) && player->GetQuestStatus(10277) == QUEST_STATUS_INCOMPLETE)
                {
                    float Radius = 10.0f;
                    if (me->IsWithinDistInMap(who, Radius))
                    {
                        Start(false, false, who->GetGUID());
                    }
                }
            }
        }

        void JustEngagedWith(Unit* /*who*/) override { }
        void Reset() override { }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);
        }
    };
};

/*######
## npc_steward_of_time
######*/

class npc_steward_of_time : public CreatureScript
{
public:
    npc_steward_of_time() : CreatureScript("npc_steward_of_time") { }

    bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* quest) override
    {
        if (quest->GetQuestId() == 10279)                      //Quest: To The Master's Lair
            player->CastSpell(player, 34891, true);               //(Flight through Caverns)

        return false;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
            player->CastSpell(player, 34891, true);               //(Flight through Caverns)

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        if (player->GetQuestStatus(10279) == QUEST_STATUS_INCOMPLETE || player->GetQuestRewardStatus(10279))
        {
            AddGossipItemFor(player, 8072, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            SendGossipMenuFor(player, 9978, creature->GetGUID());
        }
        else
        {
            SendGossipMenuFor(player, 9977, creature->GetGUID());
        }

        return true;
    }
};

/*######
## npc_stone_watcher_of_norgannon
######*/

class npc_stone_watcher_of_norgannon : public CreatureScript
{
public:
    npc_stone_watcher_of_norgannon() : CreatureScript("npc_stone_watcher_of_norgannon") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                AddGossipItemFor(player, 57001, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, 1675, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, 57002, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, 1676, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, 57003, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                SendGossipMenuFor(player, 1677, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                AddGossipItemFor(player, 57004, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, 1678, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                AddGossipItemFor(player, 57005, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, 1679, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                CloseGossipMenuFor(player);
                player->AreaExploredOrEventHappens(2954);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        if (player->GetQuestStatus(2954) == QUEST_STATUS_INCOMPLETE)
        {
            AddGossipItemFor(player, 57000, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        }

        SendGossipMenuFor(player, 1674, creature->GetGUID());

        return true;
    }
};

/*####
# npc_tooga
####*/

enum Tooga
{
    SAY_TOOG_WORRIED            = 0,
    SAY_TOOG_POST_1             = 1,
    SAY_TORT_POST_2             = 0,
    SAY_TOOG_POST_3             = 2,
    SAY_TORT_POST_4             = 1,
    SAY_TOOG_POST_5             = 3,
    SAY_TORT_POST_6             = 2,

    QUEST_TOOGA                 = 1560,
    NPC_TORTA                   = 6015,

    POINT_ID_TO_WATER           = 1,
    FACTION_TOOG_ESCORTEE       = 113
};

Position const ToWaterLoc = {-7032.664551f, -4906.199219f, -1.606446f, 0.0f};

class npc_tooga : public CreatureScript
{
public:
    npc_tooga() : CreatureScript("npc_tooga") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_TOOGA)
        {
            if (npc_toogaAI* pToogaAI = CAST_AI(npc_tooga::npc_toogaAI, creature->AI()))
                pToogaAI->StartFollow(player, FACTION_TOOG_ESCORTEE, quest);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_toogaAI(creature);
    }

    struct npc_toogaAI : public FollowerAI
    {
        npc_toogaAI(Creature* creature) : FollowerAI(creature) { }

        uint32 CheckSpeechTimer;
        uint32 PostEventTimer;
        uint32 PhasePostEvent;

        ObjectGuid TortaGUID;

        void Reset() override
        {
            CheckSpeechTimer = 2500;
            PostEventTimer = 1000;
            PhasePostEvent = 0;

            TortaGUID.Clear();
        }

        void MoveInLineOfSight(Unit* who) override

        {
            FollowerAI::MoveInLineOfSight(who);

            if (!me->GetVictim() && !HasFollowState(STATE_FOLLOW_COMPLETE | STATE_FOLLOW_POSTEVENT) && who->GetEntry() == NPC_TORTA)
            {
                if (me->IsWithinDistInMap(who, INTERACTION_DISTANCE))
                {
                    Player* player = GetLeaderForFollower();
                    if (player && player->GetQuestStatus(QUEST_TOOGA) == QUEST_STATUS_INCOMPLETE)
                        player->GroupEventHappens(QUEST_TOOGA, me);

                    TortaGUID = who->GetGUID();
                    SetFollowComplete(true);
                }
            }
        }

        void MovementInform(uint32 MotionType, uint32 PointId) override
        {
            FollowerAI::MovementInform(MotionType, PointId);

            if (MotionType != POINT_MOTION_TYPE)
                return;

            if (PointId == POINT_ID_TO_WATER)
                SetFollowComplete();
        }

        void UpdateFollowerAI(uint32 Diff) override
        {
            if (!UpdateVictim())
            {
                //we are doing the post-event, or...
                if (HasFollowState(STATE_FOLLOW_POSTEVENT))
                {
                    if (PostEventTimer <= Diff)
                    {
                        PostEventTimer = 5000;

                        Creature* torta = ObjectAccessor::GetCreature(*me, TortaGUID);
                        if (!torta || !torta->IsAlive())
                        {
                            //something happened, so just complete
                            SetFollowComplete();
                            return;
                        }

                        switch (PhasePostEvent)
                        {
                            case 1:
                                Talk(SAY_TOOG_POST_1);
                                break;
                            case 2:
                                torta->AI()->Talk(SAY_TORT_POST_2);
                                break;
                            case 3:
                                Talk(SAY_TOOG_POST_3);
                                break;
                            case 4:
                                torta->AI()->Talk(SAY_TORT_POST_4);
                                break;
                            case 5:
                                Talk(SAY_TOOG_POST_5);
                                break;
                            case 6:
                                torta->AI()->Talk(SAY_TORT_POST_6);
                                me->GetMotionMaster()->MovePoint(POINT_ID_TO_WATER, ToWaterLoc);
                                break;
                        }

                        ++PhasePostEvent;
                    }
                    else
                        PostEventTimer -= Diff;
                }
                //...we are doing regular speech check
                else if (HasFollowState(STATE_FOLLOW_INPROGRESS))
                {
                    if (CheckSpeechTimer <= Diff)
                    {
                        CheckSpeechTimer = 5000;

                        if (urand(0, 9) > 8)
                            Talk(SAY_TOOG_WORRIED);
                    }
                    else
                        CheckSpeechTimer -= Diff;
                }

                return;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_tanaris()
{
    new npc_aquementas();
    new npc_custodian_of_time();
    new npc_steward_of_time();
    new npc_stone_watcher_of_norgannon();
    new npc_tooga();
}
