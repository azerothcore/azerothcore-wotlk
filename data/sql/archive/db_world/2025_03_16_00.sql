-- DB update 2025_03_15_00 -> 2025_03_16_00
-- Fixes Zangarmarsh Quest "A Job Undone" invalid prerequisite quest
-- closes https://github.com/azerothcore/azerothcore-wotlk/issues/21708
UPDATE `quest_template_addon` SET `PrevQuestID` = 9773 WHERE (`ID` = 9899);
