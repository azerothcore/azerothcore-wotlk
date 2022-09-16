-- DB update 2020_12_04_00 -> 2020_12_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_04_00 2020_12_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606590908424148300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606590908424148300');

-- Update level range for Val'kyr Battle-maiden (59-60)
UPDATE `creature_template` SET `maxlevel`=60 WHERE `entry`=31095;

-- Update Terrifying Abomination wander distance
UPDATE `creature` SET `wander_distance`=1 WHERE `guid` IN 
(130505, 130506, 130507, 130508, 130511, 130512, 130513, 130515, 130516, 130517, 130519, 130521, 130522, 130524, 130525, 130526, 130527, 130528, 130530, 130531, 130532, 130535, 130536, 130537, 130539);

-- Update level range for Terrifying Abomination (57-58)
UPDATE `creature_template` SET `minlevel`=57 WHERE `entry`=31098;

-- Fix Terrifying Abomination's SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=31098 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(31098, 0, 0, 0, 9, 0, 50, 1, 8, 20, 0, 0, 0, 11, 50335, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terrifying Abomination - Within 8-20 Range - Cast Scourge Hook'),
(31098, 0, 1, 0, 0, 0, 80, 0, 0, 0, 7000, 9000, 0, 11, 15496, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terrifying Abomination - In Combat - Cast Cleave');

-- Update SAI, unit_flag and update level range for Knight of the Ebon Blade (57-58)
UPDATE `creature_template` SET `minlevel`=57, `unit_flags`=557056, `AIName`='SmartAI' WHERE `entry`=31094;
DELETE FROM `smart_scripts` WHERE `entryorguid`=31094 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(31094, 0, 0, 0, 0, 0, 100, 0, 9250, 14750, 10250, 15750, 0, 11, 52372, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Knight of the Ebon Blade - In Combat - Cast Icy Touch'),
(31094, 0, 1, 0, 0, 0, 100, 0, 4500, 6200, 5500, 7200, 0, 11, 52374, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Knight of the Ebon Blade - In Combat - Cast Blood Strike'),
(31094, 0, 2, 0, 0, 0, 100, 0, 3500, 9100, 4500, 11000, 0, 11, 52373, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Knight of the Ebon Blade - In Combat - Cast Plague Strike'),
(31094, 0, 3, 0, 0, 0, 100, 0, 5200, 15500, 6200, 17500, 0, 11, 52375, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Knight of the Ebon Blade - In Combat - Cast Death Coil'),
(31094, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 70, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Knight of the Ebon Blade - On Death - Respawn');

-- Add missing Knight of the Ebon Blade corpses on lower level
DELETE FROM `creature` WHERE `guid` IN (200153, 200154, 200155, 200156, 200157);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES 
(200153, 31094, 0, 0, 0, 1, 448, 0, 1, 2425.68, -5617.98, 420.644, 1.325, 360, 0, 0, 15955, 11445, 0, 0, 537166592, 32, 0),
(200154, 31094, 0, 0, 0, 1, 448, 0, 1, 2435.938, -5620.978, 420.421, 3.319, 360, 0, 0, 15955, 11445, 0, 0, 537166592, 32, 0),
(200155, 31094, 0, 0, 0, 1, 448, 0, 1, 2415.195, -5601.245, 420.643, 0.833, 360, 0, 0, 15955, 11445, 0, 0, 537166592, 32, 0),
(200156, 31094, 0, 0, 0, 1, 448, 0, 1, 2396.438, -5628.738, 420.702, 3.523, 360, 0, 0, 15955, 11445, 0, 0, 537166592, 32, 0),
(200157, 31094, 0, 0, 0, 1, 448, 0, 1, 2403.937, -5642.425, 420.678, 0.478, 360, 0, 0, 15955, 11445, 0, 0, 537166592, 32, 0);

DELETE FROM `creature_addon` WHERE `guid` IN (200153, 200154, 200155, 200156, 200157);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES 
(200153, 0, 0, 0, 1, 0, 0, 29266),
(200154, 0, 0, 0, 1, 0, 0, 29266),
(200155, 0, 0, 0, 1, 0, 0, 29266),
(200156, 0, 0, 0, 1, 0, 0, 29266),
(200157, 0, 0, 0, 1, 0, 0, 29266);

-- Update Knight of the Ebon Blade positions
UPDATE `creature` SET `position_x`=2410.179, `position_y`=-5621.223, `position_z`=420.653 WHERE `guid`=130488;
UPDATE `creature` SET `position_x`=2411.769, `position_y`=-5624.546, `position_z`=420.652 WHERE `guid`=130485;
UPDATE `creature` SET `position_x`=2413.665, `position_y`=-5627.342, `position_z`=420.652 WHERE `guid`=130487;
UPDATE `creature` SET `position_x`=2415.735, `position_y`=-5629.859, `position_z`=420.651 WHERE `guid`=130486;

-- Add Patchwerk texts
DELETE FROM `creature_text` WHERE `CreatureID`=31099 AND `GroupID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(31099, 0, 0, '%s goes into a frenzy!', 41, 0, 100, 0, 0, 0, 38630, 0, 'Patchwerk emote Frenzy - Ebon Hold');

-- Update AIName to Patchwerk and build SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=31099;
DELETE FROM `smart_scripts` WHERE `entryorguid`=31099 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(31099, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 1500, 1500, 0, 11, 58412, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Patchwerk - In Combat - Cast Hateful Strike'),
(31099, 0, 1, 0, 2, 0, 100, 1, 0, 4, 0, 0, 0, 11, 28131, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Patchwerk - On 5% HP - Cast self Frenzy'),
(31099, 0, 2, 0, 2, 0, 100, 1, 0, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Patchwerk - On 5% HP - Say Line 0');

-- Make spell 'Scourge hook' to only target players
DELETE FROM `conditions` WHERE `SourceEntry`=50335 AND `ConditionTypeOrReference`=31;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `Comment`) VALUES 
(17, 0, 50335, 0, 0, 31, 1, 4, 0, 0, 0, 0, 0, 'Spell force target - \'Scourge Hook\' - Player only');

-- Adjust Patchwerk spawn time
UPDATE `creature` SET `spawntimesecs`=120 WHERE `guid`=130542;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
