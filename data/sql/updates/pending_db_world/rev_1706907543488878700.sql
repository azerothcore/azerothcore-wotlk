-- Update creature 25949 'Ice Caller Briatha' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 25949) AND (`guid` IN (245627));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(245627, 25949, 1, 1, 1, 0, 4194.7880859375, 1171.5792236328125, 6.983758449554443359, 0.698131680488586425, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 25949));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 25949);
