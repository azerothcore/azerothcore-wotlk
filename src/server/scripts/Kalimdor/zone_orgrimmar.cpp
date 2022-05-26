/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "TaskScheduler.h"

/*######
## npc_shenthul
######*/

enum Shenthul
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

        void EnterCombat(Unit* /*who*/) override { }

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

enum ThrallWarchief
{
    QUEST_6566                     = 6566,

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
    AREA_CROSSROADS                = 380
};

const Position heraldOfThrallPos = { -462.404f, -2637.68f, 96.0656f, 5.8606f };

#define GOSSIP_HTW "Please share your wisdom with me, Warchief."
#define GOSSIP_STW1 "What discoveries?"
#define GOSSIP_STW2 "Usurper?"
#define GOSSIP_STW3 "With all due respect, Warchief - why not allow them to be destroyed? Does this not strengthen our position?"
#define GOSSIP_STW4 "I... I did not think of it that way, Warchief."
#define GOSSIP_STW5 "I live only to serve, Warchief! My life is empty and meaningless without your guidance."
#define GOSSIP_STW6 "Of course, Warchief!"

/// @todo verify abilities/timers
class npc_thrall_warchief : public CreatureScript
{
public:
    npc_thrall_warchief() : CreatureScript("npc_thrall_warchief") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, 5733, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                SendGossipMenuFor(player, 5734, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, 5735, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, 5736, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, 5737, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                SendGossipMenuFor(player, 5738, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                CloseGossipMenuFor(player);
                player->AreaExploredOrEventHappens(QUEST_6566);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_6566) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_HTW, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

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

        void EnterCombat(Unit* /*who*/) override { }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_TALKING)
            {
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->GetMap()->LoadGrid(heraldOfThrallPos.GetPositionX(), heraldOfThrallPos.GetPositionY());
                me->SummonCreature(NPC_HERALD_OF_THRALL, heraldOfThrallPos, TEMPSUMMON_TIMED_DESPAWN, 20 * IN_MILLISECONDS);
                _scheduler.Schedule(2s, [this](TaskContext /*context*/)
                    {
                        Talk(SAY_THRALL_ON_QUEST_REWARD_0);
                    })
                .Schedule(13s, [this](TaskContext /*context*/)
                    {
                        Talk(SAY_THRALL_ON_QUEST_REWARD_1);
                    })
                .Schedule(15s, [this](TaskContext /*context*/)
                    {
                        DoCastAOE(SPELL_WARCHIEF_BLESSING, true);
                        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        me->GetMap()->DoForAllPlayers([&](Player* p)
                            {
                                if (p->IsAlive() && !p->IsGameMaster())
                                {
                                    if (p->GetAreaId() == AREA_ORGRIMMAR || p->GetAreaId() == AREA_RAZOR_HILL || p->GetAreaId() == AREA_CROSSROADS || p->GetAreaId() == AREA_CAMP_TAURAJO)
                                    {
                                        p->CastSpell(p, SPELL_WARCHIEF_BLESSING, true);
                                    }
                                }
                            });
                    });
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _scheduler.Update(diff);

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

        protected:
            TaskScheduler _scheduler;
    };
};

void AddSC_orgrimmar()
{
    new npc_shenthul();
    new npc_thrall_warchief();
}
