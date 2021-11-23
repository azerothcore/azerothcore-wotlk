ALTER TABLE world_db_version CHANGE COLUMN 2016_07_14_00 2016_07_28_00 bit;

-- loot for mindless servant 26536 in utgarde pinnacle
DELETE FROM `creature_loot_template` WHERE (Entry = 26536);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `ChanceOrQuestChance`, `LootMode`, `GroupId`, `mincountOrRef`, `maxcount`) VALUES
(26536, 33470, 10.7, 1, 0, 1, 7),
(26536, 26002, 3, 1, 1, -26002, 1),
(26536, 26011, 1, 1, 1, -26011, 1),
(26536, 26012, 1, 1, 1, -26012, 1),
(26536, 26040, 21.4, 1, 0, -26040, 1),
(26536, 33370, 3.6, 1, 1, 1, 1),
(26536, 33399, 3.6, 1, 1, 1, 1),
(26536, 33454, 35.5, 1, 0, 1, 1),
(26536, 37068, 0.69, 1, 1, 1, 1),
(26536, 37069, 0.69, 1, 1, 1, 1),
(26536, 37070, 0.69, 1, 1, 1, 1),
(26536, 45912, 0.1, 1, 1, 1, 1);
