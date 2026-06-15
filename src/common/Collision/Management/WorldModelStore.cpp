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

#include "Log.h"
#include "WorldModelStore.h"

std::shared_ptr<VMAP::WorldModel> WorldModelStore::AcquireModelInstance(std::string const& basepath, std::string const& filename, uint32 flags/* Only used when creating the model */)
{
    //! Critical section, thread safe access
    std::lock_guard<std::mutex> lock(_lock);

    ModelFileMap::iterator model = _loadedModels.find(filename);
    if (model == _loadedModels.end())
    {
        std::shared_ptr<VMAP::WorldModel> worldmodel = std::make_shared<VMAP::WorldModel>();
        LOG_DEBUG("maps", "WorldModelStore: loading file '{}{}'", basepath, filename);
        if (!worldmodel->readFile(basepath + filename + ".vmo"))
        {
            LOG_ERROR("maps", "WorldModelStore: could not load '{}{}.vmo'", basepath, filename);
            return nullptr;
        }

        worldmodel->Flags = flags;

        model = _loadedModels.insert(std::pair<std::string, std::shared_ptr<VMAP::WorldModel>>(filename, worldmodel)).first;
    }

    return model->second;
}
