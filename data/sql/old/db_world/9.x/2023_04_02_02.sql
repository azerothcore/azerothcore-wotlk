-- DB update 2023_04_02_01 -> 2023_04_02_02
UPDATE `smart_scripts` SET `event_type` = 25, `comment` = 'Arcatraz Sentinel - On Reset - Set Health 40%' WHERE `source_type` = 0 AND `entryorguid` = 20869 AND `id` = 0;
