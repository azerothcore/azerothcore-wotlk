-- DB update 2022_12_06_11 -> 2022_12_06_12
--
UPDATE `smart_scripts` SET `event_chance`=30 WHERE (`entryorguid` = 17264) AND (`source_type` = 0) AND (`id` IN (0));
