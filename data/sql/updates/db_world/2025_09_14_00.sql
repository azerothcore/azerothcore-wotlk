-- DB update 2025_09_13_03 -> 2025_09_14_00
-- From 0 to 9796 ExclusiveGroup for "News from Zangarmarsh" and "News for Rakoria"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 9796 WHERE `ID` IN (9796, 10105);
