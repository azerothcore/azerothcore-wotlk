-- DB update 2024_11_24_03 -> 2024_11_24_04
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3678) AND (`source_type` = 0) AND (`id` IN (26));
