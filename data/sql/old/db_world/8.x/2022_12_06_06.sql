-- DB update 2022_12_06_05 -> 2022_12_06_06
--
UPDATE `smart_scripts` SET `target_type`=2 WHERE (`entryorguid` = 22993) AND (`source_type` = 0) AND (`id` IN (5));
