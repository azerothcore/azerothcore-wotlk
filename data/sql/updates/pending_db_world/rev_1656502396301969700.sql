--
DELETE FROM `creature_formations` WHERE `memberGUID` IN (49313, 49314);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(49310, 49313, 0, 0, 27, 0, 0),
(49310, 49314, 0, 0, 27, 0, 0);
