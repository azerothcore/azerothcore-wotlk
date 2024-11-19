-- DB update 2023_10_07_02 -> 2023_10_08_00
--
DELETE FROM `command` WHERE `name`='commentator';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('commentator', 2, 'Syntax: .commentator [on/off]\r\n\r\nEnable or Disable in game Commentator tag or show current state if on/off not provided.');
