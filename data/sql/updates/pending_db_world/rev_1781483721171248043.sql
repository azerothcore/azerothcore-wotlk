-- Rifle the Bodies, Your Presence is Required - chain fix
UPDATE `quest_template` SET `RewardNextQuest` = 0 WHERE (`ID` IN (11995, 11996));
UPDATE `quest_template_addon` SET `PrevQuestID` = 0, `BreadcrumbForQuestId` = 0 WHERE `ID` = 11999;
