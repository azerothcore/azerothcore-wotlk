INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634327540840591400');

DELETE FROM `command` WHERE `name` IN ('bags','bags clear');
INSERT INTO `command` VALUES
('bags',2,'Syntax: .bags $subcommand \nType .bags to see the list of possible subcommands or .help bags $subcommand to see info on subcommands'),
('bags clear',2,'Syntax: .bags clear $itemQuality \nClear from players\' bags all items including and below $itemQuality (or all items if used .bags clear all).');
