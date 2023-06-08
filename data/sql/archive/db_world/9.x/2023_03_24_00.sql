-- DB update 2023_03_23_03 -> 2023_03_24_00
--
UPDATE `smart_scripts` SET `event_type`=1, `event_flags`=6, `event_param1`=2000, `event_param2`=6000, `event_param3`=18000, `event_param4`=24000, `action_param2`=0, `target_type`=1 WHERE `entryorguid`=17371 AND `source_type`=0 AND `id`=5;
