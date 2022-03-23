INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648075927512739900');

DELETE FROM `smart_scripts`  WHERE `entryorguid` = 1373 AND `id` IN (9, 10);
UPDATE `smart_scripts` SET `action_param2` = 45 WHERE `entryorguid` = 1373 AND `id` = 3;
UPDATE `smart_scripts` SET `action_param2` = 44 WHERE `entryorguid` = 1373 AND `id` = 4;
UPDATE `smart_scripts` SET `id` = 9 WHERE `entryorguid` = 1373 AND `id` = 11;
UPDATE `smart_scripts` SET `id` = 10 WHERE `entryorguid` = 1373 AND `id` = 12;
UPDATE `smart_scripts` SET `id` = 11 WHERE `entryorguid` = 1373 AND `id` = 13;
