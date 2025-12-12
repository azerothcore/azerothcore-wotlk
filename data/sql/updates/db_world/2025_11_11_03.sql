-- DB update 2025_11_11_02 -> 2025_11_11_03
--
SET @ARGENT_CRUSADE := 1106;
SET @KIRIN_TOR := 1090;
SET @KNIGHTS_OF_THE_EBON_BLADE := 1098;
SET @WYRMREST_ACCORD := 1091;
SET @ALLIANCE_VANGUARD := 1037;
SET @HORDE_EXPEDITION := 1052;
SET @SONS_OF_HODIR := 1119;

UPDATE `quest_template` SET `RewardFactionOverride1`=2200000 WHERE `ID` IN (12915, 12956);
UPDATE `quest_template` SET `RewardFactionOverride1`=0 WHERE `ID` IN (12924, 12975, 12976, 12977, 12981, 12985, 12987, 12994, 13001, 13003, 13010, 13011, 13046, 13108, 13420, 13421, 13559);
UPDATE `quest_template` SET `RewardFactionID1` = 0, `RewardFactionValue1` = 0, `RewardFactionOverride1` = 0 WHERE `ID` IN (12966, 12967);

UPDATE `reputation_reward_rate` SET `quest_rate`=1.3,`quest_daily_rate`=1.3,`quest_weekly_rate`=1.3,`quest_monthly_rate`=1.3,`quest_repeatable_rate`=1.3 WHERE `faction` IN (@ARGENT_CRUSADE, @KNIGHTS_OF_THE_EBON_BLADE, @KIRIN_TOR, @WYRMREST_ACCORD);

DELETE FROM `reputation_reward_rate` WHERE `faction` IN (@SONS_OF_HODIR, @ALLIANCE_VANGUARD, @HORDE_EXPEDITION);
INSERT INTO `reputation_reward_rate` (`faction`, `quest_rate`, `quest_daily_rate`, `quest_weekly_rate`, `quest_monthly_rate`, `quest_repeatable_rate`, `creature_rate`, `spell_rate`) VALUES
(@SONS_OF_HODIR, 1.3, 1.3, 1.3, 1.3, 1.3, 1.3, 1.3),
(@ALLIANCE_VANGUARD, 1.0, 1.0, 1.0, 1.0, 1.0, 1.3, 1.3),
(@HORDE_EXPEDITION, 1.0, 1.0, 1.0, 1.0, 1.0, 1.3, 1.3);
