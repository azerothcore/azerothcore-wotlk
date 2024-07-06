-- DB update 2024_07_06_03 -> 2024_07_06_04
-- RequiredMinRepValue was set to 1
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0 WHERE (`ID` IN (10412, 10414, 10415, 10325, 10326, 10327));
