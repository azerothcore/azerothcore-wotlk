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

#ifndef SCRIPT_OBJECT_SESSION_SCRIPT_H_
#define SCRIPT_OBJECT_SESSION_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum SessionHook
{
    SESSIONHOOK_ON_UPDATE,
    SESSIONHOOK_END
};

class SessionScript : public ScriptObject
{
protected:
    SessionScript(char const* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    /**
     * @brief This hook is called once per world tick for every session, from the world thread,
     * right before the session processes its logout and warden checks.
     *
     * @param session Contains information about the WorldSession
     * @param diff Contains information about the diff time
     */
    virtual void OnSessionUpdate(WorldSession* /*session*/, uint32 /*diff*/) { }
};

#endif
