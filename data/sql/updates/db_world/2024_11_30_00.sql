-- DB update 2024_11_27_02 -> 2024_11_30_00
--
-- To Skettis! requirement removed from Escape from Skettis
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 11085);

-- To Skettis! requirement removed from Hungry Nether Rays
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 11093);
