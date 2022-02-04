INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644010195021128100');

UPDATE `command` SET `help` = 'Syntax: .instance unbind <mapid|all> [player] [difficulty]\nClear all/some of player/targets/self \'s binds' WHERE `name` = 'instance unbind';
