INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638624697731724160');

-- groups Rage Talon Captains 137860 and 137861 with their formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (137860, 137861);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(137860, 137860, 50, 0, 3, 0, 0),
(137860, 137866, 50, 0, 3, 0, 0),
(137860, 137961, 50, 0, 3, 0, 0),
(137860, 137963, 50, 0, 3, 0, 0),
(137860, 137994, 50, 0, 3, 0, 0),
(137861, 137861, 50, 0, 3, 0, 0),
(137861, 137867, 50, 0, 3, 0, 0),
(137861, 137982, 50, 0, 3, 0, 0),
(137861, 137981, 50, 0, 3, 0, 0),
(137861, 137863, 50, 0, 3, 0, 0);

