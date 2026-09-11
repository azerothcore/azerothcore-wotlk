--
-- Stokin' the Furnace: move achievement_heartbreaker from criteria 10072/10073 to Heartbreaker 10220/10221
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10072, 10073, 10220, 10221) AND `type` = 11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10220, 11, 0, 0, 'achievement_heartbreaker'),
(10221, 11, 0, 0, 'achievement_heartbreaker');
