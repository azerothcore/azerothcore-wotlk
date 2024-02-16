-- Update creature 37984 'Crown Duster' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 37984) AND (`guid` IN (244621, 244622, 244623, 244624, 244625));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(244621, 37984, 0, 1, 1, 0, -378.30902099609375, 208.529510498046875, 88.46282958984375, 3.839724302291870117, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244622, 37984, 0, 1, 1, 0, -394.711822509765625, 197.51910400390625, 82.26800537109375, 5.358272075653076171, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244623, 37984, 0, 1, 1, 0, -396.57464599609375, 127.8298721313476562, 54.46237945556640625, 5.201081275939941406, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244624, 37984, 0, 1, 1, 0, -387.810760498046875, 179.515625, 80.9049072265625, 1.064650893211364746, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244625, 37984, 0, 1, 1, 0, -375.36285400390625, 128.6006927490234375, 55.36986160278320312, 4.573588848114013671, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 37984) AND (`guid` IN (12468, 12469, 12470, 12471, 12472));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12468, 37984, 0, 1, 1, 0, -408.501739501953125, 203.6197967529296875, 81.3603515625, 1.605702877044677734, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12469, 37984, 0, 1, 1, 0, -421.5069580078125, 122.6284713745117187, 56.83416366577148437, 4.24114990234375, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12470, 37984, 0, 1, 1, 0, -423.4757080078125, 183.4965362548828125, 79.209228515625, 1.972222089767456054, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12471, 37984, 0, 1, 1, 0, -444.7532958984375, 174.57525634765625, 74.67865753173828125, 2.79698944091796875, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12472, 37984, 0, 1, 1, 0, -449.598968505859375, 185.50347900390625, 75.704071044921875, 2.652900457382202148, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- enable all spawns for eventEntry 8
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 8) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 37984));
INSERT INTO `game_event_creature` (SELECT 8, `guid` FROM `creature` WHERE `id1` = 37984);
