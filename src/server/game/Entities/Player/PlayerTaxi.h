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

#ifndef __PLAYER_TAXI_H__
#define __PLAYER_TAXI_H__

#include "DBCStructure.h"
#include <vector>

class ByteBuffer;

class AC_GAME_API PlayerTaxi
{
public:
    PlayerTaxi();
    ~PlayerTaxi() = default;

    // Nodes
    void InitTaxiNodesForLevel(uint32 race, uint32 chrClass, uint8 level);
    bool LoadTaxiMask(std::string_view data);

    [[nodiscard]] bool IsTaximaskNodeKnown(uint32 nodeidx) const
    {
        uint8  field   = uint8((nodeidx - 1) / 32);
        uint32 submask = 1 << ((nodeidx - 1) % 32);
        return (m_taximask[field] & submask) == submask;
    }

    bool SetTaximaskNode(uint32 nodeidx)
    {
        uint8  field   = uint8((nodeidx - 1) / 32);
        uint32 submask = 1 << ((nodeidx - 1) % 32);
        if ((m_taximask[field] & submask) != submask)
        {
            m_taximask[field] |= submask;
            return true;
        }
        else
            return false;
    }

    void AppendTaximaskTo(ByteBuffer& data, bool all);

    // Destinations
    bool LoadTaxiDestinationsFromString(std::string const& values, TeamId teamId);
    std::string SaveTaxiDestinationsToString();

    void ClearTaxiDestinations() { m_TaxiDestinations.clear(); _taxiSegment = 0; }
    void AddTaxiDestination(uint32 dest) { m_TaxiDestinations.push_back(dest); }
    [[nodiscard]] uint32 GetTaxiSource() const { return m_TaxiDestinations.size() <= _taxiSegment + 1 ? 0 : m_TaxiDestinations[_taxiSegment]; }
    [[nodiscard]] uint32 GetTaxiDestination() const { return m_TaxiDestinations.size() <= _taxiSegment + 1 ? 0 : m_TaxiDestinations[_taxiSegment + 1]; }
    [[nodiscard]] uint32 GetCurrentTaxiPath() const;
    uint32 NextTaxiDestination()
    {
        ++_taxiSegment;
        return GetTaxiDestination();
    }

    // xinef:
    void SetTaxiSegment(uint32 segment) { _taxiSegment = segment; }
    [[nodiscard]] uint32 GetTaxiSegment() const { return _taxiSegment; }

    [[nodiscard]] std::vector<uint32> const& GetPath() const { return m_TaxiDestinations; }
    [[nodiscard]] bool empty() const { return m_TaxiDestinations.empty(); }

    friend std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi);
private:
    TaxiMask m_taximask;
    std::vector<uint32> m_TaxiDestinations;
    uint32 _taxiSegment;
};

#endif
