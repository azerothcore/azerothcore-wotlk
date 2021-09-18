INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631994698247378987');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7153) AND (`Item` IN (9155));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 8598) AND (`Item` IN (9155));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 11462) AND (`Item` IN (9155));
