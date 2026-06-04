-- Frozen Lake Path 4 (path 392060) spawn and route separation.
-- Spawn position (6880.4116, -398.9924, 1004.92456) is set on the creature only.
-- It is removed from waypoint_data so the patrol loop never returns to the spawn spot.
-- The original wp1 (6954.7627, -472.37695, 997.65027) is appended as the last route point.

-- Creature spawn positions for TLPD (guid 39206) and Vyragosa (guid 39210) on Path 4
UPDATE `creature` SET `position_x` = 6880.4116, `position_y` = -398.9924, `position_z` = 1004.92456, `orientation` = 0.9124172 WHERE `guid` IN (39206, 39210);

-- Remove old wp1 from the patrol route so the spawn spot is not revisited mid-loop
DELETE FROM `waypoint_data` WHERE `id` = 392060 AND `point` = 1;

-- Old spawn position becomes the last patrol point, completing the loop naturally
DELETE FROM `waypoint_data` WHERE `id` = 392060 AND `point` = 18;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (392060, 18, 6954.7627, -472.37695, 997.65027, NULL, 0, 1);
