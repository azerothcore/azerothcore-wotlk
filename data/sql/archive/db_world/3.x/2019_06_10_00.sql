-- DB update 2019_06_08_00 -> 2019_06_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_08_00 2019_06_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559491515154304500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559491515154304500');

SET @SWIFTSPEAR := 30395;
SET @GOSSIP :=9906;

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9906 AND `OptionID` = 1;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP AND `SourceEntry` IN (0,1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,0,9,0,13037,0,0,0,0,'','Show gossip option only if player has quest Memories of Stormhoof');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@SWIFTSPEAR;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SWIFTSPEAR AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SWIFTSPEAR*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@SWIFTSPEAR,0,0,1,62,0,100,0,@GOSSIP,0,0,0,11,56760,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Chieftain Swiftspear - On gossip select - Spellcast Trigger Swiftspear Signal'),
(@SWIFTSPEAR,0,1,2,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Chieftain Swiftspear - On gossip select - Close gossip'),
(@SWIFTSPEAR,0,2,0,61,0,100,0,0,0,0,0,80,@SWIFTSPEAR*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear - On gossip select - Run script'),

(@SWIFTSPEAR*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,1,0,0,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Remove npcflag gossip'),
(@SWIFTSPEAR*100,9,2,0,0,0,100,0,6800,6800,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,3,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,4,0,0,0,100,0,6000,6000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,5,0,0,0,100,0,6100,6100,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,6,0,0,0,100,0,7200,7200,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,7,0,0,0,100,0,6000,6000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Say line'),
(@SWIFTSPEAR*100,9,8,0,0,0,100,0,3600,3600,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Play emote'),
(@SWIFTSPEAR*100,9,9,0,0,0,100,0,2700,2700,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Add npcflag gossip'),
(@SWIFTSPEAR*100,9,10,0,0,0,100,0,0,0,0,0,33,30381,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Chieftain Swiftspear script - Quest credit');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
