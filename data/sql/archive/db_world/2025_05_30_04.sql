-- DB update 2025_05_30_03 -> 2025_05_30_04
--
UPDATE `smart_scripts` SET `action_param2` = 64 WHERE `entryorguid` = 30278 AND `source_type` = 0 AND `id` IN (2,3);
