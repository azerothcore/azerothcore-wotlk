INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613146762649566200');

/* Add missing npc text for Verna Furlbrow  npc=238
   Source: https://youtu.be/jZs1NlQNGJ4?t=1124
*/
UPDATE `creature_template` SET `gossip_menu_id`=57030 , `npcflag`=`npcflag`|1 WHERE `entry`=238;
DELETE FROM `npc_text` WHERE `ID`=50027;
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`) VALUES
(50027,'Sometimes I think there\'s a big gray cloud in the sky, just raining down bad luck upon us. First, we\'re driven off our land, and now we can\'t even get out of Westfall. Everything\'s a mess. Something needs to be done.',0);

DELETE FROM `gossip_menu` WHERE `MenuID` = 57030 AND `TextID` = 50027;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(57030, 50027);

/* Change Old Blanchy to Friendly to Alliance and Horde and remove faction from tooltip
   Source: https://youtu.be/jZs1NlQNGJ4?t=1124
*/

UPDATE `creature_template` SET `faction` = 35 WHERE (`entry` = 582);
