/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef ITEMTEMPLATEMETHODS_H
#define ITEMTEMPLATEMETHODS_H

#include "Chat.h"

namespace LuaItemTemplate
{
    /**
     * Returns the [ItemTemplate]'s ID.
     *
     * @return uint32 itemId
     */
    int GetItemId(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->ItemId);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s class.
     *
     * @return uint32 class
     */
    int GetClass(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->Class);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s subclass.
     *
     * @return uint32 subClass
     */
    int GetSubClass(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->SubClass);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s name.
     *
     * @return string name
     */
    int GetName(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->Name1);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s display ID.
     *
     * @return uint32 displayId
     */
    int GetDisplayId(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->DisplayInfoID);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s quality.
     *
     * @return uint32 quality
     */
    int GetQuality(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->Quality);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s flags.
     *
     * @return uint32 flags
     */
    int GetFlags(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->Flags);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s extra flags.
     *
     * @return uint32 flags
     */
    int GetExtraFlags(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->Flags2);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s default purchase count.
     *
     * @return uint32 buyCount
     */
    int GetBuyCount(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->BuyCount);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s purchase price.
     *
     * @return int32 buyPrice
     */
    int GetBuyPrice(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->BuyPrice);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s sell price.
     *
     * @return uint32 sellPrice
     */
    int GetSellPrice(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->SellPrice);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s inventory type.
     *
     * @return uint32 inventoryType
     */
    int GetInventoryType(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->InventoryType);
        return 1;
    }

    /**
     * Returns the [Player] classes allowed to use this [ItemTemplate].
     *
     * @return uint32 allowableClass
     */
    int GetAllowableClass(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->AllowableClass);
        return 1;
    }

    /**
     * Returns the [Player] races allowed to use this [ItemTemplate].
     *
     * @return uint32 allowableRace
     */
    int GetAllowableRace(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->AllowableRace);
        return 1;
    }

    /**
     * Returns the [ItemTemplate]'s item level.
     *
     * @return uint32 itemLevel
     */
    int GetItemLevel(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->ItemLevel);
        return 1;
    }

    /**
     * Returns the minimum level required to use this [ItemTemplate].
     *
     * @return uint32 requiredLevel
     */
    int GetRequiredLevel(lua_State* L, ItemTemplate* itemTemplate)
    {
        Eluna::Push(L, itemTemplate->RequiredLevel);
        return 1;
    }
}

#endif
