-- DB update 2023_01_03_00 -> 2023_01_03_01
--
UPDATE `smart_scripts` SET `action_param2`=2 WHERE `entryorguid`=32149 AND `source_type`=0 AND `id` IN (0,1);
