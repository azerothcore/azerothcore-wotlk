INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1597499028423474100');

UPDATE `command` SET `name` = "character deleted purge", `help` = "Syntax: .character deleted purge [#keepDays]\r\nCompletely removes all characters from the database that where deleted more than #keepDays ago. If #keepDays not provided the used value from worldserver.conf option 'CharDelete.KeepDays'. If 'CharDelete.KeepDays' option is disabled (set to value 0) then this command can't be used without the specifying #keepDays parameter." WHERE (`name` = "character deleted old");
