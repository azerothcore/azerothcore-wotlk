INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630346434138351639');

-- Removed the event 14 - Friendly Health because he already heals himself on the id 5
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5236) AND (`source_type` = 0) AND (`id` = 4);

-- Changed the id 5 to 4 as we deleted the id 4
UPDATE `smart_scripts` SET `id` = 4 WHERE (`entryorguid` = 5236) AND (`source_type` = 0) AND (`id` = 5);

