-- DB update 2022_05_26_01 -> 2022_05_29_00
--
UPDATE `smart_scripts` SET `action_type`=45, `action_param1`=0, `action_param2`=1 WHERE `entryorguid`=2471801 AND `source_type`=9 AND `id`=3;
UPDATE `smart_scripts` SET `entryorguid`=24823, `source_type`=0, `event_type`=38, `event_param1`=0, `event_param2`=1 WHERE `entryorguid`=2482300 AND `source_type`=9 AND `id`=0;
