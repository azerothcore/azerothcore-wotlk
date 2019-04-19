-- DB update 2019_04_18_03 -> 2019_04_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_18_03 2019_04_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553654065143975700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553654065143975700');

-- NPC ID 9021 Kharan Mighthammer, Quest ID 4001 'What Is Going On?' and 4342 'Kharan's Tale'
SET @Kharan := 9021;

UPDATE `creature_template` SET `AIName`= 'SmartAI', `ScriptName`= '' WHERE `entry` = @Kharan;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = @Kharan);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Kharan,0,0,0, 10,0,100,0,   0,20,0,0,  1,   0,3000,0,0,0,0,7,0,0,0,0,0,0,0,'Kharan Mighthammer - Within 0-20 Range Out of Combat LoS - Say Line 0'),
(@Kharan,0,1,2, 62,0,100,0,1823, 0,0,0, 72,   0,   0,0,0,0,0,7,0,0,0,0,0,0,0,'Kharan Mighthammer - on Gossip option 0 selected - Close Gossip'),
(@Kharan,0,2,0, 61,0,100,0,   0, 0,0,0, 15,4342,   0,0,0,0,0,7,0,0,0,0,0,0,0,"Kharan Mighthammer - on Gossip option 0 selected - Quest Credit 'Kharan's Tale'"),
(@Kharan,0,3,4, 62,0,100,0,1839, 0,0,0, 72,   0,   0,0,0,0,0,7,0,0,0,0,0,0,0,'Kharan Mighthammer - on Gossip option 0 selected - Close Gossip'),
(@Kharan,0,4,0, 61,0,100,0,   0, 0,0,0, 15,4001,   0,0,0,0,0,7,0,0,0,0,0,0,0,"Kharan Mighthammer - on Gossip option 0 selected - Credit Quest 'What Is Going On?'");

DELETE FROM `creature_text` WHERE `CreatureID` = @Kharan;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@Kharan,0,0,'Key... get the key... Gerstahn has... key.',                                              12,0,100,0,0,0,4723,0,'Kharan Mighthammer'),
(@Kharan,0,1,'Try and make yourself useful, $r. GET ME OUT OF HERE! The High Interrogator has the key.',12,0,100,0,0,0,4724,0,'Kharan Mighthammer'),
(@Kharan,0,2,'HEY! HEY YOU! $R! Get me out of here!',                                                   12,0,100,0,0,0,4725,0,'Kharan Mighthammer'),
(@Kharan,0,3,'%s groans.',                                                                              16,0,100,0,0,0,4726,0,'Kharan Mighthammer');

DELETE FROM `gossip_menu_option` WHERE `MenuID` BETWEEN 1821 AND 1839;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiId`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`) VALUES
(1822,0,0,"All is not lost, Kharan!",                                                                                                              4734,1,1,1828,0,0,0,'',0),
(1828,1,0,"Continue...",                                                                                                                           5256,1,1,1827,0,0,0,'',0),
(1827,0,0,"So what happened?",                                                                                                                     4742,1,1,1826,0,0,0,'',0),
(1826,0,0,"So you suspect that someone on the inside was involved? That they were tipped off?",                                                    4744,1,1,1825,0,0,0,'',0),
(1825,0,0,"Continue with your story please.",                                                                                                      4746,1,1,1824,0,0,0,'',0),
(1824,0,0,"Indeed.",                                                                                                                               4748,1,1,1823,0,0,0,'',0),
(1823,0,0,"The door is open, Kharan. You are a free man.",                                                                                         5257,1,1,   0,0,0,0,'',0),
(1822,1,0,"I am not here to harm you, Kharan. Gor'shak sent me. He told me that you would speak to me about the Princess.",                        4732,1,1,1831,0,0,0,'',0),
(1831,0,0,"All is not lost, Kharan!",                                                                                                              4734,1,1,1832,0,0,0,'',0),
(1832,0,0,"Because you are still alive and my hands aren't gripped firmly around your stubby little neck.",                                        4736,1,1,1833,0,0,0,'',0),
(1833,0,0,"Nothing. My orders were to speak with you and then speak with Thrall. All I know is that Thrall is interested in saving your princess.",4738,1,1,1834,0,0,0,'',0),
(1834,0,0,"Which would explain why you're sitting in a jail cell at the bottom of a mountain, right, dwarf?",                                      4740,1,1,1835,0,0,0,'',0),
(1835,0,0,"So what happened?",                                                                                                                     4742,1,1,1836,0,0,0,'',0),
(1836,0,0,"So you suspect that someone on the inside was involved? That they were tipped off?",                                                    4744,1,1,1837,0,0,0,'',0),
(1837,0,0,"Continue with your story please.",                                                                                                      4746,1,1,1838,0,0,0,'',0),
(1838,0,0,"Indeed.",                                                                                                                               4748,1,1,1839,0,0,0,'',0),
(1839,0,0,"If it's any consolation, I'll be leaving the cell door open. How you get out is your problem. Good bye, Kharan.",                       4750,1,1,   0,0,0,0,'',0);

DELETE FROM `gossip_menu` WHERE `MenuID`= 1822 AND `TextID`= 2473 OR `MenuID` BETWEEN 1831 AND 1839;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES
(1822, 2473),
(1831, 2474),
(1832, 2475),
(1833, 2476),
(1834, 2477),
(1835, 2478),
(1836, 2479),
(1837, 2480),
(1838, 2481),
(1839, 2482);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`= 1822 AND `SourceEntry` IN (0,1,2473,2474) AND `SourceId`= 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,1822,2473,0,1, 9,0,4001,0,0,0,0,0,'', "Show gossip menu 1822 text id 2473 if quest 'What Is Going On?' has been taken. -OR-"),
(14,1822,2474,0,2,14,0,4001,0,0,0,0,0,'', "Show gossip menu 1822 text id 2474 if quest 'What Is Going On?' has not been taken. -OR-"),
(14,1822,2474,0,3,28,0,4001,0,0,0,0,0,'', "Show gossip menu 1822 text id 2474 if quest 'What Is Going On?' has been completed. -OR-"),
(15,1822,   1,0,0, 9,0,4001,0,0,0,0,0,'', "Show gossip menu 1822 option id 1 if quest 'What Is Going On?' has been taken."),
(14,1822,2474,0,4, 9,0,4342,0,0,0,0,0,'', "Show gossip menu 1822 text id 2474 if quest 'Kharan's Tale' has been taken. -OR-"),
(14,1822,2474,0,5,14,0,4342,0,0,0,0,0,'', "Show gossip menu 1822 text id 2474 if quest 'Kharan's Tale' has not been taken. -OR-"),
(14,1822,2474,0,6,28,0,4342,0,0,0,0,0,'', "Show gossip menu 1822 text id 2474 if quest 'Kharan's Tale' has been completed. -OR-"),
(15,1822,   0,0,0, 9,0,4342,0,0,0,0,0,'', "Show gossip menu 1822 option id 0 if quest 'Kharan's Tale' has been taken.");

SET @ID := 100000; -- High ID just to be safe.

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (1945);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`) VALUES
(1945, 0, 0, 'Teach me the art of smelting dark iron', @ID, 1, 1),
(1945, 1, 0, 'I want to pay tribute', @ID+1, 1, 1);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (4781) AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`) VALUES
(4781, 1, 0, 'Get Thorium Brotherhood Contract', @ID+2, 1, 1);


DELETE FROM `broadcast_text` WHERE `ID` BETWEEN @ID AND @ID+2;
INSERT INTO `broadcast_text` (`ID`,`Language`,`MaleText`,`FemaleText`) VALUES
(@ID, 0, 'Teach me the art of smelting dark iron','Teach me the art of smelting dark iron'),
(@ID+1, 0, 'I want to pay tribute','I want to pay tribute'),
(@ID+2, 0, 'Get Thorium Brotherhood Contract', 'Get Thorium Brotherhood Contract');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
