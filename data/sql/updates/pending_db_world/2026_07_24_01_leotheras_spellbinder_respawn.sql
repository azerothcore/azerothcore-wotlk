-- Greyheart Spellbinders don't respawn on a wipe, so Leotheras stays banished forever with
-- nothing left alive to free him.
DELETE FROM `creature_formations` WHERE `leaderGUID` = 153139;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(153139, 153139, 0, 0, 24, 0, 0),
(153139, 153140, 0, 0, 24, 0, 0),
(153139, 153141, 0, 0, 24, 0, 0),
(153139, 153142, 0, 0, 24, 0, 0);
