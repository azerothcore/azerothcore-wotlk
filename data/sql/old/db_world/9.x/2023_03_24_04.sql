-- DB update 2023_03_24_03 -> 2023_03_24_04
-- Ethereal Thief - Disarm timing
UPDATE `smart_scripts` SET `event_param1` = 9000, `event_param2` = 12000, `event_param3` = 15000, `event_param4` = 18000 WHERE `entryorguid` = 16544 AND `source_type` = 0 AND `id` = 4;
