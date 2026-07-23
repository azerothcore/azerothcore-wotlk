-- DB update 2025_10_29_02 -> 2025_10_30_00

-- Adjusts events previously ordered from 0 wrongly
UPDATE `smart_scripts` SET `event_param2` = `event_param2` +1 WHERE `event_type`  =34 AND `event_param1` = 2 AND `entryorguid` IN (-158029, -158021, -158000, -148360, -148268, -139547 ,-139546, -139539, -139538, -139533, -139532);
