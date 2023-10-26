-- Lord Alexei Barov (10504) creature formation with adds + respawn
DELETE FROM `creature_formations` WHERE (`leaderGUID` = 48863);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48863, 48862, 0, 0, 27, 0, 0),
(48863, 48863, 0, 0, 27, 0, 0),
(48863, 48864, 0, 0, 27, 0, 0);
