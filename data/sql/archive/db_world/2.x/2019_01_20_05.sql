-- DB update 2019_01_20_04 -> 2019_01_20_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_20_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_20_04 2019_01_20_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1548018591192986300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548018591192986300');

UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=2708;

DELETE FROM `smart_scripts` WHERE `entryorguid`=2708 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(2708,0,0,1,62,0,100,0,8846,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,""),
(2708,0,1,0,61,0,100,0,0,0,0,0,11,42711,2,0,0,0,0,7,0,0,0,0,0,0,0,"");

DELETE FROM `gossip_menu_option` WHERE `MenuID`=8846 AND `OptionID`=0;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(8846,0,0,"Can you send me to Theramore? I have an urgent message for Lady Jaina from King Wrynn.",22524,1,1,0,0,0,0,"",0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8846;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8846,0,0,0,28,0,11223,0,0,0,0,0,"","");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
