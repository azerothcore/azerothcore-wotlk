INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638446224179942600');

UPDATE `creature_template` SET `gossip_menu_id`= 4721 WHERE `entry`= 11861;

DELETE FROM `gossip_menu`WHERE `MenuID` = 4721 AND `TextID` = 5773;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (4721, 5773);
