-- Change quest requirement from Stop the Ascension! (11260) to The Conqueror of Skorm! (11261)
UPDATE `quest_template_addon` SET `PrevQuestID` = 11261 WHERE (`ID` = 11265);