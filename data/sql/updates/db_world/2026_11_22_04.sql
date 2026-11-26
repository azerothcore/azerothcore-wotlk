-- DB update 2026_11_22_03 -> 2026_11_22_04
--
UPDATE `quest_poi` SET `VerifiedBuild` = 51831 WHERE `QuestID` = 7640 AND `id` = 0;
UPDATE `quest_poi_points` SET `VerifiedBuild` = 51831 WHERE `QuestID` = 7640 AND `Idx1` = 0 AND `Idx2` = 0;
