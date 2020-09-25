-- DB update 2020_09_24_00 -> 2020_09_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_24_00 2020_09_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598936588616883173'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598936588616883173');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=28451;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28451 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28451,0,0,0,0,0,100,0,0,0,2300,3900,11,51742,64,0,0,0,0,2,0,0,0,0,0,0,0,"Hemet Nesingwary - Combat CMC - Cast 'Arcane Shot'"),
(28451,0,1,0,5,0,100,0,0,0,0,28467,33,28467,0,0,0,0,0,21,10,0,0,0,0,0,0,"Hemet Nesingwary - On Killed Unit - Quest Credit 'Post-partum Aggression'");

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=28468;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28468 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28468,0,0,0,5,0,100,0,0,0,0,28467,33,28467,0,0,0,0,0,21,10,0,0,0,0,0,0,"Stampy - On Killed Unit - Quest Credit 'Post-partum Aggression'");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
