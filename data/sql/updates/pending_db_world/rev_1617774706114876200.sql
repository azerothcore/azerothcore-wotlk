INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617774706114876200');

DELETE FROM `creature` WHERE (`id` = 16313) AND (`guid` IN (81792));
INSERT INTO `creature` VALUES
(81792, 16313, 530, 0, 0, 1, 1, 0, 0, 7937.95, -7354.2, 144.804, 5.9059, 300, 0, 0, 166, 178, 0, 0, 0, 0, '', 0);
