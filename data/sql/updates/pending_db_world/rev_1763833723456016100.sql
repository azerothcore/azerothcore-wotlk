-- update loot of Deep Sea Monsterbelly School (192053)
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 25671) AND (`Item` IN (37705, 40199, 41800, 44475, 46109, 50289));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25671, 37705, 0, 5, 0, 1, 1, 1, 1, 'Deep Sea Monsterbelly School - Crystallized Water'),
(25671, 40199, 0, 40, 0, 1, 1, 1, 1, 'Deep Sea Monsterbelly School - Pygmy Suckerfish'),
(25671, 41800, 0, 0, 0, 1, 1, 1, 1, 'Deep Sea Monsterbelly School - Deep Sea Monsterbelly'),
(25671, 44475, 0, 5, 0, 1, 1, 1, 1, 'Deep Sea Monsterbelly School - Reinforced Crate'),
(25671, 46109, 0, 0.01, 0, 1, 1, 1, 1, 'Deep Sea Monsterbelly School - Sea Turtle'),
(25671, 50289, 0, 0.05, 0, 1, 1, 1, 1, 'Deep Sea Monsterbelly School - Blacktip Shark');
