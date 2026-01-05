-- DB update 2026_01_05_00 -> 2026_01_05_01
-- "A Score to Settle" requires "Report to Anselm"
UPDATE `quest_template_addon` SET `PrevQuestID` = 11234 WHERE `ID` = 11272;
