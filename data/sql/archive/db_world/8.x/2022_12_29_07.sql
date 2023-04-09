-- DB update 2022_12_29_06 -> 2022_12_29_07
UPDATE `smart_scripts` SET `target_type`=2 WHERE (`entryorguid` = 20713) AND (`source_type` = 0) AND (`id` IN (1));
