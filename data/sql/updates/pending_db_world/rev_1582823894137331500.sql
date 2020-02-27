INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582823894137331500');

-- Set movement type for formation members
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (6886, 6883, 6880, 6877);

-- Deactivate paths for formation members
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` IN (6886, 6883, 6880, 6877);

-- Create formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 6885;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(6885, 6885, 0, 0, 515, 0, 0),
(6885, 6886, 5, 0, 515, 0, 0),
(6885, 6883, 10, 0, 515, 0, 0),
(6885, 6880, 15, 0, 515, 0, 0),
(6885, 6877, 20, 0, 515, 0, 0);

-- Delete unused waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (68860, 68830, 68800, 68770);
