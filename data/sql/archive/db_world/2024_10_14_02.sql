-- DB update 2024_10_14_01 -> 2024_10_14_02
-- Update creature 'Raging Soul' with sniffed values

-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (18506))
AND (`guid` IN (12707, 12708, 12709, 12710));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12707, 18506, 558, 3, 1, 0, 48.44750595092773437, -170.952972412109375, 15.11065673828125, 6.016101837158203125, 7200, 0, 0, 0, 0, 0, "", 46368, 1, NULL),
(12708, 18506, 558, 3, 1, 0, 60.22912216186523437, -165.152603149414062, 15.32995414733886718, 3.326717376708984375, 7200, 0, 0, 0, 0, 0, "", 46368, 1, NULL),
(12709, 18506, 558, 3, 1, 0, 67.13529205322265625, -160.446762084960937, 15.37751579284667968, 0.466603010892868041, 7200, 0, 0, 0, 0, 0, "", 52237, 1, NULL),
(12710, 18506, 558, 3, 1, 0, 69.42613983154296875, -157.7301025390625, 15.39217567443847656, 3.025804519653320312, 7200, 10, 1, 0, 0, 0, "", 52237, 1, NULL);
