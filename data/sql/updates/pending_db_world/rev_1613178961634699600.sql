INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613178961634699600');

/* Add missing npc text for William Pestle  npc=253
   Source: https://youtu.be/4wIP0mdSVUA?t=40s
*/

UPDATE `creature_template` SET `gossip_menu_id`=57031 , `npcflag`=`npcflag`|1 WHERE `entry`=253;
DELETE FROM `npc_text` WHERE `ID`=50028;
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`) VALUES
(50028,'Aha! Good day, good day, Master $C! Come, sit down and have a drink. You have an enterprising look in your eye, and I think you\'ll find speaking to me worth your time....',0);

DELETE FROM `gossip_menu` WHERE `MenuID` = 57031 AND `TextID` = 50028;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(57031, 50028);