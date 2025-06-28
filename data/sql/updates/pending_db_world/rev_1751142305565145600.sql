-- Update creature '[DNT] Torch Tossing Target Bunny Controller' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` IN (25536)) AND (`guid` IN (46914));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(46914, 25536, 1, 1, 1, 0, 8700.30859375, 932.3953857421875, 15.39370346069335937, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (25536)) AND (`guid` IN (12741, 12742, 12743, 12744, 12745, 12746, 12747));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12741, 25536, 0, 1, 1, 0, -4699.91748046875, -1223.1417236328125, 501.74273681640625, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12742, 25536, 0, 1, 1, 0, -8834.6591796875, 860.409912109375, 98.92121124267578125, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12743, 25536, 0, 1, 1, 0, 1821.796630859375, 219.0257720947265625, 60.35529327392578125, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12744, 25536, 1, 1, 1, 0, -1036.5052490234375, 291.666656494140625, 135.8285369873046875, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12745, 25536, 1, 1, 1, 0, 1912.2239990234375, -4337.7275390625, 21.54599571228027343, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50129, 1, NULL),
(12746, 25536, 530, 1, 1, 0, -3794.286865234375, -11503.6953125, -134.666015625, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12747, 25536, 530, 1, 1, 0, 9805.505859375, -7239.36083984375, 26.12895011901855468, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (25536)));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` IN (25536));

--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25536;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25536);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25536, 0, 0, 0, 1, 0, 100, 0, 3280, 3280, 3280, 3280, 0, 0, 11, 45907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny Controller - Out of Combat - Cast \'Torch Target Picker\'');
