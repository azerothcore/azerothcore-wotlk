-- DB update 2024_11_20_00 -> 2024_11_20_01
--
-- SMART_EVENT_IS_IN_MELEE_RANGE invert, SMARTCAST_TRIGGERED, TRIGGERED_IGNORE_POWER_AND_REAGENT_COST
UPDATE `smart_scripts` SET `event_type` = 110, `event_param1` = 0, `event_param3` = 3000, `event_param4` = 3500, `event_param6` = 1, `action_param2` = (`action_param2` | 0x2 | 0x40), `action_param3` = (`action_param3` | 0x4), `comment` = 'Irespeaker - On Not In Melee Range - Cast \'Fel Fireball\'' WHERE (`entryorguid` = 24999) AND (`source_type` = 0) AND (`id` = 0);

-- SMART_EVENT_IS_IN_MELEE_RANGE, SMARTCAST_TRIGGERED TRIGGERED_IGNORE_POWER_AND_REAGENT_COST
UPDATE `smart_scripts` SET `event_type` = 110, `action_param2` = (`action_param2` | 0x2), `action_param3` = (`action_param3` | 0x4), `comment` = 'Irespeaker - On In Melee Range - Cast \'Fel Consumption\'' WHERE (`entryorguid` = 24999) AND (`source_type` = 0) AND (`id` = 1);
