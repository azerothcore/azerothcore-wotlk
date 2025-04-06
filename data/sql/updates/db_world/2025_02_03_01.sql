-- DB update 2025_02_03_00 -> 2025_02_03_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25485) AND (`source_type` = 0) AND (`id` IN (0));
