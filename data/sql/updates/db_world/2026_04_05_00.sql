-- DB update 2026_04_04_01 -> 2026_04_05_00
UPDATE `smart_scripts` SET `event_phase_mask` = 0 WHERE `entryorguid` = 27653 AND `id` IN (2, 3);
