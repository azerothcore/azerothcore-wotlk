-- DB update 2022_12_22_09 -> 2022_12_22_10
--
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 4, `MaxStanding2` = 4, `RewOnKillRepValue1` = 1, `RewOnKillRepValue2` = 1 WHERE (`creature_id` = 17540);

DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = 18056);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(18056, 946, 947, 7, 0, 2, 7, 0, 2, 1);
