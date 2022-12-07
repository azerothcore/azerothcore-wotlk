-- DB update 2022_12_06_01 -> 2022_12_06_02
--
UPDATE `quest_template_addon` SET `ExclusiveGroup`=10888 WHERE `id` IN (10888,13430);
UPDATE `quest_template_addon` SET `NextQuestID`=13430 WHERE `id` IN (10884,10885,10886);
