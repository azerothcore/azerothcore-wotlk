INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625577114142882549');

-- Delete various incorrect items from Torwa's Pouch
DELETE FROM `item_loot_template` WHERE `Entry` = 11568 AND `Item` IN (2450, 3820, 8838, 11018, 16204);
-- Make Preserved Pheromone Mixture drop with 100% chance
UPDATE `item_loot_template` SET `Chance` = 100 WHERE `Entry` = 11568 AND `Item` = 11570;

-- Delete Threshadon Meat/Preserved Pheromone from Hoard of the Black Dragonflight
DELETE FROM `item_loot_template` WHERE `Entry` = 10569 AND `Item` IN (11569, 11570);

-- Delete Threshadon Meat/Preserved Pheromone from A Small Pack
DELETE FROM `item_loot_template` WHERE `Entry` = 11107 AND `Item` IN (11569, 11570);
