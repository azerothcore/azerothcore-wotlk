-- DB update 2023_05_10_02 -> 2023_05_10_03
--
UPDATE `quest_template_addon` SET `ExclusiveGroup` = -10962 WHERE (`ID` IN (10962, 10968));
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE (`ID` = 10956);
