-- Update creature 26221 'Earthen Ring Elder' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 26221) AND (`guid` IN (90494, 90495, 90496, 90498, 90499, 90508));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(90494, 26221, 1, 1, 1, 0, 8703.544921875, 958.0125732421875, 13.31546592712402343, 4.031710624694824218, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(90495, 26221, 0, 1, 1, 0, 1791.362060546875, 231.328125, 60.19393539428710937, 0.907571196556091308, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(90496, 26221, 1, 1, 1, 0, -1017.338623046875, 295.305572509765625, 135.8292694091796875, 3.96189737319946289, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(90498, 26221, 530, 1, 1, 0, -1740.58837890625, 5342.6611328125, -12.3448038101196289, 2.007128715515136718, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(90499, 26221, 0, 1, 1, 0, -4715.455078125, -1228.57177734375, 501.74273681640625, 1.588249564170837402, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(90508, 26221, 1, 1, 1, 0, 1911.9930419921875, -4331.91796875, 21.57311058044433593, 0.506145477294921875, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 26221) AND (`guid` IN (12458, 12459, 12460));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12458, 26221, 0, 1, 1, 0, -8833.2255859375, 866.12738037109375, 98.8430023193359375, 5.532693862915039062, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12459, 26221, 530, 1, 1, 0, -3794.848876953125, -11523.697265625, -134.993515014648437, 0.069813169538974761, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12460, 26221, 530, 1, 1, 0, 9807.3046875, -7232.67626953125, 26.09997367858886718, 0.069813169538974761, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 26221));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 26221);
