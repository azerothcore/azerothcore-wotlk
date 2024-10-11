-- DB update 2023_02_25_00 -> 2023_02_25_01
-- Defias Gunpowder - add missing No Repeat flag (was already in the SAI comment)
UPDATE `smart_scripts` SET `event_flags` = `event_flags`|1 WHERE `entryorguid` = 17155 AND `source_type` = 1 AND `id` = 0;
