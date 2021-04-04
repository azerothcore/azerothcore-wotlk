INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617560891918432300');

DELETE FROM `quest_poi_points` WHERE `QuestID` = 6127;
INSERT INTO `quest_poi_points` VALUES
(6127, 0, 0, -544, -2672, 0),
(6127, 1, 0, 336, -2280, 0);
