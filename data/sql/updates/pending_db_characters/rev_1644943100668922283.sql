INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1644943100668922283');

UPDATE `pvpstats_battlegrounds`
SET `bracket_id` = `bracket_id` + 1
WHERE `type` = 1;
