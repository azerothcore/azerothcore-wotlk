-- DB update 2025_12_16_01 -> 2025_12_16_02
-- PrevQuestID 11009 to 0, The Crystals doesn't have Ogre Heaven as a requirement
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 11025);
