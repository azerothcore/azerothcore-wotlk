-- DB update 2024_01_08_03 -> 2024_01_11_00
-- Update creature 28344 'Blazzle' with sniffed values
-- new spawns
DELETE FROM `creature` WHERE (`id1` = 28344) AND (`guid` IN (116));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(116, 28344, 530, 1, 1, 0, 3063.40625, 3677.5703125, 142.7606658935546875, 4.276056766510009765, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);
