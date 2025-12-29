-- DB update 2024_10_13_02 -> 2024_10_13_03
-- Update creature 'Venture Co. Gemologist' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` IN (17279))
AND (`guid` IN (62061, 62062, 62063));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(62061, 17279, 530, 1, 1, 1, -4627.05712890625, -12929.3251953125, 7.633514404296875, 5.131268024444580078, 300, 0, 0, 0, 0, 0, "", 45942, 1, NULL),
(62062, 17279, 530, 1, 1, 1, -4599.86083984375, -12879.29296875, 6.824597358703613281, 3.420845270156860351, 300, 0, 0, 0, 0, 0, "", 45942, 1, NULL),
(62063, 17279, 530, 1, 1, 1, -4583.64501953125, -12864.466796875, 6.161464691162109375, 4.310963153839111328, 300, 0, 0, 0, 0, 0, "", 45942, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (17279))
AND (`guid` IN (1559, 1560));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(1559, 17279, 530, 1, 1, 1, -4587.087890625, -12868.81640625, 5.791094303131103515, 0.767944872379302978, 300, 0, 0, 0, 0, 0, "", 45942, 1, NULL),
(1560, 17279, 530, 1, 1, 1, -4641.50244140625, -12940.6015625, 8.814029693603515625, 0.855211317539215087, 300, 0, 0, 0, 0, 0, "", 45435, 1, NULL);

-- disable emote for one of the new spawns
DELETE FROM `creature_addon` WHERE (`guid` IN (1560));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(1560, 0, 0, 0, 1, 0, 0, NULL);
