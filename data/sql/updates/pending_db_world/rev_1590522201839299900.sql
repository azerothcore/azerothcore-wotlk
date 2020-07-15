INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590522201839299900');

DELETE FROM `creature_template_addon`  WHERE `entry` = 30944;
INSERT INTO `creature_template_addon` (`entry`, `bytes2`) VALUES
(30944, 0);
