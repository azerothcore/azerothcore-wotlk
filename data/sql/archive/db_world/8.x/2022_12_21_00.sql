-- DB update 2022_12_20_07 -> 2022_12_21_00
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` IN (9884,9885,9887);
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 9884 WHERE `ID` IN (9884,9885,9887,9886);
