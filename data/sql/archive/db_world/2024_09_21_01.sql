-- DB update 2024_09_21_00 -> 2024_09_21_01
DELETE FROM `command` WHERE `name` = 'debug cooldown';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('debug cooldown', 3, 'Syntax: .debug cooldown #spellID #cooldownTime #itemID\nApply a cooldown of the given duration (in milliseconds) for the given spell and item ID.');
