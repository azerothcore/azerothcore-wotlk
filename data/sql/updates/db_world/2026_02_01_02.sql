-- DB update 2026_02_01_01 -> 2026_02_01_02
-- fix talk timer for 'Brewfest Setup Crew'
UPDATE `smart_scripts` SET `event_param4` = 60000, `event_param5` = 360000 WHERE `entryorguid` = 23504 AND `source_type` = 0 AND `id` = 0 AND `link` = 0;
