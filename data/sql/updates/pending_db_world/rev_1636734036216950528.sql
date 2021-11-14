INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636734036216950528');

-- Add missing gossip text for Finkle Einhorn
DELETE FROM `gossip_menu` WHERE `MenuID` IN (2994,2995,2996,2997,2998,2999);
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES
(2994,3660),(2995,3661),(2996,3662),(2997,3663),(2998,3664),(2999,3665);
