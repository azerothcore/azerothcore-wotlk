INSERT INTO version_db_world (`sql_rev`) VALUES ('1545842754423232286');

DELETE FROM `mail_loot_template` WHERE `entry` IN (90, 119, 124, 140, 180, 183, 216, 217, 218, 270);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (4989, 4988, 5620, 5632, 5619, 4987);
