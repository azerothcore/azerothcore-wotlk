/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

 //#include "ScriptMgr.h"
 //#include "Player.h"
 //#include "Config.h"
 //#include "Chat.h"
 //
 // // Add player scripts
 //class AddItemEx : public PlayerScript
 //{
 //public:
 //    AddItemEx() : PlayerScript("AddItemEx") { }
 //
 //    void OnLogin(Player* player) override
 //    {
 //        ChatHandler(player->GetSession()).SendSysMessage("注入了！");
 //    }
 //};
 //
 //// Add all scripts in one
 //void AddAddItemExScripts()
 //{
 //    new AddItemEx();
 //}


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
#include "AccountMgr.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "GameGraveyard.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "GuildMgr.h"
#include "IPLocation.h"
#include "InstanceSaveMgr.h"
#include "LFG.h"
#include "Language.h"
#include "MapMgr.h"
#include "MiscPackets.h"
#include "MovementGenerator.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "Realm.h"
#include "SpellAuras.h"
#include "TargetedMovementGenerator.h"
#include "Tokenize.h"
#include "WeatherMgr.h"

class MoveItem : public CommandScript
{
public:
    MoveItem() : CommandScript("MoveItem") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> commandTable =
        {
            { "moveitem",               SEC_ADMINISTRATOR,       true, &HandleMoveItemCommand, ""  }
        };

        return commandTable;
    }

    //          Handle + "Something" + Command
    static bool HandleMoveItemCommand(ChatHandler* handler, std::string targetPlayerName, std::string sourcePlayerName, int32 count)
    {
        Player* pl = ObjectAccessor::FindPlayerByName(sourcePlayerName, false);

        if (!pl)
        {
            handler->SendSysMessage("角色未登录");
            return true;
        }

        HandleAddItemCommand(handler, 51809, pl, pl, count);
        //Player* player = handler->GetSession()->GetPlayer();
        //ChatHandler(player->GetSession()).SendSysMessage("1111!");
        handler->SendSysMessage("move");
        return true;
    }

private :
    static bool HandleAddItemCommand(ChatHandler* handler, uint32 itemId, Player* player, Player* playerTarget,int32 count)
    {
        if (!sObjectMgr->GetItemTemplate(itemId))
        {
            handler->PSendSysMessage(LANG_COMMAND_ITEMIDINVALID, itemId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        /*int32 count = 1;

        if (_count)
        {
            count = *_count;
        }

        if (!count)
        {
            count = 1;
        }*/

        //Player* player = handler->GetSession()->GetPlayer();
        //Player* playerTarget = handler->getSelectedPlayer();

        //if (!playerTarget)
        //{
        //    playerTarget = player;
        //}

        // Subtract
        if (count < 0)
        {
            // Only have scam check on player accounts
            if (playerTarget->GetSession()->GetSecurity() == SEC_PLAYER)
            {
                if (!playerTarget->HasItemCount(itemId, 0))
                {
                    // output that player don't have any items to destroy
                    handler->PSendSysMessage(LANG_REMOVEITEM_FAILURE, handler->GetNameLink(playerTarget).c_str(), itemId);
                    handler->SetSentErrorMessage(true);
                    return false;
                }

                if (!playerTarget->HasItemCount(itemId, -count))
                {
                    // output that player don't have as many items that you want to destroy
                    handler->PSendSysMessage(LANG_REMOVEITEM_ERROR, handler->GetNameLink(playerTarget).c_str(), itemId);
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }

            // output successful amount of destroyed items
            playerTarget->DestroyItemCount(itemId, -count, true, false);
            handler->PSendSysMessage(LANG_REMOVEITEM, itemId, -count, handler->GetNameLink(playerTarget).c_str());
            return true;
        }

        // Adding items
        uint32 noSpaceForCount = 0;

        // check space and find places
        ItemPosCountVec dest;
        InventoryResult msg = playerTarget->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, count, &noSpaceForCount);

        if (msg != EQUIP_ERR_OK) // convert to possible store amount
        {
            count -= noSpaceForCount;
        }

        if (!count || dest.empty()) // can't add any
        {
            handler->PSendSysMessage(LANG_ITEM_CANNOT_CREATE, itemId, noSpaceForCount);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Item* item = playerTarget->StoreNewItem(dest, itemId, true);

        // remove binding (let GM give it to another player later)
        if (player == playerTarget)
        {
            for (auto const& itemPos : dest)
            {
                if (Item* item1 = player->GetItemByPos(itemPos.pos))
                {
                    item1->SetBinding(false);
                }
            }
        }

        if (count && item)
        {
            player->SendNewItem(item, count, false, true);

            if (player != playerTarget)
            {
                playerTarget->SendNewItem(item, count, true, false);
            }
        }

        if (noSpaceForCount)
        {
            handler->PSendSysMessage(LANG_ITEM_CANNOT_CREATE, itemId, noSpaceForCount);
        }

        return true;
    }


};

void AddMoveItemScripts()
{
    new MoveItem();
}
