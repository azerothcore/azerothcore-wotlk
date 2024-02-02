-- Update creature 25980 'Heretic Bodyguard' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 25980) AND (`guid` IN (90920, 91009));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(90920, 25980, 1, 1, 1, 0, 4198.93310546875, 1181.44873046875, 5.203701496124267578, 4.310963153839111328, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(91009, 25980, 1, 1, 1, 0, 4205.69384765625, 1174.2926025390625, 5.943501472473144531, 3.438298702239990234, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 25980));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 25980);
