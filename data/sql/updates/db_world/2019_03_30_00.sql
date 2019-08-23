-- DB update 2019_03_28_00 -> 2019_03_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_28_00 2019_03_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553731839786525000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553731839786525000');

DELETE FROM `creature` WHERE `guid` IN (3110330, 35237);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(3110330, 7750, 0, 0, 0, 1, 2, 0, 1, -10630.2, -2988.19, 28.8757, 4.93301, 300, 0, 0, 3399, 0, 0, 0, 0, 0, '', 0),
(35237, 7572, 0, 0, 0, 1, 1, 0, 1, -10632.3, -3009.37, 29.2653, 6.19592, 300, 0, 0, 4121, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `conditions` WHERE  `SourceTypeOrReferenceId`=15 AND `SourceGroup`=840 AND `SourceEntry`=2 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=29 AND `ConditionTarget`=0 AND `ConditionValue1`=7750 AND `ConditionValue2`=40 AND `ConditionValue3`=0;

-- Creature Corporal Thund Splithoof 7750 SAI
SET @ENTRY := 7750;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 20, 0, 100, 0, 2701, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'When player rewards quest 2701 - Action invoker: Set phase id to 1 // ');


-- Creature Fallen Hero of the Horde 7572 SAI
SET @ENTRY := 7572;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 62, 0, 100, 1, 842, 0, 0, 0, 26, 2784, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 0 from menu 842 selected - Action invoker: Call event happened from quest 2784 for the whole group // Fallen Hero of the Horde - On Gossip Option 0 Selected - Quest Credit \'Fall From Grace\''),
(@ENTRY, 0, 1, 0, 62, 0, 100, 1, 881, 0, 0, 0, 26, 2801, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 0 from menu 881 selected - Action invoker: Call event happened from quest 2801 for the whole group // Fallen Hero of the Horde - On Gossip Option 1 Selected - Quest Credit \'A Tale of Sorrow\''),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On link - Action invoker: Close gossip // Fallen Hero of the Horde - On Gossip Option 0 Selected - Close Gossip'),
(@ENTRY, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On link - Action invoker: Close gossip // Fallen Hero of the Horde - On Gossip Option 1 Selected - Close Gossip'),
(@ENTRY, 0, 4, 0, 19, 0, 100, 0, 2702, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'When player accepts quest 2702 - Action invoker: Set phase id to 3 // '),
(@ENTRY, 0, 5, 0, 62, 0, 100, 0, 840, 2, 0, 0, 44, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 2 from menu 840 selected - Action invoker: Set phase id to 3 // ');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
