-- Update creature 38016 'Crown Agent' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 38016) AND (`guid` IN (244611, 244612, 244613, 244614, 244615));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(244611, 38016, 0, 1, 1, 0, 100.4280776977539062, -2490.742431640625, 121.4135208129882812, 2.317224502563476562, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244612, 38016, 0, 1, 1, 0, 110.3350677490234375, -2455.6650390625, 123.664825439453125, 0.428374558687210083, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244613, 38016, 0, 1, 1, 0, 120.4652786254882812, -2504.8212890625, 119.0987548828125, 6.003932476043701171, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244614, 38016, 0, 1, 1, 0, 117.6076431274414062, -2483.757080078125, 121.3556594848632812, 2.608929634094238281, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244615, 38016, 0, 1, 1, 0, 60.27604293823242187, -2513.822998046875, 122.183349609375, 2.436220169067382812, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 38016) AND (`guid` IN (12495, 12496, 12497, 12498, 12499));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12495, 38016, 0, 1, 1, 0, 65.65277862548828125, -2493.58154296875, 122.7665252685546875, 3.151055335998535156, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12496, 38016, 0, 1, 1, 0, 73.61978912353515625, -2444.29345703125, 123.7148590087890625, 3.797217607498168945, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12497, 38016, 0, 1, 1, 0, 73.92874908447265625, -2467.363525390625, 123.9583206176757812, 4.145519256591796875, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12498, 38016, 0, 1, 1, 0, 84.55902862548828125, -2507.171875, 119.3596343994140625, 5.80364847183227539, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12499, 38016, 0, 1, 1, 0, 90.19791412353515625, -2452.260498046875, 123.6936492919921875, 0.013602874241769313, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- enable all spawns for eventEntry 8
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 8) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 38016));
INSERT INTO `game_event_creature` (SELECT 8, `guid` FROM `creature` WHERE `id1` = 38016);
