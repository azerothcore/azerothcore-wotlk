--
UPDATE `quest_template_addon` SET `PrevQuestId`=0 WHERE `ID`=1699;
UPDATE `quest_template_addon` SET `NextQuestId`=1699 WHERE `ID` IN (1698,10371);
