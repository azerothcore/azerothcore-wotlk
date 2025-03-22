-- DB update 2025_03_09_01 -> 2025_03_09_02
-- XOR PrevQuestID that was 499 Elixir of Suffering
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 501;
