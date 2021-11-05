INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635874451387473500');

DELETE FROM `quest_poi` WHERE `QuestID`=8311 AND `id`>0;
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES
(8311,1,4,0,301,0,0,3,12340),
(8311,2,5,0,341,0,0,3,12340),
(8311,3,6,0,341,0,0,3,12340),
(8311,4,7,1,381,0,0,3,12340);

DELETE FROM `quest_poi_points` WHERE `QuestID`=8311 AND `Idx1`>0;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(8311,1,0,-8869,670,12340),
(8311,2,0,-4594,-1003,12340),
(8311,3,0,-4845,-860,12340),
(8311,4,0,10124,2227,12340);
