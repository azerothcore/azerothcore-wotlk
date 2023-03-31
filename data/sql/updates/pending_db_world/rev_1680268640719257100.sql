--
UPDATE `reference_loot_template` SET `GroupId` = 3 WHERE `Entry` = 25004 AND `Item` IN (28205,28231,28403,28413,28414,28415);

DELETE FROM `creature_loot_template` WHERE (`Entry` = 20912) AND (`Item` IN (25004, 1, 2));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20912, 1, 25004, 100, 0, 1, 2, 1, 1, 'Harbinger Skyriss - (ReferenceTable) Group 1'),
(20912, 2, 25004, 100, 0, 1, 3, 1, 1, 'Harbinger Skyriss - (ReferenceTable) Group 2');
