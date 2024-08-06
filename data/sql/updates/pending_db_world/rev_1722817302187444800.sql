--
DELETE FROM `command` WHERE `name` = 'morph mount';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('morph mount', 1, 'Syntax: .morph mount #displayid - Change the selected target\'s mount\'s model ID to #displayid.');
