-- DB update 2026_06_12_01 -> 2026_06_12_02
DELETE FROM `creature_loot_template` WHERE `Entry` = 31610 AND `Item` = 41796;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31610, 41796, 0, 100, 0, 1, 0, 1, 1, 'Anub\'arak (1) - Design: Infused Twilight Opal');
