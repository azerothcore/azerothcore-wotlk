INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641972530727711400');

-- Goblin Rocket Fuel and Discombobulator Ray should have 100% drop chance from Mux's Quality Goods
UPDATE `item_loot_template` SET `Chance` = 100 WHERE `Item` IN (4388, 9061) AND `Entry` = 22320;
