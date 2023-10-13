/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "ScriptedAI/ScriptedCreature.h"
#include "GossipDef.h"
#include "ScriptedGossip.h"
#include "MapMgr.h"
#include "Chat.h"
#include "ScriptMgr.h"

struct KeystoneRangeCheck : public BasicEvent
{
    KeystoneRangeCheck(Player* player, GameObject* go) : guid(go->GetGUID()), player(player)
    {
        ASSERT(player->mythicStartCheck == nullptr, "Only one KeystoneRangeCheck should be active at one time");
        player->mythicStartCheck = this;
        player->m_Events.AddEvent(this, player->m_Events.CalculateTime(500));
    }

    bool Execute(uint64, uint32) override
    {
        GameObject const* go = ObjectAccessor::GetGameObject(*player, guid);
        if (go && go->IsWithinDistInMap(player, go->GetCombatReach() + 5.0f))
        {
            player->m_Events.AddEvent(this, player->m_Events.CalculateTime(500));
            return false;
        }
        
        player->mythicStartCheck = nullptr;
        player->SendForgeUIMsg(ForgeTopic::MYTHIC_OPEN_WINDOW, "0");
        return true;
    }

    ObjectGuid guid;
    Player* player;
    uint32 lastNotSavedAlert = 0;
};

class go_mythic_init : public GameObjectScript
{
public:
    go_mythic_init() : GameObjectScript("go_mythic_init") {}

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        WorldSession* session = player->GetSession();
        auto map = go->GetMap()->GetId();
        auto keyMap = sObjectMgr->GetDungeonKeyMap();

        if (auto item = keyMap[map]) {
            if (player->HasItemCount(item->itemId)) {
                if (!player->mythicStartCheck)
                    new KeystoneRangeCheck(player, go);

                auto difficulty = -(player->GetItemByEntry(item->itemId)->GetItemRandomPropertyId() + 100);
                player->SendForgeUIMsg(ForgeTopic::MYTHIC_OPEN_WINDOW, std::to_string(difficulty) + ";" + go->GetMap()->GetMapName());
                return true;
            }
        }
        return true;
    }
};

void AddSC_ForgedInstance()
{
    new go_mythic_init();
}
