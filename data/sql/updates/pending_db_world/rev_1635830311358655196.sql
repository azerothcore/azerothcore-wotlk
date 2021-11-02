INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635830311358655196');

DELETE FROM `command` WHERE `name` IN ('teleport name npc id','teleport name npc guid','teleport name npc name');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('teleport name npc id',2,'Syntax: .teleport name id #playername #creatureId
Teleport the given character to first found creature with id #creatureId. Character can be offline.'),
('teleport name npc guid',2,'Syntax: .teleport name id #playername #creatureSpawnId
Teleport the given character to creature with spawn id #creatureSpawnId. Character can be offline.'),
('teleport name npc name',2,'Syntax: .teleport name id #playername #creatureName
Teleport the given character to first found creature with name (must match exactly) #creatureName. Character can be offline.');
