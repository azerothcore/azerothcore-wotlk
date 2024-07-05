-- DB update 2024_06_20_01 -> 2024_06_20_02
UPDATE `gameobject_loot_template` SET `Reference` = 13002, `Chance` = 20 WHERE `Entry` = 26862 AND `Reference` = 12901; -- Rare gems, reference currently unused I think
UPDATE `gameobject_loot_template` SET `MaxCount` = 3 WHERE `Entry` = 26862 AND `Item` = 34907; -- Shattered gem fragments

UPDATE `gameobject_loot_template` SET `Chance` = 50 WHERE `Entry` = 26862 AND `Reference` = 12903; -- Epic gems
 -- Rare gem reference
UPDATE `reference_loot_template` SET `MaxCount` = 2 WHERE `Entry` = 13002;
