INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623193677054313100');

-- Remove Conjured Mana Agate drop from Vultros
DELETE FROM `creature_loot_template` WHERE `entry` = 462 AND `item` = 5514;
