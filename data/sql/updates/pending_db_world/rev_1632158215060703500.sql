INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632158215060703500');

DELETE FROM `creature_loot_template` WHERE `Entry` IN (2640, 4442, 6514, 6527, 8299, 9318, 9416, 10419, 11456, 11462) AND `Item` = 9197;
