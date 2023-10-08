--
DELETE FROM `command` WHERE `name`='commentator';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('commentator', 2, 'Syntax: .commentator [on/off]\r\n\r\nEnable or Disable in game Commentator tag or show current state if on/off not provided.');
