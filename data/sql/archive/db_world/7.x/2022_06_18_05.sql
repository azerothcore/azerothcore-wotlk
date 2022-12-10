-- DB update 2022_06_18_04 -> 2022_06_18_05
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1940) AND (`source_type` = 0) AND (`id` IN (1, 2, 3, 4));
