-- DB update 2024_12_20_00 -> 2024_12_20_01
--
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (2359, 4120, 6073, 4499, 824, 624, 2450, 4113, 2269, 4844, 4846, 623, 674, 1094, 4849, 3586, 1167, 1393, 14427)) AND (`Item` IN (2838));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2359, 2838, 0, 25, 0, 1, 0, 1, 2, 'Heavy Stone -- Elemental Slave'),
(4120, 2838, 0, 25, 0, 1, 0, 1, 2, 'Heavy Stone -- Thundering Boulderkin'),
(6073, 2838, 0, 25, 0, 1, 0, 1, 2, 'Heavy Stone -- Searing Infernal'),
(4499, 2838, 0, 4, 0, 1, 0, 1, 1, 'Heavy Stone -- Defias Worker'),
(824, 2838, 0, 4, 0, 1, 0, 1, 1, 'Defias Digger'),
(624, 2838, 0, 3, 0, 1, 0, 1, 1, 'Heavy Stone -- Undead Excavator'),
(2450, 2838, 0, 2, 0, 1, 0, 1, 3, 'Heavy Stone -- Miner Hackett'),
(4113, 2838, 0, 2.66, 0, 1, 0, 1, 3, 'Heavy Stone -- Gravelsnout Digger'),
(2269, 2838, 0, 1.44, 0, 1, 0, 1, 3, 'Heavy Stone -- Hillsbrad Miner'),
(4844, 2838, 0, 1.1, 0, 1, 0, 1, 3, 'Heavy Stone -- Shadowforge Surveyor'),
(4846, 2838, 0, 1.1, 0, 1, 0, 1, 3, 'Heavy Stone -- Shadowforge Digger'),
(623, 2838, 0, 1, 0, 1, 0, 1, 1, 'Heavy Stone -- Skeletal Miner'),
(674, 2838, 0, 0.9, 0, 1, 0, 1, 3, 'Heavy Stone -- Venture CO Stripminer'),
(1094, 2838, 0, 0.9, 0, 1, 0, 1, 3, 'Heavy Stone -- Venture CO Miner'),
(4849, 2838, 0, 0.81, 0, 1, 0, 1, 3, 'Heavy Stone -- Shadowforge Archaeologist'),
(3586, 2838, 0, 0.8, 0, 1, 0, 1, 1, 'Heavy Stone -- Miner Johnson'),
(1167, 2838, 0, 0.8, 0, 1, 0, 1, 1, 'Heavy Stone -- Stonesplinter Digger'),
(1393, 2838, 0, 0.6, 0, 1, 0, 1, 1, 'Heavy Stone -- Beserk Trogg'),
(14427, 2838, 0, 0.4, 0, 1, 0, 3, 3, 'Heavy Stone -- Gibblesnik');