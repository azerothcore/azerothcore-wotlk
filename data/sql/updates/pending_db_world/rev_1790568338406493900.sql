-- Onyxia's Lair, World Triggers over Onyxia's air-phase points and the room centre
SET @CGUID := 13396;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+8 AND `id` = 22515;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `CreateObject`, `VerifiedBuild`, `Comment`) VALUES
(@CGUID+0, 22515, 249, 3, 25.16067, -216.08244, -58.92215, 2.687807083129882812, 300, 1, 69933, 'World Trigger - Onyxia air phase, north'),
(@CGUID+1, 22515, 249, 3, 12.422047, -242.43831, -60.561646, 2.530727386474609375, 300, 1, 69933, 'World Trigger - Onyxia air phase, north-east'),
(@CGUID+2, 22515, 249, 3, -14.978153, -245.48346, -60.375755, 1.989675283432006835, 300, 1, 69933, 'World Trigger - Onyxia air phase, east'),
(@CGUID+3, 22515, 249, 3, -63.786427, -235.2712, -60.19681, 0.575958669185638427, 300, 1, 69933, 'World Trigger - Onyxia air phase, south-east'),
(@CGUID+4, 22515, 249, 3, -75.387505, -215.21892, -58.02298, 0.05235987901687622, 300, 1, 69933, 'World Trigger - Onyxia air phase, south'),
(@CGUID+5, 22515, 249, 3, -64.04101, -188.51236, -59.439896, 5.654866695404052734, 300, 1, 69933, 'World Trigger - Onyxia air phase, south-west'),
(@CGUID+6, 22515, 249, 3, -15.713689, -181.3027, -62.038284, 4.24114990234375, 300, 1, 69933, 'World Trigger - Onyxia air phase, west'),
(@CGUID+7, 22515, 249, 3, 11.944992, -180.16212, -60.27321, 3.804817676544189453, 300, 1, 69933, 'World Trigger - Onyxia air phase, north-west'),
(@CGUID+8, 22515, 249, 3, -33.936684, -215.75456, -87.710365, 4.764749050140380859, 300, 1, 69933, 'World Trigger - Onyxia''s Lair room centre');
