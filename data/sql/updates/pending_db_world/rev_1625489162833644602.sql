INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625489162833644602');

-- Add gossip to Maggran Earthbinder
DELETE FROM `gossip_menu` WHERE `MenuID` = 50008;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(50008, 5443);
UPDATE `creature_template` SET `gossip_menu_id` = 50008 WHERE `entry` = 11860;
