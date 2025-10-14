--
DELETE FROM `command` WHERE `name` = 'zonestats';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('zonestats', 1, '.debug zonestats [$playerName]\nDisplays the amount of players in the player\'s current zone.');
