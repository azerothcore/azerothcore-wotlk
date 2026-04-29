-- DB update 2025_12_08_00 -> 2025_12_08_01
-- PrevQuestID 0 to 12598, Skimmer Spinnerets requires Throwing Down
-- NextQuestID 12555 to 12583, Skimmer Spinnerets opens up Crashed Sprayer, not A Tangled Skein
-- ExclusiveGroup -12583 to 0, linear chain, no need for a group
UPDATE `quest_template_addon` SET `PrevQuestID` = 12598 , `NextQuestID` = 12583, `ExclusiveGroup` = 0 WHERE (`ID` = 12553);

-- ExclusiveGroup -12583 to 0, linear chain, no need for a group
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE (`ID` = 12583);

-- PrevQuestID 0 to 12598, Cocooned! requires Throwing Down
-- NextQuestID 12555 to 0, Cocooned! doesn't open up A Tangled Skein
-- ExclusiveGroup -12583 to 0, linear chain, no need for a group
UPDATE `quest_template_addon` SET `PrevQuestID` = 12598, `NextQuestID` = 0, `ExclusiveGroup` = 0 WHERE (`ID` = 12606);

-- PrevQuestID 0 to 12552, Pure Evil requires Death to the Necromagi
UPDATE `quest_template_addon` SET `PrevQuestID` = 12552 WHERE (`ID` = 12584);

-- PrevQuestId 12596 to 12598, Death to the Necromagi requires Throwing Down, not Pa'Troll
UPDATE `quest_template_addon` SET `PrevQuestID` = 12598 WHERE (`ID` = 12552);
