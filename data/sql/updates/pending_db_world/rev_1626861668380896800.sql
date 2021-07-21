INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626861668380896800');

-- Changed the spawn timer from 2 hours to 10 minutes for the item Waterlogged Letter
UPDATE `gameobject` SET `spawntimesecs` = 600 WHERE (`id` = 2656) AND (`guid` IN (14656));

