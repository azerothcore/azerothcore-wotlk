INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623886496730734500');

-- Added the NPC text for Arcanist Helion's gossip menu
DELETE FROM `npc_text` WHERE `ID` = 50030;
INSERT INTO `npc_text` VALUES (50030, 'Knowledge is power - TRUE power, my young friend. You\'ll be wise to acquire as much of it as you can, and pay proper heed to those who have already done so.\r\n\r\nBefore the razing of the Sunwell, we fooled ourselves into thinking we had neared the apex of our civilization. It took the Scourge to bring us to our knees... and in a way, back to reality.', 'Knowledge is power - TRUE power, my young friend. You\'ll be wise to acquire as much of it as you can, and pay proper heed to those who have already done so.\r\n\r\nBefore the razing of the Sunwell, we fooled ourselves into thinking we had neared the apex of our civilization. It took the Scourge to bring us to our knees... and in a way, back to reality.', 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

-- Created his gossip menu
DELETE FROM `gossip_menu` WHERE (`MenuID` = 12002);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(12002, 50030);

-- Updated his gossip menu on creature template
UPDATE `creature_template` SET `gossip_menu_id` = 12002 WHERE (`entry` = 15297);
