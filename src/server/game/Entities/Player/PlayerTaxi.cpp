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

#include "ObjectMgr.h"
#include "Player.h"
#include "Tokenize.h"
#include "StringConvert.h"

PlayerTaxi::PlayerTaxi() : _taxiSegment(0)
{
    memset(m_taximask, 0, sizeof(m_taximask));
}

void PlayerTaxi::InitTaxiNodesForLevel(uint32 race, uint32 chrClass, uint8 level)
{
    // class specific initial known nodes
    switch (chrClass)
    {
        case CLASS_DEATH_KNIGHT:
        {
            for (uint8 i = 0; i < TaxiMaskSize; ++i)
                m_taximask[i] |= sOldContinentsNodesMask[i];
            break;
        }
    }

    // race specific initial known nodes: capital and taxi hub masks
    switch (race)
    {
        case RACE_HUMAN:
            SetTaximaskNode(2);
            break;     // Human
        case RACE_ORC:
            SetTaximaskNode(23);
            break;     // Orc
        case RACE_DWARF:
            SetTaximaskNode(6);
            break;     // Dwarf
        case RACE_NIGHTELF:
            SetTaximaskNode(26);
            SetTaximaskNode(27);
            break;     // Night Elf
        case RACE_UNDEAD_PLAYER:
            SetTaximaskNode(11);
            break;// Undead
        case RACE_TAUREN:
            SetTaximaskNode(22);
            break;     // Tauren
        case RACE_GNOME:
            SetTaximaskNode(6);
            break;     // Gnome
        case RACE_TROLL:
            SetTaximaskNode(23);
            break;     // Troll
        case RACE_BLOODELF:
            SetTaximaskNode(82);
            break;     // Blood Elf
        case RACE_DRAENEI:
            SetTaximaskNode(94);
            break;     // Draenei
    }

    // new continent starting masks (It will be accessible only at new map)
    switch (Player::TeamIdForRace(race))
    {
        case TEAM_ALLIANCE:
            SetTaximaskNode(100);
            break;
        case TEAM_HORDE:
            SetTaximaskNode(99);
            break;
        default:
            break;
    }
    // level dependent taxi hubs
    if (level >= 68)
        SetTaximaskNode(213);                               //Shattered Sun Staging Area
}

bool PlayerTaxi::LoadTaxiMask(std::string_view data)
{
    bool warn = false;
    std::vector<std::string_view> tokens = Acore::Tokenize(data, ' ', false);

    for (uint8 index = 0; (index < TaxiMaskSize) && (index < tokens.size()); ++index)
    {
        if (Optional<uint32> mask = Acore::StringTo<uint32>(tokens[index]))
        {
            // load and set bits only for existing taxi nodes
            m_taximask[index] = sTaxiNodesMask[index] & *mask;

            if (m_taximask[index] != *mask)
            {
                warn = true;
            }
        }
        else
        {
            m_taximask[index] = 0;
            warn = true;
        }
    }

    return !warn;
}

void PlayerTaxi::AppendTaximaskTo(ByteBuffer& data, bool all)
{
    if (all)
    {
        for (uint8 i = 0; i < TaxiMaskSize; i++)
            data << uint32(sTaxiNodesMask[i]);              // all existed nodes
    }
    else
    {
        for (uint8 i = 0; i < TaxiMaskSize; i++)
            data << uint32(m_taximask[i]);                  // known nodes
    }
}

bool PlayerTaxi::LoadTaxiDestinationsFromString(const std::string& values, TeamId teamId)
{
    ClearTaxiDestinations();

    for (auto const& itr : Acore::Tokenize(values, ' ', false))
    {
        if (Optional<uint32> node = Acore::StringTo<uint32>(itr))
        {
            AddTaxiDestination(*node);
        }
        else
        {
            return false;
        }
    }

    // Check integrity
    if (m_TaxiDestinations.size() < 3)
        return false;

    // xinef: current segment is saved as last destination in db
    _taxiSegment = m_TaxiDestinations[m_TaxiDestinations.size() - 1];
    m_TaxiDestinations.pop_back();

    for (size_t i = 0; i < m_TaxiDestinations.size() - 1; ++i)
    {
        uint32 cost;
        uint32 path;
        sObjectMgr->GetTaxiPath(m_TaxiDestinations[i], m_TaxiDestinations[i + 1], path, cost);
        if (!path)
            return false;
    }

    // can't load taxi path without mount set (quest taxi path?)
    if (!sObjectMgr->GetTaxiMountDisplayId(GetTaxiSource(), teamId, true))
        return false;

    return true;
}

std::string PlayerTaxi::SaveTaxiDestinationsToString()
{
    if (m_TaxiDestinations.empty())
        return "";

    std::ostringstream ss;

    for (size_t i = 0; i < m_TaxiDestinations.size(); ++i)
        ss << m_TaxiDestinations[i] << ' ';

    ss << _taxiSegment << ' ';
    return ss.str();
}

uint32 PlayerTaxi::GetCurrentTaxiPath() const
{
    if (m_TaxiDestinations.size() < 2 || m_TaxiDestinations.size() <= _taxiSegment + 1)
        return 0;

    uint32 path;
    uint32 cost;

    sObjectMgr->GetTaxiPath(m_TaxiDestinations[_taxiSegment], m_TaxiDestinations[_taxiSegment + 1], path, cost);

    return path;
}

std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi)
{
    for (uint8 i = 0; i < TaxiMaskSize; ++i)
        ss << taxi.m_taximask[i] << ' ';
    return ss;
}
