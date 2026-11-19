-- DB update 2026_10_27_02 -> 2026_10_27_03
-- Sweet Amber (48, 53): objective POIs are on the Westfall map (UiMap 1436) in 3.4.3 sniffs
UPDATE `quest_poi` SET `WorldMapAreaId` = 39 WHERE `QuestID` IN (48, 53) AND `id` = 0;
UPDATE `quest_poi` SET `VerifiedBuild` = 51831 WHERE `QuestID` IN (48, 53) AND `id` IN (0, 1);
UPDATE `quest_poi_points` SET `VerifiedBuild` = 51831 WHERE `QuestID` IN (48, 53) AND `Idx1` IN (0, 1) AND `Idx2` = 0;
