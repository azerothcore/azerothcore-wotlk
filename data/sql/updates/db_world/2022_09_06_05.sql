-- DB update 2022_09_06_04 -> 2022_09_06_05

UPDATE `smart_scripts` SET `target_type` = 23 WHERE (`entryorguid` = 33519) AND (`source_type` = 0) AND (`id` IN (1));
