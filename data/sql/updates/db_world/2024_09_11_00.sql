-- DB update 2024_09_09_00 -> 2024_09_11_00
UPDATE `smart_scripts`
SET `event_param4` = 6000
WHERE `entryorguid` = 22945
  AND `source_type` = 0
  AND `id` = 0;
