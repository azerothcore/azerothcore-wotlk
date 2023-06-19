-- DB update 2022_11_05_03 -> 2022_11_06_00
-- lots of Reputation changes
DELETE FROM `creature_onkill_reputation` WHERE `creature_id`=26081;
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES (26081, 87, 21, 5, 0, 5, 7, 1, -25, 0);
-- Spawn to 8 hours
UPDATE `creature` SET `spawntimesecs`=28800 WHERE `guid`=1975960 AND `id1`=26081;
