INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1594986175990195100');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 124371 AND `id` = 4;
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 124371 AND `id` = 3;
