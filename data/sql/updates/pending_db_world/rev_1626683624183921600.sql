INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626683624183921600');

-- Changed the param WP_START run from 1 to 0 so he walks when the quest starts.
UPDATE `smart_scripts` SET `action_param1` = 0 WHERE (`entryorguid` = 1379) AND (`source_type` = 0) AND (`id` IN (0));

