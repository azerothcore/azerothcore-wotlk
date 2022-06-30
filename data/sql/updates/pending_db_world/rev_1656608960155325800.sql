--
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (6140, 6141);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES (6140, 25, 4, 0);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`) VALUES (6141, 25, 5, 0);
