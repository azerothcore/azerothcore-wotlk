-- DB update 2024_06_24_01 -> 2024_06_24_02
-- Torek
UPDATE `smart_scripts` SET `target_type` = 16, `comment` = 'Torek - On Quest Accept - Store Party Targetlist' WHERE (`entryorguid` = 12858) AND (`source_type` = 0) AND (`id` = 1);
