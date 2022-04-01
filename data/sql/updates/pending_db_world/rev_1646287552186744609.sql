INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646287552186744609');

DELETE FROM `command` WHERE `name`='debug objectcount';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug objectcount',3,'Syntax: .debug objectcount <optional map id> Shows the number of Creatures and GameObjects for the specified map id or for all maps if none is specified');
