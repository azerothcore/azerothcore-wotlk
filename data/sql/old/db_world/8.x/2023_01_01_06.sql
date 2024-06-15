-- DB update 2023_01_01_05 -> 2023_01_01_06
--
UPDATE `smart_scripts` SET `target_param3`=1 WHERE `entryorguid`=17729 AND `source_type`=0 AND `id` IN (3,4);
