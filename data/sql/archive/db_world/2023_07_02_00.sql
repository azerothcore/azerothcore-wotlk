-- DB update 2023_06_30_00 -> 2023_07_02_00
--
UPDATE `smart_scripts` SET `event_param5`=5000 WHERE `entryorguid` = 16420 AND `source_type` = 0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param5`=1000 WHERE `entryorguid` = 30085 AND `source_type` = 0 AND `id` = 1;
