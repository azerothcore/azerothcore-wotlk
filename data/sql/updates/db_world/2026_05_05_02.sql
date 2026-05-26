-- DB update 2026_05_05_01 -> 2026_05_05_02

-- Delete Row 7
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3099200) AND (`source_type` = 9) AND (`id` IN (7));
