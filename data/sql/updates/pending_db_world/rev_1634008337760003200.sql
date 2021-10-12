INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634008337760003200');

-- Remove 'Immunity: Arcane' (34184) from on respawn events
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10485 AND `source_type` = 0 AND `id` = 5;
