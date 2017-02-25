-- Added Command cs_deserter
-- By Bodeguero for AzerothCore.

DELETE FROM `command` WHERE `name` IN
("deserter",
"deserter  instance add",
"deserter instance remove",
"deserter bg add",
"deserter bg remove");

REPLACE INTO `command` (`name`, `security`, `help`) VALUES
("deserter", 4, "Syntax: .deserter \n\n Type: .deserter to see the list of possible subcommands"),
("deserter instance add", 4, "Syntax: .deserter instance add $time \n\n Adds the instance deserter debuff to your target with $time duration."),
("deserter instance remove", 4, "Syntax: .deserter instance remove \n\n Removes the instance deserter debuff from your target."),
("deserter bg add", 4, "Syntax: .deserter bg add $time \n\n Adds the bg deserter debuff to your target with $time duration."),
("deserter bg remove", 4, "Syntax: .deserter bg remove \n\n Removes the bg deserter debuff from your target.");