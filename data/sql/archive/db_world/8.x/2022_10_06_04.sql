-- DB update 2022_10_06_03 -> 2022_10_06_04
-- Horde "Trial of the Sea Lion" Quest ID 30 POI fix
UPDATE `quest_poi` SET `WorldMapAreaId`=17 WHERE `QuestID`=30 AND `MapID`=1;
UPDATE `quest_poi_points` SET `X`=1050, `Y`=-3119 WHERE `QuestID`=30 AND `Idx1`=2;
-- Alliance "Trial of the Sea Lion" Quest ID 272 POI fix
UPDATE `quest_poi` SET `WorldMapAreaId`=40 WHERE `QuestID`=272 AND `MapID`=0;
UPDATE `quest_poi_points` SET `X`=-10172, `Y`=2391 WHERE `QuestID`=272 AND `Idx1`=2;
