-- Match the existing PvP title criteria to their 3.3.5a client descriptions.
-- Deadly Gladiator has title 157; Wrathful has no criterion in these achievements.
-- Gladiator
UPDATE `achievement_criteria_data` SET `value1` = 42 WHERE `type` = 23 AND `criteria_id` IN (7416, 9718, 9721);
-- Duelist
UPDATE `achievement_criteria_data` SET `value1` = 43 WHERE `type` = 23 AND `criteria_id` IN (7415, 9720);
-- Rival
UPDATE `achievement_criteria_data` SET `value1` = 44 WHERE `type` = 23 AND `criteria_id` IN (7418, 9719);
-- Challenger
UPDATE `achievement_criteria_data` SET `value1` = 45 WHERE `type` = 23 AND `criteria_id` IN (7408);
-- Deadly Gladiator
UPDATE `achievement_criteria_data` SET `value1` = 157 WHERE `type` = 23 AND `criteria_id` IN (10878, 10879, 10881, 13001);
-- Furious Gladiator
UPDATE `achievement_criteria_data` SET `value1` = 167 WHERE `type` = 23 AND `criteria_id` IN (12999, 13002, 13006);
-- Relentless Gladiator
UPDATE `achievement_criteria_data` SET `value1` = 169 WHERE `type` = 23 AND `criteria_id` IN (13000, 13003, 13005);
