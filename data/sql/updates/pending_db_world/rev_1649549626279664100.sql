INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649549626279664100');

-- Gryan Stoutmantle gossip
DELETE FROM `gossip_menu` WHERE `MenuID` = 61029;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (61029, 50020);
UPDATE `creature_template` SET `gossip_menu_id` = 61029 WHERE `entry` = 234;

-- Farmer_Furlbrow
DELETE FROM `gossip_menu` WHERE `MenuID` = 61030;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (61030, 50019);
UPDATE `creature_template` SET `gossip_menu_id` = 61030 WHERE `entry` = 237;
