INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547165890320901800');

DELETE FROM `trinity_string` WHERE `entry` BETWEEN 5062 AND 5071;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(5062, 'You will now read %s conversations.'),
(5063, 'Stopped spying %s.')
(5064, '%s is already being followed by: %s'),
(5065, 'Following %s\'s group, you will now read each player\'s conversations.'),
(5066, 'Stopped spying %s\'s group.'),
(5067, 'You are not spying %s\'s group.'),
(5068, 'Cleared all followed players.'),
(5069, '[ v ]==== Current spy list ====[ v ]'),
(5070, '[SPY] %s whispers %s: %s'),
(5071, '[SPY] %s tells group: %s');
