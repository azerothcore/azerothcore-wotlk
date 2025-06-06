-- DB update 2023_10_10_12 -> 2023_10_10_13
-- Alliance / Horde Cleric
UPDATE `smart_scripts` SET `event_param5` = 1 WHERE `source_type` = 0 AND `entryorguid` IN (26805,26803) AND `id` IN (0,1);
