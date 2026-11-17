--
DELETE FROM `quest_poi` WHERE (`QuestID`, `id`) IN ((7640,0));
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`,
`VerifiedBuild`) VALUES
(7640,0,-1,0,30,0,0,1,51831);

DELETE FROM `quest_poi_points` WHERE (`QuestID`, `Idx1`) IN ((7640,0));
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(7640,0,0,-8577,881,51831);
