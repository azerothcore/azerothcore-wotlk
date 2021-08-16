INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629117996105184400');

DELETE FROM `quest_poi_points` WHERE `QuestID`=2518 AND `Idx1`=0 AND `Idx2`=0;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES (2518, 0, 0, 10979, 1366, 0);
