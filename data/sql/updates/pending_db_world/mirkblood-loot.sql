UPDATE `creature_template` SET `lootid` = 28194, `mingold` = 350000, `maxgold` = 450000 WHERE `entry` = 28194;

DELETE FROM `creature_loot_template` WHERE `Entry` = 28194;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28194, 39769, 0, 100, 0, 1, 0, 1, 1, 'Prince Tenris Mirkblood - Arcanite Ripper'),
(28194, 38658, 0, 100, 0, 1, 0, 1, 1, 'Prince Tenris Mirkblood - Vampiric Batling'),
(28194, 29434, 0, 100, 0, 1, 0, 2, 2, 'Prince Tenris Mirkblood - Badge of Justice'),
(28194, 4113, 4113, 100, 0, 1, 0, 1, 1, 'Prince Tenris Mirkblood - (ReferenceTable)');
