#include "ObjectAccessor.h"
#include "ScriptObject.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include <array>
#include <ctime>
#include <cstring>
#include "zeppelin.h"

// TODO: Move to const ,header
std::map<ZeppelinEntry, ZeppelinLocation> ZeppelinLocationStore = {
    {GROMGOL_ORGRIMMAR, LOCATION_UNKNOWN},
    // {GROMGOL_UNDERCITY, LOCATION_UNKNOWN}, // fix init state
    // {ORGRIMMAR_UNDERCITY, LOCATION_UNKNOWN}, // fix init state
};

// 175080 The Iron Eagle (ORG - STV)
struct go_zeppelin_transport : GameObjectAI
{
    go_zeppelin_transport(GameObject *object) : GameObjectAI(object) { };

    void OnStateChanged(uint32 state, Unit* /*unit*/) override
    {
        // no hook exists for stopping, event for arriving in org is early
        // EventInform arrival is early for org, DBC hack required or hook
        if (state == GO_STATE_READY) // stop frame
            me->PlayRadiusSound(SOUND_ZEPPELIN_HORN, 45.0f);
    }

    void EventInform(uint32 eventId) override
    {
        ZeppelinEvent event = static_cast<ZeppelinEvent>(eventId);
        ZeppelinEntry zeppelinEntry = static_cast<ZeppelinEntry>(me->GetEntry());
        // Update location
        {
            auto itr = EVENT_TO_LOCATION_MAP.find(event);
            if (itr == EVENT_TO_LOCATION_MAP.end()) return;
            ZeppelinLocationStore[zeppelinEntry] = itr->second;
        }

        // Arrival
        {
            auto itr = EVENT_TO_MASTER_MAP.find(event);
            if (itr != EVENT_TO_MASTER_MAP.end())
            {
                ZeppelinMaster entry = itr->second;
                if (Creature* creature = me->FindNearestCreature(entry, 100.0f)) // range TC
                {
                    creature->AI()->Talk(0);
                }
            }
        }
        // Deperature
    }

// void UpdateAI(uint32 const diff) override
// {
//     _scheduler.Update(diff);
// }
// protected:
// TaskScheduler _scheduler;
};

// Zeppelin masters are only distinguished by their associated zeppelin and location, so we can define a superclass for them.
class npc_zeppelin_master : public CreatureScript
{
public:
    npc_zeppelin_master(const char* name_subclass, ZeppelinEntry entry, ZeppelinLocation location, uint32 gossipMenuID, uint32 gossipMenuItemID) : CreatureScript(name_subclass)
    {
        _entry = entry;
        _location = location;
        _gossipMenuID = gossipMenuID;
        _gossipMenuItemID = gossipMenuItemID;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ZeppelinLocation zeppelinLocation = ZeppelinLocationStore[_entry];
        if (zeppelinLocation != _location)
            AddGossipItemFor(player, _gossipMenuID, 0, GOSSIP_SENDER_INFO, GOSSIP_ACTION_INFO_DEF);
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        ZeppelinLocation zeppelinLocation = ZeppelinLocationStore[_entry];
        auto itr = STATION_MAP.find(std::make_pair(_entry, zeppelinLocation));
        if (itr == STATION_MAP.end()) return false;
        ZeppelinStation station = itr->second;
        uint32 npcTextID;
        switch (zeppelinLocation)
        {
            case LOCATION_ARRIVED_FIRST:
                npcTextID = GOSSIP_MAP.at(std::make_pair(station, ARRIVED));
            case LOCATION_ARRIVED_SECOND:
                npcTextID = GOSSIP_MAP.at(std::make_pair(station, ARRIVED));
            case LOCATION_DEPARTED_FIRST:
                npcTextID = GOSSIP_MAP.at(std::make_pair(station, DEPARTED));
            case LOCATION_DEPARTED_SECOND:
                npcTextID = GOSSIP_MAP.at(std::make_pair(station, DEPARTED));
            default: // LOCATION_UNKNOWN
                npcTextID = GOSSIP_UNKNOWN;
        }
        SendGossipMenuFor(player, npcTextID, creature->GetGUID());
        return true;
    }

private:
    ZeppelinEntry _entry;
    ZeppelinLocation _location;
    uint32 _gossipMenuID;
    uint32 _gossipMenuItemID;
};

// class ZeppelinMaster : public CreatureScript
// {
// public:
//     ZeppelinMaster(const char* name_subclass, Zeppelin* zeppelin, ZeppelinLocation npcLocation) : CreatureScript(name_subclass)
//     {
//         this->zeppelin = zeppelin;
//         this->npcLocation = npcLocation;
//     };

//     struct ZeppelinMasterAI : public ScriptedAI
//     {
//         ZeppelinMasterAI(Creature* creature) : ScriptedAI(creature) { }

//         bool GossipHello(Player* player) override
//         {
//             if (getZeppelinLocation(zeppelin) != npcLocation)
//                 AddGossipItemFor(player, GOSSIP_WHERE_IS_THE_ZEPPELIN, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
//             SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
//             return true;
//         }

//         bool GossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
//         {
//             uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
//             player->PlayerTalkClass->ClearMenus();
//             SendGossipMenuFor(player, getGossipEntry(zeppelin), me->GetGUID());
//             return true;
//         }
//     protected:
//         Zeppelin* zeppelin;
//         ZeppelinLocation npcLocation;
//     };

//     CreatureAI* GetAI(Creature* creature) const override
//     {
//         return new ZeppelinMasterAI(creature);
//     }

// protected:
//     Zeppelin* zeppelin;
//     ZeppelinLocation npcLocation;
// };


void AddSC_zeppelin_scripts()
{
    RegisterGameObjectAI(go_zeppelin_transport);
    new npc_zeppelin_master("npc_nez_raz", GROMGOL_ORGRIMMAR, NPC_LOCATION_FIRST, 2441, 0);
    new npc_zeppelin_master("npc_snurk_bucksquick", GROMGOL_ORGRIMMAR, NPC_LOCATION_SECOND);
}
