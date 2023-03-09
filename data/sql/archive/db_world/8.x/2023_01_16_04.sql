-- DB update 2023_01_16_03 -> 2023_01_16_04
--
UPDATE `smart_scripts` SET `target_type`=5 WHERE `entryorguid`=17871 AND `source_type`=0 AND `id` IN (0,1);
