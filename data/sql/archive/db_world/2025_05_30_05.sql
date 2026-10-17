-- DB update 2025_05_30_04 -> 2025_05_30_05
--
DELETE FROM `command` WHERE `name`IN('debug boundary');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('debug boundary', 3, 'Syntax: .debug boundary [duration] [fill] [z]\nOptional arguments:\n- duration: Duration in ms (default: 5000, max: 180000).\n- fill: Fills the boundary with markers.\n- z: Includes z-axis in visualization.');
