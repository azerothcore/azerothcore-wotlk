-- DB update 2026_04_29_05 -> 2026_04_29_06

-- Remove DisplayID_Other_Gender.
UPDATE `creature_model_info` SET `DisplayID_Other_Gender` = 0 WHERE (`DisplayID` IN (12829, 12830));
