INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634394523910362900');

 -- Forsaken Thug
UPDATE `creature_template_addon` SET `mount` = 0, `bytes2` = 4097 WHERE `entry` = 3734;
UPDATE `creature_addon` SET `mount` = 0 WHERE `guid` IN (32905, 32906, 32907, 32908, 32909, 32910);
