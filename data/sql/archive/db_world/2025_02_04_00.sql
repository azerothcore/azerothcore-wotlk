-- DB update 2025_02_03_01 -> 2025_02_04_00
--
-- Set questId on WP start
UPDATE `smart_scripts` SET `action_param4` = 5203 WHERE (`entryorguid` = 1101600) AND (`source_type` = 9) AND (`id` = 9);
-- Delete area explored action
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11016) AND (`source_type` = 0) AND (`id` = 38);
UPDATE `smart_scripts` SET `link`=39 WHERE (`entryorguid` = 11016) AND (`source_type` = 0) AND (`id` = 37);
