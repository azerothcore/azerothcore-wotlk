-- DB update 2024_06_10_00 -> 2024_06_10_01
-- Chicken
DELETE FROM `creature` WHERE (`id1` = 620) AND (`guid` IN (14896, 15403, 15943, 16368));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(14896, 620, 0, 0, 0, 267, 271, 1, 1, 0, -816.1612, -616.04034, 13.880794, 0.9943093061447144, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(15403, 620, 0, 0, 0, 267, 271, 1, 1, 0, -814.34357, -583.0802, 15.234792, 0.8475685715675354, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(15943, 620, 0, 0, 0, 267, 271, 1, 1, 0, -752.3134, -550.3316, 19.06126, 3.9133145809173584, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(16368, 620, 0, 0, 0, 267, 271, 1, 1, 0, -829.1331, -534.4989, 14.115756, 0.11760736256837845, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0);
