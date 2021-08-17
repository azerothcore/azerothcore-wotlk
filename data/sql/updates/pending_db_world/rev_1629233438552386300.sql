INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629233438552386300');

UPDATE `command` SET `help` = 'Syntax: .modify mount #id #speed\nDisplay selected player as mounted at #creatureDisplayID and set speed to #speed value between 0.1 - 50.0' WHERE `name` = 'modify mount';
