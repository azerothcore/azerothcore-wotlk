#pragma once

#include "../Action.h"

namespace BotAI
{
    class AddLootAction : public Action {
    public:
        AddLootAction(PlayerbotAI* ai) : Action(ai, "add loot") {}
        virtual bool Execute(Event event);
        virtual bool isUseful();
    };

    class AddAllLootAction : public Action {
    public:
        AddAllLootAction(PlayerbotAI* ai, string name = "add all loot") : Action(ai, name) {}
        virtual bool Execute(Event event);
        virtual bool isUseful();

    protected:
        virtual bool AddLoot(uint64 guid);
    };

    class AddGatheringLootAction : public AddAllLootAction {
    public:
        AddGatheringLootAction(PlayerbotAI* ai) : AddAllLootAction(ai, "add gathering loot") {}

    protected:
        virtual bool AddLoot(uint64 guid);
    };

}
