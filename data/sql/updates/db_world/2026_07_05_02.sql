-- DB update 2026_07_05_01 -> 2026_07_05_02

-- Set Cast Flag for Net Spell.
UPDATE `smart_scripts` SET `action_param2` = 12 WHERE (`entryorguid` = 6230) AND (`source_type` = 0) AND (`id` IN (0));
