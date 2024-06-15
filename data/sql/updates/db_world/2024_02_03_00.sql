-- DB update 2024_02_01_01 -> 2024_02_03_00
-- Update creature 26123 'Midsummer Supplier' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 26123) AND (`guid` IN (202770, 202864, 86163));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(202770, 26123, 530, 1, 1, 0, -3792.682373046875, -11515.6591796875, -134.693161010742187, 6.248278617858886718, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(202864, 26123, 0, 1, 1, 0, -4707.91015625, -1226.0858154296875, 501.74273681640625, 2.146754980087280273, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86163, 26123, 1, 1, 1, 0, 8701.7451171875, 962.31097412109375, 12.8077402114868164, 3.193952560424804687, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 26123) AND (`guid` IN (118));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(118, 26123, 0, 1, 1, 0, -8829.3544921875, 871.2298583984375, 98.76789093017578125, 4.537856101989746093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 26123));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 26123);
