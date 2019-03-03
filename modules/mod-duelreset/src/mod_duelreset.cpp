/*
 *  Originally written  for TrinityCore by ShinDarth and GigaDev90 (www.trinitycore.org)
 *  Converted as module for AzerothCore by ShinDarth and Yehonal   (www.azerothcore.org)
 *  Modifications by StygianTheBest - v2017.08.01
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as published
 *  by the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Pet.h"
#include "SpellInfo.h"
#include "Config.h"

bool DuelResetEnabled = true;
bool DuelResetAnnounceModule = true;
bool ResetHealthMana = true;
bool ResetCooldowns = true;

class DuelResetConfig : public WorldScript
{
public:
    DuelResetConfig() : WorldScript("DuelResetConfig") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/mod_duelreset.conf";
#ifdef WIN32
            cfg_file = "mod_duelreset.conf";
#endif
            std::string cfg_def_file = cfg_file + ".dist";
            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());

            // Load Configuration Settings
            SetInitialWorldSettings();
        }
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
        DuelResetEnabled = sConfigMgr->GetBoolDefault("DuelReset.Enabled", true);
        DuelResetAnnounceModule = sConfigMgr->GetBoolDefault("DuelReset.Announce", true);
        ResetHealthMana = sConfigMgr->GetBoolDefault("DuelReset.HealthMana", true);
        ResetCooldowns = sConfigMgr->GetBoolDefault("DuelReset.Cooldowns", true);
    }
};

class DuelResetAnnounce : public PlayerScript
{

public:

    DuelResetAnnounce() : PlayerScript("DuelResetAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (DuelResetAnnounceModule)
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00DuelReset |rmodule.");
        }
    }
};

class DuelResetScript : public PlayerScript
{
public:
    DuelResetScript() : PlayerScript("DuelResetScript") { }

    // Called when a duel starts (after 3s countdown)
    void OnDuelStart(Player* player1, Player* player2) override
    {
        // Cooldowns reset
        if (ResetCooldowns)
        {
            // Temporary basic cooldown reset
            player1->RemoveArenaSpellCooldowns();
            player2->RemoveArenaSpellCooldowns();

            /* TODO: convert this
            player1->GetSpellHistory()->SaveCooldownStateBeforeDuel();
            player2->GetSpellHistory()->SaveCooldownStateBeforeDuel();

            ResetSpellCooldowns(player1, true);
            ResetSpellCooldowns(player2, true);
            */
        }

        // Health and mana reset
        if (ResetHealthMana)
        {
            player1->SaveHealthBeforeDuel();
            player1->SetHealth(player1->GetMaxHealth());

            player2->SaveHealthBeforeDuel();
            player2->SetHealth(player2->GetMaxHealth());

            // check if player1 class uses mana
            if (player1->getPowerType() == POWER_MANA || player1->getClass() == CLASS_DRUID)
            {
                player1->SaveManaBeforeDuel();
                player1->SetPower(POWER_MANA, player1->GetMaxPower(POWER_MANA));
            }

            // check if player2 class uses mana
            if (player2->getPowerType() == POWER_MANA || player2->getClass() == CLASS_DRUID)
            {
                player2->SaveManaBeforeDuel();
                player2->SetPower(POWER_MANA, player2->GetMaxPower(POWER_MANA));
            }
        }
    }

    // Called when a duel ends
    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type) override
    {
        // do not reset anything if DUEL_INTERRUPTED or DUEL_FLED
        if (type == DUEL_WON)
        {
            // Cooldown restore
            if (ResetCooldowns)
            {
                /* TODO: convert this
                ResetSpellCooldowns(winner, false);
                ResetSpellCooldowns(loser, false);

                winner->GetSpellHistory()->RestoreCooldownStateAfterDuel();
                loser->GetSpellHistory()->RestoreCooldownStateAfterDuel();
                //*/
            }

            // Health and mana restore
            if (ResetHealthMana)
            {
                winner->RestoreHealthAfterDuel();
                loser->RestoreHealthAfterDuel();

                // check if player1 class uses mana
                if (winner->getPowerType() == POWER_MANA || winner->getClass() == CLASS_DRUID)
                    winner->RestoreManaAfterDuel();

                // check if player2 class uses mana
                if (loser->getPowerType() == POWER_MANA || loser->getClass() == CLASS_DRUID)
                    loser->RestoreManaAfterDuel();
            }
        }
    }

    static void ResetSpellCooldowns(Player* player, bool onStartDuel)
    {
        /* TODO: convert this
        if (onStartDuel)
        {
            // remove cooldowns on spells that have < 10 min CD > 30 sec and has no onHold
            player->GetSpellHistory()->ResetCooldowns([](SpellHistory::CooldownStorageType::iterator itr) -> bool
            {
                SpellHistory::Clock::time_point now = SpellHistory::Clock::now();
                uint32 cooldownDuration = itr->second.CooldownEnd > now ? std::chrono::duration_cast<std::chrono::milliseconds>(itr->second.CooldownEnd - now).count() : 0;
                SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(itr->first);
                return spellInfo->RecoveryTime < 10 * MINUTE * IN_MILLISECONDS
                       && spellInfo->CategoryRecoveryTime < 10 * MINUTE * IN_MILLISECONDS
                       && !itr->second.OnHold
                       && cooldownDuration > 0
                       && ( spellInfo->RecoveryTime - cooldownDuration ) > (MINUTE / 2) * IN_MILLISECONDS
                       && ( spellInfo->CategoryRecoveryTime - cooldownDuration ) > (MINUTE / 2) * IN_MILLISECONDS;
            }, true);
        }
        else
        {
            // remove cooldowns on spells that have < 10 min CD and has no onHold
            player->GetSpellHistory()->ResetCooldowns([](SpellHistory::CooldownStorageType::iterator itr) -> bool
            {
                SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(itr->first);
                return spellInfo->RecoveryTime < 10 * MINUTE * IN_MILLISECONDS
                       && spellInfo->CategoryRecoveryTime < 10 * MINUTE * IN_MILLISECONDS
                       && !itr->second.OnHold;
            }, true);
        }

        // pet cooldowns
        if (Pet* pet = player->GetPet())
            pet->GetSpellHistory()->ResetAllCooldowns();
        //*/
    }
};

void AddSC_DuelReset()
{
    new DuelResetConfig();
    new DuelResetAnnounce();
    new DuelResetScript();
}
