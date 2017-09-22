/**
    This plugin can be used for common player customizations
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Configuration/Config.h"

class MyPlayer : public PlayerScript{
public:

    MyPlayer() : PlayerScript("MyPlayer") { }

    void OnLogin(Player* player) override {
        if (sConfigMgr->GetBoolDefault("MyCustom.enableHelloWorld", false)) {
            ChatHandler(player->GetSession()).SendSysMessage("Hello World from Skeleton-Module!");
        }
    }
};

void AddMyPlayerScripts() {
    new MyPlayer();
}

