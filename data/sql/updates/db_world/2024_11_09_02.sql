-- DB update 2024_11_09_01 -> 2024_11_09_02
--
DELETE FROM `creature` WHERE `guid` = 320 AND `id1` = 24358;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(320, 24358, 0, 0, 568, 0, 0, 1, 1, 0, 121.36404, 1674.9835, 42.10491, 1.553343057632446289, 608400, 0, 0, 4890, 0, 2, 1, 0, 0, 'npc_harrison_jones', 50375, 2, NULL);
