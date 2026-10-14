-- DB update 2026_10_10_16 -> 2026_10_10_17
-- "Badlands Reagent Run II" requires "Uldaman Reagent Run"
UPDATE `quest_template_addon` SET `PrevQuestID` = 17 WHERE `ID` = 2501;
