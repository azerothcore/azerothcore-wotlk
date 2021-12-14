INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639521847268743300');

UPDATE `creature_template` SET `mechanic_immune_mask` = 646135647 WHERE (`entry` IN (11502, 12057));
UPDATE `creature_template` SET `mechanic_immune_mask` = 646135583 WHERE (`entry` = 12056);
