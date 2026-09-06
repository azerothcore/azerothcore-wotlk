-- DB update 2025_09_19_00 -> 2025_09_19_01
--
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=4112 AND `type`=15;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (4112, 15, 3, 0, '');
