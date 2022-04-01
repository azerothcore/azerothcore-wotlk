INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648810356834040900');

DELETE FROM `command` WHERE `name` IN ('respawn', 'respawn all');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('respawn', 2, 'Syntax: .respawn\nRespawn the selected unit without waiting respawn time expiration.'),
('respawn all', 4, 'Syntax: .respawn all\nRespawn all nearest creatures and GO without waiting respawn time expiration.');
