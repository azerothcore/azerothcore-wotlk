INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629293337424377430');

UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` = 9198;
DELETE FROM `skinning_loot_template` WHERE `entry` = 9198;

