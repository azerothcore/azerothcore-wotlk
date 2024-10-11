-- DB update 2022_06_09_00 -> 2022_06_09_01
--
DELETE FROM `npc_text` WHERE `ID` IN (7637,100117,100118,100119);
INSERT INTO `npc_text` (`ID`,`text0_0`,`BroadcastTextID0`,`Probability0`) VALUES
(7637,'The markings of this tablet show ancient diagrams and hold dire words of power.$B$BYou believe it is an alchemical recipe, but it is beyond your skill...',10487,1),
(100117,'Hazza\'rah, the Dreamweaver.$B$BHis is the power of nightmares, and may his foes ever sleep.$B$BHazza\'rah now dwells near the edge of madness...',10540,1),
(100118,'Renataki, of the Thousand Blades.$B$BPain is his lifeblood.  Fear, his ally.  May he one day return and bring joyous bloodshed with him.$B$BRenataki now dwells far from here. One day, he may return...',10541,1),
(100119,'Wushoolay, the Storm Witch.$B$BHer power is the power of the sky, the rain, and the shattered earth.  May she once again reign mother to the Gurubashi.  $B$BWushoolay now dwells near the edge of madness...',10544,1);

DELETE FROM `gossip_menu` WHERE `MenuID`=6443 AND `TextID`=7637;
DELETE FROM `gossip_menu` WHERE `MenuID`=6448 AND `TextID`=7643;
DELETE FROM `gossip_menu` WHERE `MenuID`=6449 AND `TextID`=100117;
DELETE FROM `gossip_menu` WHERE `MenuID`=6450 AND `TextID`=100118;
DELETE FROM `gossip_menu` WHERE `MenuID`=6451 AND `TextID`=100119;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES
(6443,7637),
(6448,7643),
(6449,100117),
(6450,100118),
(6451,100119);

DELETE FROM `gossip_menu_option` WHERE `MenuID`=6443;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionId`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
(6443,0,0,"Learn the recipe.",10486,1,1,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=6443;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (6448,6449,6450,6451);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,6443,7635,0,0,25,0,2259,0,0,1,0,0,"","Show gossip text 7635 if spell 'Alchemy' is not learned"),
(14,6443,7636,0,0,7,0,171,300,0,0,0,0,"","Show gossip text 7636 if player has Alchemy with skill level 300"),
(14,6443,7637,0,0,25,0,2259,0,0,0,0,0,"","Show gossip text 7637 if spell 'Alchemy' is learned"),
(14,6443,7637,0,0,7,0,171,300,0,1,0,0,"","Show gossip text 7637 if player has not Alchemy with skill level 300"),
(15,6443,0,0,0,7,0,171,300,0,0,0,0,"","Show Gossip Option 0 if player has Alchemy with skill level 300"),
(15,6443,0,0,0,25,0,24266,0,0,1,0,0,"","Show Gossip Option 0 if spell 'Gurubashi Mojo Madness' is not learned"),
(14,6448,7643,0,0,12,0,27,0,0,1,0,0,"","Show gossip text 7643 if game event 'Edge of Madness: Gri'lek is not active"),
(14,6448,7669,0,0,12,0,27,0,0,0,0,0,"","Show gossip text 7669 if game event 'Edge of Madness: Gri'lek is active"),
(14,6449,7670,0,0,12,0,28,0,0,1,0,0,"","Show gossip text 7670 if game event 'Edge of Madness: Hazza'rah is not active"),
(14,6449,100117,0,0,12,0,28,0,0,0,0,0,"","Show gossip text 100117 if game event 'Edge of Madness: Hazza'rah is active"),
(14,6450,100118,0,0,12,0,29,0,0,1,0,0,"","Show gossip text 100118 if game event 'Edge of Madness: Renataki is not active"),
(14,6450,7673,0,0,12,0,29,0,0,0,0,0,"","Show gossip text 7673 if game event 'Edge of Madness: Renataki is active"),
(14,6451,7674,0,0,12,0,30,0,0,1,0,0,"","Show gossip text 7674 if game event 'Edge of Madness: Wushoolay is not active"),
(14,6451,100119,0,0,12,0,30,0,0,0,0,0,"","Show gossip text 100119 if game event 'Edge of Madness: Wushoolay is active");

UPDATE `gameobject_template` SET `AIName` = "SmartGameObjectAI", `ScriptName` = "" WHERE `entry` = 180368;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 180368 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(180368,1,0,1,62,0,100,0,6443,0,0,0,0,85,24267,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tablet of Madness - On Gossip Option 0 Selected - Self Cast 'Gurubashi Mojo Madness'"),
(180368,1,1,0,61,0,100,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tablet of Madness - On Link - Close Gossip");
