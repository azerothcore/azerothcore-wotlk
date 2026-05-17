-- DB update 2026_05_17_01 -> 2026_05_17_02
UPDATE `smart_scripts` SET `action_param6` = 2 WHERE `entryorguid` IN (17809, 17810, 17811, 17812) AND `source_type` = 0 AND `action_type` = 53;
