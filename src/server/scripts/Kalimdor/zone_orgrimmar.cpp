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
SDName: Orgrimmar
SD%Complete: 100
SDComment: Quest support: 2460, 6566
SDCategory: Orgrimmar
EndScriptData */

/* ContentData
npc_shenthul
npc_thrall_warchief
EndContentData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "TaskScheduler.h"

/*######
## npc_shenthul
######*/

enum Shenthul : uint32
{
    QUEST_SHATTERED_SALUTE  = 2460
};

class npc_shenthul : public CreatureScript
{
public:
    npc_shenthul() : CreatureScript("npc_shenthul") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_SHATTERED_SALUTE)
        {
            CAST_AI(npc_shenthul::npc_shenthulAI, creature->AI())->CanTalk = true;
            CAST_AI(npc_shenthul::npc_shenthulAI, creature->AI())->PlayerGUID = player->GetGUID();
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_shenthulAI(creature);
    }

    struct npc_shenthulAI : public ScriptedAI
    {
        npc_shenthulAI(Creature* creature) : ScriptedAI(creature) { }

        bool CanTalk;
        bool CanEmote;
        uint32 SaluteTimer;
        uint32 ResetTimer;
        ObjectGuid PlayerGUID;

        void Reset() override
        {
            CanTalk = false;
            CanEmote = false;
            SaluteTimer = 6000;
            ResetTimer = 0;
            PlayerGUID.Clear();
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            if (CanEmote)
            {
                if (ResetTimer <= diff)
                {
                    if (Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID))
                    {
                        if (player->GetTypeId() == TYPEID_PLAYER && player->GetQuestStatus(QUEST_SHATTERED_SALUTE) == QUEST_STATUS_INCOMPLETE)
                            player->FailQuest(QUEST_SHATTERED_SALUTE);
                    }
                    Reset();
                }
                else ResetTimer -= diff;
            }

            if (CanTalk && !CanEmote)
            {
                if (SaluteTimer <= diff)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    CanEmote = true;
                    ResetTimer = 60000;
                }
                else SaluteTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void ReceiveEmote(Player* player, uint32 emote) override
        {
            if (emote == TEXT_EMOTE_SALUTE && player->GetQuestStatus(QUEST_SHATTERED_SALUTE) == QUEST_STATUS_INCOMPLETE)
            {
                if (CanEmote)
                {
                    player->AreaExploredOrEventHappens(QUEST_SHATTERED_SALUTE);
                    Reset();
                }
            }
        }
    };
};

/*######
## npc_thrall_warchief
######*/

enum ThrallWarchief : uint32
{
    SPELL_CHAIN_LIGHTNING          = 16033,
    SPELL_SHOCK                    = 16034,

    // For The Horde! (ID: 4974)
    QUEST_FOR_THE_HORDE            = 4974,
    SPELL_WARCHIEF_BLESSING        = 16609,
    NPC_HERALD_OF_THRALL           = 10719,
    ACTION_START_TALKING           = 0,

    SAY_THRALL_ON_QUEST_REWARD_0   = 0,
    SAY_THRALL_ON_QUEST_REWARD_1   = 1,

    AREA_ORGRIMMAR                 = 1637,
    AREA_RAZOR_HILL                = 362,
    AREA_CAMP_TAURAJO              = 378,
    AREA_CROSSROADS                = 380,

    // What the Wind Carries (ID: 6566)
    QUEST_WHAT_THE_WIND_CARRIES     = 6566,
    GOSSIP_MENU_THRALL              = 3664,
    GOSSIP_RESPONSE_THRALL_FIRST    = 5733,
};

const Position heraldOfThrallPos = { -462.404f, -2637.68f, 96.0656f, 5.8606f };

/// @todo verify abilities/timers
class npc_thrall_warchief : public CreatureScript
{
public:
    npc_thrall_warchief() : CreatureScript("npc_thrall_warchief") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        uint32 DiscussionOrder = action - GOSSIP_ACTION_INFO_DEF;

        if (DiscussionOrder>= 1 && DiscussionOrder <= 6)
        {
            uint32 NextAction = GOSSIP_ACTION_INFO_DEF + DiscussionOrder + 1;
            uint32 GossipResponse = GOSSIP_RESPONSE_THRALL_FIRST + DiscussionOrder - 1;

            AddGossipItemFor(player, GOSSIP_MENU_THRALL + DiscussionOrder, 0, GOSSIP_SENDER_MAIN, NextAction);
            SendGossipMenuFor(player, GossipResponse, creature->GetGUID());
        }
        else if (DiscussionOrder == 7)
        {
            CloseGossipMenuFor(player);
            player->AreaExploredOrEventHappens(QUEST_WHAT_THE_WIND_CARRIES);
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        if (player->GetQuestStatus(QUEST_WHAT_THE_WIND_CARRIES) == QUEST_STATUS_INCOMPLETE)
        {
            AddGossipItemFor(player, GOSSIP_MENU_THRALL, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnQuestReward(Player* /*player*/, Creature* creature, Quest const* quest, uint32 /*item*/) override
    {
        if (quest->GetQuestId() == QUEST_FOR_THE_HORDE)
        {
            if (creature && creature->AI())
            {
                creature->AI()->DoAction(ACTION_START_TALKING);
            }
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_thrall_warchiefAI(creature);
    }

    struct npc_thrall_warchiefAI : public ScriptedAI
    {
        npc_thrall_warchiefAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 ChainLightningTimer;
        uint32 ShockTimer;

        void Reset() override
        {
            ChainLightningTimer = 2000;
            ShockTimer = 8000;
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_TALKING)
            {
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->GetMap()->LoadGrid(heraldOfThrallPos.GetPositionX(), heraldOfThrallPos.GetPositionY());
                me->SummonCreature(NPC_HERALD_OF_THRALL, heraldOfThrallPos, TEMPSUMMON_TIMED_DESPAWN, 20 * IN_MILLISECONDS);
                me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                scheduler.Schedule(2s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_THRALL_ON_QUEST_REWARD_0);
                }).Schedule(9s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_THRALL_ON_QUEST_REWARD_1);
                    DoCastAOE(SPELL_WARCHIEF_BLESSING, true);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    me->GetMap()->DoForAllPlayers([&](Player* player)
                    {
                        if (player->IsAlive() && !player->IsGameMaster())
                        {
                            if (player->GetAreaId() == AREA_ORGRIMMAR)
                            {
                                player->CastSpell(player, SPELL_WARCHIEF_BLESSING, true);
                            }
                        }
                    });
                }).Schedule(19s, [this](TaskContext /*context*/)
                {
                    me->GetMap()->DoForAllPlayers([&](Player* player)
                    {
                        if (player->IsAlive() && !player->IsGameMaster())
                        {
                            if (player->GetAreaId() == AREA_CROSSROADS)
                            {
                                player->CastSpell(player, SPELL_WARCHIEF_BLESSING, true);
                            }
                        }
                    });
                });
            }
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);

            if (!UpdateVictim())
                return;

            if (ChainLightningTimer <= diff)
            {
                DoCastVictim(SPELL_CHAIN_LIGHTNING);
                ChainLightningTimer = 9000;
            }
            else ChainLightningTimer -= diff;

            if (ShockTimer <= diff)
            {
                DoCastVictim(SPELL_SHOCK);
                ShockTimer = 15000;
            }
            else ShockTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_orgrimmar()
{
    new npc_shenthul();
    new npc_thrall_warchief();
}
