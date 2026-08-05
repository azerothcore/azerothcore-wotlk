-- DB update 2026_06_13_03 -> 2026_06_13_04
UPDATE `smart_scripts` SET
    `event_param1` = 10000, -- InitialMin: 10s
    `event_param2` = 20000, -- InitialMax: 20s
    `event_param3` = 10000, -- RepeatMin: 10s
    `event_param4` = 45000, -- RepeatMax: 45s
    `comment` = 'Surveyor Candress - Combat - Cast Fireball (Range 0-40, 10-45s cd)'
WHERE `entryorguid` = 16522 AND `id` = 5 AND `source_type` = 0;
