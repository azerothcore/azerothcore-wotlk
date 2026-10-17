-- DB update 2025_08_30_00 -> 2025_08_30_01
-- Update creature 'Tahu Sagewind' with sniffed values
-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (34528)) AND (`guid` IN (37));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(37, 34528, 1, 1, 1, 0, -1047.1771240234375, -287.98785400390625, 159.113677978515625, 2.728425025939941406, 120, 0, 0, 0, 0, 0, "", 45435, 1, NULL);
