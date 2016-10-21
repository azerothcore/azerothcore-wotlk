/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AddonMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Timer.h"

#include <list>

namespace AddonMgr
{

// Anonymous namespace ensures file scope of all the stuff inside it, even
// if you add something more to this namespace somewhere else.
namespace
{
    // List of saved addons (in DB).
    typedef std::list<SavedAddon> SavedAddonsList;

    SavedAddonsList m_knownAddons;
}

void LoadFromDB()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = CharacterDatabase.Query("SELECT name, crc FROM addons");
    if (!result)
    {
        sLog->outString(">> Loaded 0 known addons. DB table `addons` is empty!");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        std::string name = fields[0].GetString();
        uint32 crc = fields[1].GetUInt32();

        m_knownAddons.push_back(SavedAddon(name, crc));

        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u known addons in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SaveAddon(AddonInfo const& addon)
{
    std::string name = addon.Name;

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ADDON);

    stmt->setString(0, name);
    stmt->setUInt32(1, addon.CRC);

    CharacterDatabase.Execute(stmt);

    m_knownAddons.push_back(SavedAddon(addon.Name, addon.CRC));
}

SavedAddon const* GetAddonInfo(const std::string& name)
{
    for (SavedAddonsList::const_iterator it = m_knownAddons.begin(); it != m_knownAddons.end(); ++it)
    {
        SavedAddon const& addon = (*it);
        if (addon.Name == name)
            return &addon;
    }

    return NULL;
}

} // Namespace
