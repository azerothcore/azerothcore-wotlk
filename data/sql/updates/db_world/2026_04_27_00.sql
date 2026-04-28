-- DB update 2026_04_26_05 -> 2026_04_27_00

-- Change target to self.
UPDATE `smart_scripts` SET `target_type` = 1 WHERE (`entryorguid` = 8400) AND (`source_type` = 0) AND (`id` IN (0));
