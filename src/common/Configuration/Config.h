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
#include <ace/Configuration_Import_Export.h>
#include <ace/Thread_Mutex.h>
#include <AutoPtr.h>

typedef acore::AutoPtr<ACE_Configuration_Heap, ACE_Null_Mutex> Config;

class ConfigMgr
{
    friend class ConfigLoader;

public:
    static ConfigMgr* instance();

    /// Method used only for loading main configuration files (authserver.conf and worldserver.conf)
    bool LoadInitial(std::string const& file);

    /**
     * This method loads additional configuration files
     * It is recommended to use this method in WorldScript::OnConfigLoad hooks
     *
     * @return true if loading was successful
     */
    bool LoadMore(std::string const& file);

    bool Reload();

    bool LoadAppConfigs(std::string const& applicationName = "worldserver");
    bool LoadModulesConfigs();

    std::string GetStringDefault(std::string const& name, const std::string& def, bool logUnused = true);
    bool GetBoolDefault(std::string const& name, bool def, bool logUnused = true);
    int GetIntDefault(std::string const& name, int def, bool logUnused = true);
    float GetFloatDefault(std::string const& name, float def, bool logUnused = true);

    std::list<std::string> GetKeysByString(std::string const& name);

    bool isDryRun() { return dryRun; }
    void setDryRun(bool mode) { dryRun = mode; }

    void SetConfigList(std::string const& fileName, std::string const& modulesConfigList = "");

private:
    bool dryRun = false;

    bool GetValueHelper(const char* name, ACE_TString& result);
    bool LoadData(std::string const& file);

    typedef ACE_Thread_Mutex LockType;
    typedef ACE_Guard<LockType> GuardType;

    std::vector<std::string> _modulesConfigFiles;
    std::string _initConfigFile;
    Config _config;
    LockType _configLock;

    ConfigMgr() = default;
    ConfigMgr(ConfigMgr const&) = delete;
    ConfigMgr& operator=(ConfigMgr const&) = delete;
    ~ConfigMgr() = default;
};

#define sConfigMgr ConfigMgr::instance()

#endif
