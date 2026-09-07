--
-- Remove PrevQuestID for Amani Encroachment (8476); previously Farstrider Retreat (9359)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 8476);
