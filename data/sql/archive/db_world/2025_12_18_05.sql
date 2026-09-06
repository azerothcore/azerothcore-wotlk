-- DB update 2025_12_18_04 -> 2025_12_18_05
--
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 3938;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(3938, 11, 0, 0, 'achievement_fa_la_la_la_ogrila');
