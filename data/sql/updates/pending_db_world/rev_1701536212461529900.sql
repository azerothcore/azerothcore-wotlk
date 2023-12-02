-- Fix loot Prospecting Adamantite Ore --

DELETE FROM `reference_loot_template` WHERE (`Entry` = 13003);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13003, 21929, 0, 0, 0, 1, 1, 1, 1, 'Flame Spessarite'),
(13003, 23077, 0, 0, 0, 1, 1, 1, 1, 'Blood Garnet'),
(13003, 23079, 0, 0, 0, 1, 1, 1, 1, 'Deep Peridot'),
(13003, 23107, 0, 0, 0, 1, 1, 1, 1, 'Shadow Draenite'),
(13003, 23112, 0, 0, 0, 1, 1, 1, 1, 'Golden Draenite'),
(13003, 23117, 0, 0, 0, 1, 1, 1, 1, 'Azure Moonstone');

UPDATE `prospecting_loot_template` SET `Reference` = 13003 WHERE (`entry` = 23425) AND (`Item` IN (1));
