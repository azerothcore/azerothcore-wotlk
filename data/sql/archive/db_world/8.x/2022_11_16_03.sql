-- DB update 2022_11_16_02 -> 2022_11_16_03
--
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = 676);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(676, 21, 0, 5, 0, 5, 0, 0, 0, 0);
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 5 WHERE `creature_id` IN (674, 675, 677, 1094, 1095, 1096, 1097, 4260, 4723);
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5 WHERE `creature_id` IN (921);

