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

#ifndef __WORLDGLOBALS_H
#define __WORLDGLOBALS_H

#include "Common.h"
#include "Opcodes.h"

struct AntiDosOpcodePolicy
{
    uint8 Policy;
    uint16 MaxAllowedCount;
};

class WorldGlobals
{
public:
    static WorldGlobals* instance();

    void LoadAntiDosOpcodePolicies();
    AntiDosOpcodePolicy const* GetAntiDosPolicyForOpcode(uint16 opcode);

private:
    std::array<std::unique_ptr<AntiDosOpcodePolicy>, NUM_OPCODE_HANDLERS> _antiDosOpcodePolicies;
};

#define sWorldGlobals WorldGlobals::instance()

#endif
