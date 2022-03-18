INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647391921098550500');

-- Update target for quest credit
UPDATE `smart_scripts` SET `target_type` = 21, `target_param1` = 5 WHERE `entryorguid` = 7207 AND `id` = 1;
