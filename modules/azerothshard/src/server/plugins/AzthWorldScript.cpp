#include "Configuration/Config.h"
#include "ScriptMgr.h"

#ifndef _AZTH_MOD_CONFIG
# define _AZTH_MOD_CONFIG  "azth_mod.conf"
#endif

class AzthWorldScript : public WorldScript
{
public:
    AzthWorldScript() : WorldScript("AzthWorldScript") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string cfg_file = _AZTH_MOD_CONFIG;
            std::string cfg_def_file = cfg_file;
            cfg_def_file += ".dist";

            sConfigMgr->LoadMore(cfg_def_file.c_str());
            
            sConfigMgr->LoadMore(cfg_file.c_str());
        }
    }
};

void AddSC_AzthWorldScript()
{
    new AzthWorldScript();
}
