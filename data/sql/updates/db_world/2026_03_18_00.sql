-- DB update 2026_03_17_00 -> 2026_03_18_00
--
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34175) AND (`Item` IN (40547, 40549));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34175, 40549, 0, 0, 0, 1, 1, 1, 1, 'Boots of the Renewed Flight');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 26094) AND (`Item` IN (43953, 43952));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26094, 43952, 0, 1, 0, 1, 0, 1, 1, 'Alexstrasza\'s Gift - Reins of the Azure Drake');
