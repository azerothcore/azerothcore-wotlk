INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621936778445126400');

DELETE FROM `quest_poi` WHERE (`QuestID` = 1109);
INSERT INTO `quest_poi` VALUES
(1109, 0, 4, 1, 11, 1717, 0, 1, 0),
(1109, 1, -1, 0, 20, 1497, 0, 1, 0);

DELETE FROM `quest_poi_points` WHERE (`QuestID` = 1109);
INSERT INTO `quest_poi_points` VALUES
(1109, 0, 0, -4536, -1839, 0),
(1109, 0, 1, -4401, -1839, 0),
(1109, 0, 2, -4444, -1702, 0),
(1109, 0, 3, -4503, -1705, 0),
(1109, 0, 4, -4536, -1839, 0),
(1109, 1, 0, 1434, 405, 0);
