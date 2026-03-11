-- DB update 2025_12_26_04 -> 2025_12_26_05
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24229) AND (`source_type` = 0) AND (`id` IN (1));
