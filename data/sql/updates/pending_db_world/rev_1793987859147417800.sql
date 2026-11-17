-- Pristine Spider Silk (1940), Items of Power (1948), Power in Uldaman (1956): POIs match 3.4.3 51831 sniffs
UPDATE `quest_poi` SET `VerifiedBuild` = 51831
WHERE (`QuestID`, `id`) IN ((1940,0), (1948,0), (1948,1), (1948,2), (1956,0));
UPDATE `quest_poi_points` SET `VerifiedBuild` = 51831
WHERE (`QuestID`, `Idx1`) IN ((1940,0), (1948,0), (1948,1), (1948,2), (1956,0));
