INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1580747652284896800');
UPDATE `command` SET `help`='Syntax: .morph #displayid\r\n              .morph reset\r\n\r\n1. Change your current model id to #displayid.\r\n2. Reset the model of the selected target' WHERE  `name`='morph';
DELETE FROM `command` WHERE  `name`='demorph';