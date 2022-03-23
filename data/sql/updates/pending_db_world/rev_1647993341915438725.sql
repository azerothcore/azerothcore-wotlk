INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647993341915438725');

-- Burning Blade npc weapons
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` IN (4663,4664,4665,4666,4667);
