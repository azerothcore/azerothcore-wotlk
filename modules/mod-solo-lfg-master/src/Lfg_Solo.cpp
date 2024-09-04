/*
** Made by Traesh https://github.com/Traesh
** AzerothCore 2019 http://www.azerothcore.org/
** Conan513 https://github.com/conan513
** Made into a module by Micrah https://github.com/milestorme/
*/

#include "ScriptMgr.h"
#include "Player.h"
#include "Configuration/Config.h"
#include "World.h"
#include "LFGMgr.h"
#include "Chat.h"
#include "Opcodes.h"

class lfg_solo_announce : public PlayerScript
{
public:
    lfg_solo_announce() : PlayerScript("lfg_solo_announce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (sConfigMgr->GetOption<bool>("SoloLFG.Announce", true))
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00Solo Dungeon Finder |rmodule.");
        }
    }
};

class lfg_solo : public WorldScript
{
public:
    lfg_solo() : WorldScript("lfg_solo") {}

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        if (sConfigMgr->GetOption<bool>("SoloLFG.Enable", true) != sLFGMgr->IsTesting())
        {
            sLFGMgr->ToggleTesting();
        }
    }
};

void AddLfgSoloScripts()
{
	new lfg_solo_announce();
    new lfg_solo();
}
