-- DB update 2022_06_18_13 -> 2022_06_18_14
--
DELETE FROM `creature_loot_template` WHERE item=6838;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(1111, 6838, 0, 100, 1, 1, 2, 1, 1, 'Leech Stalker - Scorched Spider Fang'),
(1111, 6838, 0, 50, 1, 1, 3, 1, 1, 'Leech Stalker - Scorched Spider Fang'),
(4040, 6838, 0, 100, 1, 1, 2, 1, 1, 'Cave Stalker - Scorched Spider Fang'),
(4040, 6838, 0, 50, 1, 1, 3, 1, 1, 'Cave Stalker - Scorched Spider Fang');

DELETE FROM `creature_loot_template` WHERE item=6839;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(4031, 6839, 0, 100, 1, 1, 2, 1, 1, 'Fledgling Chimaera - Charred Horn'),
(4031, 6839, 0, 34, 1, 1, 3, 1, 1, 'Fledgling Chimaera - Charred Horn'),
(4031, 6839, 0, 34, 1, 1, 4, 1, 1, 'Fledgling Chimaera - Charred Horn'),
(4032, 6839, 0, 100, 1, 1, 2, 1, 1, 'Young Chimaera - Charred Horn'),
(4032, 6839, 0, 34, 1, 1, 3, 1, 1, 'Young Chimaera - Charred Horn'),
(4032, 6839, 0, 34, 1, 1, 4, 1, 1, 'Young Chimaera - Charred Horn');
