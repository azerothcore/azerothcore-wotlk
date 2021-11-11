INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636656798364802400');

DELETE FROM `command` WHERE `name` IN ('inventory','inventory count');
INSERT INTO `command` VALUES
('inventory',1,'Syntax: .inventory $subcommand \nType .inventory to see the list of possible subcommands or .help inventory $subcommand to see info on subcommands'),
('inventory count',1,'Syntax: .inventory count $playerName or $plaerGuid \nCount free slots in bags divided into different bag types.');
