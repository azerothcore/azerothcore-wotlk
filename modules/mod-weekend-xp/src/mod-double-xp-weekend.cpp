#include "Configuration/Config.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Chat.h"
#include <time.h>

using namespace Acore::ChatCommands;

enum WeekendXP
{
    SETTING_WEEKEND_XP_RATE = 0,
    SETTING_WEEKEND_XP_DISABLE = 1,
    SETTING_WEEKEND_XP_VERSION = 2,

    LANG_CMD_WEEKEND_XP_SET   = 11120,
    LANG_CMD_WEEKEND_XP_ERROR = 11121,
    LANG_CMD_WEEKEND_XP_CONFIG = 11122,

    WD_FRIDAY   = 5,
    WD_SATURDAY = 6,
    WD_SUNDAY   = 0,
};

class DoubleXpWeekend
{

public:
    
    DoubleXpWeekend() { }
    
    // NOTE We need to access the DoubleXpWeekend logic from other
    // places, so keep all the logic accessible via a singleton here,
    // and have the `CommandScript` and the `PlayeScript` access this
    // for the functionality they need.
    static DoubleXpWeekend* instance()
    {
        static DoubleXpWeekend instance;
        return &instance;
    }

    uint32 OnGiveXP(Player* player, uint32 originalAmount, uint8 xpSource) const
    {
        if (!IsEventActive())
        {
            return originalAmount;
        }

        if (ConfigQuestOnly() && xpSource != PlayerXPSource::XPSOURCE_QUEST && xpSource != PlayerXPSource::XPSOURCE_QUEST_DF)
        {
            return originalAmount;
        }

        if (player->GetLevel() >= ConfigMaxLevel())
        {
            return originalAmount;
        }

        float newAmount = (float)originalAmount * GetExperienceRate(player);
        return (uint32) newAmount;
    }

    void OnLogin(Player* player, ChatHandler* handler) const
    {
        // TODO I am assuming that this is always called when a character logs in...
        // if that is not the case, thing migh get weird... Adding some asserts or warnings would be nice
        // but I'm not sure how to handle "This shouldn't be happening but it is" kind of scenarios in acore
        MigratePlayerSettings(player, handler);

        if (ConfigAnnounce())
        {
            if (IsEventActive() && !ConfigAlwaysEnabled())
            {
                float rate = GetExperienceRate(player);
                handler->PSendSysMessage("It's the weekend! Your XP rate has been set to: {}", rate);
            }
            else if (IsEventActive() && ConfigAlwaysEnabled())
            {
                float rate = GetExperienceRate(player);
                handler->PSendSysMessage("Your XP rate has been set to: {}", rate);
            }
            else
            {
                handler->PSendSysMessage("This server is running the |cff4CFF00Double XP Weekend |rmodule.");
            }
        }
    }

    bool HandleSetXPBonusCommand(ChatHandler* handler, float rate) const
    {
        Player* player = handler->GetPlayer();

        float maxRate = ConfigMaxAllowedRate();

        if (rate <= 0.0f || rate > maxRate)
        {
            handler->PSendSysMessage(LANG_CMD_WEEKEND_XP_ERROR, maxRate);
            handler->SetSentErrorMessage(true);
            return true;
        }

        PlayerSettingSetRate(player, rate);
        handler->PSendSysMessage(LANG_CMD_WEEKEND_XP_SET, rate);

        // TODO if the `EnablePlayerSettings` is not set, the setting wont be remembered by the
        // server after the player logs out, meaning the player needs to do this again on next login

        return true;
    }

    bool HandleGetCurrentConfigCommand(ChatHandler* handler) const
    {
        Player* player = handler->GetPlayer();

        const float actualRate = GetExperienceRate(player);
        const bool isAnnounceEnabled = ConfigAnnounce();
        const bool isAlwaysEnabled = ConfigAlwaysEnabled();
        const bool isQuestOnly = ConfigQuestOnly();
        const uint32 maxLevel = ConfigMaxLevel();
        const float xpRate = ConfigxpAmount();
        const bool isIndividulaXpEnabled = ConfigIndividualXPEnabled();
        const bool isEnabled = ConfigEnabled();
        const float maxXpRate = ConfigMaxAllowedRate();

        handler->PSendSysMessage(LANG_CMD_WEEKEND_XP_CONFIG,
            actualRate,
            isAnnounceEnabled,
            isAlwaysEnabled,
            isQuestOnly,
            maxLevel,
            xpRate,
            isIndividulaXpEnabled,
            isEnabled,
            maxXpRate
        );

        return true;
    }

private:

    // NOTE keep options together to prevent having more than 1 potential default value
    bool ConfigAlwaysEnabled() const { return sConfigMgr->GetOption<bool>("XPWeekend.AlwaysEnabled", false); }
    bool ConfigAnnounce() const { return sConfigMgr->GetOption<bool>("XPWeekend.Announce", false); }
    bool ConfigQuestOnly() const { return sConfigMgr->GetOption<bool>("XPWeekend.QuestOnly", false); }
    uint32 ConfigMaxLevel() const { return sConfigMgr->GetOption<uint32>("XPWeekend.MaxLevel", 80); }
    float ConfigxpAmount() const { return sConfigMgr->GetOption<float>("XPWeekend.xpAmount", 2.0f); }
    bool ConfigIndividualXPEnabled() const { return sConfigMgr->GetOption<bool>("XPWeekend.IndividualXPEnabled", false); }
    bool ConfigEnabled() const { return sConfigMgr->GetOption<bool>("XPWeekend.Enabled", false); }
    float ConfigMaxAllowedRate() const { return sConfigMgr->GetOption<float>("XPWeekend.MaxAllowedRate", 2.0f); }

    void PlayerSettingSetRate(Player* player, float rate) const
    {
        // HACK PlayerSetting seems to store uint32 only, so save our `float` as if it was a `uint32`
        uint32 encodedRate;
        float* reinterpretingPointer = (float*)&encodedRate;
        *reinterpretingPointer = rate;
        player->UpdatePlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_RATE, encodedRate);
    }
    
    float PlayerSettingGetRate(Player* player) const
    {
        uint32 rateStored = player->GetPlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_RATE).value;
        // HACK PlayerSetting seems to store uint32 only, so save our `float` as if it was a `uint32`
        float rate = *(float*)&rateStored;
        return rate;
    }

    void MigratePlayerSettings(Player* player, ChatHandler* /*handler*/) const
    {
        static const uint32 VERSION = 1;

        uint32 playersCurrentVersion = player->GetPlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_VERSION).value;
        bool validMigration = playersCurrentVersion == 0 && VERSION == 1;
        if (!validMigration) 
        {
            // Currently there is only either version 0 (the default) or 1
            // This check should never fail unless a new version is introduced and the
            // migration here is not updated.
            return;
        }

        // On version 1 the only thing to migrate is the SETTING_WEEKEND_XP_RATE
        float newRate = ConfigxpAmount();
        uint32 originalRate = player->GetPlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_RATE).value;
        if (originalRate <= 0)
        {
            // player setting was never set before, just use default
        }
        else if ((float)originalRate > ConfigMaxAllowedRate())
        {
            // player setting was set but the value is not valid, just use default
        }                
        else
        {
            // player setting was set, use the same rate
            newRate = (float) originalRate;
        }

        // HACK PlayerSetting seems to store uint32 only, so save our `float` as if it was a `uint32`
        uint32 encodedRate;
        float* reinterpretingPointer = (float*)&encodedRate;
        *reinterpretingPointer = newRate;
        player->UpdatePlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_RATE, encodedRate);
        player->UpdatePlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_VERSION, VERSION);
    }
    
    // TODO why is there a `GetDisable` player setting but no way to actually modify it? Leaving as is for now...
    bool PlayerSettingGetDisable(Player* player) const
    {
        return player->GetPlayerSetting("mod-double-xp-weekend", SETTING_WEEKEND_XP_DISABLE).value == (uint32)1;
    }

    float GetExperienceRate(Player* player) const
    {
        float rate = ConfigxpAmount();

        if (PlayerSettingGetDisable(player))
        {
            return 1.0f;
        }

        // If individualxp setting is enabled... and a rate was set, overwrite it.
        if (ConfigIndividualXPEnabled())
        {
            rate = PlayerSettingGetRate(player);
        }

        // Prevent returning 0% rate.
        return rate > 0.0f ? rate : 1.0f;
    }

    bool IsEventActive() const
    {
        if (ConfigAlwaysEnabled())
        {
            return true;
        }
            
        if (!ConfigEnabled())
        {
            return false;
        }

        time_t t = time(nullptr);
        tm* now = localtime(&t);

        return now->tm_wday == WD_FRIDAY || now->tm_wday == WD_SATURDAY || now->tm_wday == WD_SUNDAY;
    }
};

class weekendxp_commandscript : public CommandScript
{
public:
    weekendxp_commandscript() : CommandScript("weekendxp_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commandTable =
        {
            { "weekendxp rate", HandleSetXPBonusCommand, SEC_PLAYER, Console::No },
            { "weekendxp config", HandleGetCurrentConfigCommand, SEC_PLAYER, Console::No },
        };

        return commandTable;
    }

    static bool HandleSetXPBonusCommand(ChatHandler* handler, float rate)
    {
        DoubleXpWeekend* mod = DoubleXpWeekend::instance();
        return mod->HandleSetXPBonusCommand(handler, rate);
    }

    static bool HandleGetCurrentConfigCommand(ChatHandler* handler)
    {
        DoubleXpWeekend* mod = DoubleXpWeekend::instance();
        return mod->HandleGetCurrentConfigCommand(handler);
    }
};

class DoubleXpWeekendPlayerScript : public PlayerScript
{
public:
    DoubleXpWeekendPlayerScript() : PlayerScript("DoubleXpWeekend") { }

    void OnLogin(Player* player) override
    {
        DoubleXpWeekend* mod = DoubleXpWeekend::instance();
        ChatHandler handler = ChatHandler(player->GetSession());
        mod->OnLogin(player, &handler);
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 xpSource) override
    {
        DoubleXpWeekend* mod = DoubleXpWeekend::instance();
        amount = mod->OnGiveXP(player, amount, xpSource);
    }

};

void AdddoublexpScripts()
{
    new DoubleXpWeekendPlayerScript();
    new weekendxp_commandscript();
}
