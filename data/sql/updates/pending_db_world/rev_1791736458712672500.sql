-- Stormwind City Patroller (entry 1976, guid 90438, path 904380):
-- waypoints 10-13 sit ~5 yards below the shoreline (z 87.42-88.22 while
-- points 9 and 14 sit at z 92.03 / 92.87) and drift 10-25 yards east of
-- the walkable corridor, pinning the patroller onto the canal water surface
-- (it visibly stutters/jumps there every patrol cycle, as the waypoint z
-- fights the height clamping that forbids walking on water).
-- Redistribute points 10-13 evenly along the shoreline between points 9
-- and 14 (five-way interpolation). Neighbouring paths 796700/796750/797920
-- all stay at z >= 92.6, confirming the intended ground level.
UPDATE `waypoint_data` SET `position_x`=-8908.99, `position_y`=814.13, `position_z`=92.195 WHERE `id`=904380 AND `point`=10;
UPDATE `waypoint_data` SET `position_x`=-8920.86, `position_y`=803.348, `position_z`=92.365 WHERE `id`=904380 AND `point`=11;
UPDATE `waypoint_data` SET `position_x`=-8932.74, `position_y`=792.564, `position_z`=92.535 WHERE `id`=904380 AND `point`=12;
UPDATE `waypoint_data` SET `position_x`=-8944.61, `position_y`=781.781, `position_z`=92.705 WHERE `id`=904380 AND `point`=13;
