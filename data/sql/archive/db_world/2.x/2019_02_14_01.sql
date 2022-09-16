-- DB update 2019_02_14_00 -> 2019_02_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_14_00 2019_02_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1549338391766716500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549338391766716500');

UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=9563;

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (2061, 2062, 2714, 2715, 2716, 2717, 2718, 2719, 2720, 2721, 2722, 2723, 2725);
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(2061,0,0,"Milk me, John.",5833,1,1,2062,0,0,0,"",0,0),
(2062,0,0,"Do it... Do it now.",5835,1,1,0,0,0,0,"",0,0),
(2061,1,0,"Official buisness, John. I need some information about Marsha Windsor. Tell me about the last time you saw him.",0,1,1,2714,0,0,0,"",0,0),
(2714,0,0,"So what did you do?",0,1,1,2715,0,0,0,"",0,0),
(2715,0,0,"Start making sense, dwarf. I don't want to have anything to do with your cracker, your pappy, or any sort of 'discreditin'.",0,1,1,2716,0,0,0,"",0,0),
(2716,0,0,"Ironfoe?",0,1,1,2717,0,0,0,"",0,0),
(2717,0,0,"Interesting... continue John.",0,1,1,2718,0,0,0,"",0,0),
(2718,0,0,"So that's how Windsor died…",0,1,1,2719,0,0,0,"",0,0),
(2719,0,0,"So how did he die?",0,1,1,2720,0,0,0,"",0,0),
(2720,0,0,"Ok so where the hell is he? Wait a minute! Are you drunk?",0,1,1,2721,0,0,0,"",0,0),
(2721,0,0,"WHY is he in Blackrock Depths?",0,1,1,2722,0,0,0,"",0,0),
(2722,0,0,"300? So the Dark Irons killed him and dragged him into the Depths?",0,1,1,2723,0,0,0,"",0,0),
(2723,0,0,"Ahh... Ironfoe",0,1,1,2725,0,0,0,"",0,0),
(2725,0,0,"Thanks, Ragged John. Your story was very uplifting and informative",0,1,1,0,0,0,0,"",0,0);


DELETE FROM `smart_scripts` WHERE `entryorguid`=9563 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(9563,0,0,1,62,0,100,0,2062,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Ragged John - On Gossip 2062 Option 0 Selected - Close Gossip"),
(9563,0,1,2,61,0,100,0,0,0,0,0,0,11,16472,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Ragged John - On link - Cast Wicked Milking"),
(9563,0,2,0,61,0,100,0,0,0,0,0,0,15,4866,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Ragged John - On link - Give credit quest(4866)"),
(9563,0,3,4,62,0,100,0,2725,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Ragged John - On Gossip 2725 Option 0 Selected - Close Gossip"),
(9563,0,4,0,61,0,100,0,0,0,0,0,0,15,4224,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Ragged John - On link - Give credit quest(4224)");


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=2061;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,2061,0,0,1,9,0,4866,0,0,0,0,0,"","Show gossip 2061 option 0 if player does have quest 4866 taken"),
(15,2061,0,0,1,1,0,16468,0,0,0,0,0,"","Show Gossip 2061 option 0 only if player has aura 16468"),
(15,2061,1,0,2,9,0,4224,0,0,0,0,0,"","Show gossip 2061 option 1 if player does have quest 4224 taken");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
