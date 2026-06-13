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

#ifndef _WORLDMODELSTORE_H
#define _WORLDMODELSTORE_H

#include "WorldModel.h"
#include <memory>
#include <mutex>
#include <unordered_map>

class WorldModelStore
{
public:
    static WorldModelStore* instance()
    {
        static WorldModelStore instance;
        return &instance;
    }

    std::shared_ptr<VMAP::WorldModel> AcquireModelInstance(std::string const& basepath, std::string const& filename, uint32 flags);

private:
    typedef std::unordered_map<std::string, std::shared_ptr<VMAP::WorldModel>> ModelFileMap;
    ModelFileMap _loadedModels;

    std::mutex _lock;
};

#define sWorldModelStore WorldModelStore::instance()

#endif
