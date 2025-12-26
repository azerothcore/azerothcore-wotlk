-- Make "Into the Fold" (11978) available without prereqs
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE `ID` IN (11977, 11979);
