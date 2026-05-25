/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Chat.h"
#include "CommandScript.h"
#include "Creature.h"
#include "GameTime.h"
#include "GameObject.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PoolMgr.h"

using namespace Acore::ChatCommands;

class pool_commandscript : public CommandScript
{
public:
    pool_commandscript() : CommandScript("pool_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable poolCommandTable =
        {
            { "info",    HandlePoolInfoCommand,    SEC_GAMEMASTER, Console::Yes },
            { "lookup",  HandlePoolLookupCommand,  SEC_GAMEMASTER, Console::No  },
        };
        static ChatCommandTable commandTable =
        {
            { "pool", poolCommandTable }
        };
        return commandTable;
    }

private:
    static char const* StatusTag(bool active)
    {
        return active ? "ACTIVE" : "inactive";
    }

    static void ListPoolMembers(ChatHandler* handler, char const* typeName,
        std::vector<PoolObject> const& explicitly,
        std::vector<PoolObject> const& equal, bool isCreature)
    {
        if (explicitly.empty() && equal.empty())
            return;

        uint32 total = explicitly.size() + equal.size();
        handler->PSendSysMessage(LANG_POOL_INFO_MEMBERS_HEADER, typeName, total);

        auto printMember = [&](PoolObject const& obj)
        {
            bool spawned = isCreature
                ? sPoolMgr->IsSpawnedObject<Creature>(obj.guid)
                : sPoolMgr->IsSpawnedObject<GameObject>(obj.guid);

            std::string name = "Unknown";
            uint32 entry = 0;
            uint32 mapId = 0;
            float x = 0, y = 0, z = 0;

            if (isCreature)
            {
                if (CreatureData const* data = sObjectMgr->GetCreatureData(obj.guid))
                {
                    entry = data->id1;
                    mapId = data->mapid;
                    x = data->posX;
                    y = data->posY;
                    z = data->posZ;
                    if (CreatureTemplate const* tpl = sObjectMgr->GetCreatureTemplate(entry))
                        name = tpl->Name;
                }
            }
            else
            {
                if (GameObjectData const* data = sObjectMgr->GetGameObjectData(obj.guid))
                {
                    entry = data->id;
                    mapId = data->mapid;
                    x = data->posX;
                    y = data->posY;
                    z = data->posZ;
                    if (GameObjectTemplate const* tpl = sObjectMgr->GetGameObjectTemplate(entry))
                        name = tpl->name;
                }
            }

            handler->PSendSysMessage(LANG_POOL_INFO_MEMBER,
                StatusTag(spawned), obj.guid, name, entry, mapId, x, y, z);
        };

        for (auto const& obj : explicitly)
            printMember(obj);
        for (auto const& obj : equal)
            printMember(obj);
    }

    static bool HandlePoolInfoCommand(ChatHandler* handler, uint32 poolId)
    {
        PoolTemplateData const* tpl = sPoolMgr->GetPoolTemplate(poolId);
        if (!tpl)
        {
            handler->PSendSysMessage(LANG_POOL_NOT_FOUND, poolId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 activeCount = sPoolMgr->GetSpawnedData().GetActiveObjectCount(poolId);
        handler->PSendSysMessage(LANG_POOL_INFO_HEADER, poolId,
            tpl->Description.empty() ? "(none)" : tpl->Description,
            tpl->MaxLimit, activeCount);

        // Show parent pool if nested
        uint32 parentPool = sPoolMgr->IsPartOfAPool<Pool>(poolId);
        if (parentPool)
            handler->PSendSysMessage("  Parent pool: {}", parentPool);

        // Creature members
        if (PoolGroup<Creature> const* creGroup = sPoolMgr->GetPoolCreatureGroup(poolId))
        {
            if (!creGroup->IsEmpty())
                ListPoolMembers(handler, "Creatures",
                    creGroup->GetExplicitlyChanced(), creGroup->GetEqualChanced(), true);
        }

        // GameObject members
        if (PoolGroup<GameObject> const* goGroup = sPoolMgr->GetPoolGameObjectGroup(poolId))
        {
            if (!goGroup->IsEmpty())
                ListPoolMembers(handler, "GameObjects",
                    goGroup->GetExplicitlyChanced(), goGroup->GetEqualChanced(), false);
        }

        // Sub-pool members
        if (PoolGroup<Pool> const* poolGroup = sPoolMgr->GetPoolPoolGroup(poolId))
        {
            auto const& explicitly = poolGroup->GetExplicitlyChanced();
            auto const& equal = poolGroup->GetEqualChanced();
            if (!explicitly.empty() || !equal.empty())
            {
                uint32 total = explicitly.size() + equal.size();
                handler->PSendSysMessage(LANG_POOL_INFO_SUBPOOLS_HEADER, total);

                auto printSubPool = [&](PoolObject const& obj)
                {
                    bool active = sPoolMgr->GetSpawnedData().IsActiveObject<Pool>(obj.guid);
                    PoolTemplateData const* subTpl = sPoolMgr->GetPoolTemplate(obj.guid);
                    std::string desc = subTpl ? subTpl->Description : "Unknown";

                    handler->PSendSysMessage(LANG_POOL_INFO_SUBPOOL,
                        StatusTag(active), obj.guid, desc);
                };

                for (auto const& obj : explicitly)
                    printSubPool(obj);
                for (auto const& obj : equal)
                    printSubPool(obj);
            }
        }

        return true;
    }

    static bool HandlePoolLookupCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        // Check targeted creature
        Creature* target = handler->getSelectedCreature();
        if (target && target->GetSpawnId())
        {
            uint32 spawnId = target->GetSpawnId();
            uint32 poolId = sPoolMgr->GetCreaturePoolId(spawnId);
            if (poolId)
            {
                bool spawned = sPoolMgr->IsSpawnedObject<Creature>(spawnId);
                handler->PSendSysMessage(LANG_POOL_LOOKUP_IN_POOL,
                    target->GetName(), spawnId, poolId, StatusTag(spawned));
                handler->PSendSysMessage(LANG_POOL_LOOKUP_USE_INFO, poolId);
            }
            else
                handler->PSendSysMessage(LANG_POOL_LOOKUP_NOT_IN_POOL,
                    target->GetName(), spawnId);

            return true;
        }

        // Check nearby gameobject
        GameObject* goTarget = handler->GetNearbyGameObject();
        if (goTarget && goTarget->GetSpawnId())
        {
            uint32 spawnId = goTarget->GetSpawnId();
            uint32 poolId = sPoolMgr->GetGameObjectPoolId(spawnId);
            if (poolId)
            {
                bool spawned = sPoolMgr->IsSpawnedObject<GameObject>(spawnId);
                handler->PSendSysMessage(LANG_POOL_LOOKUP_IN_POOL,
                    goTarget->GetName(), spawnId, poolId, StatusTag(spawned));
                handler->PSendSysMessage(LANG_POOL_LOOKUP_USE_INFO, poolId);
            }
            else
                handler->PSendSysMessage(LANG_POOL_LOOKUP_NOT_IN_POOL,
                    goTarget->GetName(), spawnId);

            return true;
        }

        handler->SendSysMessage(LANG_POOL_LOOKUP_NOTARGET);
        handler->SetSentErrorMessage(true);
        return false;
    }
};

void AddSC_pool_commandscript()
{
    new pool_commandscript();
}
