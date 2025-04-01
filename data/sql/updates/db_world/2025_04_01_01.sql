-- DB update 2025_04_01_00 -> 2025_04_01_01
-- Remove quest requirement for Gammerita, Mon!
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 7816);
