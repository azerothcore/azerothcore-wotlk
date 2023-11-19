-- DB update 2023_11_19_05 -> 2023_11_19_06
-- Update `.go xyz` syntax
DELETE FROM `command` WHERE `name`='go xyz';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('go xyz', 1, '\rSyntax: .go xyz #x #y [#z [#mapid [#orientation]]]\r\rTeleport player to point with (#x,#y,#z) coordinates at map #mapid with orientation #orientation.\r\rIf #z is not provided, ground/water level will be used. If #mapid is not provided, the current map will be used. If #orientation is not provided, the current orientation will be used.\r\rNon-numbers are allowed and will be ignored.');
