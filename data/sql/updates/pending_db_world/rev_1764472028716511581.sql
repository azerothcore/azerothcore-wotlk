UPDATE `quest_poi` SET `MapID` = 571, `WorldMapAreaId` = 491 WHERE `QuestID` = 11527;

DELETE FROM `quest_poi_points` WHERE `QuestID` = 11527;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(11527, 0, 0, 118, -3697, 0),
(11527, 1, 0, 118, -3697, 0);
