-- DB update 2025_01_16_00 -> 2025_01_16_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24043) AND (`source_type` = 0) AND (`id` IN (2));
