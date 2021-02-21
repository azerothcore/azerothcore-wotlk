#ifndef ROBOT_CONFIG_H
#define ROBOT_CONFIG_H

#include "Common.h"

class RobotConfig
{
    RobotConfig() = default;
    RobotConfig(RobotConfig const&) = delete;
    RobotConfig& operator=(RobotConfig const&) = delete;
    ~RobotConfig() = default;

public:
    static RobotConfig* instance();

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

    bool LoadAppConfigs(std::string const& applicationName = "robot");
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

    bool LoadData(std::string const& file);

public:
    bool StartRobotSystem();
    uint32 Enable;
    std::string AccountNamePrefix;
    uint32 DPSDelay;
};

#define sRobotConfig RobotConfig::instance()

#endif
