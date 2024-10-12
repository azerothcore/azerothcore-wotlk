/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _ARENATEAMFILTER_H
#define _ARENATEAMFILTER_H

#include "Common.h"
#include "ArenaTeamMgr.h"
#include "ArenaTeam.h"
#include <sstream>
#include <string>
#include <memory>
#include <unordered_map>
#include <algorithm>
#include <cctype>

class ArenaTeamFilter
{
public:
    virtual ~ArenaTeamFilter() = default;

    virtual ArenaTeamMgr::ArenaTeamContainer Filter(ArenaTeamMgr::ArenaTeamContainer teams) = 0;
};

class ArenaTeamFilterByTypes : public ArenaTeamFilter
{
public:
    ArenaTeamFilterByTypes(std::vector<uint8> validTypes) : _validTypes(validTypes) {}

    ArenaTeamMgr::ArenaTeamContainer Filter(ArenaTeamMgr::ArenaTeamContainer teams) override
    {
        ArenaTeamMgr::ArenaTeamContainer result;

        for (const auto& pair : teams)
        {
            ArenaTeam* team = pair.second;
            for (uint8 arenaType : _validTypes)
            {
                if (team->GetType() == arenaType)
                {
                    result[pair.first] = team;
                    break;
                }
            }
        }

        return result;
    }

private:
    std::vector<uint8> _validTypes;
};

class ArenaTeamFilterAllTeams : public ArenaTeamFilter
{
public:
    ArenaTeamMgr::ArenaTeamContainer Filter(ArenaTeamMgr::ArenaTeamContainer teams) override
    {
        return teams;
    }
};

class ArenaTeamFilterFabricByUserInput
{
public:
    std::unique_ptr<ArenaTeamFilter> CreateFilterByUserInput(std::string userInput)
    {
        std::transform(userInput.begin(), userInput.end(), userInput.begin(),
                       [](unsigned char c) { return std::tolower(c); });

        if (userInput == "all")
            return std::make_unique<ArenaTeamFilterAllTeams>();

        // Parse the input string (e.g., "2,3") into valid types
        std::vector<uint8> validTypes = ParseTypes(userInput);

        if (!validTypes.empty())
            return std::make_unique<ArenaTeamFilterByTypes>(validTypes);

        return nullptr;
    }

private:
    std::vector<uint8> ParseTypes(const std::string& userInput)
    {
        std::vector<uint8> validTypes;
        std::istringstream ss(userInput);
        std::string token;

        while (std::getline(ss, token, ','))
        {
            try
            {
                uint8 type = static_cast<uint8>(std::stoi(token)); // Convert token to integer
                validTypes.push_back(type);                        // Add to valid types vector
            }
            catch (const std::exception&)
            {
                // Ignore invalid tokens, could log or throw depending on requirements
            }
        }

        return validTypes;
    }
};

#endif // _ARENATEAMFILTER_H
