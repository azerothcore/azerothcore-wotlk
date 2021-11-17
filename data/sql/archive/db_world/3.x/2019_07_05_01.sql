-- DB update 2019_07_05_00 -> 2019_07_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_05_00 2019_07_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1554741101083171200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554741101083171200');

UPDATE `creature_template` SET `unit_flags` = 4 WHERE `entry` = 22443;
UPDATE `creature_template` SET `flags_extra`= 2 WHERE `entry` IN (22471, 22472);
UPDATE `creature_template` SET `InhabitType` = '3' WHERE `entry` = 22500;
UPDATE `creature_template` SET `ScriptName` = 'npc_deaths_fel_cannon' WHERE `entry` = 22443;
UPDATE `creature_template` SET `ScriptName` = 'npc_deaths_door_fell_cannon_target_bunny' WHERE `entry` = 22495;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` IN (22471, 22472);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39221 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22471 AND `ConditionValue3`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39221 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22472 AND `ConditionValue3`=0;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39221 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22495 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (13, 1, 39221, 0, 0, 31, 0, 3, 22495, 0, 0, 0, 0, '', 'Target Death\'s Door Fel Cannon Target Bunny');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39219 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22443 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (13, 1, 39219, 0, 0, 31, 0, 3, 22443, 0, 0, 0, 0, '', 'Target Death\'s Door Fel Cannon');

DELETE FROM `creature` WHERE `id`=22495;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(78947, 22495, 530, 0, 0, 1, 1, 0, 0, 2191.68725585938, 5478.57275390625, 160.826309204102, 0.456801176071167, 1, 0, 0, 6986, 0, 0, 0, 0, 0, '', 0),
(78948, 22495, 530, 0, 0, 1, 1, 0, 0, 1978.12377929688, 5319.36865234375, 162.545059204102, 2.30369400978088, 300, 0, 0, 6986, 0, 0, 0, 0, 0, '', 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22474;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22474 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(22474,0,0,1,9,0,100,0,0,1,0,0,0,11,60081,2,0,0,0,0,2,0,0,0,0,0,0,0,0,'Unstable Fel-Imp - On Victim In Range (0 Yards) - Cast ''Cosmetic - Explosion'''),
(22474,0,1,0,61,0,100,0,0,0,0,0,0,67,1,500,500,0,0,0,1,0,0,0,0,0,0,0,0,'Unstable Fel-Imp - Linked - Create Timed Event ID 1'),
(22474,0,2,0,59,0,100,0,1,0,0,0,0,11,39266,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Unstable Fel-Imp - On Timed Event ID 1 - Cast ''Unstable Explosion''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
