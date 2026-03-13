-- DB update 2024_03_20_01 -> 2024_03_20_02
-- Lord Alexei Barov (10504) creature formation with adds + respawn
DELETE FROM `creature_formations` WHERE (`leaderGUID` = 48863);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48863, 48862, 0, 0, 24, 0, 0),
(48863, 48863, 0, 0, 24, 0, 0),
(48863, 48864, 0, 0, 24, 0, 0);

-- Lord Alexei Barov (10504) linked respawns with adds
DELETE FROM `linked_respawn` WHERE `linkedGuid`=48863 AND `linkType`=0;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(48862, 48863, 0),
(48864, 48863, 0);
