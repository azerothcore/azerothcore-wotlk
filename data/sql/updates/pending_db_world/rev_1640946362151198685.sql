INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640946362151198685');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 13036) AND (`Item` BETWEEN 18255 AND 18533);
DELETE FROM `creature_loot_template` WHERE (`Item` IN (18255, 18266, 18297, 18365)) AND (`Entry` != 14354);
DELETE FROM `creature_loot_template` WHERE (`Item` IN (18266, 18297, 18365)) AND (`Entry` = 14354);

