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
#include "GameObject.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "MapMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Cell.h"
#include "Tokenize.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

using namespace Acore::ChatCommands;

struct PoolTemplateItem
{
    uint32 Entry;
    uint32 Chance;
};

// Represents one "spawn point" which might contain multiple GUIDs
struct NodeGroup
{
    float X, Y, Z;
    std::vector<std::pair<uint32, uint32>> FoundObjects;
};

struct PoolSession
{
    std::string ZoneName;
    std::vector<PoolTemplateItem> CurrentTemplate;
    std::vector<NodeGroup> CapturedGroups;
};

static std::map<ObjectGuid, PoolSession> sPoolSessions;

class pooltools_commandscript : public CommandScript
{
public:
    pooltools_commandscript() : CommandScript("pooltools_commandscript") {}

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable poolToolsCommandTable =
        {
            { "start",  HandlePoolStart,  SEC_ADMINISTRATOR, Console::No },
            { "def",    HandlePoolDef,    SEC_ADMINISTRATOR, Console::No },
            { "add",    HandlePoolAdd,    SEC_ADMINISTRATOR, Console::No },
            { "remove", HandlePoolRemove, SEC_ADMINISTRATOR, Console::No },
            { "end",    HandlePoolEnd,    SEC_ADMINISTRATOR, Console::No },
            { "clear",  HandlePoolClear,  SEC_ADMINISTRATOR, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "pooltools", poolToolsCommandTable }
        };
        return commandTable;
    }

    static bool HandlePoolStart(ChatHandler* handler, std::string description)
    {
        ObjectGuid playerGuid = handler->GetPlayer()->GetGUID();

        if (sPoolSessions.find(playerGuid) != sPoolSessions.end())
        {
            handler->SendErrorMessage("Session already active. Use .pooltools clear first.");
            return false;
        }

        PoolSession session;
        session.ZoneName = description;

        sPoolSessions[playerGuid] = session;

        handler->PSendSysMessage("|cff00ff00Pool Session Started.|r Description: {}", description);
        return true;
    }

    static bool HandlePoolDef(ChatHandler* handler, Tail args)
    {
        ObjectGuid playerGuid = handler->GetPlayer()->GetGUID();
        if (sPoolSessions.find(playerGuid) == sPoolSessions.end())
        {
            handler->SendErrorMessage("No active session.");
            return false;
        }

        std::vector<std::string_view> tokens = Acore::Tokenize(args, ' ', false);

        if (tokens.empty() || tokens.size() % 2 != 0)
        {
            handler->SendErrorMessage("Invalid syntax. Usage: .pooltools def [ID] [Chance] [ID] [Chance]...");
            return false;
        }

        std::vector<PoolTemplateItem> newTemplate;
        for (size_t i = 0; i < tokens.size(); i += 2)
        {
            uint32 entry = Acore::StringTo<uint32>(tokens[i]).value_or(0);
            uint32 chance = Acore::StringTo<uint32>(tokens[i + 1]).value_or(0);

            if (entry == 0) continue;
            newTemplate.push_back({ entry, chance });
        }

        sPoolSessions[playerGuid].CurrentTemplate = newTemplate;
        handler->PSendSysMessage("Template Defined ({} items).", newTemplate.size());
        return true;
    }

    static bool HandlePoolAdd(ChatHandler* handler, Optional<float> radiusArg)
    {
        ObjectGuid playerGuid = handler->GetPlayer()->GetGUID();
        if (sPoolSessions.find(playerGuid) == sPoolSessions.end()) return false;

        PoolSession& session = sPoolSessions[playerGuid];
        if (session.CurrentTemplate.empty())
        {
            handler->SendErrorMessage("Define a template first with .pooltools def");
            return false;
        }

        Player* player = handler->GetPlayer();
        float radius = radiusArg.value_or(5.0f);

        float searchX = player->GetPositionX();
        float searchY = player->GetPositionY();
        float searchZ = player->GetPositionZ();

        GameObject* target = handler->GetNearbyGameObject();
        if (radius <= 10.0f && target)
        {
            searchX = target->GetPositionX();
            searchY = target->GetPositionY();
            searchZ = target->GetPositionZ();
        }

        std::list<GameObject*> nearbyGOs;
        Acore::GameObjectInRangeCheck check(searchX, searchY, searchZ, radius);
        Acore::GameObjectListSearcher<Acore::GameObjectInRangeCheck> searcher(player, nearbyGOs, check);
        Cell::VisitObjects(player, searcher, radius);

        int addedCount = 0;
        int newGroupsCount = 0;

        for (GameObject* go : nearbyGOs)
        {
            if (go->GetDistance(searchX, searchY, searchZ) > radius)
                continue;

            bool isTemplateMatch = false;
            for (auto const& tpl : session.CurrentTemplate)
            {
                if (go->GetEntry() == tpl.Entry)
                {
                    isTemplateMatch = true;
                    break;
                }
            }
            if (!isTemplateMatch) continue;

            uint32 spawnId = go->GetSpawnId();

            bool alreadyCaptured = false;
            for (auto const& group : session.CapturedGroups)
            {
                for (auto const& obj : group.FoundObjects)
                {
                    if (obj.second == spawnId)
                    {
                        alreadyCaptured = true;
                        break;
                    }
                }
                if (alreadyCaptured) break;
            }
            if (alreadyCaptured) continue;

            // Clustering
            NodeGroup* existingGroup = nullptr;
            for (auto& group : session.CapturedGroups)
            {
                if (go->GetDistance(group.X, group.Y, group.Z) < 0.1f)
                {
                    existingGroup = &group;
                    break;
                }
            }

            if (existingGroup)
            {
                existingGroup->FoundObjects.push_back({ go->GetEntry(), spawnId });
                addedCount++;
            }
            else
            {
                NodeGroup newGroup;
                newGroup.X = go->GetPositionX();
                newGroup.Y = go->GetPositionY();
                newGroup.Z = go->GetPositionZ();
                newGroup.FoundObjects.push_back({ go->GetEntry(), spawnId });

                session.CapturedGroups.push_back(newGroup);
                newGroupsCount++;
                addedCount++;
            }
        }

        if (addedCount == 0)
        {
            handler->SendErrorMessage("No new matching objects found in {}y radius.", radius);
            return false;
        }

        handler->PSendSysMessage("|cff00ff00Scan Complete.|r Added {} objects into {} new groups.", addedCount, newGroupsCount);

        if (!session.CapturedGroups.empty())
        {
            NodeGroup& lastGroup = session.CapturedGroups.back();
            for (auto& p : lastGroup.FoundObjects)
            {
                handler->PSendSysMessage(" - Entry {} (GUID: {})", p.first, p.second);
            }
        }
        return true;
    }

    static bool HandlePoolRemove(ChatHandler* handler)
    {
        ObjectGuid playerGuid = handler->GetPlayer()->GetGUID();
        if (sPoolSessions.find(playerGuid) == sPoolSessions.end())
        {
            handler->SendErrorMessage("No active session.");
            return false;
        }

        PoolSession& session = sPoolSessions[playerGuid];

        if (session.CapturedGroups.empty())
        {
            handler->SendErrorMessage("No groups captured.");
            return false;
        }

        NodeGroup removed = session.CapturedGroups.back();
        session.CapturedGroups.pop_back();

        handler->PSendSysMessage("|cffff0000Undo Successful.|r Removed last group containing {} objects.", removed.FoundObjects.size());
        return true;
    }

    static bool HandlePoolEnd(ChatHandler* handler, std::string fileName)
    {
        ObjectGuid playerGuid = handler->GetPlayer()->GetGUID();
        auto it = sPoolSessions.find(playerGuid);
        if (it == sPoolSessions.end()) return false;

        PoolSession& session = it->second; // Use reference from iterator

        if (fileName.empty()) fileName = "pool.sql";
        if (fileName.find(".sql") == std::string::npos) fileName += ".sql";

        std::ofstream outfile;
        outfile.open(fileName, std::ios_base::app);

        if (!outfile.is_open())
        {
            handler->SendErrorMessage("Could not open file {}", fileName);
            return false;
        }

        auto EscapeSQL = [](std::string_view input) -> std::string {
            std::string safe;
            safe.reserve(input.size());
            for (char c : input) {
                if (c == '\'') safe += "\\'";
                else safe += c;
            }
            return safe;
            };

        bool complexPool = (session.CurrentTemplate.size() > 1);

        // SQL Variables and Header
        outfile << fmt::format("-- Pool Dump: {}\n", session.ZoneName);
        outfile << "SET @mother_pool := @mother_pool+1;\n";
        if (complexPool)
            outfile << "SET @pool_node := @pool_node+1;\n\n";
        outfile << fmt::format("SET @max_limit   := {};\n\n", (session.CapturedGroups.size() + 3) / 4);

        // DELETEs section
        if (!session.CapturedGroups.empty())
        {
            outfile << "-- Cleanup specific object links\n";
            outfile << "DELETE FROM `pool_gameobject` WHERE `guid` IN (";

            std::vector<std::string> guidList;
            for (auto const& group : session.CapturedGroups)
                for (auto const& obj : group.FoundObjects)
                    guidList.push_back(std::to_string(obj.second));

            outfile << fmt::format("{}", fmt::join(guidList, ", "));
            outfile << ");\n\n";
        }

        outfile << "DELETE FROM `pool_template` WHERE `entry`=@mother_pool;\n";
        outfile << fmt::format("INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@mother_pool, @max_limit, '{} - Mother Pool');\n", EscapeSQL(session.ZoneName));

        int groupCounter = 0;

        // We can buffer the simple bulk inserts here
        std::vector<std::string> bulkInserts;

        for (auto const& group : session.CapturedGroups)
        {
            groupCounter++;

            // Generate Description
            std::set<std::string> uniqueNames;
            for (auto const& obj : group.FoundObjects)
            {
                GameObjectTemplate const* goInfo = sObjectMgr->GetGameObjectTemplate(obj.first);
                uniqueNames.insert(goInfo ? goInfo->name : std::to_string(obj.first));
            }

            std::string groupDesc = fmt::format("{}", fmt::join(uniqueNames, " / "));
            std::string safeGroupDesc = EscapeSQL(groupDesc);

            // Simple pooling
            if (!complexPool)
            {
                for (auto const& obj : group.FoundObjects)
                {
                    float chance = 0.0f;
                    for (auto const& tpl : session.CurrentTemplate)
                        if (tpl.Entry == obj.first) chance = (float)tpl.Chance;

                    bulkInserts.push_back(fmt::format("({}, @mother_pool, {}, '{} - {}')",
                        obj.second, chance, EscapeSQL(session.ZoneName), safeGroupDesc));
                }
            }
            // Pool_pool integration
            else
            {
                outfile << fmt::format("-- Group {}\n", groupCounter);
                outfile << "SET @pool_node := @pool_node + 1;\n";

                // Create the Sub-Pool Node
                outfile << fmt::format("INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pool_node, 1, '{} - Node {}');\n",
                    EscapeSQL(session.ZoneName), groupCounter);

                // Link Node to Mother Pool
                outfile << fmt::format("INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES (@pool_node, @mother_pool, 0, '{} - {}');\n",
                    EscapeSQL(session.ZoneName), safeGroupDesc);

                // Link Objects to Sub-Pool Node
                outfile << "INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES\n";

                std::vector<std::string> nodeInserts;
                for (auto const& obj : group.FoundObjects)
                {
                    GameObjectTemplate const* goInfo = sObjectMgr->GetGameObjectTemplate(obj.first);
                    std::string objName = goInfo ? goInfo->name : "Unknown";

                    float chance = 0.0f;
                    for (auto const& tpl : session.CurrentTemplate)
                        if (tpl.Entry == obj.first) chance = (float)tpl.Chance;

                    nodeInserts.push_back(fmt::format("({}, @pool_node, {}, '{} - {}')",
                        obj.second, chance, EscapeSQL(session.ZoneName), EscapeSQL(objName)));
                }
                outfile << fmt::format("{};\n\n", fmt::join(nodeInserts, ",\n"));
            }
        }

        if (!complexPool && !bulkInserts.empty())
        {
            outfile << "INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES \n";
            outfile << fmt::format("{};\n", fmt::join(bulkInserts, ",\n"));
        }

        outfile.close();
        handler->PSendSysMessage("Dumped {} groups to {}", groupCounter, fileName);

        // Cleanup
        sPoolSessions.erase(it);
        return true;
    }

    static bool HandlePoolClear(ChatHandler* handler)
    {
        sPoolSessions.erase(handler->GetPlayer()->GetGUID());
        handler->PSendSysMessage("Session cleared.");
        return true;
    }
};

void AddSC_pooltools_commandscript()
{
    new pooltools_commandscript();
}
