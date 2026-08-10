-- Mimiron DB Target: the NPC the P3Wx2 Laser Barrage beams track.
-- Path, positions and lap time are the creature's sniffed movement spline.
SET @CGUID := 13395;
SET @PATH  := @CGUID;

DELETE FROM `creature` WHERE `id` = 33576 AND `map` = 603;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID, 33576, 603, 0, 0, 3, 1, 2785.423, 2673.1191, 372.36053, 5.714255, 7200, 2, 68974);

DELETE FROM `creature_addon` WHERE `guid` = @CGUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes1`, `bytes2`) VALUES
(@CGUID, @PATH, 0, 1);

-- Sniffed spline: 19 control points, CatmullRom, one lap every 34016 ms. The velocity is what makes
-- the waypoint generator's own spline arithmetic land on that lap time, so the sweep rate matches.
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `velocity`, `smoothTransition`) VALUES
(@PATH,  1, 2785.423 , 2673.1191, 372.36053, 20.8988, 1),
(@PATH,  2, 2823.0237, 2649.0586, 371.9791 , 20.8988, 1),
(@PATH,  3, 2854.097 , 2590.8262, 371.9791 , 20.8988, 1),
(@PATH,  4, 2852.951 , 2547.1116, 372.36053, 20.8988, 1),
(@PATH,  5, 2822.796 , 2489.515 , 372.36053, 20.8988, 1),
(@PATH,  6, 2784.964 , 2465.2473, 372.36053, 20.8988, 1),
(@PATH,  7, 2741.2397, 2456.771 , 372.36053, 20.8988, 1),
(@PATH,  8, 2701.0356, 2464.3186, 372.36053, 20.8988, 1),
(@PATH,  9, 2660.476 , 2489.578 , 372.36053, 20.8988, 1),
(@PATH, 10, 2636.8928, 2525.6873, 372.36053, 20.8988, 1),
(@PATH, 11, 2631.294 , 2547.8306, 372.36053, 20.8988, 1),
(@PATH, 12, 2631.4365, 2591.7522, 372.36053, 20.8988, 1),
(@PATH, 13, 2637.3616, 2613.7002, 372.36053, 20.8988, 1),
(@PATH, 14, 2650.2214, 2636.1633, 372.36053, 20.8988, 1),
(@PATH, 15, 2661.5715, 2649.7153, 372.36053, 20.8988, 1),
(@PATH, 16, 2696.5955, 2672.6636, 372.36053, 20.8988, 1),
(@PATH, 17, 2711.0989, 2677.7908, 372.36053, 20.8988, 1),
(@PATH, 18, 2740.676 , 2683.1196, 372.36053, 20.8988, 1),
(@PATH, 19, 2771.834 , 2677.767 , 372.36053, 20.8988, 1);
