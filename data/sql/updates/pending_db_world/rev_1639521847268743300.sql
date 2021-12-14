INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639521847268743300');

UPDATE `creature_template` SET `mechanic_immune_mask`= `mechanic_immune_mask`&~ 16384 WHERE (`entry` IN (11502, 12057, 12056));
