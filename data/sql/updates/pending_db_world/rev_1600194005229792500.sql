INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1600194005229792500');

-- Delete LANG_FLEE and LANG_CALL_FOR_HELP
DELETE FROM `acore_string` WHERE `entry` IN (5035,5030);
