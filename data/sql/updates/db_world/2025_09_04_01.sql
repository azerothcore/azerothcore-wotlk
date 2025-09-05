-- DB update 2025_09_04_00 -> 2025_09_04_01
UPDATE `creature_model_info` SET `DisplayID_Other_Gender` = 0 WHERE `DisplayID` IN (16292, 16294);
