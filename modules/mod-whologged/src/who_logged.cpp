#include "Configuration/Config.h"
#include "Player.h"
#include "Creature.h"
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Define.h"
#include "GossipDef.h"

class WhoLoggedAnnounce : public PlayerScript
{
public:
        WhoLoggedAnnounce() : PlayerScript("WhoLoggedAnnounce") { }


    void OnLogin(Player* p)
    {
        std::string playerIP = p->GetSession()->GetRemoteAddress();
        std::string playerName = p->GetName();
        uint32 pAccountID = p->GetSession()->GetAccountId();
        uint32 pLevel = p->getLevel();
        std::string pClass;
        std::ostringstream message;
       

        if (!sConfigMgr->GetBoolDefault("PlayerAnnounce", true))
        {
            return;
        }

        switch (p->getClass())
        {
        case CLASS_WARLOCK:
            pClass = "Warlock";
            break;
        case CLASS_WARRIOR:
            pClass = "Warrior";
            break;
        case CLASS_MAGE:
            pClass = "Mage";
            break;
        case CLASS_SHAMAN:
            pClass = "Shaman";
            break;
        case CLASS_DEATH_KNIGHT:
            pClass = "Death Knight";
            break;
        case CLASS_DRUID:
            pClass = "Druid";
            break;
        case CLASS_HUNTER:
            pClass = "Hunter";
            break;
        case CLASS_PALADIN:
            pClass = "Paladin";
            break;
        case CLASS_ROGUE:
            pClass = "Rogue";
            break;
        case CLASS_PRIEST:
            pClass = "Priest";
            break;
        }

        sLog->SetColor(true, CYAN);
        sLog->outString("Player '%s' has logged in : Level '%u' : Class '%s' : IP '%s' : AccountID '%u'", playerName.c_str(), pLevel, pClass.c_str(), playerIP.c_str(), pAccountID);
        sLog->ResetColor(true);
    }
};

class who_logged_conf : public WorldScript
{
public:
    who_logged_conf() : WorldScript("who-logged_conf") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string cfg_file = "Settings/modules/mod_who-logged.conf";
            std::string cfg_def_file = cfg_file + ".dist";

            sConfigMgr->LoadMore(cfg_def_file.c_str());

            sConfigMgr->LoadMore(cfg_file.c_str());
        }
    }
};

void AddWhoLoggedScripts()
{
    new WhoLoggedAnnounce();
    new who_logged_conf();
}