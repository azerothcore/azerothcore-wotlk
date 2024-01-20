-- DB update 2021_09_20_14 -> 2021_09_20_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_14 2021_09_20_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631853768268568696'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631853768268568696');

--
SET @id := 18884;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid`=@id;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@id,0,0,0,11,0,100,0,0,0,0,0,11,32942,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Warp Chaser - On Spawn - Cast Phasing Invisibility'),
(@id,0,1,0,0,0,100,0,500,2000,7000,15000,11,37417,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Warp Chaser - In Combat - Cast Charge'),
(@id,0,2,0,0,0,100,0,3000,5000,10000,15000,11,32739,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Warp Chaser - In Combat - Cast Venomous Bite'),
(@id,0,3,0,6,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,22484,10,0,0,0,0,0, 'Warp Chaser - On Death - Set Data on Zeppit');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid`=22484;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(22484,0,0,0,38,0,100,0,1,1,0,0,11,39244,0,0,0,0,0,21,10,0,0,0,0,0,0, 'Zeppit - On Data Set - Cast on Master');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_15' WHERE sql_rev = '1631853768268568696';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
