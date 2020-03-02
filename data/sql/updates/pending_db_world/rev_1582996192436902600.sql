INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582996192436902600');

-- Update gossip_menu table to allow bigger MenuIDs
ALTER TABLE `gossip_menu` CHANGE COLUMN `MenuID` `MenuID` INT UNSIGNED NOT NULL DEFAULT 0 FIRST;

-- Zone Stormwind - npc_lady_katrana_prestor gossip menu
UPDATE npc_text SET TEXT0_0 = '<Lady Prestor glares at you.>', BroadcastTextID0 = '0' WHERE ID = '2693';
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES ('90000', '2693');
UPDATE `creature_template` SET `gossip_menu_id`='90000' WHERE  `entry`=1749;

-- Added hardcoded strings to acore strings. diferent locales will be used.
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES 
(2697, 'Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice.'),
(2698, 'My apologies, Lady Prestor.'),
(2699, 'Begging your pardon, Lady Prestor. That was not my intent.'),
(2700, 'Thank you for your time, Lady Prestor.');
