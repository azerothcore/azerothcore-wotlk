-- DB update 2022_06_22_01 -> 2022_06_22_02
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (11357, 14989);

DELETE FROM `smart_scripts` WHERE ((`source_type` = 0 AND `entryorguid` = 14989)) OR (`source_type` = 0 AND `entryorguid` = 11357);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14989, 0, 0, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 24320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Cloud - On Update - Cast \'Poisonous Blood\''),
(11357, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - On Reset - Cast \'Thrash\''),
(11357, 0, 1, 0, 0, 0, 100, 0, 11000, 13000, 19000, 22000, 0, 11, 16790, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - In Combat - Cast \'Knockdown\''),
(11357, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 11, 24319, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - On Just Died - Cast \'Summon Poison Cloud\' (No Repeat)');

DELETE FROM `creature` WHERE (`id1` = 11357 AND `guid` IN ( 49033, 49034));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49033, 11357, 0, 0, 309, 0, 0, 1, 1, 0, -11746, -1620.6, 36.9961, 1.59794, 60, 5, 0, 15260, 0, 2, 0, 0, 0, '', 0),
(49034, 11357, 0, 0, 309, 0, 0, 1, 1, 0, -11836.5, -1599.98, 40.7501, 1.51519, 60, 5, 0, 15260, 0, 2, 0, 0, 0, '', 0);
