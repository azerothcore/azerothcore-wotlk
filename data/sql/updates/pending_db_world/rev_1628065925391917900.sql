INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628065925391917900');

-- Changed the spell Chill(28547) to Chilled(15850) for Chillwind Ravager(7449)
UPDATE `smart_scripts` SET `action_param1` = 15850, `comment` = 'Chillwind Ravager - In Combat - Cast \'Chilled\'' WHERE (`entryorguid` = 7449) AND (`source_type` = 0) AND (`id` IN (0));

