-- DB update 2022_07_01_00 -> 2022_07_01_01
--
UPDATE `smart_scripts` SET `event_param1` = 5000, `event_param2` = 5000 WHERE `entryorguid` IN (15203, 15204, 15205, 15305) AND `event_type` = 1;
