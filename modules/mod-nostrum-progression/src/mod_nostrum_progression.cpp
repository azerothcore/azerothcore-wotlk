/*
 * NostrumWoW Progression Module
 *
 * Enforces a configurable phase level cap without modifying MaxPlayerLevel.
 * Players above the cap are reduced to it on login and on leveling.
 * XP is zeroed while at or above the cap to prevent level-up.
 */

#include "Chat.h"
#include "Common.h"
#include "Config.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"

class NostrumProgressionPlayerScript : public PlayerScript
{
public:
    NostrumProgressionPlayerScript() : PlayerScript("NostrumProgressionPlayerScript",
        {
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_ON_LEVEL_CHANGED,
            PLAYERHOOK_ON_GIVE_EXP,
        })
    {
    }

    void OnPlayerLogin(Player* player) override
    {
        if (!sConfigMgr->GetOption<bool>("Nostrum.Progression.Enable", true))
            return;

        uint8 cap = static_cast<uint8>(sConfigMgr->GetOption<int32>("Nostrum.Progression.LevelCap", 19));

        if (IsExempt(player))
        {
            if (sConfigMgr->GetOption<bool>("Nostrum.Progression.LoginAnnouncement", true))
            {
                std::string phase = sConfigMgr->GetOption<std::string>("Nostrum.Progression.PhaseName", "Phase 1");
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "[NostrumWoW] {} - Level cap: {} (GM bypass active)", phase, uint32(cap));
            }
            return;
        }

        // Enforce cap if player somehow logged in above it
        if (player->GetLevel() > cap)
            EnforceCap(player, cap);

        if (sConfigMgr->GetOption<bool>("Nostrum.Progression.LoginAnnouncement", true))
        {
            std::string phase = sConfigMgr->GetOption<std::string>("Nostrum.Progression.PhaseName", "Phase 1");
            ChatHandler(player->GetSession()).PSendSysMessage(
                "[NostrumWoW] {} - Current level cap: {}", phase, uint32(cap));
        }
    }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        if (!sConfigMgr->GetOption<bool>("Nostrum.Progression.Enable", true))
            return;

        if (IsExempt(player))
            return;

        uint8 cap = static_cast<uint8>(sConfigMgr->GetOption<int32>("Nostrum.Progression.LevelCap", 19));

        if (player->GetLevel() > cap)
            EnforceCap(player, cap);
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (!sConfigMgr->GetOption<bool>("Nostrum.Progression.Enable", true))
            return;

        if (IsExempt(player))
            return;

        uint8 cap = static_cast<uint8>(sConfigMgr->GetOption<int32>("Nostrum.Progression.LevelCap", 19));

        if (player->GetLevel() >= cap)
            amount = 0;
    }

private:
    bool IsExempt(Player* player) const
    {
        if (!sConfigMgr->GetOption<bool>("Nostrum.Progression.GmBypass", true))
            return false;
        return player->GetSession()->GetSecurity() >= SEC_GAMEMASTER;
    }

    void EnforceCap(Player* player, uint8 cap) const
    {
        player->GiveLevel(cap);
        // Zero out current XP so the player doesn't immediately level again
        player->SetUInt32Value(PLAYER_XP, 0);

        std::string phase = sConfigMgr->GetOption<std::string>("Nostrum.Progression.PhaseName", "Phase 1");
        ChatHandler(player->GetSession()).PSendSysMessage(
            "[NostrumWoW] Your level has been set to {} -- {} level cap enforced.", uint32(cap), phase);
    }
};

void Addmod_nostrum_progressionScripts()
{
    new NostrumProgressionPlayerScript();
}
