INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636703045917932956');

DELETE FROM `quest_poi` WHERE `QuestID` = 6662;
DELETE FROM `quest_poi_points` WHERE `QuestID` = 6662;

INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`)
VALUES(6662, 0, -1, 0, 0, 0, 0, 0, 0);

INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`)
VALUES(6662, 1, -1, 0, 0, 0, 0, 0, 0);

INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`, `Idx2`, `X`,`Y`, `VerifiedBuild`)
VALUES (6662, 0, 0, -4838, -1318, 0);

INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`, `Idx2`, `X`,`Y`, `VerifiedBuild`)
VALUES (6662, 1, 0, -8364, 535, 0);


