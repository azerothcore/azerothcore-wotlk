--
DELETE FROM `command` WHERE `name` IN ("deserter instance remove all", "deserter bg remove all");

INSERT INTO `command` (`name`, `security`, `help`) VALUES
("deserter instance remove all", 3, "Syntax: .deserter instance remove all <maxDuration> \n\n Removes the instance deserter debuff from all online and offline players.\r\nmaxDuration sets the maximum duration to be removed. Defaults to 30min if unspecified. Use -1 for any duration."),
("deserter bg remove all", 3, "Syntax: .deserter bg remove all <maxDuration> \n\n Removes the bg deserter debuff from all online and offline players.\r\nmaxDuration sets the maximum duration to be removed. Defaults to 15min if unspecified. Use -1 for any duration.");