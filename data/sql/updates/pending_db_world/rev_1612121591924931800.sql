INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612121591924931800');

DELETE FROM `creature_template_addon` WHERE `entry` IN (32149,32255);
INSERT INTO `creature_template_addon` (`entry`, `bytes1`, `bytes2`, `auras`) VALUES
(32149, 0, 1, "54262"),
(32255, 0, 1, "54262 60231");
