--
DELETE FROM `quest_poi` WHERE (`QuestID`, `id`) IN ((7640,0), (7640,1));
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`,
`VerifiedBuild`) VALUES
(7640,0,-1,0,301,0,0,3,0),
(7640,1,0,0,23,0,0,1,0);

DELETE FROM `quest_poi_points` WHERE (`QuestID`, `Idx1`) IN ((7640,1));
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(7640,1,0,2796,-3022,0),
(7640,1,1,2855,-3072,0),
(7640,1,2,2980,-3081,0),
(7640,1,3,3151,-2812,0),
(7640,1,4,2966,-2693,0),
(7640,1,5,2930,-2725,0),
(7640,1,6,2896,-2756,0);
