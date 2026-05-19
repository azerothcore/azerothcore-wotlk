-- DB update 2026_05_18_02 -> 2026_05_19_00
-- Update creature 'Ludin Farrow' with sniffed values
-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (26546)) AND (`guid` IN (1550));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(1550, 26546, 0, 1, 1, 0, -3726.6103515625, -576.7655029296875, 4.643310546875, 4.171336650848388671, 120, 0, 0, 0, 0, 0, "", 45772, 1, NULL);
