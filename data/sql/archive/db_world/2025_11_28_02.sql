-- DB update 2025_11_28_01 -> 2025_11_28_02
-- update loot of Deep Sea Monsterbelly School (192053)
-- Crystallized Water, Deep Sea Monsterbelly, Reinforced Crate
UPDATE `gameobject_loot_template` SET `GroupId` = 1 WHERE (`Entry` = 25671) AND (`Item` IN (37705, 41800, 44475));
-- Crystallized Water, Reinforced Crate
UPDATE `gameobject_loot_template` SET `Chance` = 0 WHERE (`Entry` = 25671) AND (`Item` IN (37705, 44475));

-- Pygmy Suckerfish, Sea Turtle, Blacktip Shark
UPDATE `gameobject_loot_template` SET `GroupId` = 2 WHERE (`Entry` = 25671) AND (`Item` IN (40199, 46109, 50289));
