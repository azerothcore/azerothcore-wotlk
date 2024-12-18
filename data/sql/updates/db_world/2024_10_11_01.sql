-- DB update 2024_10_11_00 -> 2024_10_11_01
--
UPDATE `smart_scripts` SET `target_type`=12, `target_param1`=1 WHERE `entryorguid`=1436800 AND `source_type`=9 AND `id` IN (2, 4);
