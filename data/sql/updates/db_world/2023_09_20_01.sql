-- DB update 2023_09_20_00 -> 2023_09_20_01
UPDATE `quest_poi` SET `WorldMapAreaId` = 24 WHERE (`QuestID` = 7321) AND (`id` IN (0,1,2,3));
UPDATE `quest_poi` SET `id` = 4, `ObjectiveIndex` = -1 WHERE (`QuestID` = 7321) AND (`id` = 0);
UPDATE `quest_poi` SET `id` = 5, `Flags` = 3 WHERE (`QuestID` = 7321) AND (`id` = 1);
UPDATE `quest_poi` SET `id` = 6, `Flags` = 3 WHERE (`QuestID` = 7321) AND (`id` = 2);
UPDATE `quest_poi` SET `id` = 7, `ObjectiveIndex` = 4, `Flags` = 3 WHERE (`QuestID` = 7321) AND (`id` = 3);
UPDATE `quest_poi_points` SET `Idx1` = 4, `Idx2` = 0, `X` = -852, `Y` = -594 WHERE (`QuestID` = 7321) AND (`Idx1` = 0) AND (`Idx2` = 0);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 0, `X` = -662, `Y` = -755 WHERE (`QuestID` = 7321) AND (`Idx1` = 0) AND (`Idx2` = 1);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 1, `X` = -646, `Y` = -742 WHERE (`QuestID` = 7321) AND (`Idx1` = 0) AND (`Idx2` = 2);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 2, `X` = -657, `Y` = -731 WHERE (`QuestID` = 7321) AND (`Idx1` = 0) AND (`Idx2` = 3);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 3, `X` = -672, `Y` = -723 WHERE (`QuestID` = 7321) AND (`Idx1` = 0) AND (`Idx2` = 4);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 4, `X` = -688, `Y` = -718 WHERE (`QuestID` = 7321) AND (`Idx1` = 0) AND (`Idx2` = 5);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 5, `X` = -714, `Y` = -710 WHERE (`QuestID` = 7321) AND (`Idx1` = 1) AND (`Idx2` = 0);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 6, `X` = -901, `Y` = -658 WHERE (`QuestID` = 7321) AND (`Idx1` = 1) AND (`Idx2` = 1);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 7, `X` = -919, `Y` = -668 WHERE (`QuestID` = 7321) AND (`Idx1` = 1) AND (`Idx2` = 2);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 8, `X` = -917, `Y` = -676 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 0);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 9, `X` = -904, `Y` = -689 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 1);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 10, `X` = -875, `Y` = -716 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 2);
UPDATE `quest_poi_points` SET `Idx1` = 5, `Idx2` = 11, `X` = -854, `Y` = -726 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 3);
UPDATE `quest_poi_points` SET `Idx1` = 6, `Idx2` = 0, `X` = -480, `Y` = -989 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 4);
UPDATE `quest_poi_points` SET `Idx1` = 6, `Idx2` = 1, `X` = -475, `Y` = -963 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 5);
UPDATE `quest_poi_points` SET `Idx1` = 6, `Idx2` = 2, `X` = -480, `Y` = -936 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 6);
UPDATE `quest_poi_points` SET `Idx1` = 6, `Idx2` = 3, `X` = -543, `Y` = -781 WHERE (`QuestID` = 7321) AND (`Idx1` = 2) AND (`Idx2` = 7);
UPDATE `quest_poi_points` SET `Idx1` = 6, `Idx2` = 4, `X` = -557, `Y` = -763 WHERE (`QuestID` = 7321) AND (`Idx1` = 3) AND (`Idx2` = 0);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 7321 AND `Idx1` = 6 AND `Idx2` IN (5,6,7,8,9,10,11);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 7321 AND `Idx1` = 7 AND `Idx2` IN (0,1,2,3,4,5,6,7,8,9,10,11);
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES 
(7321, 6, 5, -575, -742, 0),
(7321, 6, 6, -596, -747, 0),
(7321, 6, 7, -614, -784, 0),
(7321, 6, 8, -609, -797, 0),
(7321, 6, 9, -549, -926, 0),
(7321, 6, 10, -528, -965, 0),
(7321, 6, 11, -512, -984, 0),
(7321, 7, 0, -238, -1121, 0),
(7321, 7, 1, -254, -1107, 0),
(7321, 7, 2, -380, -1010, 0),
(7321, 7, 3, -415, -986, 0),
(7321, 7, 4, -428, -981, 0),
(7321, 7, 5, -438, -1021, 0),
(7321, 7, 6, -423, -1042, 0),
(7321, 7, 7, -373, -1084, 0),
(7321, 7, 8, -349, -1099, 0),
(7321, 7, 9, -296, -1128, 0),
(7321, 7, 10, -286, -1131, 0),
(7321, 7, 11, -249, -1142, 0);
