-- Set Viper Sting to only in heroic
Update `smart_scripts` set `event_flags`=4 WHERE (`entryorguid` = 18501) AND (`source_type` = 0) AND (`id` IN (4));
