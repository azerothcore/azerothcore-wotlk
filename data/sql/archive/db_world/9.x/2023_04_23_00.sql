-- DB update 2023_04_22_11 -> 2023_04_23_00
--
-- Put Item 1219 Redridge Machete loot on right mob
DELETE FROM `reference_loot_template` WHERE  `Entry`=24077 AND `Item`=1219;
DELETE FROM `creature_loot_template` WHERE  `Entry`=424 AND `Item`=1219 AND `Reference`=0 AND `GroupId`=0;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(424, 1219, 0, 2, 0, 1, 0, 1, 1, 'Redridge Poacher - Redridge Machete');
