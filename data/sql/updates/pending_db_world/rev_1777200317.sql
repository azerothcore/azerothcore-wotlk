
-- Set timers to 0.
UPDATE `smart_scripts` SET `event_param1` = 0, `event_param2` = 0 WHERE (`entryorguid` = 2851100) AND (`source_type` = 9) AND (`id` IN (4));

-- Set flag WHILE_CHARMED.
UPDATE `smart_scripts` SET `event_flags` = 512 WHERE (`entryorguid` = 2851101) AND (`source_type` = 9) AND (`id` IN (3));
