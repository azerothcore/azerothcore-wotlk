-- DB update 2021_10_30_02 -> 2021_10_30_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_30_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_30_02 2021_10_30_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635436307444392570'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635436307444392570');

-- Add Gossip Option
DELETE FROM `gossip_menu_option` WHERE `MenuID`=347 AND `OptionID`=0;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(347,0,0,'Trick or Treat!',10693,1,1,0,0,0,0,NULL,0,0);

-- Conditions for Innkeeper Shaussiy Gossip menu option
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=347 AND `SourceEntry`=0 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 347, 0, 0, 0, 1, 0, 24755, 0, 0, 1, 0, 0, '', 'Show gossip menu 347 option id 0 if player doesn''t have aura Tricked or Treated.'),
(15, 347, 0, 0, 0, 12, 0, 12, 0, 0, 0, 0, 0, '', 'Show gossip menu 347 option id 0 if event Hallow''s End is active.');

-- Add SAI to Innkeeper Shaussiy
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=6737;
DELETE FROM `smart_scripts` WHERE `entryorguid`=6740 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(6737,0,0,1,62,0,100,0,347,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Shaussiy - On gossip option 0 select - Close gossip'),
(6737,0,1,0,61,0,100,0,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Shaussiy - On gossip option 0 select - Player cast Trick or Treat on Invoker');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_30_03' WHERE sql_rev = '1635436307444392570';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
