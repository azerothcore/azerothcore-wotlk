-- DB update 2026_10_31_02 -> 2026_11_02_00
--
-- Set Type Yell (14)
UPDATE `creature_text` SET `Type` = 14 WHERE (`CreatureID` = 32871) AND (`GroupID` IN (17, 18, 19));
