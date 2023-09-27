#include "Transmogrification.h"
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "Creature.h"
#include "DBCStores.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "Item.h"
#include "ItemTemplate.h"
#include "Language.h"
#include "Log.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SpellInfo.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>

std::array<uint32, 2> ENCHANT_SLOTS = {
    EQUIPMENT_SLOT_MAINHAND,
    EQUIPMENT_SLOT_OFFHAND,
};

struct TransmogrifierRangeCheck : public BasicEvent
{
    TransmogrifierRangeCheck(Player* player, Creature* creature) : guid(creature->GetGUID()), player(player)
    {
        ASSERT(player->pendingTransmogCheck == nullptr, "Only one PendingTransmogCheck should be active at one time");
        player->pendingTransmogCheck = this;
        player->m_Events.AddEvent(this, player->m_Events.CalculateTime(500));
    }

    bool Execute(uint64, uint32) override
    {
        Creature const* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*player, guid);
        if (creature && creature->IsWithinDistInMap(player, creature->GetCombatReach() + 4.0f + 50.0f))
        {
            player->m_Events.AddEvent(this, player->m_Events.CalculateTime(500));
            return false;
        }
        
        player->pendingTransmogCheck = nullptr;
        player->SendForgeUIMsg(ForgeTopic::LOAD_XMOG, "0");
        return true;
    }

    ObjectGuid guid;
    Player* player;
    uint32 lastNotSavedAlert = 0;
};

class npc_transmogrifier : public CreatureScript
{
public:
    npc_transmogrifier() : CreatureScript("npc_transmogrifier") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        WorldSession* session = player->GetSession();
        if (!player->pendingTransmogCheck)
            new TransmogrifierRangeCheck(player, creature);

        player->SendForgeUIMsg(ForgeTopic::LOAD_XMOG, "1");
        return true;
    }
};

void AddSC_Transmogrification()
{
    new npc_transmogrifier();
}
