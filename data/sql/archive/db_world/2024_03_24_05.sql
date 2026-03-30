-- DB update 2024_03_24_04 -> 2024_03_24_05
-- change quest chaining issue #18055
UPDATE `quest_template_addon` SET `PrevQuestID` = 9756 WHERE `ID` = 9759;
