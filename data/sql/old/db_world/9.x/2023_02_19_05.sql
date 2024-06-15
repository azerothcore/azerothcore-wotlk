-- DB update 2023_02_19_04 -> 2023_02_19_05
--
UPDATE `smart_scripts` SET `event_type`=0, `event_param1`=2000, `event_param2`=6000, `event_param3`=12000, `target_type`=5, `target_param1`=25 WHERE `entryorguid`=18311 AND `source_type`=0 AND `id`=4;
