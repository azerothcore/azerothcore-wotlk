-- DB update 2022_06_29_04 -> 2022_06_29_05
--
SET @NPC := 300758; # Actual GUID is unknown, but this is the same placeholder GUID used by Vmangos and is available
SET @PATH := @NPC * 10;

DELETE FROM `creature` WHERE `guid`=@NPC;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(@NPC, 8924, 0, 0, 0, -7404.57, -894.073, 171.873, 2.89516, 108000, 0, 2);

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);

INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -7404.57, -894.073, 171.873, 100, 0),
(@PATH, 2, -7397.19, -934.067, 169.109, 100, 0),
(@PATH, 3, -7397.22, -957.259, 170.151, 100, 0),
(@PATH, 4, -7406.08, -992.606, 173.821, 100, 0),
(@PATH, 5, -7378.71, -995.416, 171.25, 100, 0),
(@PATH, 6, -7348, -986.191, 171.532, 100, 0),
(@PATH, 7, -7346.79, -1017.81, 177.942, 100, 0),
(@PATH, 8, -7371.64, -1036.28, 177.966, 100, 0),
(@PATH, 9, -7390.05, -1044.6, 176.843, 100, 0),
(@PATH, 10, -7406.18, -1044.51, 176.751, 100, 0),
(@PATH, 11, -7390.37, -1044.6, 176.823, 100, 0),
(@PATH, 12, -7371.64, -1036.28, 177.966, 100, 0),
(@PATH, 13, -7346.79, -1017.81, 177.942, 100, 0),
(@PATH, 14, -7348, -986.191, 171.532, 100, 0),
(@PATH, 15, -7378.71, -995.416, 171.25, 100, 0),
(@PATH, 16, -7406.08, -992.606, 173.821, 100, 0),
(@PATH, 17, -7397.25, -957.381, 170.135, 100, 0),
(@PATH, 18, -7397.19, -934.067, 169.109, 100, 0),
(@PATH, 19, -7404.57, -894.073, 171.873, 100, 0),
(@PATH, 20, -7438.96, -892.375, 171.973, 100, 0);
