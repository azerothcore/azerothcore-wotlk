-- DB update 2023_10_25_01 -> 2023_10_25_02
--
UPDATE`smart_scripts` SET `action_param2` = 2 WHERE `source_type` = 0 AND `id` = 0 AND `entryorguid` IN (19007,19006);
