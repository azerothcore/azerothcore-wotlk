-- DB update 2024_08_06_01 -> 2024_08_06_02
--
DELETE FROM `command` WHERE `name` = 'morph mount';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('morph mount', 1, 'Syntax: .morph mount #displayid - Change the selected target\'s mount\'s model ID to #displayid.');
