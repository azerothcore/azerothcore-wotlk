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

#ifndef SCRIPT_OBJECT_ALL_COMMAND_SCRIPT_H_
#define SCRIPT_OBJECT_ALL_COMMAND_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum AllCommandHook
{
    ALLCOMMANDHOOK_ON_HANDLE_DEV_COMMAND,
    ALLCOMMANDHOOK_CAN_EXECUTE_COMMAND,
    ALLCOMMANDHOOK_END
};

class AllCommandScript : public ScriptObject
{
protected:
    AllCommandScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    virtual void OnHandleDevCommand(Player* /*player*/, bool& /*enable*/) { }

    /**
     * @brief This hook runs execute chat command
     *
     * @param handler Contains information about the ChatHandler
     * @param cmdStr Contains information about the command name
     */
    [[nodiscard]] virtual bool CanExecuteCommand(ChatHandler& /*handler*/, std::string_view /*cmdStr*/) { return true; }
};

// Compatibility for old scripts
using CommandSC = AllCommandScript;

#endif
