-- DB update 2022_09_06_03 -> 2022_09_06_04
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (15651, 15652)) AND (`action_param1` = 22863)  AND (`source_type` = 0);
