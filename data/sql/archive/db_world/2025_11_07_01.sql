-- DB update 2025_11_07_00 -> 2025_11_07_01
--
-- v11_2_5_63906
SET @VBUILD := 63906;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28932;
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 28932);

DELETE FROM `creature` WHERE (`id1` = 28932) AND `guid` IN (96663, 96664, 96671, 96798, 96800, 96865, 96870, 96871);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(96663, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6146.6094, -1971.1476, 481.92764, 5.305801, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96664, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6143.005, -1973.7048, 482.06653, 4.520403, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96671, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6218.721, -1985.6326, 482.0804, 4.3982296, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96798, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6221.371, -1989.2194, 482.06653, 1.5009831, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96800, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6128.758, -2046.2726, 482.0735, 2.7052603, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96865, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6131.65, -2049.7249, 482.03876, 0.6806784, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96870, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6203.877, -2064.1401, 482.06653, 0.06981317, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL),
(96871, 28932, 0, 0, 571, 0, 0, 1, 1, 0, 6207.528, -2061.5386, 482.02487, 4.08407, 300, 5, 0, 4979, 0, 1, 0, 0, 0, '', @VBUILD, 0, NULL);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-96663, -96798, -96800, -96870, -96664, -96671, -96865, -96871)) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96663, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52686, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam LH\''),
(-96798, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52686, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam LH\''),
(-96800, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52686, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam LH\''),
(-96870, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52686, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam LH\''),
(-96664, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52681, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam RH\''),
(-96671, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52681, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam RH\''),
(-96865, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52681, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam RH\''),
(-96871, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52681, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Effect Bunny - On Update - Cast \'Voltarus Blight Beam RH\'');

-- Set `unitflag` to IMMUNE_TO_PC, verify spawns, add missing spawn
DELETE FROM `creature` WHERE (`id1` = 28931) and `guid` IN (96497, 96498, 96499, 96545);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(96497, 28931, 0, 0, 571, 0, 0, 1, 1, 0, 6144.44, -1971.41, 461.385, 5.16617, 300, 0, 0, 200000, 0, 0, 0, 256, 0, '', NULL, @VBUILD),
(96498, 28931, 0, 0, 571, 0, 0, 1, 1, 0, 6206.33, -2063.48, 461.385, 2.14675, 300, 0, 0, 200000, 0, 0, 0, 256, 0, '', NULL, @VBUILD),
(96499, 28931, 0, 0, 571, 0, 0, 1, 1, 0, 6129.33, -2047.82, 461.385, 0.506145, 300, 0, 0, 200000, 0, 0, 0, 256, 0, '', NULL, @VBUILD),
(96545, 28931, 0, 0, 571, 0, 0, 1, 1, 0, 6221.2, -1986.5, 461.385, 3.78736, 300, 0, 0, 200000, 0, 0, 0, 256, 0, '', NULL, @VBUILD);

-- Voltarus Blight Beam LH, RH
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (52686, 52681)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28931) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 52686, 0, 0, 31, 0, 3, 28931, 0, 0, 0, 0, '', 'target Blightblood Troll'),
(13, 1, 52681, 0, 0, 31, 0, 3, 28931, 0, 0, 0, 0, '', 'target Blightblood Troll');
