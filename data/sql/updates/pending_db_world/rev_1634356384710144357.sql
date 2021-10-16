INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634356384710144357');

-- Makes Apothecary Dithers start and end "The Key to Scholomance"
UPDATE `creature_queststarter` SET `id` = 11057 WHERE `quest` = 5511;
UPDATE `creature_questender` SET `id` = 11057 WHERE `quest` = 5511;

