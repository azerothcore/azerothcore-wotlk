-- DB update 2025_12_15_00 -> 2025_12_16_00
-- Sets the chests in "Brackwell Pumpkin Patch" to 15 mins (validated in Classic Era and TBC PTR).
UPDATE `gameobject` SET `rotation0`= 0,`rotation1`= 0,`rotation2`= 0,`rotation3`= 0, `spawntimesecs` = 900, `animprogress` = 255, `VerifiedBuild` = 64907 WHERE `id` = 106318 AND `guid` IN (85745, 85756, 85879, 26916);

-- The below Rotation Values are Most probably related to one of the Rotation0 - 3
-- GameObject Rotation: X: 0 Y: 0 Z: 0.9996567 W: 0.026201647
UPDATE `gameobject` SET `position_x` = -9711.927, `position_y` = -943.4976, `position_z` = 38.416466, `orientation` = 3.0891833, `Comment` = "Brackwell Pumpkin Patch - Inside Barn" WHERE `id` = 106318 AND `guid` = 26916;
-- GameObject Rotation: X: 0 Y: 0 Z: -0.19936752 W: 0.9799248
UPDATE `gameobject` SET `position_x` = -9796.159, `position_y` = -929.679, `position_z` = 39.13272, `orientation` = 5.8817606, `Comment` = "Brackwell Pumpkin Patch - Outside Trio House" WHERE `id` = 106318 AND `guid` = 85756;
-- GameObject Rotation: X: 0 Y: 0 Z: 0.47715855 W: 0.87881726
UPDATE `gameobject` SET `position_x` = -9804.657, `position_y` = -934.9581, `position_z` = 39.855556, `orientation` = 0.99483716, `Comment` = "Brackwell Pumpkin Patch - Inside Trio House" WHERE `id` = 106318 AND `guid` = 85879;
-- GameObject Rotation: X: 0 Y: 0 Z: 0.6883545 W: 0.72537446
UPDATE `gameobject` SET `position_x` = -9739.496, `position_y` = -934.5089, `position_z` = 38.918198, `orientation` = 1.5184362, `Comment` = "Brackwell Pumpkin Patch - Outside Barn" WHERE `id` = 106318 AND `guid` = 85745;

DELETE FROM `pool_template` WHERE `entry` = 143;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(143, 1, "Brackwell Pumpkin Patch - Battered Chest (106319)"); -- 1 out 4 possible spawns.

DELETE FROM `pool_gameobject` WHERE `pool_entry` = 143 AND `guid` IN (85745, 85756, 85879, 26916);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(26916, 143, 15, "Brackwell Pumpkin Patch - Battered Chest (106319)"),
(85756, 143, 35, "Brackwell Pumpkin Patch - Battered Chest (106319)"),
(85879, 143, 35, "Brackwell Pumpkin Patch - Battered Chest (106319)"),
(85745, 143, 15, "Brackwell Pumpkin Patch - Battered Chest (106319)");
