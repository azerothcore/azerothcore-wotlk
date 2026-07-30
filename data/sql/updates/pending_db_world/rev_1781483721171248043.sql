-- Rifle the Bodies, Your Presence is Required - chain fix
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 11999;
