INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646088848185485200');

SET @NPC := 793;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -12210.5, 34.3149, 16.1189, 100, 0),
(@PATH, 2, -12231.7, 40.5723, 21.022, 100, 0),
(@PATH, 3, -12216.4, 36.2551, 17.6715, 100, 0),
(@PATH, 4, -12189.2, 25.7189, 8.19729, 100, 0),
(@PATH, 5, -12162.7, 14.3586, -3.5121, 100, 0);
