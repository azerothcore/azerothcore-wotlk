-- DB update 2024_11_22_00 -> 2024_11_22_01
--
-- fix (db/Quest) - Makes a bunch of "mandatory" quests into "optional" 2.0
-- The Spirits of Stonetalon requirement removed from Goblin Invaders
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 1062);

-- Lost Deathstalkers requirement removed from Wild Hearts
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 429);

-- Vital Intelligence requirement removed from At War With The Scarlet Crusade (1/4)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 427);
