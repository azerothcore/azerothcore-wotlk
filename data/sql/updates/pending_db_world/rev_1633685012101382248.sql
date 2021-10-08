INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633685012101382248');

-- Stone circle quest (3444) correct POIs

DELETE FROM `quest_poi_points` WHERE `QuestID`= 3444;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES 
(3444, 0, 0, -992, -3710, 0),
(3444, 1, 0, -7988, -3856, 0);

DELETE FROM `quest_poi` WHERE `QuestID`= 3444;
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES 
(3444, 0, 4, 1, 11, 0, 0, 1, 0),
(3444, 1, -1, 1, 161, 0, 0, 1, 0);

