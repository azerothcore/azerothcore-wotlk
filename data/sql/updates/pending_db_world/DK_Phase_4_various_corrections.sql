
-- Add Waypoint for Knight Commander Plaguefist (sniffed)
DELETE FROM `waypoint_data` WHERE `id` IN (12994700);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12994700, 1, 1369.2288, -5721.9683, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 2, 1361.9355, -5725.302, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 3, 1353.9138, -5723.0273, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 4, 1348.8505, -5717.2407, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 5, 1353.9138, -5723.0273, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 6, 1361.9355, -5725.302, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 7, 1369.2288, -5721.9683, 136.41475, NULL, 0, 0, 0, 100, 0),
(12994700, 8, 1380.4694, -5711.5713, 136.48778, NULL, 0, 0, 0, 100, 0);

-- Set Spawn Point and path id for Plaguefist
UPDATE `creature` SET `position_x` = 1380.4694, `position_y` = -5711.5713, `position_z` = 136.48778, `MovementType` = 2 WHERE (`id1` IN(29053)) AND (`guid` IN(129947));
DELETE FROM `creature_addon` WHERE (`guid` IN (129947));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(129947, 12994700, 0, 0, 0, 0, 0, NULL);

-- Set Rooted on triggers (sniffed)
UPDATE `creature_template_movement` SET `Rooted` = 1 WHERE (`CreatureId` = 29038);

-- Delete Wrong guids (triggers)
DELETE FROM `creature` WHERE (`id1` = 29038) AND (`guid` IN (129920, 129921, 129922, 129923, 129924, 129925, 129926, 129927, 129928, 129929, 129930, 129931, 129932, 129933, 129934, 129935, 129936, 129937, 129938, 129939, 129940, 129941, 129942, 129943, 129944, 129945));

-- Update Triggers' positions (sniffed)
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 29038);
UPDATE `creature` SET `position_x` = 1382.6744, `position_y` = -5700.4575, `position_z` = 156.20384, `orientation` = 2.40855, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129906));
UPDATE `creature` SET `position_x` = 1366.528, `position_y` = -5701.2534, `position_z` = 147.08313, `orientation` = 1.30899, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129907));
UPDATE `creature` SET `position_x` = 1365.096, `position_y` = -5699.7446, `position_z` = 138.45604, `orientation` = 5.04400, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129908));
UPDATE `creature` SET `position_x` = 1371.1465, `position_y` = -5705.8774, `position_z` = 136.49808, `orientation` = 5.25344, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129909));
UPDATE `creature` SET `position_x` = 1384.8456, `position_y` = -5699.0986, `position_z` = 138.05069, `orientation` = 1.78023, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129910));
UPDATE `creature` SET `position_x` = 1386.3185, `position_y` = -5704.4565, `position_z` = 137.52542, `orientation` = 2.16420, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129911));
UPDATE `creature` SET `position_x` = 1384.8456, `position_y` = -5699.0986, `position_z` = 138.05069, `orientation` = 1.78023, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129912));
UPDATE `creature` SET `position_x` = 1380.1602, `position_y` = -5701.692, `position_z` = 164.21506, `orientation` = 5.16617, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129913));
UPDATE `creature` SET `position_x` = 1375.4838, `position_y` = -5700.0117, `position_z` = 150.63083, `orientation` = 3.82227, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129914));
UPDATE `creature` SET `position_x` = 1376.7048, `position_y` = -5700.71, `position_z` = 138.45558, `orientation` = 3.49065, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129915));
UPDATE `creature` SET `position_x` = 1369.781, `position_y` = -5702.2817, `position_z` = 138.52371, `orientation` = 0.94247, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129916));
UPDATE `creature` SET `position_x` = 1370.8365, `position_y` = -5700.444, `position_z` = 148.90135, `orientation` = 5.68977, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129917));
UPDATE `creature` SET `position_x` = 1383.7201, `position_y` = -5700.9634, `position_z` = 145.79176, `orientation` = 1.46607, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129918));
UPDATE `creature` SET `position_x` = 1372.7944, `position_y` = -5705.7993, `position_z` = 147.11938, `orientation` = 2.72271, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129919));

-- Edit SmartAI for Triggers
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29038;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29038);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29038, 0, 0, 0, 8, 0, 100, 0, 52953, 0, 12000, 14000, 0, 0, 11, 52955, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[Chapter II] Torch Toss Dummy - On Spellhit \'Torch\' - Cast \'Torch\'');

-- Add condition for spell torch (Its target must be only a trigger)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 52953) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 24) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 10) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 52953, 0, 0, 24, 0, 10, 0, 0, 0, 0, 0, '', '');

-- Add SmartAI on Death Knights near the Chapel
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29030;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29030);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29030, 0, 0, 0, 1, 0, 100, 0, 4000, 12000, 8000, 16000, 0, 0, 11, 52953, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - Out of Combat - Cast \'Torch\''),
(29030, 0, 1, 0, 31, 0, 100, 0, 52953, 0, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - On Target Spellhit \'Torch\' - Play Emote 4'),
(28930, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 52372, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Icy Touch\''),
(28930, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 0, 0, 11, 52373, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Plague Strike\''),
(28930, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52374, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Blood Strike\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29031;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29031);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29031, 0, 0, 0, 1, 0, 100, 0, 4000, 12000, 8000, 16000, 0, 0, 11, 52953, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - Out of Combat - Cast \'Torch\''),
(29031, 0, 1, 0, 31, 0, 100, 0, 52953, 0, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - On Target Spellhit \'Torch\' - Play Emote 4'),
(28931, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 52372, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Icy Touch\''),
(28931, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 0, 0, 11, 52373, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Plague Strike\''),
(28931, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52374, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Blood Strike\'');

-- Set SmartAI for Death Knights inside the tavern.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28934;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28934);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28934, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 52372, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Icy Touch\''),
(28934, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 0, 0, 11, 52373, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Plague Strike\''),
(28934, 0, 2, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52374, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Blood Strike\''),
(28934, 0, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52375, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Death Coil\'');
