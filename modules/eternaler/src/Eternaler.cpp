/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "util_item.h"

// Add player scripts
class Eternaler : public PlayerScript
{
public:
    Eternaler() : PlayerScript("Eternaler") { }

    void OnLogin(Player* player) override
    {
        /*if (sConfigMgr->GetOption<bool>("MyModule.Enable", false))
        {
            ChatHandler(player->GetSession()).SendSysMessage("Hello World from Skeleton-Module!");
        }*/

        //if (player->HasAtLoginFlag(AT_LOGIN_FIRST))
        //{
        //    util_item::Add(player, 4500, 4);  //16格万古居民背包4个
        //    ChatHandler(player->GetSession()).SendSysMessage("请在背包中查看新人礼品！");
        //}
    }

    void OnPVPKill(Player*, Player*) override
    {

    }

    void OnCreate(Player* player) override
    {

    }


};

// Add all scripts in one
void AddEternalerScripts()
{
    new Eternaler();
}
