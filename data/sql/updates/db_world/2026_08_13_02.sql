-- DB update 2026_08_13_01 -> 2026_08_13_02
-- Rifle the Bodies, Your Presence is Required - chain fix
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 11999;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11999 WHERE (`ID` = 11996);
