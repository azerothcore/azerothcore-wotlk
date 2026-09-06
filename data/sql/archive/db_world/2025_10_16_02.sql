-- DB update 2025_10_16_01 -> 2025_10_16_02
--
DELETE FROM `command` WHERE `name` = "packetlog";
INSERT INTO `command` (`name`, `security`, `help`) VALUES
("packetlog", 2, "Syntax: .packetlog [on/off]\n Toggles to allow the character using the command to start to log their packets into the server, PacketLogFile needs to be set with a valid filename");
