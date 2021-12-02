INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638446224179942600');

UPDATE `creature_template` SET `gossip_menu_id`=1 WHERE  `entry`=11861;

DELETE FROM `gossip_menu`WHERE `MenuID` = 1 AND `TextID` = 8;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (1, 8);

DELETE FROM `npc_text`WHERE `ID` = 8;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (8, 'Stonetalon Mountains has many perilous caves through out this region. Exploring these caves can hold many adventures for those willing to risk life for glory.');
