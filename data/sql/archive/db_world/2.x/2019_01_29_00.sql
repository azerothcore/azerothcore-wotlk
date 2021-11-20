-- DB update 2019_01_28_02 -> 2019_01_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_28_02 2019_01_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1548473216184905600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548473216184905600');

UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=1855;

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (3502, 3681, 3682, 3683) AND `OptionID`=0;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(3502,0,0,"I am ready to hear your tale, Tirion.",7219,1,1,3681,0,0,0,"",0,0),
(3681,0,0,"Thank you, Tirion. What of your identity?",7221,1,1,3682,0,0,0,"",0,0),
(3682,0,0,"That is terrible.",7223,1,1,3683,0,0,0,"",0,0),
(3683,0,0,"I will, Tirion.",7225,1,1,0,0,0,0,"",0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=1855 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1855,0,0,1,62,0,100,0,3683,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tirion Fordring - On Gossip Option 0 Selected - Close Gossip"),
(1855,0,1,0,61,0,100,0,0,0,0,0,0,15,5742,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tirion Fordring - on link - give credit quest(5742)");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3502;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,3502,0,0,0,9,0,5742,0,0,0,0,0,"","Show gossip option if player does have quest 5742 taken");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
