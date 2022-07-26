-- DB update 2022_07_25_00 -> 2022_07_25_01
DELETE FROM `creature_formations` WHERE `leaderguid` IN (144488, 144486, 144484, 144483);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(144488, 144488, 0, 0, 3, 0, 0),
(144488, 144489, 0, 0, 3, 0, 0),
(144486, 144486, 0, 0, 3, 0, 0),
(144486, 144487, 0, 0, 3, 0, 0),
(144484, 144484, 0, 0, 3, 0, 0),
(144484, 144485, 0, 0, 3, 0, 0),
(144483, 144483, 0, 0, 3, 0, 0),
(144483, 144482, 0, 0, 3, 0, 0);
