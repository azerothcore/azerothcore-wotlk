-- DB update 2022_12_11_07 -> 2022_12_11_08
--
UPDATE `smart_scripts` SET `event_param5`=1 WHERE `entryorguid`=21126 AND `source_type`=0 AND `id` IN (5,6);
