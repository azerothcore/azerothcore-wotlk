#include "ScriptMgr.h"
#include "Configuration/Config.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "Player.h"
#include "Object.h"
#include "DataMap.h"

using namespace Acore::ChatCommands;

/*
Coded by Talamortis - For Azerothcore
Thanks to Rochet for the assistance
*/

bool IndividualXpEnabled;
bool IndividualXpAnnounceModule;
uint32 MaxRate;
uint32 DefaultRate;

class IndividualXPConf : public WorldScript
{
public:
    IndividualXPConf() : WorldScript("IndividualXPConf") { }

    void OnBeforeConfigLoad(bool /*reload*/) override
    {
        IndividualXpAnnounceModule = sConfigMgr->GetOption<bool>("IndividualXp.Announce", 1);
        IndividualXpEnabled = sConfigMgr->GetOption<bool>("IndividualXp.Enabled", 1);
        MaxRate = sConfigMgr->GetOption<uint32>("MaxXPRate", 10);
        DefaultRate = sConfigMgr->GetOption<uint32>("DefaultXPRate", 1);
    }
};

enum IndividualXPAcoreString
{
    ACORE_STRING_CREDIT                 = 35411,
    ACORE_STRING_MODULE_DISABLED,
    ACORE_STRING_RATES_DISABLED,
    ACORE_STRING_COMMAND_VIEW,
    ACORE_STRING_MAX_RATE,
    ACORE_STRING_MIN_RATE,
    ACORE_STRING_COMMAND_SET,
    ACORE_STRING_COMMAND_DISABLED,
    ACORE_STRING_COMMAND_ENABLED,
    ACORE_STRING_COMMAND_DEFAULT
};

class IndividualXpAnnounce : public PlayerScript
{
public:

    IndividualXpAnnounce() : PlayerScript("IndividualXpAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if ((IndividualXpEnabled) && (IndividualXpAnnounceModule))
        {
            ChatHandler(player->GetSession()).SendSysMessage(ACORE_STRING_CREDIT);
        }
    }
};

class PlayerXpRate : public DataMap::Base
{
public:
    PlayerXpRate() {}
    PlayerXpRate(uint32 XPRate) : XPRate(XPRate) {}
    uint32 XPRate = 1;
};

class IndividualXP : public PlayerScript
{
public:
    IndividualXP() : PlayerScript("IndividualXP") {}

    void OnLogin(Player* player) override
    {
        QueryResult result = CharacterDatabase.Query("SELECT `XPRate` FROM `individualxp` WHERE `CharacterGUID`='{}'", player->GetGUID().GetCounter());

        if (!result)
        {
            player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate = DefaultRate;
        }
        else
        {
            Field* fields = result->Fetch();
            player->CustomData.Set("IndividualXP", new PlayerXpRate(fields[0].Get<uint32>()));
        }
    }

    void OnLogout(Player* player) override
    {
        if (PlayerXpRate* data = player->CustomData.Get<PlayerXpRate>("IndividualXP"))
        {
            CharacterDatabase.DirectExecute("REPLACE INTO `individualxp` (`CharacterGUID`, `XPRate`) VALUES ('{}', '{}');", player->GetGUID().GetCounter(), data->XPRate);
        }
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (IndividualXpEnabled)
        {
            if (PlayerXpRate* data = player->CustomData.Get<PlayerXpRate>("IndividualXP"))
                amount *= data->XPRate;
        }
    }

};

class IndividualXPCommand : public CommandScript
{
public:
    IndividualXPCommand() : CommandScript("IndividualXPCommand") {}

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable IndividualXPCommandTable =
        {
            { "enable",  HandleEnableCommand, SEC_PLAYER, Console::No },
            { "disable",  HandleDisableCommand, SEC_PLAYER, Console::No },
            { "view",  HandleViewCommand, SEC_PLAYER, Console::No },
            { "set",  HandleSetCommand, SEC_PLAYER, Console::No },
            { "default",  HandleDefaultCommand, SEC_PLAYER, Console::No }
        };

        static ChatCommandTable IndividualXPBaseTable =
        {
            { "xp",  IndividualXPCommandTable }
        };

        return IndividualXPBaseTable;
    }

    static bool HandleViewCommand(ChatHandler* handler)
    {
        if (!IndividualXpEnabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
        {
            handler->PSendSysMessage(ACORE_STRING_RATES_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }
        else
        {
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_VIEW, player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate);
        }
        return true;
    }

    static bool HandleSetCommand(ChatHandler* handler, uint32 rate)
    {
        if (!IndividualXpEnabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!rate)
            return false;

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        if (rate > MaxRate)
        {
            handler->PSendSysMessage(ACORE_STRING_MAX_RATE, MaxRate);
            handler->SetSentErrorMessage(true);
            return false;
        }
        else if (rate == 0)
        {
            handler->PSendSysMessage(ACORE_STRING_MIN_RATE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate = rate;
        ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_SET, rate);
        return true;
    }

    static bool HandleDisableCommand(ChatHandler* handler)
    {
        if (!IndividualXpEnabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        // Turn Disabled On But Don't Change Value...
        player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
        player->GetSession()->SendAreaTriggerMessage(ACORE_STRING_COMMAND_DISABLED);
        return true;
    }

    static bool HandleEnableCommand(ChatHandler* handler)
    {
        if (!IndividualXpEnabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
        player->GetSession()->SendAreaTriggerMessage(ACORE_STRING_COMMAND_ENABLED);
        return true;
    }

    static bool HandleDefaultCommand(ChatHandler* handler)
    {
        if (!IndividualXpEnabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate = DefaultRate;
        ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_DEFAULT, DefaultRate);
        return true;
    }
};

void AddIndividualXPScripts()
{
    new IndividualXPConf();
    new IndividualXpAnnounce();
    new IndividualXP();
    new IndividualXPCommand();
}
