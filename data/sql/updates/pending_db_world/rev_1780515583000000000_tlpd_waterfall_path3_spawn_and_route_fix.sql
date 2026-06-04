-- Waterfall Path 3 (path 392050) spawn and route separation.
-- Spawn position (6550.9775, -671.7839, 834.73395) is set on the creature only.
-- It is removed from waypoint_data so the patrol loop never returns to the spawn spot.
-- The original wp1 (6481.932, -689.96844, 770.06104) is appended as the last route point.

-- Creature spawn positions for TLPD (guid 39205) and Vyragosa (guid 39209) on Path 3
UPDATE `creature` SET `position_x` = 6550.9775, `position_y` = -671.7839, `position_z` = 834.73395, `orientation` = 5.51175 WHERE `guid` IN (39205, 39209);

-- Remove old wp1 from the patrol route so the spawn spot is not revisited mid-loop
DELETE FROM `waypoint_data` WHERE `id` = 392050 AND `point` = 1;

-- Old spawn position becomes the last patrol point, completing the loop naturally
DELETE FROM `waypoint_data` WHERE `id` = 392050 AND `point` = 12;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (392050, 12, 6481.932, -689.96844, 770.06104, NULL, 0, 1);
