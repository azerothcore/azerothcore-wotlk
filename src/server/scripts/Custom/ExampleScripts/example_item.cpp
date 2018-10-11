/*
    MIT License

    Copyright (c) 2018 José González

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
 */

#include "ScriptMgr.h"
//#include "ScriptPCH.h"   <- You could use the Precompiled Headers too!

//    item_ + "something"
class item_example : public ItemScript
{
public:
    item_example() : ItemScript("item_example"){}

    // Triggers when the item executes the spell assigned to it
    // If you don't want a spell executed, assign the "Dummy Spell" (ID: 18282)
    bool OnUse(Player * player, Item * item, SpellCastTargets const& targets) override
    {
        player->GetSession()->SendNotification("|CFF7BBEF7[Loot Especial]|r:Item Example was used!");

        return true;
    }

    // Triggers when the player accepts the quest assigned to the item
    bool OnQuestAccept(Player* player, Item* item, Quest const* quest) override
    {
        return true;
    }

    // Triggers when the item expires, just before destroying it
    bool OnExpire(Player* /*player*/, ItemTemplate const* /*proto*/) override
    {
        return true;
    }

    // Triggers when the player selects an option from the gossip menu assigned to the item
    void OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action) override
    {
        return;
    }

    // Same as before, but this time the option has a code assigned
    void OnGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code) override
    {
        return;
    }
};

void AddSC_item_example()
{
    new item_example();
}
