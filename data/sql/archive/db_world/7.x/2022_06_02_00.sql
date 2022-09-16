-- DB update 2022_05_30_02 -> 2022_06_02_00
--
DELETE FROM `command` WHERE `name` IN ("deserter instance add", "deserter instance remove", "deserter instance remove all", "deserter bg add", "deserter bg remove", "deserter bg remove all");

INSERT INTO `command` (`name`, `security`, `help`) VALUES
("deserter instance add", 3, "Syntax: .deserter instance add $playerName $time \n\n Adds the instance deserter debuff to a player or your target with $time duration."),
("deserter instance remove", 3, "Syntax: .deserter instance remove $playerName \n\n Removes the instance deserter debuff from a player or your target."),
("deserter instance remove all", 3, "Syntax: .deserter instance remove all \n\n Removes the instance deserter debuff from all online and offline players."),
("deserter bg add", 3, "Syntax: .deserter bg add $playerName $time \n\n Adds the bg deserter debuff to a player or your target with $time duration."),
("deserter bg remove", 3, "Syntax: .deserter bg remove $playerName \n\n Removes the bg deserter debuff from a player or your target."),
("deserter bg remove all", 3, "Syntax: .deserter bg remove all \n\n Removes the bg deserter debuff from all online and offline players.");
