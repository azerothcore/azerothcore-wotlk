INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642523191674512900');

DELETE FROM `creature_formations` WHERE `memberGUID` IN (42921, 44397, 44396);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(42921, 42921, 0, 0, 3),
(42921, 44397, 0, 0, 3),
(42921, 44396, 0, 0, 3);
