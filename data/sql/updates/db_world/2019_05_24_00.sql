-- DB update 2019_05_23_02 -> 2019_05_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_23_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_23_02 2019_05_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558344021525123100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558344021525123100');

SET @HAROLD := 25804;
SET @STAMPEDING_MAMMOTH := 25988;
SET @STAMPEDING_CARIBOU := 25989;
SET @STAMPEDING_RHINO := 25990;

DELETE FROM `creature_summon_groups` WHERE `summonerId`=@HAROLD AND `summonerType`=0 AND `entry` IN(25988, 25989, 25990);
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
(@HAROLD, 0, 0, 25988, 3286.08, 5655.42, 52.98, 1.25, 1, 20000),
(@HAROLD, 0, 0, 25988, 3291.20, 5650.54, 53.09, 1.35, 1, 20000),
(@HAROLD, 0, 0, 25989, 3285.02, 5648.22, 51.93, 1.35, 1, 20000),
(@HAROLD, 0, 0, 25989, 3290.59, 5643.01, 51.60, 1.35, 1, 20000),
(@HAROLD, 0, 0, 25989, 3296.20, 5645.08, 52.65, 1.35, 1, 20000),
(@HAROLD, 0, 0, 25990, 3292.17, 5639.34, 51.06, 1.35, 1, 20000),
(@HAROLD, 0, 0, 25990, 3286.03, 5640.44, 50.38, 1.35, 1, 20000),
(@HAROLD, 0, 0, 25990, 3279.33, 5644.00, 50.23, 1.35, 1, 20000);

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@HAROLD;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@HAROLD AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HAROLD,0,0,3,8,0,100,1,46368,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Harold Lane - On Spellhit Blow Cenarion Horn - Say Line 0 (No Repeat)'),
(@HAROLD,0,1,0,0,0,100,0,1100,10100,16400,28300,11,53432,0,0,0,0,0,1,0,0,0,0,0,0,0,'Harold Lane - In Combat - Cast Bear Trap'),
(@HAROLD,0,2,0,9,0,100,0,8,40,9200,12400,11,53425,0,0,0,0,0,2,0,0,0,0,0,0,0,'Harold Lane - Within 8-40 Range - Cast Throw Bear Pelt'),
(@HAROLD,0,3,0,61,0,100,0,46368,0,0,0,107,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Harold Lane - On Spellhit Blow Cenarion Horn - Summon Creature Group 0 (No Repeat)'),
(@HAROLD,0,4,0,38,0,100,0,0,1,0,0,11,46385,0,0,0,0,0,1,0,0,0,0,0,0,0,'Harold Lane - On Data Set 0 1 - Cast Stampede');

UPDATE `creature_template` SET `AIName`="SmartAI", unit_flags=256+512 WHERE `entry` IN (@STAMPEDING_MAMMOTH, @STAMPEDING_CARIBOU, @STAMPEDING_RHINO);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@STAMPEDING_MAMMOTH, @STAMPEDING_CARIBOU, @STAMPEDING_RHINO) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@STAMPEDING_MAMMOTH,0,0,0,54,0,100,0,0,0,0,0,69,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stampeding Mammoth - On Just Summoned - Move To Invoker'),
(@STAMPEDING_MAMMOTH,0,1,2,34,0,100,1,0,0,0,0,45,0,1,0,0,0,0,19,@HAROLD,100,0,0,0,0,0,'Stampeding Mammoth - On Reached Point 0 - Set Data 0 1 (No repeat)'),
(@STAMPEDING_MAMMOTH,0,2,0,61,0,100,0,0,0,0,0,53,1,@STAMPEDING_MAMMOTH,0,0,0,0,1,0,0,0,0,0,0,0,'Stampeding Mammoth - On Reached Point 0 - Start Waypoint'),
(@STAMPEDING_MAMMOTH,0,3,0,34,0,100,0,0,2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stampeding Mammoth - On Reached Point 2 - Despawn Instant'),
(@STAMPEDING_CARIBOU,0,0,0,54,0,100,0,0,0,0,0,69,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stampeding Caribou - On Just Summoned - Move To Invoker'),
(@STAMPEDING_CARIBOU,0,1,2,34,0,100,1,0,0,0,0,45,0,1,0,0,0,0,19,@HAROLD,100,0,0,0,0,0,'Stampeding Caribou - On Reached Point 0 - Set Data 0 1 (No repeat)'),
(@STAMPEDING_CARIBOU,0,2,0,61,0,100,0,0,0,0,0,53,1,@STAMPEDING_CARIBOU,0,0,0,0,1,0,0,0,0,0,0,0,'Stampeding Caribou - On Reached Point 0 - Start Waypoint'),
(@STAMPEDING_CARIBOU,0,3,0,34,0,100,0,0,2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stampeding Caribou - On Reached Point 2 - Despawn Instant'),
(@STAMPEDING_RHINO,0,0,0,54,0,100,0,0,0,0,0,69,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stampeding Rhino - On Just Summoned - Move To Invoker'),
(@STAMPEDING_RHINO,0,1,2,34,0,100,1,0,0,0,0,45,0,1,0,0,0,0,19,@HAROLD,100,0,0,0,0,0,'Stampeding Rhino - On Reached Point 0 - Set Data 0 1 (No repeat)'),
(@STAMPEDING_RHINO,0,2,0,61,0,100,0,0,0,0,0,53,1,@STAMPEDING_RHINO,0,0,0,0,1,0,0,0,0,0,0,0,'Stampeding Rhino - On Reached Point 0 - Start Waypoint'),
(@STAMPEDING_RHINO,0,3,0,34,0,100,0,0,2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stampeding Rhino - On Reached Point 2 - Despawn Instant');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=46385;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 46385, 0, 0, 31, 0, 3, @HAROLD, 0, 0, 0, 0, '', 'Stampeding creatures - Stampede targets only Harold Lane');

DELETE FROM `waypoints` WHERE `entry` IN(@STAMPEDING_MAMMOTH, @STAMPEDING_CARIBOU, @STAMPEDING_RHINO);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(@STAMPEDING_MAMMOTH, 1, 3301.39, 5694.10, 60.00, ''),
(@STAMPEDING_MAMMOTH, 2, 3304.44, 5757.94, 51.88, ''),
(@STAMPEDING_CARIBOU, 1, 3301.39, 5694.10, 60.00, ''),
(@STAMPEDING_CARIBOU, 2, 3304.44, 5757.94, 51.88, ''),
(@STAMPEDING_RHINO, 1, 3301.39, 5694.10, 60.00, ''),
(@STAMPEDING_RHINO, 2, 3304.44, 5757.94, 51.88, '');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
