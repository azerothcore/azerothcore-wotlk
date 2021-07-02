INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1625236840920068800');

UPDATE `character_skills` SET `value` = 300, `max` = 300 WHERE `skill` = 762 AND `value` > 300 AND `max` > 300;
