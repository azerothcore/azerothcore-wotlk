-- DB update 2022_06_26_00 -> 2022_06_26_01
--
SET @ENTRY := 14517;
SET @PATH := @ENTRY*10;
UPDATE `creature_template_movement` SET `Flight` = 2 WHERE `CreatureId` = @ENTRY;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -12291.88, -1380.0778, 144.90173, 2.286381244659423828, 0, 2, 0, 100, 0),
(@PATH, 2, -12273.857, -1407.774, 132.22281, 0, 0, 2, 0, 100, 0);
