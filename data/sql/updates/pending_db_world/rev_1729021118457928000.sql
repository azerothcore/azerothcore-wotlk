-- Update creature 'Oomailiq' with sniffed values

-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (31806))
AND (`guid` IN (308));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(308, 31806, 621, 1, 1, 0, -19.990936279296875, 0.077455997467041015, 17.6105804443359375, 3.071779489517211914, 120, 0, 0, 0, 0, 0, "", 45942, 1, NULL);
