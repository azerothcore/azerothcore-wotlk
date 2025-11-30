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

#ifndef _ARENATEAMFILTER_H
#define _ARENATEAMFILTER_H

#include "Common.h"
#include "ArenaTeamMgr.h"
#include "ArenaTeam.h"
#include "Tokenize.h"
#include "StringConvert.h"
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

        for (auto const& pair : teams)
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

class ArenaTeamFilterFactoryByUserInput
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
    std::vector<uint8> ParseTypes(std::string_view userInput)
    {
        std::vector<uint8> validTypes;
        auto tokens = Acore::Tokenize(userInput, ',', false);

        for (auto const& token : tokens)
            if (auto typeOpt = Acore::StringTo<uint8>(token))
                validTypes.push_back(*typeOpt);

        return validTypes;
    }
};

#endif // _ARENATEAMFILTER_H
