INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631995181138245446');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 5988) AND (`Item` IN (9206));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 7154) AND (`Item` IN (9206));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 7856) AND (`Item` IN (9206));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9240) AND (`Item` IN (9206));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10986) AND (`Item` IN (9206));
