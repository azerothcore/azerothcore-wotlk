--
DELETE FROM `command` WHERE `name` = 'debug zonestats';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('debug zonestats', 1, '.debug zonestats [$playerName]\nDisplays the amount of players in the player\'s current zone.');
