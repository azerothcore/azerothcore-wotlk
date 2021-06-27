INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624165153573726801');

-- Removes Green Linen Shirt from Skeletal Warrior
DELETE FROM `creature_loot_template` WHERE `Entry` = 48 AND `Item` = 2579;
