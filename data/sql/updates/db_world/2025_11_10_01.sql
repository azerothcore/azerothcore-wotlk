-- DB update 2025_11_10_00 -> 2025_11_10_01
--
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE (`ID` = 11472);
UPDATE `quest_template` SET `RewardFactionValue1` = 5, `RewardFactionOverride1` = 0 WHERE (`ID` = 11945);
