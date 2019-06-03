INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559053099143474521');

UPDATE `smart_scripts` SET `action_param2` = 4, `action_param3` = 10000 WHERE `source_type` = 9 AND `id` = 1 AND `entryorguid` IN (1847100,1847101,1847102,1847103,1847104);
UPDATE `smart_scripts` SET `action_param2` = 4, `action_param3` = 10000 WHERE `entryorguid` = 1847101 AND `source_type` = 9 AND `id` = 2;
