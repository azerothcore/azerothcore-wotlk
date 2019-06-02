INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559456042362460279');

-- use "SMART_ACTION_MUSIC" instead of "SMART_ACTION_SOUND" to play "Lament of the Highborne" as music for the players in the area
UPDATE `smart_scripts` SET `action_type` = 216, `action_param2` = 1, `action_param3` = 2, `target_type` = 1, `target_param1` = 0, `comment` = 'Sylvanas Lamenter - On Update - Play Area Music' WHERE `entryorguid` = 39048 AND `source_type` = 0 AND `id` = 1;

-- use "onlySelf" 1 for Thrall event as the music needs to be played only for the players directly
UPDATE `smart_scripts` SET `action_param2` = 1 WHERE `entryorguid` = 19556 AND `source_type` = 0 AND `action_type` = 216;
