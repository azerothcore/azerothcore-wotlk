-- DB update 2022_05_21_02 -> 2022_05_21_03
-- Dungeon/BRD Link mobs in the 2 rooms before High Interrogator Gerstahn (no previous creature_formations for the listed GUIDs)
-- Left room
DELETE FROM `creature_formations` WHERE `memberguid` IN (90695,91054,91082,90850);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(91054, 90695, 0, 0, 3, 0, 0),
(91054, 91054, 0, 0, 3, 0, 0),
(91054, 91082, 0, 0, 3, 0, 0),
(91054, 90850, 0, 0, 3, 0, 0);

-- Right room
DELETE FROM `creature_formations` WHERE `memberguid` IN (91037,45892,91076,90899,91087);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(91037, 91037, 0, 0, 3, 0, 0),
(91037, 45892, 0, 0, 3, 0, 0),
(91037, 91076, 0, 0, 3, 0, 0),
(91037, 90899, 0, 0, 3, 0, 0),
(91037, 91087, 0, 0, 3, 0, 0);
