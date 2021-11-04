INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636046620398906100');

DELETE FROM `quest_poi` WHERE `QuestID` IN (11356,11357) AND `id`>0;
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES
(11356,1,-1,0,27,0,0,1,12340),
(11356,2,-1,530,464,0,0,1,12340),
(11357,1,-1,1,4,0,0,1,12340),
(11357,2,-1,530,462,0,0,1,12340);

DELETE FROM `quest_poi_points` WHERE `QuestID` IN(11356,11357) AND `Idx1`>0;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(11356,1,0,-5622,-473,12340),
(11356,2,0,-4187,-12501,12340),
(11357,1,0,356,-4742,12340),
(11357,2,0,9516,-6815,12340);
