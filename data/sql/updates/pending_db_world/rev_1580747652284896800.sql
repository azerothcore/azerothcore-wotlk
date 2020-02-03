INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1580747652284896800');
DELETE FROM `command` WHERE  `name`='demorph';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('morph target', '1', 'Syntax: .morph target #displayid - Change the target\'s current model id to #displayid.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('morph reset', '1', 'Syntax: .morph reset - Doesn\'t use any parameters to reset the target\'s model');
UPDATE `command` SET `help`='Syntax: .morph $subcommand\r\nType .morph to see the list of possible subcommands or .help modify $subcommand to see info on subcommands' WHERE  `name`='morph';


