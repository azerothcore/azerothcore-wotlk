-- DB update 2025_10_26_02 -> 2025_10_26_03
--
DELETE FROM `creature_formations` WHERE (`leaderGUID` = 126747) AND (`memberGUID` IN (126747, 126748));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(126747, 126747, 0, 0, 3, 0, 0),
(126747, 126748, 0, 0, 3, 0, 0);
