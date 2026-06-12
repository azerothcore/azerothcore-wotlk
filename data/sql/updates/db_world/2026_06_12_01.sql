-- DB update 2026_06_12_00 -> 2026_06_12_01
--
-- Remove "We made it! Thank you for getting me out of that hell hole. Tell Hemet to expect me!"
DELETE FROM `creature_text` WHERE (`CreatureID` = 28787) AND `GroupID` = 0 AND `ID` = 0;
-- Remove "Let's get the hell out of here"
DELETE FROM `creature_text` WHERE (`CreatureID` = 28787) AND `GroupID` = 6 AND `ID` = 0;
