-- DB update 2022_06_22_02 -> 2022_06_22_03
--
DELETE FROM `command` WHERE `name` IN ("deserter instance remove all", "deserter bg remove all");

INSERT INTO `command` (`name`, `security`, `help`) VALUES
("deserter instance remove all", 3, "Syntax: .deserter instance remove all <$maxDuration>\r\n Removes the instance deserter debuff from all online and offline players.\nOptional $maxDuration sets the maximum duration to be removed. Use a timestring like \"1h45m\". \"-1\" for any duration. Default: 30m"),
("deserter bg remove all", 3, "Syntax: .deserter bg remove all <$maxDuration>\r\n Removes the bg deserter debuff from all online and offline players.\nOptional $maxDuration sets the maximum duration to be removed. Use a timestring like \"1h45m\". \"-1\" for any duration. Default: 15m");