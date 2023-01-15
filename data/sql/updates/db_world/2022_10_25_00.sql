-- DB update 2022_10_23_02 -> 2022_10_25_00
--
DELETE FROM `acore_string` WHERE `entry` = 5083;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5083, 'Character %s (%u) moved from account %s (%u) to account %s (%u).');

DELETE FROM `command` WHERE `name` = 'character changeaccount';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('character changeaccount', 3, 'Syntax: .character changeaccount $NewAccountName $Name.\nMoves the specified character to the provided account. \nKicks the player if the character is online.');
