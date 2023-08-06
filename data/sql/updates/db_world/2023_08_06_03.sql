-- DB update 2023_08_06_02 -> 2023_08_06_03
--
UPDATE `creature_template` SET `gossip_menu_id` = 7092, `npcflag` = `npcflag`|1 WHERE `entry`=16123;
DELETE FROM `gossip_menu` WHERE `MenuID` = 7092;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (7092, 8345);
DELETE FROM `npc_text` WHERE `ID` = 8345;
INSERT INTO `npc_text` (`ID`, `Probability0`, `BroadcastTextID0`) VALUES (8345, 1, 11932);

