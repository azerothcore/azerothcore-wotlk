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

struct IndividualXpModule
{
    bool Enabled, AnnounceModule, AnnounceRatesOnLogin;
    float MaxRate, DefaultRate;
};

IndividualXpModule individualXp;

enum IndividualXPAcoreString
{
    ACORE_STRING_CREDIT = 35411,
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

class IndividualXPConf : public WorldScript
{
public:
    IndividualXPConf() : WorldScript("IndividualXPConf") { }

    void OnBeforeConfigLoad(bool /*reload*/) override
    {
        individualXp.Enabled = sConfigMgr->GetOption<bool>("IndividualXp.Enabled", true);
        individualXp.AnnounceModule = sConfigMgr->GetOption<bool>("IndividualXp.Announce", true);
        individualXp.AnnounceRatesOnLogin = sConfigMgr->GetOption<bool>("IndividualXp.AnnounceRatesOnLogin", true);
        individualXp.MaxRate = sConfigMgr->GetOption<float>("IndividualXp.MaxXPRate", 10.0f);
        individualXp.DefaultRate = sConfigMgr->GetOption<float>("IndividualXp.DefaultXPRate", 1.0f);
    }
};

class PlayerXpRate : public DataMap::Base
{
public:
    PlayerXpRate() {}
    PlayerXpRate(float XPRate) : XPRate(XPRate) {}
    float XPRate = 1.0f;
};

class IndividualXP : public PlayerScript
{
public:
    IndividualXP() : PlayerScript("IndividualXP") {}

    void OnPlayerLogin(Player* player) override
    {
        QueryResult result = CharacterDatabase.Query("SELECT `XPRate` FROM `individualxp` WHERE `CharacterGUID`='{}'", player->GetGUID().GetCounter());

        if (!result)
        {
            player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate = individualXp.DefaultRate;
        }
        else
        {
            Field* fields = result->Fetch();
            player->CustomData.Set("IndividualXP", new PlayerXpRate(fields[0].Get<float>()));
        }

        if (individualXp.Enabled)
        {
            // Announce Module
            if (individualXp.AnnounceModule)
            {
                ChatHandler(player->GetSession()).SendSysMessage(ACORE_STRING_CREDIT);
            }

            // Announce Rates
            if (individualXp.AnnounceRatesOnLogin)
            {
                if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
                {
                    ChatHandler(player->GetSession()).PSendSysMessage(ACORE_STRING_RATES_DISABLED);
                }
                else
                {
                    ChatHandler(player->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_VIEW, player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate);
                    ChatHandler(player->GetSession()).PSendSysMessage(ACORE_STRING_MAX_RATE, individualXp.MaxRate);
                }
            }
        }
    }

    void OnPlayerLogout(Player* player) override
    {
        if (PlayerXpRate* data = player->CustomData.Get<PlayerXpRate>("IndividualXP"))
        {
            CharacterDatabase.DirectExecute("REPLACE INTO `individualxp` (`CharacterGUID`, `XPRate`) VALUES ('{}', '{}');", player->GetGUID().GetCounter(), data->XPRate);
        }
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (individualXp.Enabled)
        {
            if (PlayerXpRate* data = player->CustomData.Get<PlayerXpRate>("IndividualXP"))
            {
                amount = static_cast<uint32>(std::round(static_cast<float>(amount) * data->XPRate));
            }
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
        if (!individualXp.Enabled)
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

    static bool HandleSetCommand(ChatHandler* handler, float rate)
    {
        if (!individualXp.Enabled)
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

        if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
        {
            handler->PSendSysMessage(ACORE_STRING_RATES_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }
        else
        {
            if (rate > individualXp.MaxRate)
            {
                handler->PSendSysMessage(ACORE_STRING_MAX_RATE, individualXp.MaxRate);
                handler->SetSentErrorMessage(true);
                return false;
            }

            if (rate < 0.1f)
            {
                handler->PSendSysMessage(ACORE_STRING_MIN_RATE);
                handler->SetSentErrorMessage(true);
                return false;
            }

            player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate = rate;
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_SET, rate);
            return true;
        }
    }

    static bool HandleDisableCommand(ChatHandler* handler)
    {
        if (!individualXp.Enabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        if (!player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
        {
            // Turn Disabled On But Don't Change Value...
            player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_DISABLED);
            return true;
        }
        else
        {
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_RATES_DISABLED);
            return false;
        }
    }

    static bool HandleEnableCommand(ChatHandler* handler)
    {
        if (!individualXp.Enabled)
        {
            handler->PSendSysMessage(ACORE_STRING_MODULE_DISABLED);
            handler->SetSentErrorMessage(true);
            return true;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
        {
            player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_ENABLED);
        }
        else
        {
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_RATES_DISABLED);
        }

        return true;
    }

    static bool HandleDefaultCommand(ChatHandler* handler)
    {
        if (!individualXp.Enabled)
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
            player->CustomData.GetDefault<PlayerXpRate>("IndividualXP")->XPRate = individualXp.DefaultRate;
            ChatHandler(handler->GetSession()).PSendSysMessage(ACORE_STRING_COMMAND_DEFAULT, individualXp.DefaultRate);
            return true;
        }
    }
};

void AddIndividualXPScripts()
{
    new IndividualXPConf();
    new IndividualXP();
    new IndividualXPCommand();
}
