--
DELETE FROM `acore_string` WHERE `entry` IN (283,300,301,11003);
INSERT INTO `acore_string` (`entry`, `content_default`, locale_deDE) VALUES
(283, "%s has disabled %s's chat for %s, effective at the player's next login. Reason: %s.", "Ihr habt dem Spieler %s das chatten für %s gesperrt, beginnend mit dem nächsten Login des Spielers. Grund: %s."),
(300, "Your chat has been disabled for %s. By: %s, Reason: %s.", "Euer Chat wurde für %s abgeschaltet. Von: %s, Grund: %s"),
(301, "%s has disabled %s's chat for %s. Reason: %s.", "Ihr hab den Chat von %s für %s abgeschaltet. Von: %s, Grund: %s"),
(11003, "Server: %s has muted %s for %s, reason: %s", NULL);

DELETE FROM `command` WHERE `name` IN ("mute");
INSERT INTO `command` (`name`, `security`, `help`) VALUES
("mute", 2, "Syntax: .mute [$playerName] $mutetime [$reason]\nDisible chat messaging for any character from account of character $playerName (or currently selected) at $mutetime time. Player can be offline.\n$mutetime: use a timestring like \"1d15h33s\".");