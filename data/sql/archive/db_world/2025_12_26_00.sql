-- DB update 2025_12_24_01 -> 2025_12_26_00
-- Make "Into the Fold" (11978) available without prereqs
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE `ID` IN (11977, 11979);
