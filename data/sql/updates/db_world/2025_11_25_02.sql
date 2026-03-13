-- DB update 2025_11_25_01 -> 2025_11_25_02
-- Removes the pre-quest for Elixir of Pain [502] for Elixir of Agony
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 509);
