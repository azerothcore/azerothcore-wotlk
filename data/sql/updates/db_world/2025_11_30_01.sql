-- DB update 2025_11_30_00 -> 2025_11_30_01
-- Burning to Help doesn't require Sharpening Your Talons
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 12683;
