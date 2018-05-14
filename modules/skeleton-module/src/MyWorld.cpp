#include "Configuration/Config.h"
#include "ScriptMgr.h"

class MyWorld : public WorldScript
{
public:
    MyWorld() : WorldScript("MyWorld") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/my_custom.conf";
            std::string cfg_def_file = cfg_file +".dist";

            sConfigMgr->LoadMore(cfg_def_file.c_str());

            sConfigMgr->LoadMore(cfg_file.c_str());
        }
    }
};

void AddMyWorldScripts()
{
    new MyWorld();
}
