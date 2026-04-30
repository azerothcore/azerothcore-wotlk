#include "Config.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "WorldConfig.h"
#include "WorldScript.h"

class DualSpec19WorldScript : public WorldScript
{
public:
    DualSpec19WorldScript() : WorldScript("DualSpec19WorldScript",
        {
            WORLDHOOK_ON_AFTER_CONFIG_LOAD,
            WORLDHOOK_ON_STARTUP,
        })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        if (!sConfigMgr->GetOption<bool>("DualSpec19.Enable", true))
            return;

        uint32 minLevel = sConfigMgr->GetOption<uint32>("DualSpec19.MinLevel", 19);
        sWorld->setIntConfig(CONFIG_MIN_DUALSPEC_LEVEL, minLevel);

        // DB is not ready on the first config load during startup; OnStartup handles that.
        if (reload)
            UpdateGossipCost();
    }

    void OnStartup() override
    {
        if (!sConfigMgr->GetOption<bool>("DualSpec19.Enable", true))
            return;

        UpdateGossipCost();
    }

private:
    void UpdateGossipCost()
    {
        uint32 cost = sConfigMgr->GetOption<uint32>("DualSpec19.Cost", 10000);
        WorldDatabase.Execute(
            "UPDATE gossip_menu_option SET BoxMoney = {} WHERE OptionType = 18",
            cost
        );
    }
};

void Addmod_dual_spec_19Scripts()
{
    new DualSpec19WorldScript();
}
