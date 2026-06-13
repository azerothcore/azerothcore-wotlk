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

#ifndef SCRIPT_OBJECT_CONDITION_SCRIPT_H_
#define SCRIPT_OBJECT_CONDITION_SCRIPT_H_

#include "ScriptObject.h"

class ConditionScript : public ScriptObject
{
protected:
    ConditionScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a single condition is checked for a player.
    [[nodiscard]] virtual bool OnConditionCheck(Condition* /*condition*/, ConditionSourceInfo& /*sourceInfo*/) { return true; }
};

#endif
