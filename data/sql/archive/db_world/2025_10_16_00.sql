-- DB update 2025_10_14_00 -> 2025_10_16_00
-- 53 WP_START
-- update previous parameter run = 1 to forcedMovement = 2 (run)
update `smart_scripts` set `action_param1` = 2 where `action_type` = 53 and `action_param1` = 1;
-- update previous parameter run = 0 to forcedMovement = 1 (walk)
update `smart_scripts` set `action_param1` = 1 where `action_type` = 53 and `action_param1` = 0;

-- 113 START_CLOSEST_WAYPOINT
-- update previous parameter run = 1 to forcedMovement = 2 (run)
update `smart_scripts` set `action_param4` = 2 where `action_type` = 113 and `action_param4` = 1;
-- update previous parameter run = 0 to forcedMovement = 1 (walk)
update `smart_scripts` set `action_param4` = 1 where `action_type` = 113 and `action_param4` = 0;
