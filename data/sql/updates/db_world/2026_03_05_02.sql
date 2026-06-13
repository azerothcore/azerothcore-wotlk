-- DB update 2026_03_05_01 -> 2026_03_05_02
--
DELETE FROM `reference_loot_template` WHERE `Entry` = 1011822 AND `Item` = 5093;

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3457) AND (`Item` IN (5093));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3457, 5093, 0, 30.1, 0, 1, 0, 1, 1, 'Razormane Stalker - Razormane Backstabber');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3456) AND (`Item` IN (5093));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3456, 5093, 0, 30.34, 0, 1, 0, 1, 1, 'Razormane Pathfinder - Razormane Backstabber');
