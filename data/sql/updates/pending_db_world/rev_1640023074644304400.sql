INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640023074644304400');

UPDATE `smart_scripts` SET `event_param2` = 1 WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 0;
UPDATE `smart_scripts` SET `event_param2` = 0  WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 1;
