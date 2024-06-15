-- DB update 2024_02_03_00 -> 2024_02_03_01
-- Update creature 26124 'Midsummer Merchant' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 26124) AND (`guid` IN (86179, 86224));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(86179, 26124, 0, 1, 1, 0, 1806.268798828125, 220.1627044677734375, 60.39253616333007812, 1.431169986724853515, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86224, 26124, 1, 1, 1, 0, -1017.98272705078125, 307.571197509765625, 135.8292694091796875, 2.181661605834960937, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 26124) AND (`guid` IN (120));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(120, 26124, 530, 1, 1, 0, 9796.3671875, -7253.505859375, 26.25297164916992187, 5.113814830780029296, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- remaining spawns (no sniffed values available)
-- (`guid` IN (86227))

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 26124));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 26124);
