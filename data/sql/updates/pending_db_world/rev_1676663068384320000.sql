-- Reply-Code Alpha - All Is Well That Ends Well 10 & 25 - Remove requirement for sigil quest completion.
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 13631); -- Normal (10m)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 13819); -- Heroic (25m)
