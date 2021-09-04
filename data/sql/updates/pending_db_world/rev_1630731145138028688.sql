INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630731145138028688');

-- Update frequency of Rift Spawn health check for stun to 1 second
UPDATE `smart_scripts` SET `event_param3` = 1000, `event_param4` = 1000 WHERE `entryorguid` = 6492 AND `source_type` = 0 AND `id` = 5;

