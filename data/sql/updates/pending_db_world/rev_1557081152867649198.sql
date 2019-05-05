INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557081152867649198');

INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena create', 3, 'Syntax: .arena create $name "arena name" #type\n\nA command to create a new Arena-team in game. #type  = [2/3/5]');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena disband', 3, 'Syntax: .arena disband #TeamID\n\nA command to disband Arena-team in game.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena rename', 3, 'Syntax: .arena rename "oldname" "newname"\n\nA command to rename Arena-team name.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena captain', 3, 'Syntax: .arena captain #TeamID $name\n\nA command to set new captain to the team $name must be in the team');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena info', 2, 'Syntax: .arena info #TeamID\n\nA command that show info about arena team');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('arena lookup', 2, 'Syntax: .arena lookup $name\n\nA command that give a list of arenateam with the given $name');
