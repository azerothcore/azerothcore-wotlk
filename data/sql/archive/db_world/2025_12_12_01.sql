-- DB update 2025_12_12_00 -> 2025_12_12_01
--
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 11298);
