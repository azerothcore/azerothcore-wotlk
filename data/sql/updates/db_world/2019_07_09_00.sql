-- DB update 2019_07_08_00 -> 2019_07_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_08_00 2019_07_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561636568439132700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561636568439132700');

-- "Caverndeep Burrower" and "Caverndeep Reaver" used wrong group id "1" for their creature text ("0" is correct)
-- The text is used after being hit by "Radiation", e.g. from a dying "Irradiated Pillager"
UPDATE `smart_scripts` SET `action_param1` = 0 WHERE `source_type` = 0 AND `action_type` = 1 AND `entryorguid` IN (6206,6211);

-- Scarlet Abbot
UPDATE `creature_text` SET `GroupID` = 1 WHERE `CreatureID` = 4303 AND `GroupID` = 0 AND `ID` = 0;

-- Blackwood Ursa SAI
SET @ENTRY := 2170;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE `creature_template` SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,14,0,100,0,200,40,18000,21000,11,1058,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Blackwood Ursa - Friendly At 200 Health - Cast Rejuvenation');

-- "Scarlet Peasant" and "Citizen of Havenshire" have to use target "self" for their "talk" actions
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `action_type` = 1 AND `target_type` = 7 AND `source_type` = 0 AND `entryorguid` IN (28576,28577,28557);

-- "Scarlet Medic" has to use target "self" for the "talk" action
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `action_type` = 1 AND `target_type` = 2 AND `source_type` = 0 AND `entryorguid` = 28608;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
