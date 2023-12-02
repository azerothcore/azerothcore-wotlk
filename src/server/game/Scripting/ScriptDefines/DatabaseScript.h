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

#ifndef SCRIPT_OBJECT_DATABASE_SCRIPT_H_
#define SCRIPT_OBJECT_DATABASE_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

class DatabaseScript : public ScriptObject
{
protected:

    DatabaseScript(const char* name);

public:

    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    /**
     * @brief Called after all databases are loaded
     *
     * @param updateFlags Update flags from the loader
     */
    virtual void OnAfterDatabasesLoaded(uint32 /*updateFlags*/) { }

    /**
     * @brief Called after all creature template data has been loaded from the database. This hook could be called multiple times, not just at server startup.
     *
     * @param creatureTemplates Pointer to a modifiable vector of creature templates. Indexed by Entry ID.
     */
    virtual void OnAfterDatabaseLoadCreatureTemplates(std::vector<CreatureTemplate*> /*creatureTemplates*/) { }

};

#endif
