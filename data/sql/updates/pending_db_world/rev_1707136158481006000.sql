-- Update creature 25924 'Twilight Speaker Viktor' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 25924) AND (`guid` IN (245626));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(245626, 25924, 1, 1, 1, 1, 3922.167236328125, 789.5479736328125, 9.14093780517578125, 0.78539818525314331, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 25924));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 25924);
