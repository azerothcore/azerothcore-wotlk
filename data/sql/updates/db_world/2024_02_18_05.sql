-- DB update 2024_02_18_04 -> 2024_02_18_05
-- Update creature 38006 'Crown Hoodlum' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 38006) AND (`guid` IN (244616, 244617, 244618, 244619, 244620));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(244616, 38006, 1, 1, 1, 0, -3344.072998046875, -4162.02783203125, 20.593231201171875, 5.002112388610839843, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244617, 38006, 1, 1, 1, 0, -3351.350830078125, -4129.876953125, 33.59409332275390625, 2.808437824249267578, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244618, 38006, 1, 1, 1, 0, -3364.498291015625, -4119.53466796875, 24.82869338989257812, 5.05707550048828125, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244619, 38006, 1, 1, 1, 0, -3329.0625, -4137.69091796875, 26.09952545166015625, 2.198208093643188476, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244620, 38006, 1, 1, 1, 0, -3355.954833984375, -4206.5, 23.66841316223144531, 4.573012828826904296, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 38006) AND (`guid` IN (12473, 12474, 12475, 12476, 12477));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12473, 38006, 1, 1, 1, 0, -3367.390625, -4190.8212890625, 17.9209747314453125, 3.833674192428588867, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12474, 38006, 1, 1, 1, 0, -3375.93408203125, -4146.0625, 18.473297119140625, 0.113560080528259277, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12475, 38006, 1, 1, 1, 0, -3381.329833984375, -4178.83154296875, 18.70720291137695312, 3.892084121704101562, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12476, 38006, 1, 1, 1, 0, -3408.854248046875, -4213.8994140625, 11.20813941955566406, 0.962113082408905029, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12477, 38006, 1, 1, 1, 0, -3417.116455078125, -4196.486328125, 10.71973228454589843, 1.248782634735107421, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- enable all spawns for eventEntry 8
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 8) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 38006));
INSERT INTO `game_event_creature` (SELECT 8, `guid` FROM `creature` WHERE `id1` = 38006);
