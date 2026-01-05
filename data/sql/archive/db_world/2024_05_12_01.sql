-- DB update 2024_05_12_00 -> 2024_05_12_01
-- Shen'dralar Ancient smart ai
SET @ENTRY := 14358;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - On reset - Set event phase to phase 1'),
(@ENTRY, 0, 1, 0, 62, 0, 100, 512, 5723, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - On gossip action 0 from menu 5723 selected - Gossip player: Close gossip'),
(@ENTRY, 0, 2, 3, 20, 1, 100, 0, 7461, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - On player rewarded quest The Madness Within (7461) - Set event phase to phase 2'),
(@ENTRY, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - storedTarget[0] = Rewarded player'),
(@ENTRY, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (5, 0, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, 3.5, 3.5, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (3.5, 3.5, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, 0, 5, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (0, 5, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, 3.5, -3.5, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (3.5, -3.5, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, -5, 0, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (-5, 0, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, -3.5, -3.5, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (-3.5, -3.5, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, 0, -5, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (0, -5, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 12, 14364, 3, 300000, 0, 0, 0, 1, 0, 0, 0, -3.5, 3.5, 0, 0, 'Shen\'dralar Ancient - Summon creature Shen\'dralar Spirit (14364) at Self\'s position, moved by offset (-3.5, 3.5, 0, 0) as summon type timed despawn with duration 300 seconds'),
(@ENTRY, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 5, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - Play emote ONESHOT_APPLAUD (21)'),
(@ENTRY, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 14364, 10, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - Send stored target storedTarget[0] to Creature Shen\'dralar Spirit (14364) in 10 yd'),
(@ENTRY, 0, 14, 15, 20, 2, 100, 0, 7461, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - storedTarget[0] = Rewarded player (phase 2)'),
(@ENTRY, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 14364, 10, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - Send stored target storedTarget[0] to Creature Shen\'dralar Spirit (14364) in 10 yd (phase 2)'),
(@ENTRY, 0, 16, 0, 35, 0, 100, 512, 14364, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Ancient - On summoned creature Shen\'dralar Spirit (14364) despawn - Set event phase to phase 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 14358 AND `SourceId` = 0;

 -- Shen'dralar Spirit smart ai
SET @ENTRY := 14364;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 60, 0, 100, 0, 0, 30000, 20000, 30000, 10, 2, 21, 4, 66, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Spirit - Play random emote: ONESHOT_BOW (2), ONESHOT_APPLAUD (21), ONESHOT_CHEER(DNR) (4), ONESHOT_SALUTE (66),'),
(@ENTRY, 0, 1, 0, 60, 0, 100, 512, 15000, 15000, 15000, 15000, 66, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 'Shen\'dralar Spirit Look at storedTarget[0]');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 14364 AND `SourceId` = 0;

-- Treasure of the Shen'dralar
 -- 179517 (Area: 2557 - Difficulty: 1) CreateObject1
SET @OGUID1:=11921;
DELETE FROM `gameobject` WHERE (`id` = 179517) AND (`guid` IN (@OGUID1));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@OGUID1, 179517, 429, 2557, 2557, 1, 1, 129.4810638427734375, 544.96710205078125, -48.4663200378417968, 1.623155713081359863, 0, 0, 0.725374221801757812, 0.688354730606079101, 7200, 255, 1, '', 52237);

-- Skeletal Remains of Kariel Winthalus
-- 179544 (Area: 2557 - Difficulty: 1) CreateObject1
SET @OGUID2:=44739;
DELETE FROM `gameobject` WHERE (`id` = 179544) AND (`guid` IN (@OGUID2));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@OGUID2, 179544, 429, 2557, 2557, 1, 1, 163.0381622314453125, 530.1822509765625, -48.4669570922851562, 5.026549339294433593, 0, 0, -0.5877847671508789, 0.809017360210418701, 7200, 255, 1, '', 52237);
