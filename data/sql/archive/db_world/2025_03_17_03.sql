-- DB update 2025_03_17_02 -> 2025_03_17_03
UPDATE `quest_poi` SET `WorldMapAreaId` = 1421, `VerifiedBuild` = 51831 WHERE (`QuestID` = 8948) AND (`id` = 0);
UPDATE `quest_poi_points` SET `VerifiedBuild` = 51831 WHERE (`QuestID` = 8948) AND (`Idx1` = 0) AND (`Idx2` = 0);
