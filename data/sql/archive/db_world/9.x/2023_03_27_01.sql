-- DB update 2023_03_27_00 -> 2023_03_27_01
--
UPDATE `smart_scripts` SET `event_param1`=3600, `event_param2`=10800, `event_param3`=16900, `event_param4`=26500 WHERE `entryorguid`=20478 AND `source_type`=0 AND `id`=1;
