/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"

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

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_SHATTERED_SALUTE)
        {
            CAST_AI(npc_shenthul::npc_shenthulAI, creature->AI())->CanTalk = true;
            CAST_AI(npc_shenthul::npc_shenthulAI, creature->AI())->PlayerGUID = player->GetGUID();
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
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
        uint64 PlayerGUID;

        void Reset()
        {
            CanTalk = false;
            CanEmote = false;
            SaluteTimer = 6000;
            ResetTimer = 0;
            PlayerGUID = 0;
        }

        void EnterCombat(Unit* /*who*/) { }

        void UpdateAI(uint32 diff)
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
                } else ResetTimer -= diff;
            }

            if (CanTalk && !CanEmote)
            {
                if (SaluteTimer <= diff)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    CanEmote = true;
                    ResetTimer = 60000;
                } else SaluteTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void ReceiveEmote(Player* player, uint32 emote)
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
    QUEST_6566              = 6566,

    SPELL_CHAIN_LIGHTNING   = 16033,
    SPELL_SHOCK             = 16034
};

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
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                SendGossipMenuFor(player, 5733, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
                SendGossipMenuFor(player, 5734, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                SendGossipMenuFor(player, 5735, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                SendGossipMenuFor(player, 5736, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
                SendGossipMenuFor(player, 5737, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_STW6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7);
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
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_HTW, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
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

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (ChainLightningTimer <= diff)
            {
                DoCastVictim(SPELL_CHAIN_LIGHTNING);
                ChainLightningTimer = 9000;
            } else ChainLightningTimer -= diff;

            if (ShockTimer <= diff)
            {
                DoCastVictim(SPELL_SHOCK);
                ShockTimer = 15000;
            } else ShockTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_orgrimmar()
{
    new npc_shenthul();
    new npc_thrall_warchief();
}
