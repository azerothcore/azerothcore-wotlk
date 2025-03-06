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

#include "Config.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "ServerAutoShutdown.h"
#include "TaskScheduler.h"

class ServerAutoShutdown_World : public WorldScript
{
public:
    ServerAutoShutdown_World() : WorldScript("ServerAutoShutdown_World", {
        WORLDHOOK_ON_UPDATE,
        WORLDHOOK_ON_AFTER_CONFIG_LOAD,
        WORLDHOOK_ON_STARTUP
    }) { }

    void OnUpdate(uint32 diff) override
    {
        sSAS->OnUpdate(diff);
    }

    void OnAfterConfigLoad(bool reload) override
    {
        if (reload)
            sSAS->Init();
    }

    void OnStartup() override
    {
        sSAS->Init();
    }
};

// Group all custom scripts
void AddSC_ServerAutoShutdown()
{
    new ServerAutoShutdown_World();
}
