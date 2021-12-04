INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638624697731724160');

-- groups Rage Talon Captains 137860 and 137861 with their formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (137860, 137861);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(137860, 137860, 0, 0, 3, 0, 0),
(137860, 137866, 0, 0, 3, 0, 0),
(137860, 137961, 0, 0, 3, 0, 0),
(137860, 137963, 0, 0, 3, 0, 0),
(137860, 137994, 0, 0, 3, 0, 0),
(137861, 137861, 0, 0, 3, 0, 0),
(137861, 137867, 0, 0, 3, 0, 0),
(137861, 137982, 0, 0, 3, 0, 0),
(137861, 137981, 0, 0, 3, 0, 0),
(137861, 137863, 0, 0, 3, 0, 0);

