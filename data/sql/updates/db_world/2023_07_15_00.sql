-- DB update 2023_07_12_00 -> 2023_07_15_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (22038, 22482) AND (`source_type` = 0) AND (`id` IN (12));
