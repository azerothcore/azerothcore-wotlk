-- DB update 2024_02_03_02 -> 2024_02_03_03
-- Update creature 25951 'Heretic Emissary' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 25951) AND (`guid` IN (86643));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(86643, 25951, 1, 1, 1, 0, 4199.23779296875, 1175.6844482421875, 6.156942367553710937, 3.787364482879638671, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 25951));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 25951);
