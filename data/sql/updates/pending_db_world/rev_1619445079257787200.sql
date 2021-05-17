INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619445079257787200');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 2560) AND (`Item` IN (4100, 4101, 4102));
