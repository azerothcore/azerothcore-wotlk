--
UPDATE `command` SET `help`='Syntax: .wpgps\r\nOutput current position to sql developer log as partial SQL query to be used in pathing (formated for waypoint_data table).\r\nUse .wpgps sai for waypoint (SAI) table format.' WHERE `name`='wpgps';

DELETE FROM `command` WHERE `name`='wpgps sai';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('wpgps sai', 3, 'Syntax: .wpgps sai\r\n\r\nOutput current position to sql developer log as partial SQL query to be used in pathing (formated for waypoint (SAI) table).');
