-- Brunnhildar route (Path 1) spawn and route separation.
-- Spawn position (6821.0693, -1800.8033, 940.85815) is set on the creature only.
-- It is removed from waypoint_data so the patrol loop never returns to the spawn spot.
-- The original wp1 (6748.211, -1664.3069, 919.3118) is appended as the last route point.

-- Creature spawn positions for TLPD (guid 39203) and Vyragosa (guid 39207) on Path 1
UPDATE `creature` SET `position_x` = 6821.0693, `position_y` = -1800.8033, `position_z` = 940.85815, `orientation` = 0.8169179 WHERE `guid` IN (39203, 39207);

-- Remove old wp1 from the patrol route so the spawn spot is not revisited mid-loop
DELETE FROM `waypoint_data` WHERE `id` = 392030 AND `point` = 1;

-- Old spawn position becomes the last patrol point, completing the loop naturally
DELETE FROM `waypoint_data` WHERE `id` = 392030 AND `point` = 14;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (392030, 14, 6748.211, -1664.3069, 919.3118, NULL, 0, 1);
