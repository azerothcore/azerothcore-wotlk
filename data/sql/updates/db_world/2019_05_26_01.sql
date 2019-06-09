-- DB update 2019_05_26_00 -> 2019_05_26_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_26_00 2019_05_26_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558471696386408000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558471696386408000');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `Entry` IN (29351, 29358);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29351, 29358) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29351,0,0,0,0,0,100,0,2000,5000,7000,9000,11,38621,0,0,0,0,0,2,0,0,0,0,0,0,0,'Niffelem Frost Giant - IC - Cast Debilitating Strike'),
(29358,0,0,0,0,0,100,0,2000,5000,7000,9000,11,61572,0,0,0,0,0,2,0,0,0,0,0,0,0,'Frostworg - IC - Cast Frostbite'),
(29358,0,1,0,0,0,100,0,2000,6000,6000,9000,11,50075,0,0,0,0,0,2,0,0,0,0,0,0,0,'Frostworg - IC - Cast Maim Flesh');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
