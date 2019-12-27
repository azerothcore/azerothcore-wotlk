/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef CONFIG_H
#define CONFIG_H

#include <string>
#include <list>
#include <vector>
#include <mutex>
#include <unordered_map>


class ConfigMgr
{
    friend class ConfigLoader;

    private:
        std::string m_filename;
        std::unordered_map<std::string, std::string> m_entries; // keys are converted to lower case.  values cannot be.

    ConfigMgr() = default;
    ConfigMgr(ConfigMgr const&) = delete;
    ConfigMgr& operator=(ConfigMgr const&) = delete;
    ~ConfigMgr() = default;

    public:
        bool SetSource(const std::string& file);
        bool Reload();

        bool IsSet(const std::string& name) const;

        const std::string GetStringDefault(const std::string& name, const std::string& def = "") const;
        bool GetBoolDefault(const std::string& name, bool def) const;
        int32 GetIntDefault(const std::string& name, int32 def) const;
        float GetFloatDefault(const std::string& name, float def) const;

        const std::string& GetFilename() const { return m_filename; }
        std::mutex _configLock;

};

#define sConfigMgr ConfigMgr::instance()

#endif
