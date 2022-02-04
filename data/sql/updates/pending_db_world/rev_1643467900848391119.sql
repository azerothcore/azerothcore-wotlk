INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643467900848391119');

-- missed dialogue page text for npc Old Orok "How can I help you, $c?"
DELETE FROM `gossip_menu` WHERE `MenuID` = 9856 AND `TextID` = 10887;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9856, 10887);
