--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16977 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16977, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 20823, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - In Combat - Cast \'Fireball\''),
(16977, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 9000, 12000, 0, 0, 11, 15735, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - In Combat - Cast \'Arcane Missiles\''),
(16977, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 33245, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - Between 0-50% Health - Cast \'Ice Barrier\' (No Repeat)'),
(16977, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - Between 0-15% Health - Flee For Assist (No Repeat)'),
(16977, 0, 4, 0, 1, 0, 100, 0, 300000, 300000, 300000, 300000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 86053, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - OOC - Face target dummy'),
(16977, 0, 5, 0, 1, 0, 100, 0, 302000, 302000, 300000, 300000, 0, 0, 11, 29458, 0, 0, 0, 0, 0, 10, 86053, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - OOC - Cast \'Blizzard\''),
(16977, 0, 7, 0, 1, 0, 100, 0, 316000, 316000, 300000, 300000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 86056, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - OOC - Face target dummy'),
(16977, 0, 8, 0, 1, 0, 100, 0, 317000, 317000, 300000, 300000, 0, 0, 11, 29459, 0, 0, 0, 0, 0, 10, 86056, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - OOC - Cast \'Pyroblast\''),
(16977, 0, 9, 0, 1, 0, 100, 0, 324000, 324000, 300000, 300000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - OOC - Face self');
-- override existing creatures
-- xintor
DELETE FROM `creature` WHERE `guid` = 86049 AND `id1` = 16977;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(86049, 16977, 0, 0, 530, 0, 0, 1, 1, 1, -1311.5757, 2767.7476, -27.080133, 4.590215682983398437, 60, 0, 0, 5158, 2486, 0, 0, 0, 0, '', 0, 0, NULL);
-- dummies
DELETE FROM `creature` WHERE `guid` IN (86050, 86051, 86052) AND `id1` = 17060;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(86050, 17060, 0, 0, 530, 0, 0, 1, 1, 0, -1310.3284, 2773.9905, -26.935608, 4.78220224380493164, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL),
(86051, 17060, 0, 0, 530, 0, 0, 1, 1, 0, -1309.691, 2772.9463, -26.96556, 4.502949237823486328, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL),
(86052, 17060, 0, 0, 530, 0, 0, 1, 1, 0, -1308.7676, 2773.6067, -26.975742, 4.188790321350097656, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL);
-- new creatures
DELETE FROM `creature` WHERE `guid` IN (86053, 86054, 86055, 86056) AND `id1` = 17059;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(86053, 17059, 0, 0, 530, 0, 0, 1, 1, 0, -1315.7537, 2774.218, -26.852127, 5.009094715118408203, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL),
(86054, 17059, 0, 0, 530, 0, 0, 1, 1, 0, -1304.5875, 2771.2754, -27.027822, 3.996803998947143554, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL),
(86055, 17059, 0, 0, 530, 0, 0, 1, 1, 0, -1321.1343, 2771.1653, -26.577145, 5.654866695404052734, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL),
(86056, 17059, 0, 0, 530, 0, 0, 1, 1, 0, -1309.4927, 2774.1555, -26.953941, 4.363323211669921875, 120, 0, 0, 1524, 0, 0, 0, 0, 0, '', 52237, 0, NULL);
