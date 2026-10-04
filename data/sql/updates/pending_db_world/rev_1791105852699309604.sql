-- Slain by the Wretched (9704): Aiding the Outrunners (8347) is an optional Blood Elf breadcrumb
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 9704;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9704 WHERE `ID` = 8347;
