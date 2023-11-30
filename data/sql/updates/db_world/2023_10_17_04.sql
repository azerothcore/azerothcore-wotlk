-- DB update 2023_10_17_03 -> 2023_10_17_04
--
DELETE FROM `creature` WHERE `guid` IN (93763, 93764, 93765);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(93763, 21964, 0, 0, 548, 0, 0, 1, 1, 0, 463.83, -540.23, -7.54, 3.15, 604800, 0, 0, 603120, 161550, 0, 0, 0, 0, '', 0, 0, NULL),
(93764, 21965, 0, 0, 548, 0, 0, 1, 1, 1, 459.61, -534.81, -7.54, 3.82, 604800, 0, 0, 603120, 161550, 0, 0, 0, 0, '', 0, 0, NULL),
(93765, 21966, 0, 0, 548, 0, 0, 1, 1, 1, 459.94, -547.28, -7.54, 2.42, 604800, 0, 0, 603120, 161550, 0, 0, 0, 0, '', 0, 0, NULL);
