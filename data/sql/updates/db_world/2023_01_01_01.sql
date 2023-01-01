-- DB update 2023_01_01_00 -> 2023_01_01_01
--
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=17826 AND `source_type`=0 AND `id` IN (1,2);
