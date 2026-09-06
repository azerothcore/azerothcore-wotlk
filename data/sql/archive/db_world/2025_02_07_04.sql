-- DB update 2025_02_07_03 -> 2025_02_07_04
-- Failed Incursion requirement removed from Lost in Action
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 9738);
