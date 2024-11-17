--
-- SMARTCAST_NO_CAST_IN_MELEE, SMARTCAST_TRIGGERED, TRIGGERED_IGNORE_POWER_AND_REAGENT_COST
UPDATE `smart_scripts` SET `event_param1` = 0, `action_param2` = `action_param2` | (0x2 | 0x200), `action_param3` = `action_param3` | 0x4 WHERE (`entryorguid` = 24999) AND (`source_type` = 0) AND (`id` = 0);
-- SMARTCAST_CAST_IN_MELEE, SMARTCAST_TRIGGERED TRIGGERED_IGNORE_POWER_AND_REAGENT_COST
UPDATE `smart_scripts` SET `action_param2` = `action_param2` | (0x2 | 0x400), `action_param3` = `action_param3` | 0x4 WHERE (`entryorguid` = 24999) AND (`source_type` = 0) AND (`id` = 1);
