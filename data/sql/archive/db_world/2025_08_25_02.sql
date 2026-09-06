-- DB update 2025_08_25_01 -> 2025_08_25_02
-- fix dark portal creatures calling for help on aggro
-- 18948 Stormwind Soldier
UPDATE `smart_scripts` SET `event_type` = 4 WHERE (`entryorguid` = 18948) AND (`source_type` = 0) AND (`id` IN (7));
-- 18950 Orgrimmar Grunt
UPDATE `smart_scripts` SET `event_type` = 4 WHERE (`entryorguid` = 18950) AND (`source_type` = 0) AND (`id` IN (7));
