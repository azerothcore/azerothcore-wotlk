-- DB update 2023_01_29_00 -> 2023_01_29_01
--
UPDATE `creature_onkill_reputation` SET `RewOnKillRepFaction1` = 942, `RewOnKillRepFaction2` = 0, `MaxStanding1` = 4, `RewOnKillRepValue1` = 7, `TeamDependent` = 0 WHERE `creature_id` = 17730;

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 20177;
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(20177, 942, 0, 7, 0, 15, 0, 0, 0, 0);
