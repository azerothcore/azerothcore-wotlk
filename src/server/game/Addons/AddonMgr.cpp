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

#include "AddonMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Timer.h"
#include <list>
#include <openssl/md5.h>

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations" // In current OpenSSL 3.x MD5 is still a thing, so we use this to pass mac CI.
#endif

namespace AddonMgr
{
    // Anonymous namespace ensures file scope of all the stuff inside it, even
    // if you add something more to this namespace somewhere else.
    namespace
    {
        // List of saved addons (in DB).
        typedef std::list<SavedAddon> SavedAddonsList;

        SavedAddonsList m_knownAddons;
        BannedAddonList m_bannedAddons;
    }

    void LoadFromDB()
    {
        uint32 oldMSTime = getMSTime();

        QueryResult result = CharacterDatabase.Query("SELECT name, crc FROM addons");
        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 known addons. DB table `addons` is empty!");
            LOG_INFO("server.loading", " ");
            return;
        }

        uint32 count = 0;

        do
        {
            Field* fields = result->Fetch();

            std::string name = fields[0].Get<std::string>();
            uint32 crc = fields[1].Get<uint32>();

            m_knownAddons.push_back(SavedAddon(name, crc));

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} known addons in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");

        oldMSTime = getMSTime();
        result = CharacterDatabase.Query("SELECT id, name, version, UNIX_TIMESTAMP(timestamp) FROM banned_addons");
        if (result)
        {
            uint32 count2 = 0;
            uint32 offset = 102;

            do
            {
                Field* fields = result->Fetch();

                BannedAddon addon{};
                addon.Id = fields[0].Get<uint32>() + offset;
                addon.Timestamp = uint32(fields[3].Get<uint64>());

                std::string name = fields[1].Get<std::string>();
                std::string version = fields[2].Get<std::string>();

                MD5(reinterpret_cast<uint8 const*>(name.c_str()), name.length(), addon.NameMD5);
                MD5(reinterpret_cast<uint8 const*>(version.c_str()), version.length(), addon.VersionMD5);

                m_bannedAddons.push_back(addon);

                ++count2;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} banned addons in {} ms", count2, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    void SaveAddon(AddonInfo const& addon)
    {
        std::string name = addon.Name;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ADDON);

        stmt->SetData(0, name);
        stmt->SetData(1, addon.CRC);

        CharacterDatabase.Execute(stmt);

        m_knownAddons.push_back(SavedAddon(addon.Name, addon.CRC));
    }

    SavedAddon const* GetAddonInfo(const std::string& name)
    {
        for (auto const& addon : m_knownAddons)
        {
            if (addon.Name == name)
            {
                return &addon;
            }
        }

        return nullptr;
    }

    BannedAddonList const* GetBannedAddons()
    {
        return &m_bannedAddons;
    }

} // Namespace
