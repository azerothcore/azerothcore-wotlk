-- DB update 2023_09_18_01 -> 2023_09_18_02
--
UPDATE `smart_scripts` SET `event_param5` = 1, `action_param3` = 1 WHERE `source_type` = 0 AND `entryorguid` IN (28994,29523,28989,28721,28725,28726);
