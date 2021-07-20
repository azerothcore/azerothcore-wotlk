INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626690253021473300');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN ( 2658, 2659);

-- Added Rend Flesh and Wing Flap on Razorbeak Gryphon

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2658) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2658, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 14000, 14000, 0, 11, 3147, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorbeak Gryphon - In Combat - Cast \'Rend Flesh\' Every 14 seconds'),
(2658, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 10000, 10000, 0, 11, 11019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorbeak Gryphon - In Combat - Cast \'Wing Flap\' Every 10 seconds');

-- Added Rend Flesh and Wing Flap on Razorbeak Skylord

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2659) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2659, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 14000, 14000, 0, 11, 3147, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorbeak Gryphon - In Combat - Cast \'Rend Flesh\' Every 14 seconds'),
(2659, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 10000, 10000, 0, 11, 11019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorbeak Gryphon - In Combat - Cast \'Wing Flap\' Every 10 seconds');

-- Added movement for Razorbeak Gryphon
DELETE FROM `creature` WHERE (`id` = 2658) AND (`guid` IN (93550));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(93550, 2658, 0, 0, 0, 1, 1, 935, 0, 138.441, -3310.63, 115.738, 1.23146, 350, 5, 0, 2059, 0, 1, 0, 0, 0, '', 0);

-- Added movement for Razorbeak Skylord
DELETE FROM `creature` WHERE (`id` = 2659) AND (`guid` IN (93612, 93615));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(93612, 2659, 0, 0, 0, 1, 1, 1148, 0, 133.356, -4032.63, 127.874, 3.52646, 350, 5, 0, 2399, 0, 1, 0, 0, 0, '', 0),
(93615, 2659, 0, 0, 0, 1, 1, 1148, 0, 200.395, -3662.88, 133.817, 3.43305, 350, 10, 0, 2399, 0, 1, 0, 0, 0, '', 0);