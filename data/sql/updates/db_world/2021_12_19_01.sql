-- DB update 2021_12_19_00 -> 2021_12_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_19_00 2021_12_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639771397743365253'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639771397743365253');

-- Twin Ziggurats

-- Fix up Deatholme Darkmage
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `id`=16318;
UPDATE `creature` SET `position_x`=7172.997,`position_y`=-6615.694,`position_z`=63.740845, `orientation`=2.932153224945068359 WHERE `guid`=82743;

-- Bad spawn
DELETE FROM `creature` WHERE `guid` IN (82767);
DELETE FROM `creature_addon` WHERE `guid` IN (82767);

-- Condition for source Spell implicit target condition type Object entry guid
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=28731 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 28731, 0, 0, 31, 1, 3, 10415, 0, 0, 0, 0, '', 'Spell Ribbon of Souls (effect 0) will hit the caster of the spell if target is unit Ash''ari Crystal.');

-- Redo SAI for Deatholme Darkmage 
SET @ENTRY := 16318;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,11,28729,0,0,0,0,0,1,0,0,0,0,0,0,0,"Deatholme Darkmage - On Reset - Cast 'Ribbon of Souls'"),
(@ENTRY,0,1,0,0,0,100,0,0,0,3000,5000,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,"Deatholme Darkmage - Combat CMC - Cast 'Shadow Bolt'"),
(@ENTRY,0,2,0,0,0,100,0,7000,11000,32000,36000,11,18267,0,0,0,0,0,2,0,0,0,0,0,0,0,"Deatholme Darkmage - In Combat - Cast 'Curse of Weakness'"),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Deatholme Darkmage - Between 0-15% Health - Flee For Assist (No Repeat)");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_19_01' WHERE sql_rev = '1639771397743365253';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
