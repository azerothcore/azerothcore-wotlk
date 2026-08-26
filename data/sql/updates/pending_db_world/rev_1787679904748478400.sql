-- Quest "The Hunter and the Prince" (13361, 13400)
DELETE FROM `gameobject` WHERE `guid` = 59 AND `id` = 194023;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(59, 194023, 571, 0, 0, 1, 1, 6335.5, 2347.8, 477.23, 3.4, 0, 0, -0.99166481, 0.12884449, 120, 255, 1, '', 0, NULL);

DELETE FROM `event_scripts` WHERE `id` = 20723;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(20723, 0, 10, 32588, 60000, 0, 6314.5, 2342.8, 479.4, 0.22);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 32588) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32588, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Summoned - Say Line 0'),
(32588, 0, 1, 0, 0, 0, 100, 0, 15000, 16000, 15000, 16000, 0, 0, 11, 60744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - In Combat - Cast \'Immolation\''),
(32588, 0, 2, 0, 0, 0, 100, 0, 6000, 7000, 6000, 7000, 0, 0, 11, 61101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - In Combat - Cast \'Pierced Heart\''),
(32588, 0, 4, 0, 0, 0, 100, 0, 19000, 19000, 19000, 19000, 0, 0, 11, 60742, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - In Combat - Cast \'Shear\''),
(32588, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 32797, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Quest Credit \'The Prince\'s Destiny\''),
(32588, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 61623, 0, 0, 0, 0, 0, 19, 32326, 100, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Remove Aura \'Echoes from the Past\' From Prince Arthas Menethil'),
(32588, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 61623, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Remove Aura \'Echoes from the Past\' From Summoner');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32326;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 32326) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32326, 0, 0, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Arthas Menethil - On Passenger Removed - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 32497) AND (`source_type` = 0);
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 32497;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `SourceGroup` = 1 AND `SourceEntry` = 194023;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(30, 1, 194023, 0, 0, 47, 0, 13361, 10, 0, 0, 0, 0, '', 'Bloodstained Stone - visible only while on \'The Hunter and the Prince\' (Horde)'),
(30, 1, 194023, 0, 1, 47, 0, 13400, 10, 0, 0, 0, 0, '', 'Bloodstained Stone - visible only while on \'The Hunter and the Prince\' (Alliance)');
