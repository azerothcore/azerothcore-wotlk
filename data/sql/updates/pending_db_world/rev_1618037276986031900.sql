INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618037276986031900');

DELETE FROM `skinning_loot_template` WHERE (`entry` = 1984);

UPDATE `creature_template` SET `skinloot` = 100002 WHERE (`entry` IN (2032, 1984));
