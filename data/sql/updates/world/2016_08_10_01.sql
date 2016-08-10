INSERT IGNORE INTO `command` (`name`, `security`, `help`) VALUES
('instance setbossstate', 2, 'Syntax: .instance setbossstate $bossId $encounterState [$Name]\r\nSets the EncounterState for the given boss id to a new value. EncounterStates range from 0 to 5.\r\nIf no character name is provided, the current map will be used as target.'),
('instance getbossstate', 2, 'Syntax: .instance getbossstate $bossId [$Name]\r\nGets the current EncounterState for the provided boss id.\r\nIf no character name is provided, the current map will be used as target.');
