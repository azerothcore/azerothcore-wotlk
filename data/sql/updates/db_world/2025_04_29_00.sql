-- DB update 2025_04_26_00 -> 2025_04_29_00

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

-- Update Triggers' positions (sniffed)
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 29038);
UPDATE `creature` SET `position_x` = 1382.6744, `position_y` = -5700.4575, `position_z` = 156.20384, `orientation` = 2.40855, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129906));
UPDATE `creature` SET `position_x` = 1366.528, `position_y` = -5701.2534, `position_z` = 147.08313, `orientation` = 1.30899, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129907));
UPDATE `creature` SET `position_x` = 1365.096, `position_y` = -5699.7446, `position_z` = 138.45604, `orientation` = 5.04400, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129908));
UPDATE `creature` SET `position_x` = 1371.1465, `position_y` = -5705.8774, `position_z` = 136.49808, `orientation` = 5.25344, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129909));
UPDATE `creature` SET `position_x` = 1384.8456, `position_y` = -5699.0986, `position_z` = 138.05069, `orientation` = 1.78023, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129910));
UPDATE `creature` SET `position_x` = 1386.3185, `position_y` = -5704.4565, `position_z` = 137.52542, `orientation` = 2.16420, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129911));
UPDATE `creature` SET `position_x` = 1373.8696, `position_y` = -5698.5435, `position_z` = 162.48119, `orientation` = 2.33874, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129912));
UPDATE `creature` SET `position_x` = 1380.1602, `position_y` = -5701.692, `position_z` = 164.21506, `orientation` = 5.16617, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129913));
UPDATE `creature` SET `position_x` = 1375.4838, `position_y` = -5700.0117, `position_z` = 150.63083, `orientation` = 3.82227, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129914));
UPDATE `creature` SET `position_x` = 1376.7048, `position_y` = -5700.71, `position_z` = 138.45558, `orientation` = 3.49065, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129915));
UPDATE `creature` SET `position_x` = 1369.781, `position_y` = -5702.2817, `position_z` = 138.52371, `orientation` = 0.94247, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129916));
UPDATE `creature` SET `position_x` = 1370.8365, `position_y` = -5700.444, `position_z` = 148.90135, `orientation` = 5.68977, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129917));
UPDATE `creature` SET `position_x` = 1383.7201, `position_y` = -5700.9634, `position_z` = 145.79176, `orientation` = 1.46607, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129918));
UPDATE `creature` SET `position_x` = 1372.7944, `position_y` = -5705.7993, `position_z` = 147.11938, `orientation` = 2.72271, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129919));
UPDATE `creature` SET `position_x` = 1363.2407, `position_y` = -5699.7573, `position_z` = 148.0276, `orientation` = 0.82030, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129920));
UPDATE `creature` SET `position_x` = 1381.6825, `position_y` = -5694.4004, `position_z` = 151.04852, `orientation` = 4.92182, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129921));
UPDATE `creature` SET `position_x` = 1376.7838, `position_y` = -5694.987, `position_z` = 164.34004, `orientation` = 1.18682, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129922));
UPDATE `creature` SET `position_x` = 1382.9271, `position_y` = -5696.133, `position_z` = 164.35858, `orientation` = 6.07374, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129923));
UPDATE `creature` SET `position_x` = 1381.9062, `position_y` = -5699.478, `position_z` = 165.0547, `orientation` = 6.16101, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129924));
UPDATE `creature` SET `position_x` = 1353.2142, `position_y` = -5691.629, `position_z` = 138.42285, `orientation` = 4.41568, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129925));
UPDATE `creature` SET `position_x` = 1360.2578, `position_y` = -5696.7036, `position_z` = 138.42085, `orientation` = 0.73303, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129926));
UPDATE `creature` SET `position_x` = 1361.8759, `position_y` = -5694.812, `position_z` = 148.35965, `orientation` = 1.04719, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129927));
UPDATE `creature` SET `position_x` = 1378.0033, `position_y` = -5691.8677, `position_z` = 151.09659, `orientation` = 5.89921, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129928));
UPDATE `creature` SET `position_x` = 1356.3627, `position_y` = -5690.5327, `position_z` = 148.52733, `orientation` = 3.35103, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129929));
UPDATE `creature` SET `position_x` = 1367.5154, `position_y` = -5683.803, `position_z` = 150.42963, `orientation` = 5.41052, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129930));
UPDATE `creature` SET `position_x` = 1357.8496, `position_y` = -5694.9785, `position_z` = 147.40619, `orientation` = 3.00196, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129931));
UPDATE `creature` SET `position_x` = 1365.8773, `position_y` = -5689.083, `position_z` = 151.89368, `orientation` = 0.48869, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129932));
UPDATE `creature` SET `position_x` = 1352.3483, `position_y` = -5689.826, `position_z` = 147.72693, `orientation` = 4.71238, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129933));
UPDATE `creature` SET `position_x` = 1384.1615, `position_y` = -5686.4473, `position_z` = 136.17474, `orientation` = 0.59341, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129934));
UPDATE `creature` SET `position_x` = 1374.2194, `position_y` = -5687.5293, `position_z` = 150.03831, `orientation` = 3.71755, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129935));
UPDATE `creature` SET `position_x` = 1372.7466, `position_y` = -5693.947, `position_z` = 152.32385, `orientation` = 2.35619, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129936));
UPDATE `creature` SET `position_x` = 1368.3043, `position_y` = -5694.866, `position_z` = 150.27689, `orientation` = 5.75958, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129937));
UPDATE `creature` SET `position_x` = 1377.7802, `position_y` = -5682.7607, `position_z` = 138.39493, `orientation` = 1.93731, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129938));
UPDATE `creature` SET `position_x` = 1383.7242, `position_y` = -5689.474, `position_z` = 148.14038, `orientation` = 1.51843, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129939));
UPDATE `creature` SET `position_x` = 1355.9176, `position_y` = -5680.996, `position_z` = 138.38802, `orientation` = 4.46804, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129940));
UPDATE `creature` SET `position_x` = 1351.64, `position_y` = -5685.475, `position_z` = 135.25368, `orientation` = 3.87463, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129941));
UPDATE `creature` SET `position_x` = 1354.3893, `position_y` = -5686.206, `position_z` = 150.09084, `orientation` = 5.68977, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129942));
UPDATE `creature` SET `position_x` = 1360.0142, `position_y` = -5679.5996, `position_z` = 151.54948, `orientation` = 4.59021, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129943));
UPDATE `creature` SET `position_x` = 1369.0516, `position_y` = -5675.592, `position_z` = 135.7965, `orientation` = 0.19198, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129944));
UPDATE `creature` SET `position_x` = 1367.1002, `position_y` = -5677.607, `position_z` = 148.00508, `orientation` = 3.96189, `VerifiedBuild` = 60192 WHERE (`id1` IN(29038)) AND (`guid` IN(129945));

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
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28030;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29030);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29030, 0, 0, 0, 1, 0, 100, 0, 4000, 10000, 8000, 14000, 0, 0, 11, 52953, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - Out of Combat - Cast \'Torch\''),
(29030, 0, 1, 0, 31, 0, 100, 0, 52953, 0, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - On Target Spellhit \'Torch\' - Play Emote 4'),
(29030, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 52372, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Icy Touch\''),
(29030, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 0, 0, 11, 52373, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Plague Strike\''),
(29030, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52374, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Blood Strike\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29031;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29031);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29031, 0, 0, 0, 1, 0, 100, 0, 4000, 10000, 8000, 14000, 0, 0, 11, 52953, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - Out of Combat - Cast \'Torch\''),
(29031, 0, 1, 0, 31, 0, 100, 0, 52953, 0, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - On Target Spellhit \'Torch\' - Play Emote 4'),
(29031, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 52372, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Icy Touch\''),
(29031, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 0, 0, 11, 52373, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Plague Strike\''),
(29031, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52374, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Blood Strike\'');

-- Set SmartAI for Death Knights inside the tavern.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28934;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28934);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28934, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 52372, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Icy Touch\''),
(28934, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 0, 0, 11, 52373, 32, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Plague Strike\''),
(28934, 0, 2, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52374, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Blood Strike\''),
(28934, 0, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52375, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight - In Combat - Cast \'Death Coil\'');
