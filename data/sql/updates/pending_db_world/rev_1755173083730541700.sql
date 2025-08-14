-- testing purposes from https://github.com/azerothcore/azerothcore-wotlk/pull/22676/files
-- Fix Heb''Drakkar Headhunter waypoints error in server console
UPDATE `waypoint_data`
SET `action` = 0
WHERE `id` = 1133640 AND `point` = 3;

DELETE FROM `smart_scripts`
WHERE `entryorguid` = 28600 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (
  `entryorguid`, `source_type`, `id`, `link`,
  `event_type`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
  `action_type`, `action_param1`, `action_param2`, `action_param3`,
  `target_type`, `comment`
) VALUES (
  28600, 0, 0, 0,
  40, 3, 0, 0, 0,        -- SMART_EVENT_WAYPOINT_REACHED, point 3
  11, 52059, 0, 0,       -- SMART_ACTION_CAST, spell 52059
  1, 'Heb''Drakkar Headhunter - WP3 - Cast 52059 on self'  -- SMART_TARGET_SELF
);

-- Joseph Wilson  waypoints error in server console

-- 1) Add a delay (4000 ms) at step 4
UPDATE `waypoints`
SET `delay` = 4000
WHERE `entry` = 33589 AND `pointid` = 4;

-- 2) Remove the redundant pause + the linked action
DELETE FROM `smart_scripts`
WHERE `source_type` = 0 AND `entryorguid` = 33589 AND `id` IN (2,3);
-- 3) Recreate the orientation as a direct event on WP 4
INSERT INTO `smart_scripts` (
  `entryorguid`, `source_type`, `id`, `link`,
  `event_type`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
  `action_type`, `action_param1`, `action_param2`, `action_param3`,
  `target_type`, `comment`
) VALUES (
  33589, 0, 2, 0,
  40, 4, 0, 0, 0,             -- SMART_EVENT_WAYPOINT_REACHED, point 4
  66, 3, 0, 0,                -- SMART_ACTION_SET_ORIENTATION, orientation 3
  8, 'Joseph Wilson - On WP 4 Reached - Set Orientation 3');
