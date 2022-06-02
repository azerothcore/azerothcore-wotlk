-- DB update 2022_01_03_22 -> 2022_01_03_23
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_22';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_22 2022_01_03_23 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641238616670655918'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641238616670655918');

-- Fixes issue: https://github.com/azerothcore/azerothcore-wotlk/issues/8146
-- Made corrections to the original script, made it so you cant attack while its tagged like on retail
-- Blacksilt Scout Update SAI.
SET @ENTRY := 17326;
SET @SOURCETYPE := 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,1,8,0,100,0,30877,0,0,0,33,17654,0,0,0,0,0,16,0,0,0,0.0,0.0,0.0,0.0,"Blacksilt Scout - On Spellhit - Give Quest Credit"),
(@ENTRY,@SOURCETYPE,1,2,61,0,100,0,0,0,0,0,18,770,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Link - Set Unattackable"),
(@ENTRY,@SOURCETYPE,2,0,61,0,100,0,0,0,0,0,41,7000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Link - Set Despawn"),
(@ENTRY,@SOURCETYPE,3,0,11,0,100,0,0,0,0,0,19,770,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spawn - Remove Unit Flags");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_23' WHERE sql_rev = '1641238616670655918';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
