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

#ifndef SCRIPT_OBJECT_GAME_EVENT_SCRIPT_H_
#define SCRIPT_OBJECT_GAME_EVENT_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum GameEventHook
{
    GAMEEVENTHOOK_ON_START,
    GAMEEVENTHOOK_ON_STOP,
    GAMEEVENTHOOK_ON_EVENT_CHECK,
    GAMEEVENTHOOK_END
};

class GameEventScript : public ScriptObject
{
protected:
    GameEventScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Runs on start event
    virtual void OnStart(uint16 /*EventID*/) { }

    // Runs on stop event
    virtual void OnStop(uint16 /*EventID*/) { }

    // Runs on event check
    virtual void OnEventCheck(uint16 /*EventID*/) { }
};

#endif
