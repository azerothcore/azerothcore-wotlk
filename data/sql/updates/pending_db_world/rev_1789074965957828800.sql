--
-- Stokin' the Furnace: move achievement_heartbreaker from criteria 10072/10073 to Heartbreaker 10220/10221
UPDATE `achievement_criteria_data` SET `criteria_id` = 10220 WHERE (`criteria_id` = 10072) AND (`type` = 11) AND (`value1` = 0) AND (`value2` = 0) AND (`ScriptName` = 'achievement_heartbreaker');
UPDATE `achievement_criteria_data` SET `criteria_id` = 10221 WHERE (`criteria_id` = 10073) AND (`type` = 11) AND (`value1` = 0) AND (`value2` = 0) AND (`ScriptName` = 'achievement_heartbreaker');
