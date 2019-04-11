#pragma once

#include "../Action.h"

namespace BotAI
{
	class UseItemAction : public Action {
	public:
		UseItemAction(PlayerbotAI* ai, string name = "use", bool selfOnly = false) : Action(ai, name), selfOnly(selfOnly) {}

    public:
        virtual bool Execute(Event event);
        virtual bool isPossible();

    private:
        bool UseItemAuto(Item* item);
        bool UseItemOnGameObject(Item* item, uint64 go);
        bool UseItemOnItem(Item* item, Item* itemTarget);
        bool UseItem(Item* item, uint64 go, Item* itemTarget);
        bool UseGameObject(uint64 guid);
        bool SocketItem(Item* item, Item* gem, bool replace = false);

    private:
        bool selfOnly;
    };

    class UseSpellItemAction : public UseItemAction {
    public:
        UseSpellItemAction(PlayerbotAI* ai, string name, bool selfOnly = false) : UseItemAction(ai, name, selfOnly) {}

    public:
        virtual bool isUseful();
    };

    class UseHealingPotion : public UseItemAction {
    public:
        UseHealingPotion(PlayerbotAI* ai) : UseItemAction(ai, "healing potion") {}
        virtual bool isUseful() { return AI_VALUE2(bool, "combat", "self target"); }
    };

    class UseManaPotion : public UseItemAction
    {
    public:
        UseManaPotion(PlayerbotAI* ai) : UseItemAction(ai, "mana potion") {}
        virtual bool isUseful() { return AI_VALUE2(bool, "combat", "self target"); }
    };
}
