INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624198243312398771');

-- Mark existing POI as quest turn in for Waters of Xavian (1944)
UPDATE `quest_poi` SET `ObjectiveIndex`=-1 WHERE `QuestID`=1944 AND `id`=0;

-- Add POI for the quest objective of Waters of Xavian (1944)
DELETE FROM `quest_poi` WHERE `QuestId`=1944 AND `id`=1;
INSERT INTO `quest_poi` (`QuestId`, `id`, `ObjectiveIndex`, `MapId`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES (1944,1,4,1,43,0,0,1,0);
DELETE FROM `quest_poi_points` WHERE `QuestId`=1944 AND `Idx1`=1;
INSERT INTO `quest_poi_points` (`QuestId`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES (1944, 1, 0, 3079, -2701, 0);

-- Add POIs for the quest objective of Laughing Sisters (1945)
DELETE FROM `quest_poi` WHERE `QuestId`=1945 AND `id`=1;
INSERT INTO `quest_poi` (`QuestId`, `id`, `ObjectiveIndex`, `MapId`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES (1945,1,4,1,43,0,0,1,0);
DELETE FROM `quest_poi_points` WHERE `QuestId`=1945 AND `Idx1`=1;
INSERT INTO `quest_poi_points` (`QuestId`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(1945, 1, 0, 2797, -1812, 0),
(1945, 1, 1, 2524, -1801, 0),
(1945, 1, 2, 2519, -1618, 0);
