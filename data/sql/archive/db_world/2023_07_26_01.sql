-- DB update 2023_07_26_00 -> 2023_07_26_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17671) AND (`source_type` = 0) AND (`id` IN (4));
