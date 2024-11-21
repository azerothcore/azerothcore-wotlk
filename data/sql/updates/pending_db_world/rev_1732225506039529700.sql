--
-- fix(db/Creature) - Bonechewer Behemoth isn't immune to Distract anymore
UPDATE `creature_template` SET `mechanic_immune_mask` = 545468279 WHERE (`entry` = 23196);

-- fix (db/Quest) - Makes a bunch of "mandatory" quests into "optional" 2.0
-- The Spirits of Stonetalon requirement removed from Goblin Invaders
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 1062);

-- Lost Deathstalkers requirement removed from Wild Hearts
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 429);

-- Vital Intelligence requirement removed from At War With The Scarlet Crusade (1/4)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 427);