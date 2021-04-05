INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617661090934443600');

UPDATE `creature_template` SET `InhabitType` = 3 WHERE (`entry` IN (1018, 1019, 1140));

DELETE FROM `creature` WHERE (`id` = 1018) AND (`guid` IN (9981));
INSERT INTO `creature` VALUES
(9981, 1018, 0, 0, 0, 1, 1, 180, 0, -3112.84, -3252.45, 65.1154, 5.6466, 300, 0, 0, 896, 0, 0, 0, 0, 0, '', 0);
