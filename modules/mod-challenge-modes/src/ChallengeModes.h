/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 */

#ifndef MODULE_CHALLENGE_MODES_H
#define MODULE_CHALLENGE_MODES_H

#include "ObjectGuid.h"
#include "Optional.h"
#include "SharedDefines.h"
#include <array>
#include <string>
#include <unordered_map>
#include <unordered_set>

class Player;

enum ChallengeModeId : uint8
{
    CHALLENGE_HARDCORE           = 0,
    CHALLENGE_SEMI_HARDCORE      = 1,
    CHALLENGE_SELF_CRAFTED       = 2,
    CHALLENGE_ITEM_QUALITY       = 3,
    CHALLENGE_SLOW_XP            = 4,
    CHALLENGE_VERY_SLOW_XP       = 5,
    CHALLENGE_QUEST_XP_ONLY      = 6,
    CHALLENGE_IRON_MAN           = 7,
    CHALLENGE_HARDCORE_DEAD      = 8,
    CHALLENGE_MODE_MAX           = 9
};

enum ChallengeNpcConst : uint32
{
    NPC_CHALLENGE_KEEPER         = 190012,
    GO_SHRINE_OF_CHALLENGE       = 254605,
    NPC_TEXT_CHALLENGE_GREETING  = 190012,
    NPC_TEXT_CHALLENGE_PICKER    = 190013,
    GOSSIP_MENU_CHALLENGE        = 190012
};

enum ChallengePickerConst : uint32
{
    CHALLENGE_NORMAL_MODE            = 255,
    GOSSIP_CHALLENGE_ENABLE_BASE     = 10,
    GOSSIP_CHALLENGE_INFO_BASE       = 30,
    GOSSIP_CHALLENGE_NORMAL          = 50
};

struct ChallengeModeConfig
{
    bool Enabled = true;
    uint32 DisableLevel = 0;
    float XpMultiplier = 1.f;
    uint32 ItemRewardAmount = 1;
    uint32 RewardLevel = 80;
    uint32 RewardItem = 0;
    uint32 RewardItemCount = 1;
    uint32 RewardTitle = 0;
    uint32 RewardGold = 0;
    uint32 RewardHonor = 0;
    uint32 RewardAchievement = 0;
    uint32 RewardTalents = 0;
    std::unordered_map<uint8, uint32> TitleRewards;
    std::unordered_map<uint8, uint32> TalentRewards;
    std::unordered_map<uint8, uint32> ItemRewards;
    std::unordered_map<uint8, uint32> AchievementRewards;
};

struct ChallengeModeState
{
    std::array<uint8, CHALLENGE_MODE_MAX> Flag{};
    uint8 PickerDone = 0;
};

class ChallengeModes
{
public:
    static ChallengeModes* instance();

    void LoadConfig(bool reload);
    void EnsureDatabase();

    void LoadPlayer(Player* player);
    void UnloadPlayer(ObjectGuid guid);
    bool EnableChallenge(Player* player, uint8 mode, std::string& error);
    [[nodiscard]] bool IsEnabled(ObjectGuid guid, uint8 mode) const;
    void SetEnabled(Player* player, uint8 mode, bool enabled);

    [[nodiscard]] bool IsModuleEnabled() const { return _enabled; }
    [[nodiscard]] bool IsModeEnabled(uint8 mode) const;
    [[nodiscard]] ChallengeModeConfig const& GetModeConfig(uint8 mode) const;
    [[nodiscard]] uint32 GetNpcEntry() const { return _npcEntry; }
    [[nodiscard]] bool CanActivate(Player const* player) const;
    [[nodiscard]] bool HasActiveChallenge(ObjectGuid guid) const;
    [[nodiscard]] Optional<uint8> GetActiveChallenge(ObjectGuid guid) const;
    [[nodiscard]] bool IsPickerDone(ObjectGuid guid) const;
    [[nodiscard]] bool ShouldShowFirstLoginPicker(Player const* player) const;

    void GiveLevelRewards(Player* player, uint8 oldLevel);
    void HandlePlayerDeath(Player* player, char const* killer = nullptr);
    void GrantModeTitle(Player* player, uint8 mode, bool makeCurrent) const;
    void OpenFirstLoginPicker(Player* player);
    bool ChooseNormal(Player* player, std::string& error);
    void MarkPickerDone(Player* player);
    bool HandlePickerAddon(Player* player, std::string const& msg);

    static char const* GetModeName(uint8 mode, bool spanish);
    static char const* GetModeTitle(uint8 mode, bool spanish);
    static char const* GetModeDescription(uint8 mode, bool spanish);
    static char const* GetModeShortDescription(uint8 mode, bool spanish);
    static uint8 GetModeGossipIcon(uint8 mode);
    static bool IsSpanish(Player const* player);
    [[nodiscard]] std::string GetFormattedTitle(Player const* player, uint8 mode) const;
    void Broadcast(std::string const& message) const;
    void BroadcastLocalized(std::string const& spanish, std::string const& english) const;

private:
    ChallengeModes() = default;

    void SavePlayer(ObjectGuid guid);
    ChallengeModeState* GetState(ObjectGuid guid);
    ChallengeModeState const* GetState(ObjectGuid guid) const;
    static void LoadRewardMap(std::unordered_map<uint8, uint32>& map, std::string const& config);
    void SendPickerAddon(Player* player) const;
    void GiveConfiguredReward(Player* player, uint8 mode, uint8 level);
    void BroadcastStart(Player* player, uint8 mode) const;
    void BroadcastDeath(Player* player, uint8 mode, char const* killer) const;
    void BroadcastComplete(Player* player, uint8 mode) const;

    bool _enabled = true;
    bool _announce = true;
    bool _firstLoginUi = true;
    uint32 _npcEntry = NPC_CHALLENGE_KEEPER;
    std::array<ChallengeModeConfig, CHALLENGE_IRON_MAN + 1> _modes;
    std::unordered_map<uint32, ChallengeModeState> _players;
    std::unordered_set<uint32> _ironManDeathAnnounced;
};

#define sChallengeModes ChallengeModes::instance()

#endif
