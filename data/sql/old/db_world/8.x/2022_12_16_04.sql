-- DB update 2022_12_16_03 -> 2022_12_16_04
--
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (15233,15246,15247,15250,15252,15311,15312);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(15233, 910, 0, 0, 0, 100, 0, 0, 0, 0),
(15246, 910, 0, 3, 0, 100, 0, 0, 0, 0), 
(15247, 910, 0, 3, 0, 100, 0, 0, 0, 0), 
(15250, 910, 0, 3, 0, 100, 0, 0, 0, 0), 
(15252, 910, 0, 3, 0, 100, 0, 0, 0, 0), 
(15311, 910, 0, 3, 0, 100, 0, 0, 0, 0), 
(15312, 910, 0, 3, 0, 100, 0, 0, 0, 0); 
